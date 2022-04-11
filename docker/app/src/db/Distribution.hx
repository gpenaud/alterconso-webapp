package db;
import sugoi.form.ListData;
import sys.db.Object;
import sys.db.Types;
import Common;

/**
 * Distrib
 */
@:index(date,orderStartDate,orderEndDate)
class Distribution extends Object
{
	public var id : SId;	
	
	@hideInForms @:relation(catalogId) 	public var catalog : db.Catalog;
	@hideInForms @:relation(multiDistribId) public var multiDistrib : MultiDistrib;
	
	//deprecated
	@formPopulate("placePopulate") @:relation(placeId) public var place : Place;
	public var date : SNull<SDateTime>; 
	public var end : SNull<SDateTime>;
	
	//when orders are open
	@hideInForms public var orderStartDate : SNull<SDateTime>; 
	@hideInForms public var orderEndDate : SNull<SDateTime>;
	
	//@hideInForms public var validated :SBool;
	
	public static var DISTRIBUTION_VALIDATION_LIMIT = 10;
	
	public function new() 
	{
		super();
		date = Date.now();
		end = DateTools.delta(date, 1000 * 60 * 90);

	}
	
	/**
	 * get group members list as form data
	 */
	public function distributorPopulate():FormData<Int> {
		if(App.current.user!=null && App.current.user.getGroup()!=null){
			return App.current.user.getGroup().getMembersFormElementData();				
		}else{
			return [];
		}
		
	}
	
	/**
	 * get groups places as form data
	 * @return
	 */
	public function placePopulate():FormData<Int> {
		var out = [];
		var places = new List();
		if(this.catalog!=null){
			//edit form
			places = db.Place.manager.search($groupId == this.catalog.group.id, false);
		}else{
			//insert form
			places = db.Place.manager.search($groupId == App.current.user.getGroup().id, false);
		}
		
		for (p in places) out.push( { label:p.name,value:p.id} );
		return out;
	}
	
	/*public function hasEnoughDistributors() {
		var n = contract.distributorNum;
		
		var d = 0;
		if (distributor1 != null) d++;
		if (distributor2 != null) d++;
		if (distributor3 != null) d++;
		if (distributor4 != null) d++;
		
		return (d >= n) ;
	}
	
	public function isDistributor(u:User) {
		if (u == null) return false;
		return (distributor1!=null && u.id == distributor1.id) || 
			(distributor2!=null && u.id == distributor2.id) || 
			(distributor3!=null && u.id == distributor3.id) || 
			(distributor4!=null && u.id == distributor4.id);
	}*/
	
	/**
	 * String to identify this distribution (debug use only)
	 */
	override public function toString() {
		return "#" + id + " Distribution du "+date.toString().substr(0,10)+" - " + catalog.name;		
	}
	
	public function getOrders() {
			
		// if ( this.catalog.type == db.Catalog.TYPE_CONSTORDERS){
		// 	var pids = db.Product.manager.search($catalog == this.catalog, false);
		// 	var pids = Lambda.map(pids, function(x) return x.id);		
		// 	return db.UserOrder.manager.search( ($productId in pids), false); 
		// }else{
		return db.UserOrder.manager.search($distribution == this, false); 
		// }
	}

	

	/**
		Has user Orders ?
	**/
	@:skip var pids : Array<Int>;
	public function hasUserOrders(user:db.User):Bool{
		/*if ( this.catalog.type == db.Catalog.TYPE_CONSTORDERS){
			if(pids==null) pids = tools.ObjectListTool.getIds(db.Product.manager.search($catalog == this.catalog, false));
			return db.UserOrder.manager.search( (($productId in pids) && ($user==user || $user2==user) ),{limit:1}, false).length > 0; 
		}else{*/
			return db.UserOrder.manager.search($distribution == this  && $user==user,{limit:1}, false).length > 0; 
		//}
	}

	public function getUserOrders(user:db.User):List<db.UserOrder>{
		// if ( this.catalog.type == db.Catalog.TYPE_CONSTORDERS){
		// 	if(pids==null) pids = tools.ObjectListTool.getIds(db.Product.manager.search($catalog == this.catalog, false));			
		// 	return db.UserOrder.manager.search( (($productId in pids) && ($user==user || $user2==user) ), false); 
		// }else{
			return db.UserOrder.manager.search($distribution == this  && $user==user, false); 
		// }
	}
	
	public function getUsers():Iterable<db.User>{		
		return tools.ObjectListTool.deduplicate( Lambda.map(getOrders(), function(x) return x.user ) );		
	}

	public function getBaskets(){
		var baskets = new Map<Int,db.Basket>();
		for( o in getOrders()){
			if(o.basket!=null) baskets.set(o.basket.id,o.basket);
		}
		return Lambda.array(baskets);
	}

	
	/**
	 * Get TTC turnover for this distribution
	 */
	public function getTurnOver():Float{
		var products = catalog.getProducts(false);
		if(products.length==0) return 0.0;
		var sql = "select SUM(quantity * productPrice) from UserOrder  where productId IN (" + tools.ObjectListTool.getIds(products).join(",") +") ";
		// if (catalog.type == db.Catalog.TYPE_VARORDER) {
			sql += " and distributionId=" + this.id;	
		// }
	
		return sys.db.Manager.cnx.request(sql).getFloatResult(0);
	}
	
	/**
	 * Get HT turnover for this distribution
	 */
	public function getHTTurnOver(){
		
		var pids = tools.ObjectListTool.getIds(catalog.getProducts(false));
		
		var sql = "select SUM(uc.quantity *  (p.price/(1+p.vat/100)) ) from UserOrder uc, Product p ";
		sql += "where uc.productId IN (" + pids.join(",") +") ";
		sql += "and p.id=uc.productId ";
		
		if (catalog.type == db.Catalog.TYPE_VARORDER) {
			sql += " and uc.distributionId=" + this.id;	
		}
	
		return sys.db.Manager.cnx.request(sql).getFloatResult(0);
	}
	
	/**
	 * 
	 */
	public function canOrderNow() {
		
		if (orderEndDate == null) {
			return this.catalog.isUserOrderAvailable();
		}else {
			var n = Date.now().getTime();
			var f = this.catalog.flags.has(UsersCanOrder);
			
			return f && n < orderEndDate.getTime() && n > orderStartDate.getTime();
			
		}
	}

	/**
	 * Get next multi-devliveries
	 * ( deliveries including more than one vendors )
	 */
	/*public static function getNextMultiDeliveries(){

		var out = new Map<String,{place:Place,startDate:Date,endDate:Date,active:Bool,products:Array<ProductInfo>}>();
		return Lambda.array(manager.search($orderStartDate <= Date.now() && $orderEndDate >= Date.now() && $contract==contract,false));

		var now = Date.now();

		var contracts = Contract.getActiveContracts(App.current.user.getGroup());
		var cids = Lambda.map(contracts, function(p) return p.id);

		//available deliveries + some of the next deliveries

		var distribs = db.Distribution.manager.search(($catalogId in cids) && $orderEndDate >= now, { orderBy:date }, false);
		var inOneMonth = DateTools.delta(now, 1000.0 * 60 * 60 * 24 * 30);
		for (d in distribs) {

			var o = out.get(d.getKey());
			if (o == null) o = {place:d.place, startDate:d.date,active:null, endDate:d.end, products:[]};
			for ( p in d.contract.getProductsPreview(8)){
				if (o.products.length >= 8) break;
				o.products.push(	p.infos() );
			}

			if (d.orderStartDate.getTime() <= now.getTime() ){
				//order currently open
				o.active = true;
			}else if (d.orderStartDate.getTime() <= inOneMonth.getTime() ){
				//open soon
				o.active = false;
			}else{
				continue;

			}

			out.set(d.getKey(), o);
		}
		return Lambda.array(out);
	}*/

	override public function update(){
		if(this.date!=null){
			this.end = new Date(this.date.getFullYear(), this.date.getMonth(), this.date.getDate(), this.end.getHours(), this.end.getMinutes(), 0);
		}
		
		super.update();
	}

	public function getInfos():DistributionInfos{
		var out = {
			id:id,
			groupId		: place.group.id,
			groupName 	: place.group.name,
			vendorId				: this.catalog.vendor.id,
			distributionStartDate	: date==null ? multiDistrib.distribStartDate.getTime() : date.getTime(),
			distributionEndDate		: end==null ? multiDistrib.distribEndDate.getTime() : end.getTime(),
			orderStartDate			: null,
			orderEndDate			: null,
			place 					: multiDistrib.place.getInfos()
		};

		out.orderStartDate = if(orderStartDate==null){
			if(multiDistrib.orderStartDate==null){
				null;
			}else{
				multiDistrib.orderStartDate.getTime();
			}
		}else{ 
			orderStartDate.getTime(); 
		};

		out.orderEndDate = if(orderEndDate==null){
			if(multiDistrib.orderEndDate==null){
				null;
			}else{
				multiDistrib.orderEndDate.getTime();
			}
		}else{ 
			orderEndDate.getTime(); 
		};

		return out;

	}

	/**
		Trick for retrocompat with code made before Multidistrib entity (2019-04)
	**/
	public function populate(){
		date =  date==null ? multiDistrib.distribStartDate : date;
		end  =  end==null ? multiDistrib.distribEndDate : end;
		orderStartDate = orderStartDate==null ? multiDistrib.orderStartDate : orderStartDate;
		orderEndDate = orderEndDate==null ? multiDistrib.orderEndDate : orderEndDate;
		place = null;

	}
	
	
	/**
     * Get open to orders deliveries
     * @param	contract
     */
    public static function getOpenToOrdersDeliveries(contract:db.Catalog){

        return Lambda.array(manager.search($orderStartDate <= Date.now() && $orderEndDate >= Date.now() && $catalog==contract,{orderBy:date},false));

    }

	/**
	 * Return a string like $placeId-$date.
	 * 
	 * It's an ID representing all the distributions happening on that day at that place.
	 */
	public function getKey():String{
		return db.Distribution.makeKey(this.date, this.place);
	}
	
	public static function makeKey(date, place){
		return date.toString().substr(0, 10) +"|"+Std.string(place.id);
	}	

	
	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"date" 				=> t._("Date"),
			"endDate" 			=> t._("End hour"),
			"place" 			=> t._("Place"),
			"distributor1" 		=> t._("Distributor #1"),
			"distributor2" 		=> t._("Distributor #2"),
			"distributor3" 		=> t._("Distributor #3"),
			"distributor4" 		=> t._("Distributor #4"),
		];
	}


}