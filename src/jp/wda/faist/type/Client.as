package jp.wda.faist.type {
	
	/**
	 * 
	 * 
	 * 
	 * <span class="hide">$Id: Client.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class Client implements ParameterType {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function Client(id:String = "") {
			super();
			
			this._id = id;
		}
		
		public static const TYPE:String = "client";
		
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
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @return
		 */
		public function getTypeName():String {
			return TYPE;
		}
		
		/**
		 * 
		 * @return
		 */
		public function toString():String {
			return _id
		}

		// クラスメソッド ///////////////////////////////////////////////////////////////////
		//                                                                   Class Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	xml
		 * @return
		 */
		public static function parse(xml:XML):* {
			return new Client(String(xml));
		}
		
	}

}