package jp.wda.faist.examples.chat {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import jp.wda.faist.ClientKernel;
	import jp.wda.faist.events.FaistErrorEvent;
	import jp.wda.faist.events.FaistXMLEvent;
	import jp.wda.faist.events.FatalErrorEvent;
	import jp.wda.faist.events.LaunchProgressEvent;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IMXMLObject;
	
	/**
	 * 
	 * ...
	 * 
	 * $Id: MainManager.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class MainManager implements IMXMLObject {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function MainManager() {
			super();
			
			kernel = new ClientKernel();
			kernel.reflector	= "gpss.jpn.ph";
			kernel.port			= 843;
			kernel.serviceName	= "TestService";
			kernel.password		= "1qaz2wsx";
			
			kernel.addEventListener(LaunchProgressEvent.PROGRESS,	progress);
			kernel.addEventListener(FaistErrorEvent.ERROR,			error);
			kernel.addEventListener(FatalErrorEvent.ERROR,			fatalError);
			kernel.addEventListener(FaistXMLEvent.LAUNCH_COMPLETED,	launchCompleted);
			
			rootHandler = new SocketHandler(this);
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var kernel:ClientKernel;
		private var rootHandler:*;
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		protected var _document:Object;
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get main():Main       { return _document as Main; }
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get stage():Stage	{ return main.stage; }
		
		// イベントハンドラ /////////////////////////////////////////////////////////////////
		//                                                                   Event Handler //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	document
		 * @param	id
		 */
		public function initialized(document:Object, id:String):void {
			this._document = document;
		}
		
		/**
		 * 
		 */
		public function onApplicationComplete():void {
			main.currentState = "disconnected";
		}
		
		/**
		 * 
		 */
		public function enter():void {
			main.currentState = "processing";
			kernel.launch(rootHandler);
		}
		/**
		 * 
		 * @param	event
		 */
		private function launchCompleted(event:FaistXMLEvent):void {
			main.txMessages.text = "  - 初期化完了\r" + main.txMessages.text
			
			main.currentState = "connected";
			kernel.server().hello(kernel.myself, main.txHandleName.text);
		}
		
		/**
		 * 
		 */
		public function disconnect():void {
			main.currentState = "disconnected";
			kernel.disconnect();
		}
		
		/**
		 * 
		 */
		public function chat():void {
			kernel.server().chat(kernel.myself, main.txChat.text);
		}
		
		// イベントハンドラ /////////////////////////////////////////////////////////////////
		//                                                                   Event Handler //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	event
		 */
		private function progress(event:LaunchProgressEvent):void {
			main.txMessages.text = "  - progress. :" + event.progress + "\r" + main.txMessages.text
		}
		/**
		 * 
		 * @param	event
		 */
		private function fatalError(event:FatalErrorEvent):void {
			main.txMessages.text = "  - fatal error. :" + event.message + "\r" + main.txMessages.text
			disconnect();
		}
		/**
		 * 
		 * @param	event
		 */
		private function error(event:FaistErrorEvent):void {
			main.txMessages.text = "  - error. :" + event.message + "\r" + main.txMessages.text
		}
		
	}

}