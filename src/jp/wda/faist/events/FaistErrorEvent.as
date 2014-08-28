package jp.wda.faist.events {
	
	/**
	 * サーバとの接続に何らかのエラーが発生した場合に送出されるイベントです。
	 * 
	 * <span class="hide">$Id: FaistErrorEvent.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class FaistErrorEvent extends FaistXMLEvent {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	code
		 * @param	message
		 * @param	xml
		 * @param	type
		 */
		public function FaistErrorEvent(code:int, message:String = "", xml:XML = null, type:String = ERROR) {
			super(type, xml);
			
			this._errcode = code;
			this._message = message;
		}
		
		/**
		 * FaistErrorEvent.ERROR 定数は、
		 * サーバとの接続に何らかのエラーが発生した場合に送出されるイベントオブジェクトの
		 * <code>type</code> プロパティ値を定義します。
		 * 
		 * <p>
		 * イベントオブジェクトの各プロパティには次の値が設定されています。
		 * イベントの種類によっては無効なプロパティもあります。詳細については、各プロパティの説明を参照してください。
		 * </p>
		 * 
		 * <table class="innertable">
		 *   <tr><th>プロパティ</th><th>値</th></tr>
		 *   <tr><td>errcode</td><td>エラーコード。</td></tr>
		 *   <tr><td>message</td><td>エラーメッセージ。</td></tr>
		 *   <tr><td>xml</td><td>その他エラーに関する情報。</td></tr>
		 *   <tr><td>bubbles</td><td>false</td></tr>
		 *   <tr><td>cancelable</td><td>false</td></tr>
		 *   <tr><td>currentTarget</td><td>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 *   <tr><td>target</td><td>progress イベントに対するリスナーが登録された任意の DisplayObject インスタンスです。</td></tr>
		 *   <tr><td>type</td><td>FaistErrorEvent.ERROR</td></tr>
		 * </table>
		 * 
		 * @eventType error
		 */
		public static const ERROR:String = "jp.wda.faist.events.FaistErrorEvent:ERROR";
		
		/** 初期設定不良 */
		public static const ERR_CONFIGURATION_FAILURE:int	= 0;
		/** リフレクタサーバへの接続失敗 */
		public static const ERR_CONNECTION_FAILURE:int		= 1;
		/** リフレクタサーバからの切断 */
		public static const ERR_CONNECTION_CLOSE:int		= 2;
		/** アクセス拒否 */
		public static const ERR_ACCES_DENIED:int			= 3;
		/** コマンド不明 */
		public static const ERR_UNKNOWN_COMMAND:int			= 4;
		/** 不明なメソッド */
		public static const ERR_UNKNOWN_METHOD:int			= 5;
		
		/** サービス名使用不可 */
		public static const ERR_SERVICENAME_ALREADY_USED:int= 1001;
		/** サービス不明 */
		public static const ERR_SERVICE_NOT_FOUND:int		= 1002;
		/** サービス停止中 */
		public static const ERR_SERVICE_DOWN:int			= 1003;
		/** サービス起動中 */
		public static const ERR_SERVICE_ALREADY_LAUNCHED:int= 1004;
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * エラーコード。
		 */
		public function get errcode():int       { return _errcode; }
		/** @private */
		private var _errcode:int;
		
		/* ***********************************************************************>> */
		/**
		 * エラーメッセージ。
		 */
		public function get message():String       { return _message; }
		/** @private */
		private var _message:String;
		
	}

}