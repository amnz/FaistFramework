package  {
	/**
	 * 
	 * ...
	 * 
	 * $Id: SocketClient.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class SocketClient {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function SocketClient() {
			super();
		}
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get id():String       { return _id; }
		/** @private */
		public function set id(v:String):void { _id = v; }
		/** @private */
		private var _id:String;
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get handleName():String       { return _handleName; }
		/** @private */
		public function set handleName(v:String):void { _handleName = v; }
		/** @private */
		private var _handleName:String;
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @return
		 */
		public function toString():String {
			return _id;
		}
		
	}

}