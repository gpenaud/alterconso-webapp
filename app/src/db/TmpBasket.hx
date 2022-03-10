package db;
import sys.db.Object;
import sys.db.Types;
import Common;

/**
 * Temporary Basket
 */
@:index(ref)
class TmpBasket extends Object
{
    public var id : SId;
	public var ref : SNull<SString<256>>;
	public var cdate : SDateTime; //date when the order has been placed
	public var data : SData<TmpBasketData>;
    @:relation(userId)  public var user  : SNull<db.User>; //ordering is possible without being logged
    @:relation(multiDistribId) public var multiDistrib : db.MultiDistrib;
	
	public function new(){
		super();
		cdate = Date.now();
	}

	
	/**
		Get total amount to pay for this basket
	**/
	public function getTotal():Float{
		var total = 0.0;
		for( o in data.products){
			var p = db.Product.manager.get(o.productId,false);
			if(p==null) continue;
			total += o.quantity * p.getPrice();
		}
		return total;
	}

	public function getOrders(){
		var out = new Array<{product:db.Product,quantity:Float}>();
		for( o in data.products){
			var p = db.Product.manager.get(o.productId,false);
			if(p==null) continue;
			out.push({product:p , quantity : o.quantity});
		}
		return out;
	}

	
	
}