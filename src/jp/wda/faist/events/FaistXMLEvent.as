package jp.wda.faist.events {
	
	/**
	 * XML情報を保持したイベントです。
	 * 
	 * <span class="hide">$Id: FaistXMLEvent.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class FaistXMLEvent extends FaistEvent {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	type
		 * @param	xml
		 */
		public function FaistXMLEvent(type:String, xml:XML) {
			super(type, false, false);
			
			this.xml = xml;
		}
		
		/**
		 * FaistXMLEvent.LAUNCH_COMPLETED 定数は、
		 * Kernelの起動が完了した場合に送出されるイベントのイベントオブジェクトの
		 * <code>type</code> プロパティ値を定義します。
		 * 
		 * <p>
		 * イベントオブジェクトの各プロパティには次の値が設定されています。
		 * イベントの種類によっては無効なプロパティもあります。詳細については、各プロパティの説明を参照してください。
		 * </p>
		 * 
		 * <table class="innertable">
		 *   <tr><th>プロパティ</th><th>値</th></tr>
		 *   <tr><td>xml</td><td>リフレクタからの初期化情報。</td></tr>
		 *   <tr><td>bubbles</td><td>false</td></tr>
		 *   <tr><td>cancelable</td><td>false</td></tr>
		 *   <tr><td>currentTarget</td><td>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 *   <tr><td>target</td><td>progress イベントに対するリスナーが登録された任意の DisplayObject インスタンスです。</td></tr>
		 *   <tr><td>type</td><td>FaistXMLEvent.LAUNCH_COMPLETED</td></tr>
		 * </table>
		 * 
		 * @eventType launchCompleted
		 */
		public static const LAUNCH_COMPLETED:String = "jp.wda.faist.events.FaistXMLEvent:LAUNCH_COMPLETED";
		
		/**
		 * FaistXMLEvent.REQUEST 定数は、
		 * クライアントからの新たな接続があった場合に送出されるイベントのイベントオブジェクトの
		 * <code>type</code> プロパティ値を定義します。
		 * 
		 * <p>
		 * イベントオブジェクトの各プロパティには次の値が設定されています。
		 * イベントの種類によっては無効なプロパティもあります。詳細については、各プロパティの説明を参照してください。
		 * </p>
		 * 
		 * <table class="innertable">
		 *   <tr><th>プロパティ</th><th>値</th></tr>
		 *   <tr><td>xml</td><td>接続クライアント情報。xml.&#064;clientID を用いて、クライアントを識別してください。</td></tr>
		 *   <tr><td>bubbles</td><td>false</td></tr>
		 *   <tr><td>cancelable</td><td>false</td></tr>
		 *   <tr><td>currentTarget</td><td>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 *   <tr><td>target</td><td>progress イベントに対するリスナーが登録された任意の DisplayObject インスタンスです。</td></tr>
		 *   <tr><td>type</td><td>FaistXMLEvent.REQUEST</td></tr>
		 * </table>
		 * 
		 * @eventType request
		 */
		public static const REQUEST:String	= "jp.wda.faist.events.FaistXMLEvent:REQUEST";
		
		/**
		 * FaistXMLEvent.LEAVE 定数は、
		 * クライアントが切断された場合に送出されるイベントのイベントオブジェクトの
		 * <code>type</code> プロパティ値を定義します。
		 * 
		 * <p>
		 * イベントオブジェクトの各プロパティには次の値が設定されています。
		 * イベントの種類によっては無効なプロパティもあります。詳細については、各プロパティの説明を参照してください。
		 * </p>
		 * 
		 * <table class="innertable">
		 *   <tr><th>プロパティ</th><th>値</th></tr>
		 *   <tr><td>xml</td><td>切断クライアント情報。xml.&#064;clientID を用いて、クライアントを識別してください。</td></tr>
		 *   <tr><td>bubbles</td><td>false</td></tr>
		 *   <tr><td>cancelable</td><td>false</td></tr>
		 *   <tr><td>currentTarget</td><td>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 *   <tr><td>target</td><td>progress イベントに対するリスナーが登録された任意の DisplayObject インスタンスです。</td></tr>
		 *   <tr><td>type</td><td>FaistXMLEvent.LEAVE</td></tr>
		 * </table>
		 * 
		 * @eventType leave
		 */
		public static const LEAVE:String	= "jp.wda.faist.events.FaistXMLEvent:LEAVE";
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * XML情報。
		 */
		public function get xml():XML       { return _xml; }
		/** @private */
		public function set xml(v:XML):void { _xml = v; }
		/** @private */
		private var _xml:XML;
		
	}

}