package  {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import jp.wda.faist.selector.ClientSelector;
	import jp.wda.faist.ServerKernel;
	
	use namespace flash_proxy;
	
	/**
	 * 
	 * ...
	 * 
	 * <span class="hide">$Id: ClientProxy.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 * @private
	 */
	public dynamic class ClientProxy extends Proxy {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function ClientProxy(kernel:ServerKernel, selector:Object, handler:String) {
			this.kernel   = kernel;
			this.selector = selector;
			this.handler  = handler;
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var kernel:ServerKernel;
		/**  */
		private var selector:Object;
		/**  */
		private var handler:String;
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param	methodName
		 * @param	...args
		 * @return
		 */
		flash_proxy override function callProperty(methodName:*, ...args):* {
			var xml:XML = <invoke method={methodName.toString()} handler={handler}><params/></invoke>;
			if (selector != null) {
				if (selector is ClientSelector) {
					(selector as ClientSelector).appendCondition(xml);
				} else {
					xml.@selector = "clientID";
					xml.@clientID = selector.toString();
				}
			} else {
				xml.@selector = "all";
			}
			
			kernel.remoteCall(xml, args);
		}
		
	}

}