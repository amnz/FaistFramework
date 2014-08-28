package  {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import jp.wda.faist.ClientKernel;
	
	use namespace flash_proxy;
	
	/**
	 * 
	 * ...
	 * 
	 * <span class="hide">$Id: ServiceProxy.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 * @private
	 */
	public dynamic class ServiceProxy extends Proxy {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	デフォルトの設定を用いてオブジェクトを構築するコンストラクタ
		 */
		public function ServiceProxy(kernel:ClientKernel, handler:String) {
			this.kernel  = kernel;
			this.handler = handler;
		}
		
		// 内部フィールド定義 ///////////////////////////////////////////////////////////////
		//                                                                          Fields //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**  */
		private var kernel:ClientKernel;
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
			kernel.remoteCall(<invoke method={methodName.toString()} handler={handler}><params/></invoke>, args);
		}
		
	}

}