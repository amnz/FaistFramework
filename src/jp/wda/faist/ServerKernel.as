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
	import flash.events.DataEvent;
	import flash.events.Event;
	import jp.wda.faist.events.FaistErrorEvent;
	import jp.wda.faist.events.FaistXMLEvent;
	
	/**
	 * クライアントからの新たな接続があった場合に送出されます。
	 * 
	 * @eventType jp.wda.faist.events.FaistXMLEvent.REQUEST
	 */
	[Event(name = "request", type = "jp.wda.faist.events.FaistXMLEvent")]
	
	/**
	 * クライアントが切断された場合に送出されます。
	 * 
	 * @eventType jp.wda.faist.events.FaistXMLEvent.LEAVE
	 */
	[Event(name = "leave", type = "jp.wda.faist.events.FaistXMLEvent")]
	
	/**
	 * Faistサーバを作成するためのFaistカーネル
	 * 
	 * 
	 * <span class="hide">$Id: ServerKernel.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public final class ServerKernel extends Kernel {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	
		 */
		public function ServerKernel() {
			super();
		}
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 指定されたIDのクライアントからの接続を受け入れます。
		 * 
		 * @param	clientID
		 */
		public function accept(clientID:String):void {
			socket.send(<accept clientID={clientID}/>);
		}
		
		/**
		 * 指定されたIDのクライアントからの接続を拒否します。
		 * 
		 * @param	clientID
		 */
		public function deny(clientID:String):void {
			socket.send(<deny clientID={clientID}/>);
		}
		
		/**
		 * 
		 * @param	clientID
		 * @param	key
		 * @param	value
		 */
		public function setAttribute(clientID:String, key:String, value:String):void {
			socket.send("<attribute clientID=\"" + clientID + "\" key=\"" + key + "\"><![CDATA[" + value + "]]></attribute>");
		}
		
		/**
		 * クライアントプロクシを作成します。
		 * 
		 * @param	selector クライアントセレクタ。指定しない場合は、接続している全クライアント。
		 * @return	クライアントプロクシ
		 */
		public function clients(selector:Object = null, handler:String = "root"):ClientProxy {
			return new ClientProxy(this, selector, handler);
		}
		
		// 内部メソッド /////////////////////////////////////////////////////////////////////
		//                                                                 Private Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @private
		 */
		protected override function intialize():void {
			socket.send("<launch service=\"" + serviceName + "\" password=\"" + encrypt(password) + "\"/>");
		}
		
		/**
		 * 
		 * @param	command
		 * @param	xml
		 * @private
		 */
		protected override function evalute(command:String, xml:XML):void {
			var event:String = null;
			if (command == "screen") { event = FaistXMLEvent.REQUEST; }
			if (command == "desert") { event = FaistXMLEvent.LEAVE; }
			
			if (event != null) {
				this.dispatchEvent(new FaistXMLEvent(event, xml));
				return;
			}
			
			super.evalute(command, xml);
		}

	}

}