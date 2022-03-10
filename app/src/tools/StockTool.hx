package tools;

/**
 * ...
 * @author fbarbut
 */
class StockTool
{

	/**
	 * Stock dispatching between groups.
	 * 
	 * i.e we got 10kg of potatoes to dispatch with 3 groups.
	 * I dont want to have 3,3333 kg for each group , but something like [3,3,4]
	 */
	public static function dispatch(stock:Int, groups:Int){
		
		var out = [];
		var modulo = stock % groups;
		stock -= modulo;
		var s = Math.round(stock / groups);
		for ( i in 0...groups) out.push(s);
		for (i in 0...modulo) out[i % out.length]++;
		return out;
	}

	/**
		Dispatch equally a stock among offers.

		i.e : we got a bulk product : wheat flour.
		we got 2 offers : 1kg and 10kg.
		As it is a bluk product, stock is managed "by product"
		we need to compute how to dispatch the stock among offers.

		@param offers : ref-> qt in offer
		@return stocks : ref -> quantity of offer
	**/
	public static function dispatchOffers(baseStock:Int,offers:Map<String,Int>){

	
		//out : ref -> quantity of product
		var stocks = new Map<String,Int>();

		var totalQts = 0;
		for( off in offers) totalQts+=off;

		//divide baseStock equally between offers
		var a = Math.floor( baseStock / Lambda.count(offers) );
		// trace('amount to dispatch between offers = $a kg');

		//id of the lowest qt offer
		var lowest = null;
		for(k in offers.keys()){
			var off = offers[k];
			if(lowest==null || offers[lowest] > off) lowest = k;
		}
		// trace('lowest offer is #$lowest : '+offers[lowest]+" kg");

		for(k in offers.keys()){
			var off = offers[k];
			var amount = Math.floor(a/off);
			baseStock -= amount*off;
			stocks.set( k , amount );
		}

		// trace(stocks);

		//spread remaining stock
		if(baseStock>0){
			// trace('remains $baseStock to dispatch');
			// trace('add '+Math.floor( baseStock / offers[lowest] )+" units of offer #"+lowest);
			stocks[lowest] = stocks[lowest] + Math.floor( baseStock / offers[lowest] );
		}
		
		// trace(stocks);

		return stocks;


	}
	
}