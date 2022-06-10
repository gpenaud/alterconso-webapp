package db;
import sys.db.Object;
import sys.db.Types;
import Common;
using tools.ObjectListTool;
using Lambda;
import haxe.Json;
import service.TimeSlotsService;


/**
 * MultiDistrib represents a global distributions with many vendors. 	
 * @author fbarbut
 */
@:index(distribStartDate)
class MultiDistrib extends Object
{
	public var id : SId;
	
	public var distribStartDate : SDateTime; 
	public var distribEndDate : SDateTime;	
	public var orderStartDate : SNull<SDateTime>; 
	public var orderEndDate : SNull<SDateTime>;

	//time slots management
	@hideInForms public var slotsMode : SNull<SData<String>>;
	@hideInForms public var slots : SNull<SData<Array<Slot>>>;
	@hideInForms public var inNeedUserIds : SNull<SData<Map<Int, Array<String>>>>;
	@hideInForms public var voluntaryUsers : SNull<SData<Map<Int, Array<Int>>>>;
	
	@hideInForms @:relation(groupId) public var group : db.Group;
	@formPopulate("placePopulate") @:relation(placeId) public var place : Place;
	@hideInForms @:relation(distributionCycleId) public var distributionCycle : SNull<DistributionCycle>;

	@hideInForms public var counterBeforeDistrib:SFloat; //counter before distrib "fond de caisse"
	@hideInForms public var volunteerRolesIds : SNull<String>;

	@hideInForms public var validated:SNull<SBool>;

	@:skip public var contracts : Array<db.Catalog>;
	@:skip public var extraHtml : String;
	
	public function new(){
		super();
		contracts = [];
		extraHtml = "";
		validated = false;
	}
	
	/**
		Get a distribution for date + place.
	**/
	public static function get(date:Date, place:db.Place, ?lock=false){
		var start = tools.DateTool.setHourMinute(date, 0, 0);
		var end = tools.DateTool.setHourMinute(date, 23, 59);

		return db.MultiDistrib.manager.select($distribStartDate>=start && $distribStartDate<=end && $place==place,lock);
	}

	public static function getFromTimeRange( group: db.Group, from: Date, to: Date ) : Array<MultiDistrib> {

		var multidistribs = new Array<db.MultiDistrib>();
		var start = tools.DateTool.setHourMinute(from, 0, 0);
		var end = tools.DateTool.setHourMinute(to, 23, 59);
		
		multidistribs = Lambda.array(db.MultiDistrib.manager.search( $group == group && $distribStartDate >= start && $distribStartDate < end, false ));
		
		//sort by date desc
		multidistribs.sort(function(x,y){
			return Math.round( x.getDate().getTime()/1000 ) - Math.round(y.getDate().getTime()/1000 );
		});

		//trigger event
		for(md in multidistribs) App.current.event(MultiDistribEvent(md));

		return multidistribs;
	}

	/**
	 * TODO : refacto this to use getFromTimeRange();
	 */
	/*public static function getNextMultiDeliveries(group:db.Group){
		
		var out = new Map < String, {
			place:db.Place, 		//common delivery place
			startDate:Date, 		//global delivery start
			endDate:Date,			//global delivery stop
			orderStartDate:Date, 	//global orders opening date
			orderEndDate:Date,		//global orders closing date
			active:Bool,
			products:Array<ProductInfo>, //available products ( if no order )
			myOrders:Array<{distrib:db.Distribution,orders:Array<UserOrder>}>	//my orders			
		}>();
		
		var n = Date.now();
		var now = new Date(n.getFullYear(), n.getMonth(), n.getDate(), 0, 0, 0);
	
		var contracts = db.Catalog.getActiveContracts(group);
		var cids = Lambda.map(contracts, function(p) return p.id);
		
		//var pids = Lambda.map(db.Product.manager.search($catalogId in cids,false), function(x) return x.id);
		//var out =  UserOrder.manager.search(($userId == id || $userId2 == id) && $productId in pids, lock);	
		
		//available deliveries
		var inSixMonth = DateTools.delta(now, 1000.0 * 60 * 60 * 24 * 30 * 6);
		var distribs = db.Distribution.manager.search(($catalogId in cids) && $date >= now && $date <= inSixMonth , { orderBy:date }, false);
		
		for (d in distribs) {			
			
			//we had the distribution key ( place+date ) and the contract type in order to separate constant and varying contracts
			var key = d.getKey() + "|" + d.contract.type;
			var o = out.get(key);
			if (o == null) o = {place:d.place, startDate:d.date, active:null, endDate:d.end, products:[], myOrders:[], orderStartDate:null,orderEndDate:null};
			
			//user orders
			var orders = [];
			if(App.current.user!=null) orders = d.contract.getUserOrders(App.current.user,d);
			if (orders.length > 0){
				o.myOrders.push({distrib:d,orders:service.OrderService.prepare(orders)});
			}else{
				//no "order block" if no shop mode	
				if (!group.hasShopMode() ) {		
					continue;		
				}		

				//if its a constant order contract, skip this delivery		
				if (d.contract.type == db.Catalog.TYPE_CONSTORDERS){		
					continue;		
				}
				
				//products preview if no orders
				for ( p in d.contract.getProductsPreview(9)){
					o.products.push( p.infos(null,false) );	
				}	
			}
			
			if (d.contract.type == db.Catalog.TYPE_VARORDER){
				
				//old distribs may have an empty orderStartDate
				if (d.orderStartDate == null) {
					continue;
				}
				
				//if order opening is more far than 1 month, skip it
				// if (d.orderStartDate.getTime() > inOneMonth.getTime() ){
				// 	continue;
				// }
				
				//display closest opening date
				if (o.orderStartDate == null){
					o.orderStartDate = d.orderStartDate;
				}else if (o.orderStartDate.getTime() > d.orderStartDate.getTime()){
					o.orderStartDate = d.orderStartDate;
				}
				
				//display most far closing date
				if (o.orderEndDate == null){
					o.orderEndDate = d.orderEndDate;
				}else if (o.orderEndDate.getTime() < d.orderEndDate.getTime()){
					o.orderEndDate = d.orderEndDate;
				}
				
				out.set(key, o);	
				
			}else{
				//in constant orders, add block only if there is an order
				if(o.myOrders.length>0) out.set(key, o);
				
			}
		}
		
		//shuffle and limit product lists		
		for ( o in out){
			o.products = thx.Arrays.shuffle(o.products);			
			o.products = o.products.slice(0, 9);
		}
		
		//decide if active or not
		var now = Date.now();
		for( o in out){
			
			if (o.orderStartDate == null) continue; //constant orders
			
			if (now.getTime() >= o.orderStartDate.getTime()  && now.getTime() <= o.orderEndDate.getTime() ){
				//order currently open
				o.active = true;
				
			}else {
				o.active = false;
				
			}
		}	
		
		return Lambda.array(out);
	}*/

	public function getPlace(){
		return place;
	}

	public function getDate(){
		return distribStartDate;
	}

	public function getEndDate(){
		return distribEndDate;
	}

	/**
		prepare an excerpt of products ( and store it in cache )
	**/
	static var PRODUCT_EXCERPT_KEY = "productsExcerpt";

	public function getProductsExcerpt(productNum:Int):Array<{name:String,image:String}>{
		var key = PRODUCT_EXCERPT_KEY+this.id;
		var cache:Array<{rid:Int,name:String,image:String}> = sugoi.db.Cache.get(key);
		if(cache!=null){
			return cache;
		}else{
			cache = [];
			for( d in getDistributions(db.Catalog.TYPE_VARORDER)){
				for ( p in d.catalog.getProductsPreview(productNum)){
					cache.push( {
						rid : p.image!=null ? Std.random(500)+500 : Std.random(500),
						name:p.name,
						image:p.getImage()
					} );	
				}
			}

			//randomize
			cache.sort(function(a,b){
				return b.rid - a.rid;
			});
			cache = cache.slice(0, productNum);

			sugoi.db.Cache.set(key, cache , 3600*12 );
			return cache;	
		}

	}

	public function deleteProductsExcerpt(){
		sugoi.db.Cache.destroy(PRODUCT_EXCERPT_KEY+this.id);
	}

	public function userHasOrders(user:db.User,type:Int):Bool{
		if(user==null) return false;
		for ( d in getDistributions(type)){
			if(d.hasUserOrders(user)) return true;						
		}
		return false;
	}
	
	/**
		Are orders currently open ?
		( including exceptions )
	**/
	public function isActive(){

		if (getOrdersStartDate() == null) return false; //constant orders
			
		var now = Date.now();	
		if (now.getTime() >= getOrdersStartDate(true).getTime()  && now.getTime() <= getOrdersEndDate(true).getTime() ){			
			return true;				
		}else {
			return false;				
		}
	}

	public function getOrdersStartDate(?includingExceptions=false){
		if(includingExceptions){
			if(orderStartDate==null) return null;
			//find earliest order start date 
			var date = orderStartDate;
			for(d in getDistributions(db.Catalog.TYPE_VARORDER)){
				if(d.orderStartDate==null) continue;
				if(d.orderStartDate.getTime() < date.getTime()) date = d.orderStartDate;
			}
			return date;
		}else{
			return orderStartDate;
		}
		
	}

	public function getOrdersEndDate(?includingExceptions=false){
		if(includingExceptions){
			if(orderEndDate==null) return null;
			//find lates order end date 
			var date = orderEndDate;
			for(d in getDistributions(db.Catalog.TYPE_VARORDER)){
				if(d.orderEndDate==null) continue;
				if(d.orderEndDate.getTime() > date.getTime()) date = d.orderEndDate;
			}
			return date;
		}else{
			return orderEndDate;
		}
		
	}

	/**
		Get distributions for constant orders or variable orders.
	**/
	@:skip private var distributionsCache:Array<db.Distribution>;
	@:skip public var useCache:Bool;
	public function getDistributions(?type:Int){
		
		if(distributionsCache==null || useCache!=true){
			distributionsCache = Lambda.array( db.Distribution.manager.search($multiDistrib==this,false) );
		}

		if(type==null){
			return distributionsCache;
		}else{
			var out = [];
			for ( d in distributionsCache){
				if( d.catalog.type==type ) out.push(d);
			}
			return out;
		} 
		
	}

	public function getDistributionForContract(contract:db.Catalog):db.Distribution{
		for( d in getDistributions()){
			if(d.catalog.id == contract.id) return d;
		}
		return null;
	}

	/**
	 * Get all orders involved in this multidistrib
	 */
	public function getOrders(?type:Int){
		var out = [];
		for ( d in getDistributions(type)){
			out = out.concat(d.getOrders().array());
		}
		return out;		
	}

	/**
	 * Get orders for a user in this multidistrib
	 * @param user 
	 */
	public function getUserOrders(user:db.User,?type:Int){
		var out = [];
		for ( d in getDistributions(type) ){
			var pids = Lambda.map( d.catalog.getProducts(false), function(x) return x.id);		
			var userOrders =  db.UserOrder.manager.search( $userId == user.id && $distributionId==d.id && $productId in pids , false);	
			for( o in userOrders ){
				out.push(o);
			}
		}
		return out;		
	}

	public function getVendors():Array<db.Vendor>{
		var vendors = new Map<Int,db.Vendor>();
		for( d in getDistributions()) vendors.set(d.catalog.vendor.id,d.catalog.vendor);
		return Lambda.array(vendors);
	}
	
	public function getUsers(?type:Int){
		var users = [];
		for ( o in getOrders(type)) users.push(o.user);
		return users.deduplicate();		
	}

	public function getState():String{
		var now = Date.now().getTime();
		if(getOrdersStartDate()==null || getOrdersEndDate()==null) return null;
		
		if( getDate().getTime() > now ){
			//we're before distrib

			if( getOrdersStartDate(true).getTime() > now ){
				return "notYetOpen";
			}
			
			if( getOrdersEndDate(true).getTime() > now ){
				return "open";
			}else{
				return "closed";
			}
			

		}else{
			//after distrib
			if(isConfirmed()){
				return "validated";
			}else{
				return "distributed";
			}
		}
	}

	public function getStatus(){
		return getState();
	}
	
	
	public function isConfirmed():Bool{
				
		//return Lambda.count( distributions , function(d) return d.validated) == distributions.length;
		return validated == true;
	}

	public function isValidated(){
		return isConfirmed();
	}
	
	/*public function checkConfirmed():Bool{
		
		for ( d in getDistributions(db.Catalog.TYPE_VARORDER)){
			if(!d.validated){
				var orders = d.getOrders();
				var allOrdersPaid = Lambda.count( orders , function(d) return d.paid) == orders.length;		

				if (allOrdersPaid){
					d.lock();
					d.validated = true;
					d.update();
				}
			}
		}
		
		return isConfirmed();
	}*/

	/**
		retrocomp
	**/
	public function getKey(){
		return "md"+this.id;
	}

	override public function toString(){
		try{
			return "#"+id+" Multidistrib à "+getPlace().name+" le "+getDate();
		}catch(e:Dynamic){
			return "#"+this.id;
		}
		
	}

	public function placePopulate():sugoi.form.ListData.FormData<Int> {
		var out = [];
		var places = new List();
		if(this.place!=null){			
			places = db.Place.manager.search($groupId == this.place.group.id, false);
		}
		for (p in places) out.push( { label:p.name,value:p.id} );
		return out;
	}

	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"distribStartDate"	=> t._("Date"),
			"distribEndDate"	=> t._("End hour"),
			"place" 			=> t._("Place"),
			"orderStartDate" 	=> t._("Orders opening date"),
			"orderEndDate" 		=> t._("Orders closing date"),
		];
	}

	public function getGroup(){
		return place.group;
	}

	/**
		TODO : refacto with foreign key with multidistrib
	**/
	public function getBaskets():Array<db.Basket>{
		var baskets = [];
		for( o in getOrders()){
			if(o.basket!=null) baskets.push(o.basket);
		}
		return baskets.deduplicate();
		//return Lambda.array(db.Basket.manager.search($multiDistrib==this,false));
	}

	public function getTmpBaskets():Array<db.TmpBasket>{
		return Lambda.array(db.TmpBasket.manager.search($multiDistrib==this,false));
	}

	public function getUserBasket(user:db.User){
		var orders = getUserOrders(user);
		for( o in orders ){
			if(o.basket!=null) return o.basket;
		}
		return null;
	}

	public function getUserTmpBasket(user:db.User):db.TmpBasket{
		return db.TmpBasket.manager.select($multiDistrib==this && $user==user,false);
	}

	/**
		Get total income of the md, variable and constant
	**/
	public function getTotalIncome():Float{
		var income = 0.0;
		
		for( d in getDistributions()){
			income += d.getTurnOver();
		}

		return income;
	}


	public function getVolunteerRoles() {

		var volunteerRoles: Array<db.VolunteerRole> = [];
		if (this.volunteerRolesIds != null) {

			var multidistribRoleIds = getVolunteerRoleIds();
			volunteerRoles = new Array<db.VolunteerRole>();
			for ( roleId in multidistribRoleIds ) {
				var volunteerRole = db.VolunteerRole.manager.get(roleId);
				if ( volunteerRole != null ) {
					volunteerRoles.push( volunteerRole );
				}
			}

			volunteerRoles.sort(function(b, a) { 
				var a_str = (a.catalog == null ? "null" : Std.string(a.catalog.id)) + a.name.toLowerCase();
				var b_str = (b.catalog == null ? "null" : Std.string(b.catalog.id)) + b.name.toLowerCase();
				return  a_str < b_str ? 1 : -1;
			});
		}
		
		return volunteerRoles;
	}

	public function getVolunteerRoleIds():Array<Int>{
		if(volunteerRolesIds==null) return [];
		var rolesIds = volunteerRolesIds.split(",").map(Std.parseInt);
		rolesIds = tools.ArrayTool.deduplicate(rolesIds);
		return rolesIds;
	}

	public function getVolunteers() {
		return Lambda.array(db.Volunteer.manager.search($multiDistrib == this, false));
	}


	public function hasVacantVolunteerRoles() {

		if ( this.volunteerRolesIds != null && canVolunteersJoin() ) {
			var volunteerRoles = this.getVolunteerRoles();
			if ( volunteerRoles != null && volunteerRoles.length > db.Volunteer.manager.count($multiDistrib == this) ) {
				return true;
			} 
		}
		return false;
	}

	public function getVacantVolunteerRoles():Array<db.VolunteerRole> {

		if (hasVacantVolunteerRoles()) {
			var volunteers = getVolunteers();
			var vacantVolunteerRoles = getVolunteerRoles();

			for ( volunteer in volunteers ) {
				vacantVolunteerRoles.remove(volunteer.volunteerRole);
			}
			vacantVolunteerRoles.sort(function(b, a) { return a.name.toLowerCase() < b.name.toLowerCase() ? 1 : -1; });
			return vacantVolunteerRoles;
		}

		return [];
	}

	public function hasVolunteerRole(role: db.VolunteerRole) {
		var volunteerRoles: Array<db.VolunteerRole> = getVolunteerRoles();
		if (volunteerRoles == null) return false;
		return Lambda.has(volunteerRoles, role);
	}

	public function getVolunteerForRole(role: db.VolunteerRole) {
		return db.Volunteer.manager.select($multiDistrib == this && $volunteerRole == role, false);
	}

	public function getVolunteerForUser(user: db.User): Array<db.Volunteer> {
		return Lambda.array(db.Volunteer.manager.search($multiDistrib == this && $user == user, false));
	}
	
	/**
		Can volunteers join ( check on date and daysBeforeDutyPeriodsOpen )
	**/
	public function canVolunteersJoin() {
		var joinDate = DateTools.delta( this.distribStartDate, - 1000.0 * 60 * 60 * 24 * this.group.daysBeforeDutyPeriodsOpen );
		return Date.now().getTime() >= joinDate.getTime();		
	}

	public function getDistributionFromProduct(product:db.Product):db.Distribution{
		for( d in getDistributions()){
			for( p in d.catalog.getProducts(false)){
				if(p.id==product.id) return d;
			}
		}
		return null;
	}

		

	public function resolveSlots() {
		return new service.TimeSlotsService(this).resolveSlots();
	}

	private function userIsAlreadyAdded(userId: Int) {
		return new service.TimeSlotsService(this).userIsAlreadyAdded(userId);
	}
}