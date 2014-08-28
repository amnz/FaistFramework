package jp.wda.faist.events {
	import flash.events.Event;
	
	/**
	 * Faistフレームワークで使用するイベントの基底クラスです。
	 * 
	 * $Id: FaistEvent.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class FaistEvent extends Event {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function FaistEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}

}