package jp.wda.faist.examples.chat {
	import com.carlcalderon.arthropod.Debug;
	
	/**
	 * 
	 * ...
	 * 
	 * $Id: SocketHandler.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class SocketHandler {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function SocketHandler(manager:MainManager) {
			super();
			
			this.manager = manager;
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var manager:MainManager;
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	name
		 */
		public function join(name:String):void {
			manager.main.txMessages.text = "  - " + name + "さんが参加しました。\r" + manager.main.txMessages.text
		}
		
		/**
		 * 
		 * @param	name
		 */
		public function bye(name:String):void {
			manager.main.txMessages.text = "  - " + name + "さんが退室しました。\r" + manager.main.txMessages.text
		}
		
		/**
		 * 
		 * @param	name
		 * @param	message
		 */
		public function chat(name:String, message:String):void {
			manager.main.txMessages.text = name + "さん: " + message + "\r" + manager.main.txMessages.text
		}
		
	}

}