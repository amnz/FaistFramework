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

package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.utils.Dictionary;
	import jp.wda.faist.events.FaistErrorEvent;
	import jp.wda.faist.events.FaistXMLEvent;
	import jp.wda.faist.events.FatalErrorEvent;
	import jp.wda.faist.events.LaunchProgressEvent;
	import jp.wda.faist.ServerKernel;
	import jp.wda.faist.type.Client;

	/**
	 * 
	 * 
	 * @author		$Author: amnz $
	 * @revision	$Rev$
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class Main extends MovieClip {
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 */
		public function Main():void {
			super();
			
			kernel = new ServerKernel();
			kernel.reflector	= "gpss.jpn.ph";
			kernel.port			= 843;
			kernel.serviceName	= "TestService";
			kernel.password		= "1qaz2wsx";
			
			kernel.addEventListener(LaunchProgressEvent.PROGRESS,	progress);
			kernel.addEventListener(FaistErrorEvent.ERROR,			error);
			kernel.addEventListener(FatalErrorEvent.ERROR,			fatalError);
			kernel.addEventListener(FaistXMLEvent.LAUNCH_COMPLETED,	launchCompleted);
			kernel.addEventListener(FaistXMLEvent.REQUEST,			screen);
			kernel.addEventListener(FaistXMLEvent.LEAVE,			leave);
			
			kernel.launch(this);
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var kernel:ServerKernel;
		
		// イベントハンドラ /////////////////////////////////////////////////////////////////
		//                                                                   Event Handler //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	event
		 */
		private function launchCompleted(event:FaistXMLEvent):void {
			trace("[" + kernel.serviceName + "] initialized.");
		}
		
		/**
		 * 
		 * @param	event
		 */
		private function progress(event:LaunchProgressEvent):void {
			trace("[" + kernel.serviceName + "] progress : " + event.progress);
		}
		/**
		 * 
		 * @param	event
		 */
		private function fatalError(event:FatalErrorEvent):void {
			trace("[" + kernel.serviceName + "] fatal error... : " + event.message);
		}
		/**
		 * 
		 * @param	event
		 */
		private function error(event:FaistErrorEvent):void {
			trace("[" + kernel.serviceName + "] error : " + event.message);
		}
		
		// コマンド処理メソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	event
		 */
		private function screen(event:FaistXMLEvent):void {
			trace("[" + kernel.serviceName + "] screen :" + event.xml.@clientID + " / " + event.xml.@ipAddress);
			
			var info:SocketClient = new SocketClient();
			info.id = event.xml.@clientID;
			clients[info.id] = info;
			
			kernel.accept(event.xml.@clientID);
		}
		private var clients:Dictionary = new Dictionary();
		
		/**
		 * 
		 * @param	event
		 */
		private function leave(event:FaistXMLEvent):void {
			var info:SocketClient = clients[String(event.xml.@clientID)];
			if (info == null) { return; }
			
			trace("[" + kernel.serviceName + "] leave :" + info);
			delete clients[info.id];
			kernel.clients().bye(info.handleName);
		}

		/**
		 * 
		 * @param	test
		 * @param	num
		 */
		public function hello(client:Client, name:String):void {
			var info:SocketClient = clients[client.id];
			if (info == null) { return; }
			
			trace("[" + kernel.serviceName + "] Welcome!! :" + name + " [" + info.id + "]");
			info.handleName = name;
			kernel.setAttribute(info.id, "handleName", name);
			kernel.clients().join(name);
		}
		
		/**
		 * 
		 * @param	client
		 * @param	message
		 */
		public function chat(client:Client, message:String):void {
			var reqfrom:SocketClient = clients[client.id];
			if (reqfrom == null) { return; }
			
			kernel.clients().chat(reqfrom.handleName, message);
		}

	}

}