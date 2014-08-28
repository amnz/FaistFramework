package jp.wda.faist {
	import com.hurlant.math.BigInteger;
	import com.hurlant.util.Hex;
	
	/**
	 * 
	 * ...
	 * 
	 * <span class="hide">$Id: FaistUtil.as,v 0:1464a6555f72 2012/05/29 10:34:49 amnz $</span>
	 * @author		$Author: amnz $
	 * @revision	$Revision: 0:1464a6555f72 $
	 * @date		$Date: Tue, 29 May 2012 19:34:49 +0900 $
	 */
	public class FaistUtil {
		
		/**  */
		public static const DH_GENERATOR:BigInteger = new BigInteger("2");
		/**  */
		public static const DH_PRIME:BigInteger = new BigInteger(Hex.toArray(
			"FFFFFFFF FFFFFFFF C90FDAA2 2168C234 C4C6628B 80DC1CD1" + 
			"29024E08 8A67CC74 020BBEA6 3B139B22 514A0879 8E3404DD" + 
			"EF9519B3 CD3A431B 302B0A6D F25F1437 4FE1356D 6D51C245" + 
			"E485B576 625E7EC6 F44C42E9 A637ED6B 0BFF5CB6 F406B7ED" + 
			"EE386BFB 5A899FA5 AE9F2411 7C4B1FE6 49286651 ECE65381" + 
			"FFFFFFFF FFFFFFFF"
			));
		
		/**  */
		public static const MESSAGE_DIGEST:String = "md5";
		/**  */
		public static const CIPHER:String = "blowfish-cbc";
		
		/** 接続先Socklet */
		public static const SOCKLET:String = "faist";
		
		/** シェアドオブジェクト名 */
		public static const SHARED_OBJECT_NAME:String = "FAIST_Shared";
		
	}

}