package jp.wda.faist.events {
	
	/**
	 * 修復不能なエラーが発生した場合に送出されるイベントです。
	 * 
	 * <span class="hide">$Id: FatalErrorEvent.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class FatalErrorEvent extends FaistErrorEvent {
		
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
		public function FatalErrorEvent(code:int, message:String = "", xml:XML = null, type:String = ERROR) {
			super(code, message, xml, type);
		}
		
		/**
		 * FatalErrorEvent.ERROR 定数は、
		 * サーバとの接続に修復不能なエラーが発生した場合に送出されるイベントオブジェクトの
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
		 *   <tr><td>type</td><td>FatalErrorEvent.ERROR</td></tr>
		 * </table>
		 * 
		 * @eventType fatalError
		 */
		public static const ERROR:String = "jp.wda.faist.events.FatalErrorEvent:ERROR";
		
	}

}