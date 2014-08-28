package jp.wda.faist.type {
	
	/**
	 * 
	 * 
	 * 
	 * <span class="hide">$Id: Encrypted.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class Encrypted implements ParameterType {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	data
		 * @param	iv
		 */
		public function Encrypted(data:String, iv:String) {
			this._data = data;
			this._iv   = iv;
		}
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get data():String       { return _data; }
		/** @private */
		private var _data:String;
		
		/* ***********************************************************************>> */
		/**
		 * 
		 */
		public function get iv():String       { return _iv; }
		/** @private */
		private var _iv:String;
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @return
		 */
		public function getTypeName():String {
			return "encrypted";
		}
		
		/**
		 * 
		 * @return
		 */
		public function toString():String {
			return _data + "[" + _iv + "]"
		}
		
	}
	
}
