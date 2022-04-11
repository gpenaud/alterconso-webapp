package tools;
import Common.UserOrder;

/**
 * Utility to work on sys.db.Object lists
 * @author fbarbut
 */
class ObjectListTool
{

	/**
	 * Get a list of IDs from an object list
	 */
	public static function getIds( objs:Iterable<sys.db.Object> ):Array<Int>{
		var out = new Array<Int>();
		for ( o in objs ) out.push(untyped o.id);
		return out;
	}
	
	/**
	 * deduplicate objects on IDs
	 */
	public static function deduplicate<T>(objs:Iterable<T>):Array<T>{
		var out = new Map<Int,T>();
		for ( u in objs){
			if(u!=null) out.set( untyped u.id, u );
		} 
		return Lambda.array(out);
	}


	public static function toIdMap<T>(objs:Iterable<T>):Map<Int,T>{
		var out = new Map<Int,T>();
		for ( u in objs) out.set( untyped u.id, u );
		return out;
	}
	
	/**
	 * Deduplicate user orders. (merge orders on same product from a same user)
	 * @param	orders
	 * @return
	 */
	public static function deduplicateOrders(orders:Array<UserOrder>):Array<UserOrder>{
		
		var out = new Map<String,UserOrder>();
		
		for ( o in orders){
			
			var key = o.userId + "-" + o.userId2 + "-" + o.productId;
			var x = out.get(key);
			if ( x == null){				
				x = o;				
			}else{
				//null safety
				if (x.fees == null) x.fees = 0;
				if (o.fees == null) o.fees = 0;
				
				//merge
				x.quantity += o.quantity;
				x.fees += o.fees;
				x.subTotal += o.subTotal;
				x.total += o.total;
			}
			
			out.set(key, x);
		}
		
		return Lambda.array(out);
	}
	
	/**
	 * Deduplicate distributions by key (date+placeId)
	 * @param	distribs
	 */
	public static function deduplicateDistribsByKey(distribs:Iterable<db.Distribution>){
		
		var out = new Map<String,db.Distribution>();
		for ( d in distribs) out.set(d.getKey(), d);
		return Lambda.array(out);
	}
	
	/**
	 * Group distributions by key (date+placeId)
	 * @param	distribs
	 */
	public static function groupDistribsByKey(distribs:Iterable<db.Distribution>){
		
		var out = new Map<String,Array<db.Distribution>>();
		for ( d in distribs) {
			
			var v = out.get(d.getKey());
			if (v == null) v = [];
			v.push(d);			
			out.set(d.getKey(), v);
		}
		return out;
	}
	
	/**
	 * Groupe orders by multidistrib key (date+placeId)
	 */
	public static function groupOrdersByKey(ucs:Iterable<db.UserOrder>){
		
		var out = new Map<String,Array<db.UserOrder>>();
		for ( uc in ucs) {
			var k = uc.distribution.getKey();
			var v = out.get(k);
			if (v == null) v = [];
			v.push(uc);			
			out.set(k, v);
		}
		return out;
	}
	
	/**
	 * Group distributions by group and day, order by day
	 */
	public static function groupDistributionsByGroupAndDay(dists:Iterable<db.Distribution>){
		
		var out = new Map<String,Array<db.Distribution>>();
		for ( d in dists){
			
			var k = d.date.toString().substr(0, 10) + "-" + d.catalog.group.id;
			
			var x = out[k];
			if (x == null) x = [];
			x.push(d);
			out[k] = x;
			
		}
		
		//sort keys
		var keys = [];
		for ( k in out.keys()) keys.push(k);
		keys.sort(function(a, b){  if (a > b) return 1 else return -1; });

		var out2 = [];
		for ( k in keys) out2.push(out[k]);
		
		return out2;		
	}
	


	
}