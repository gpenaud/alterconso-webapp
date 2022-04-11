package service;

class ProductService{


	/**
	 * Batch disable products
	 */
	public static function batchDisableProducts(productIds:Array<Int>){

		var data = {pids:productIds,enable:false};
		var contract = db.Product.manager.get(productIds[0], true).catalog;
		var products = contract.getProducts(false);

		App.current.event( BatchEnableProducts(data) );
		
		for ( pid in data.pids){
			
			var p = db.Product.manager.get(pid, true);

			if ( Lambda.find(products,function(p) return p.id==pid)==null ) throw 'product $pid is not in this contract !';
			
			p.active = false;
			p.update();
		}
	}


	/**
	 * Batch enable products
	 */
	public static function batchEnableProducts(productIds:Array<Int>){

		var data = {pids:productIds,enable:true};
		var contract = db.Product.manager.get(productIds[0], true).catalog;
		var products = contract.getProducts(false);

		App.current.event( BatchEnableProducts(data) );
		
		for ( pid in data.pids){
			
			var p = db.Product.manager.get(pid, true);

			if ( Lambda.find(products,function(p) return p.id==pid)==null ) throw 'product $pid is not in this contract !';
			
			p.active = true;
			p.update();
		}
	}

	inline public static function getHTPrice(ttcPrice:Float,vatRate:Float):Float{
		return ttcPrice / (1 + vatRate / 100);
	}

	public static function getCategorizerHtml(productName:String,categId:Int,formName:String){

		productName = Formatting.escapeJS(productName);
		return '<div id="pInput"></div><script language="javascript">_.getProductInput("pInput","${productName}",$categId,"${formName}");</script>';
	}



}