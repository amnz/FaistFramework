/* *****************************************************************************
 * 
 * Copyright(C) The MONAZITE Project Team and the Others. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 * 
 * 参考)
 * Apache License, Version 2.0 日本語訳 by Open Source Group Japan
 * 
 *     http://sourceforge.jp/projects/opensource/wiki/licenses%2FApache_License_2.0
 * 
 * ***************************************************************************** */

package jp.wda.faist {
	import flash.events.DataEvent;
	import flash.events.Event;
	import jp.wda.faist.events.FaistErrorEvent;
	import jp.wda.faist.type.Client;
	
	/**
	 * Faistクライアントを作成するためのFaistカーネル
	 * 
	 * 
	 * <span class="hide">$Id: ClientKernel.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public final class ClientKernel extends Kernel {
		
		// コンストラクタ ///////////////////////////////////////////////////////////////////
		//                                                                    Constructors //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 *
		 *	
		 */
		public function ClientKernel() {
			super();
			
			this._myself = new Client();
		}
		
		// プロパティ ///////////////////////////////////////////////////////////////////////
		//                                                                      Properties //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/* ***********************************************************************>> */
		/**
		 * サーバ側のハンドラメソッドのClient型の引数に対して、このプロパティの値を渡してください。
		 */
		public function get myself():Client       { return _myself; }
		/** @private */
		private var _myself:Client;
		
		// インスタンスメソッド /////////////////////////////////////////////////////////////
		//                                                                Instance Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * サーバプロクシを作成します。引数は現在必要ありません。
		 * 
		 * @param	handler
		 * @return
		 */
		public function server(handler:String = "root"):ServiceProxy {
			return new ServiceProxy(this, handler);
		}
		
		// 内部メソッド /////////////////////////////////////////////////////////////////////
		//                                                                 Private Methods //
		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @private
		 */
		protected override function intialize():void {
			socket.send("<connect service=\"" + serviceName + "\" password=\"" + encrypt(password) + "\"/>");
		}

	}

}