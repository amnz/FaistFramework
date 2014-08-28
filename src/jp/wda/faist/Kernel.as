/* *****************************************************************************
 * 
 * Copyright(C) The MONAZITE Project Team and the Others. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 * 
 * 参考)
 * Apache License, Version 2.0 日本語訳 by Open Source Group Japan
 * 
 *     http://sourceforge.jp/projects/opensource/wiki/licenses%2FApache_License_2.0
 * 
 * ***************************************************************************** */

package jp.wda.faist {
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.hash.IHash;
	import com.hurlant.crypto.prng.Random;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.IVMode;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.math.BigInteger;
	import com.hurlant.util.Hex;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.XMLSocket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import jp.wda.faist.events.FaistErrorEvent;
	import jp.wda.faist.events.FaistXMLEvent;
	import jp.wda.faist.events.FatalErrorEvent;
	import jp.wda.faist.events.LaunchProgressEvent;
	import jp.wda.faist.type.Client;
	import jp.wda.faist.type.Encrypted;
	import jp.wda.faist.type.ParameterType;
	
	/**
	 * Kernelの起動処理進捗状況を報告します。
	 * 
	 * @eventType jp.wda.faist.events.LaunchProgressEvent.PROGRESS
	 */
	[Event(name = "progress", type = "jp.wda.faist.events.LaunchProgressEvent")]
	/**
	 * Kernelの起動が完了した場合に送出されます。
	 * 
	 * @eventType jp.wda.faist.events.FaistXMLEvent.LAUNCH_COMPLETED
	 */
	[Event(name = "launchCompleted", type = "jp.wda.faist.events.FaistXMLEvent")]
	/**
	 * 何らかのエラーが発生した場合に送出されます。
	 * 
	 * @eventType jp.wda.faist.events.FaistErrorEvent.ERROR
	 */
	[Event(name = "error", type = "jp.wda.faist.events.FaistErrorEvent")]
	/**
	 * 修復不能なエラーが発生した場合に送出されます。
	 * 
	 * @eventType jp.wda.faist.events.FatalErrorEvent.ERROR
	 */
	[Event(name = "fatalError", type = "jp.wda.faist.events.FatalErrorEvent")]
	
	/**
	 * <h1>Faistフレームワーク</h1>
	 * Faistフレームワークを使用するには、派生した ServerKernel もしくは ClientKernel を使用してください.
	 * 
	 * 
	 * <span class="hide">$Id: Kernel.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 * @see	jp.wda.faist.ServerKernel
	 * @see	jp.wda.faist.ClientKernel
	 */
	public class Kernel extends EventDispatcher {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 */
		public function Kernel() {
			super();
			
			_sharedObject = SharedObject.getLocal(FaistUtil.SHARED_OBJECT_NAME);
			Security.loadPolicyFile("xmlsocket://" + _reflector + ":843");
			
			_parsers = new Dictionary();
			addPerser(Client.TYPE, Client);
			
			this._socket = new XMLSocket();
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(Event.CLOSE,   onClose);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,             connectFailure);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, connectFailure);
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var mykey:BigInteger = null;
		/**  */
		private var mypub:BigInteger = null;
		/**  */
		private var deskey:ByteArray = null;
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * 接続先リフレクタサーバ
		 * @default "gpss.jpn.ph"
		 */
		public function get reflector():String       { return _reflector; }
		/** @private */
		public function set reflector(v:String):void { _reflector = v; }
		/** @private */
		private var _reflector:String = "gpss.jpn.ph";
		
		/* ***********************************************************************>> */
		/**
		 * 接続先リフレクタサーバのポート番号
		 * @default 843
		 */
		public function get port():int       { return _port; }
		/** @private */
		public function set port(v:int):void { _port = v; }
		/** @private */
		private var _port:int = 843;
		
		/* ***********************************************************************>> */
		/**
		 * Faistフレームワークで使用するサービス名
		 */
		public function get serviceName():String       { return _serviceName; }
		/** @private */
		public function set serviceName(v:String):void { _serviceName = v; }
		/** @private */
		private var _serviceName:String = null;
		
		/* ***********************************************************************>> */
		/**
		 * サービス名に対するパスワード
		 */
		public function get password():String       { return _password; }
		/** @private */
		public function set password(v:String):void { _password = v; }
		/** @private */
		private var _password:String = null;
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * XMLSocket接続
		 */
		private var _socket:XMLSocket;
		/**
		 * reflectorへのXMLSocket接続
		 * @return XMLSocket接続
		 * @private
		 */
		protected function get socket():XMLSocket { return _socket; }
		
		/** SharedObject */
		private static var _sharedObject:SharedObject;
		/**
		 * ローカル保持データ
		 * @return ローカル保持データ
		 */
		public static function get localdata():Object { return _sharedObject.data; }
		
		/* ***********************************************************************>> */
		/**
		 * メソッド処理ハンドラ
		 * @private
		 */
		public function get rootHandler():Object       { return _rootHandler; }
		/** @private */
		private var _rootHandler:Object;
		
		/* ***********************************************************************>> */
		/**
		 * メソッド処理ハンドラ
		 * @private
		 */
		public function get handlers():Dictionary       { return _handlers; }
		/** @private */
		private var _handlers:Dictionary = new Dictionary;
		
		/* ***********************************************************************>> */
		/**
		 * 引数パーサを追加します。
		 * 
		 * @param	type
		 * @param	parser
		 */
		public function addPerser(type:String, parser:Class):void {
			if (parser.parse) { _parsers[type] = parser; }
		}
		/** @private */
		private var _parsers:Dictionary
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Faistカーネルを起動します。
		 * 
		 * @param	handler
		 */
		public function launch(handler:Object):void {
			this._rootHandler = handler;
			validate();
		}
		
		/**
		 * 
		 * @private
		 */
		public function start():void {
			_socket.addEventListener(DataEvent.DATA, onReceive);
		}
		
		/**
		 * ソケット接続を切断します。
		 */
		public function disconnect():void {
			_socket.removeEventListener(DataEvent.DATA, onReceive);
			_socket.close();
		}
		
		/**
		 * 文字列を暗号化します。
		 * 
		 * @param	encrypt
		 * @return
		 */
		public function encrypt(encrypt:String):Encrypted {
			var data:ByteArray = Hex.toArray(Hex.fromString(encrypt));
			var pad:IPad = new PKCS5();
			var mode:ICipher = Crypto.getCipher(FaistUtil.CIPHER, deskey, pad);
			
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			
			var ivmode:IVMode = mode as IVMode;
			var iv:ByteArray  = ivmode.IV;
			
			return new Encrypted(Hex.fromArray(data), Hex.fromArray(iv));
		}
		
		/**
		 * 暗号化された引数を復号化します。
		 * 
		 * @param	dt
		 */
		public function decrypt(dt:Encrypted):String {
			var data:ByteArray = Hex.toArray(dt.data);
			var iv:ByteArray   = Hex.toArray(dt.iv);
			
			var pad:IPad = new PKCS5();
			var mode:ICipher = Crypto.getCipher(FaistUtil.CIPHER, deskey, pad);
			
			pad.setBlockSize(mode.getBlockSize());
			var ivmode:IVMode = mode as IVMode;
			ivmode.IV = iv;
			
			mode.decrypt(data);
			
			return Hex.toString(Hex.fromArray(data));
		}
		
		/**
		 * 
		 * @param	xml
		 * @param	args
		 * @private
		 */
		public function remoteCall(xml:XML, args:Array):void {
			var params:XML = xml.params[0];
			
			if (args == null || args.length == 0) {
				params.appendChild(<param type="void">0</param>);
			} else {
				for each (var arg:* in args) {
					if (arg == null) {
						params.appendChild(<param type="null"></param>);
						continue;
					}
					var type:String = getParameterType(arg);
					params.appendChild(new XML("<param type=\"" + type + "\"><![CDATA[" + arg.toString() + "]]></param>"));
				}
			}
			
			_socket.send(xml.toXMLString());
		}
		
		/**
		 * 
		 * @param	arg
		 * @return
		 */
		private function getParameterType(arg:*):String{
			if(arg is ParameterType) { return (arg as ParameterType).getTypeName(); }
			
			if (arg is int) { return "int"; }
			if (arg is Number) { return "number"; }
			
			return "string";
		}
		
		// 内部メソッド /////////////////////////////////////////////////////////////////////
		//                                                                 Private Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 初期設定検査
		 */
		private function validate():void {
			this.dispatchEvent(new LaunchProgressEvent(LaunchProgressEvent.VALIDATE));
			
			if (_rootHandler == null
					|| _reflector == null
					|| _port < 100
					|| _serviceName == null
					|| _password == null) {
				this.dispatchEvent(new FatalErrorEvent(FaistErrorEvent.ERR_CONFIGURATION_FAILURE, "configuration failure."));
				return;
			}
			
			createPrivateKey();
		}
		
		/**
		 * 秘密鍵作成
		 */
		private function createPrivateKey():void {
			this.dispatchEvent(new LaunchProgressEvent(LaunchProgressEvent.CREATE_PRIVATE_KEY));
			
			var r:Random    = new Random();
			var b:ByteArray = new ByteArray();
			r.nextBytes(b, 128/8);
			b.position = 0;
			
			mykey = new BigInteger(b);
			mypub = FaistUtil.DH_GENERATOR.modPow(mykey, FaistUtil.DH_PRIME);
			
			connect();
		}
		
		/**
		 * ReflectorへSocket接続を開始します。
		 */
		private function connect():void {
			this.dispatchEvent(new LaunchProgressEvent(LaunchProgressEvent.CONNECT_TO_REFLECTOR));
			
			_socket.connect(_reflector, _port);
		}
		/**
		 * 
		 * @param	evt
		 */
		private function onClose(evt:Event):void {
			_socket.removeEventListener(DataEvent.DATA, onReceive);
			this.dispatchEvent(new FatalErrorEvent(FaistErrorEvent.ERR_CONNECTION_CLOSE, "connection closed."));
		}
		/**
		 * 
		 * @param	evt
		 */
		private function connectFailure(evt:ErrorEvent):void {
			var message:String = evt.text;
			message = message.replace(/:\d{3,5}\s/g, " ");
			this.dispatchEvent(new FatalErrorEvent(FaistErrorEvent.ERR_CONNECTION_FAILURE, evt.type + ": " + message));
		}
		/**
		 * 
		 * @param	evt
		 */
		private function onConnect(evt:Event):void {
			handshake();
		}
		/**
		 * 
		 */
		private function handshake():void {
			this.dispatchEvent(new LaunchProgressEvent(LaunchProgressEvent.HANDSHAKE));
			_socket.addEventListener(DataEvent.DATA, onConnectSocklet);
			
			var command:String = FaistUtil.SOCKLET + "::" + mypub.toString(16) + ":encoding=UTF-8";
			if(localdata["HardwareID"] != undefined){
				command += "&hid=" + localdata["HardwareID"];
			}
			command += "&connet=true";
			
			_socket.send(command);
		}
		/**
		 * 
		 * @param	evt
		 */
		private function onConnectSocklet(evt:DataEvent):void {
			_socket.removeEventListener(DataEvent.DATA, onConnectSocklet);
			
			var result:String = evt.data;
			var resultCode:String = "-";
			if(result != null && result.length > 0){
				resultCode = evt.data.charAt(0);
			}
			
			if(resultCode == "+"){
				var resArray:Array = result.split("::");
				
				if(resArray.length > 1){
					localdata["HardwareID"] = resArray[1];
				}
				
				if(resArray.length > 2){
					var clpub:BigInteger = new BigInteger(resArray[2]);
					var rawDESKey:BigInteger = clpub.modPow(mykey, FaistUtil.DH_PRIME);
					
					var hash:IHash = Crypto.getHash(FaistUtil.MESSAGE_DIGEST);
					deskey = hash.hash(rawDESKey.toByteArray());
				}
				
				this.dispatchEvent(new LaunchProgressEvent(LaunchProgressEvent.INITIALIZE));
				
				_socket.addEventListener(DataEvent.DATA, onInitialized);
				intialize();
			}else{
				this.dispatchEvent(new FatalErrorEvent(FaistErrorEvent.ERR_ACCES_DENIED, "Access denied."));
			}
		}
		/**
		 * @private
		 */
		protected /*abstract*/ function intialize():void { ; }
		
		/**
		 * 
		 * @param	event
		 */
		private function onInitialized(event:DataEvent):void {
			_socket.removeEventListener(DataEvent.DATA, onInitialized);
			
			var result:XML = new XML(event.data);
			var code:int = int(result.@code);
			if (code != 0) { this.dispatchEvent(new FatalErrorEvent(code, result.@message)); return; }
			
			start();
			
			this.dispatchEvent(new FaistXMLEvent(FaistXMLEvent.LAUNCH_COMPLETED, result));
		}
		
		// 内部メソッド /////////////////////////////////////////////////////////////////////
		//                                                                 Private Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	evt
		 * @private
		 */
		protected function onReceive(evt:DataEvent):void {
			var xml:XML = new XML(evt.data);
			evalute(xml.name().localName, xml);
		}
		
		/**
		 * 
		 * @param	command
		 * @param	xml
		 * @private
		 */
		protected function evalute(command:String, xml:XML):void {
			if (command.toLowerCase() == "result") {
				var code:int = int(xml.@code);
				if (code != 0) { this.dispatchEvent(new FaistErrorEvent(code, xml.@message)); return; }
			} else if (command.toLowerCase() == "invoke") {
				invokeMethod(xml);
				return;
			}
			
			this.dispatchEvent(new FaistErrorEvent(FaistErrorEvent.ERR_UNKNOWN_COMMAND, "unknown command."));
		}
		
		/**
		 * 
		 * @param	xml
		 */
		private function invokeMethod(xml:XML):void {
			var methodName:String = xml.@method;
			
			var args:Array = new Array();
			for each (var arg:XML in xml.params.param) {
				if ("null" == String(arg.@type))	{ args.push(null); continue; }
				if ("int" == String(arg.@type))		{ args.push(int(arg)); continue; }
				if ("number" == String(arg.@type))	{ args.push(Number(arg)); continue; }
				if ("string" == String(arg.@type))	{ args.push(String(arg)); continue; }
				
				if (_parsers[String(arg.@type)]) {
					args.push(_parsers[String(arg.@type)].parse.call(null, arg));
					continue;
				}
			}
			
			var handler:Object = null;
			if (xml.hasOwnProperty("@handler")) {
				handler = this._handlers[String(xml.@handler)];
			}
			if (handler == null) { handler = this._rootHandler; }
			
			try {
				switch(args.length) {
					case   0: handler[methodName].call(handler); break;
					case   1: handler[methodName].call(handler, args[0]); break;
					case   2: handler[methodName].call(handler, args[0], args[1]); break;
					case   3: handler[methodName].call(handler, args[0], args[1], args[2]); break;
					case   4: handler[methodName].call(handler, args[0], args[1], args[2], args[3]); break;
					case   5: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4]); break;
					case   6: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4], args[5]); break;
					case   7: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;
					case   8: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;
					case   9: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;
					case  10: handler[methodName].call(handler, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;
					default : handler[methodName].call(handler, args); break;
				}
			} catch (error:Error) {
				this.dispatchEvent(new FaistErrorEvent(FaistErrorEvent.ERR_UNKNOWN_METHOD, "unknown method", xml));
			}
		}
		
	}

}