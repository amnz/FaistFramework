package jp.wda.faist.selector {
	
	/**
	 * 
	 * 
	 * 
	 * <span class="hide">$Id: ClientSelector.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public interface ClientSelector {
		
		/**
		 * 
		 * @param	xml
		 */
		function appendCondition(xml:XML):void;
		
	}
	
}