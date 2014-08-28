package jp.wda.faist.events {
	/**
	 * 起動処理の進捗状況を報告するためのイベントです。
	 * 
	 * <span class="hide">$Id: LaunchProgressEvent.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class LaunchProgressEvent extends FaistEvent {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	progress
		 */
		public function LaunchProgressEvent(progress:int) {
			super(PROGRESS, false, false);
			
			this._progress = progress;
		}
		/**
		 * LaunchProgressEvent.PROGRESS 定数は、
		 * 起動処理が進行するごとに送出されるイベントのイベントオブジェクトの
		 * <code>type</code> プロパティ値を定義します。
		 * 
		 * <p>
		 * イベントオブジェクトの各プロパティには次の値が設定されています。
		 * イベントの種類によっては無効なプロパティもあります。詳細については、各プロパティの説明を参照してください。
		 * </p>
		 * 
		 * <table class="innertable">
		 *   <tr><th>プロパティ</th><th>値</th></tr>
		 *   <tr><td>progress</td><td>
		 *     進捗状況。
		 *     <table class="innertable">
		 *       <tr><th>値</th><th>進捗状況</th></tr>
		 *       <tr><td>LaunchProgressEvent.VALIDATE</td><td>リフレクタサーバ接続設定値検査</td></tr>
		 *       <tr><td>LaunchProgressEvent.CREATE_PRIVATE_KEY</td><td>秘密鍵作成</td></tr>
		 *       <tr><td>LaunchProgressEvent.CONNECT_TO_REFLECTOR</td><td>リフレクタサーバへの接続</td></tr>
		 *       <tr><td>LaunchProgressEvent.HANDSHAKE</td><td>リフレクタサーバとの接続</td></tr>
		 *       <tr><td>LaunchProgressEvent.INITIALIZE</td><td>接続初期化</td></tr>
		 *     </table>
		 *   </td></tr>
		 *   <tr><td>bubbles</td><td>false</td></tr>
		 *   <tr><td>cancelable</td><td>false</td></tr>
		 *   <tr><td>currentTarget</td><td>イベントリスナーで Event オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 *   <tr><td>target</td><td>progress イベントに対するリスナーが登録された任意の DisplayObject インスタンスです。</td></tr>
		 *   <tr><td>type</td><td>LaunchProgressEvent.PROGRESS</td></tr>
		 * </table>
		 * 
		 * @eventType progress
		 */
		public static const PROGRESS:String = "jp.wda.faist.events.LaunchProgressEvent:PROGRESS";
		
		/** 起動処理進捗状況 : リフレクタサーバ接続設定値検査 */
		public static const VALIDATE:int				= 0;
		/** 起動処理進捗状況 : 秘密鍵作成 */
		public static const CREATE_PRIVATE_KEY:int		= 1;
		/** 起動処理進捗状況 : リフレクタサーバへの接続 */
		public static const CONNECT_TO_REFLECTOR:int	= 2;
		/** 起動処理進捗状況 : リフレクタサーバとの接続 */
		public static const HANDSHAKE:int				= 3;
		/** 起動処理進捗状況 : 接続初期化 */
		public static const INITIALIZE:int				= 4;
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * 起動処理の進捗状況。
		 */
		public function get progress():int       { return _progress; }
		/** @private */
		private var _progress:int;
		
	}

}