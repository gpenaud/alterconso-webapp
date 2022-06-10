package db;
import sys.db.Types;
import tink.core.Error;

enum OperationType{
	VOrder; 	//order on a variable order (debt)
	COrder;		//order on a CSA contract	(debt)
	Payment;	//payment of a debt	
	Membership;	//membership (debt)
}

typedef PaymentInfos = {
	type : String, 			//payment type (PSP)
	?remoteOpId : String,	//PSP operation ID 
	/*?netAmount:Float,		//amount paid less fees
	?fixedFees:Float,		//PSP fixed fees
	?variableFees:Float,	//PSP variable fees*/
}; 

typedef VOrderInfos = {basketId:Int};
typedef COrderInfos = {contractId:Int};
typedef MembershipInfos = {year:Int};

/**
 * Payment operation 
 * 
 * @author fbarbut
 */
class Operation extends sys.db.Object
{
	public var id : SId;
	public var name : SString<128>;
	public var amount : SFloat;
	public var date : SDateTime;
	public var type : SEnum<OperationType>;
	public var data : SData<Dynamic>;
	@hideInForms @:relation(relationId) public var relation : SNull<db.Operation>; //linked to another operation : ie a payment pays an order
	
	@formPopulate("populate") @:relation(userId) public var user : db.User;
	@hideInForms @:relation(groupId) public var group : db.Group;
		
	public var pending : SBool; //a pending payment means the payment has not been confirmed, a pending order means the ordre can still change before closing.
	
	public function getTypeIndex(){
		var e : OperationType = type;		
		return e.getIndex();
	}
	
	public function new(){
		super();
		pending = false;
	}
	
	/**
	 * if operation is a payment, give the payment type
	 */
	public function getPaymentType():String{
		switch(type){
			case Payment: 
				var x : PaymentInfos = this.data;
				if (data == null){
					return null;
				}else{
					return x.type;
				}				
			default : return null;
		}		
	}
	
	/**
	 * get translated payment type name
	 */
	public function getPaymentTypeName(){
		var t = getPaymentType();		
		if (t == null) return null;
		for ( pt in service.PaymentService.getPaymentTypes(PCAll)){
			if (pt.type == t) return pt.name;
		}
		return t;
	}
	
	/**
	 * get payments linked to this order operation
	 */
	public function getRelatedPayments(){
		return db.Operation.manager.search($relation == this && $type == Payment, false);
	}
	
	public function getOrderInfos(){
		return switch(type){
			case COrder, VOrder : this.data;				
			default : null;
		}
	}
	
	public function getPaymentInfos():PaymentInfos{
		return switch(type){
			case Payment : this.data;
			default : null;
		}
	}

	public static function countOperations(user:db.User, group:db.Group):Int{	
		return manager.count($user == user && $group == group);		
	}
	
	/**
	 *  get all  user operations
	 *  @param user - 
	 *  @param group - 
	 *  @param reverse=false - 
	 */
	public static function getOperations(user:db.User, group:db.Group,?reverse=false ){
		if(reverse) {
			return manager.search($user == user && $group == group,{orderBy:-date},false);	
		}		
		return manager.search($user == user && $group == group,{orderBy:date},false);		
	}

	public static function getOperationsWithIndex(user:db.User, group:db.Group,index:Int,limit:Int,?reverse=false ){
		if(reverse) {
			return manager.search($user == user && $group == group, { limit:[index,limit], orderBy:-date }, false);	
		}		
		return manager.search($user == user && $group == group, { limit:[index,limit], orderBy:date },false);		
	}
	
	/*public static function getOrder_Operations(user:db.User, group:db.Group,?limit=50 ){		
		//return manager.search($user == user && $group == group && $type!=Payment,{orderBy:date},false);		
		//return manager.search($user == user && $group == group && $relation==null,{orderBy:date},false);		
		return manager.search($user == user && $group == group,{orderBy:date,limit:limit},false);		
	}*/
	
	public static function getLastOperations(user:db.User, group:db.Group, ?limit = 50){
		
		var c = manager.count($user == user && $group == group);
		c -= limit;
		if (c < 0) c = 0;
		return manager.search($user == user && $group == group,{orderBy:date,limit:[c,limit]},false);	
	}
	
	/**
	 * Create a new transaction
	 * @param	orders
	 */
	public static function makeOrderOperation(orders: Array<db.UserOrder>, ?basket:db.Basket){
		
		if (orders == null) throw "orders are null";
		if (orders.length == 0) throw "no orders";
		if (orders[0].user == null ) throw "no user in order";
		var t = sugoi.i18n.Locale.texts;
		
		var _amount = 0.0;
		for ( o in orders ){
			var t = o.quantity * o.productPrice;
			_amount += t + t * (o.feesRate / 100);
		}
		
		var contract = orders[0].product.catalog;
		
		var op = new db.Operation();
		var user = orders[0].user;
		var group = orders[0].product.catalog.group;
		
		if (contract.type == db.Catalog.TYPE_CONSTORDERS){
			//Constant orders			
			var dNum = contract.getDistribs(false).length;
			op.name = "" + contract.name + " (" + contract.vendor.name+") " + dNum + " " + t._("deliveries");
			op.amount = dNum * (0 - _amount);
			op.date = Date.now();
			op.type = COrder;
			var data : COrderInfos = {contractId:contract.id};
			op.data = data;			
			op.user = user;
			op.group = group;
			op.pending = true;					
			
		}else{
			
			if (basket == null) throw "varying contract orders should have a basket";
			
			//varying orders
			var date = App.current.view.dDate(orders[0].distribution.date);
			op.name = t._("Order for ::date::",{date:date});
			op.amount = 0 - _amount;
			op.date = Date.now();
			op.type = VOrder;
			var data : VOrderInfos = {basketId:basket.id};
			op.data = data;
			op.user = user;			
			op.group = group;
			op.pending = true;		
		}
		
		op.insert();
		
		service.PaymentService.updateUserBalance(op.user, op.group);
		
		return op;	
	}
	
	/**
	 * update an order operation
	 */
	public static function updateOrderOperation(op:db.Operation, orders: Array<db.UserOrder>, ?basket:db.Basket){
		
		op.lock();
		var t = sugoi.i18n.Locale.texts;
		
		var _amount = 0.0;
		for ( o in orders ){
			var a = o.quantity * o.productPrice;
			_amount += a + a * (o.feesRate / 100);
		}
		
		var contract = orders[0].product.catalog;
		if (contract.type == db.Catalog.TYPE_CONSTORDERS){
			//Constant orders			
			var dNum = contract.getDistribs(false).length;
			op.name = "" + contract.name + " (" + contract.vendor.name+") "+ dNum + " " + t._("deliveries");
			op.amount = dNum * (0 - _amount);
		}else{
			
			if (basket == null) throw "varying contract orders should have a basket";
			op.amount = 0 - _amount;
		}
		
		//op.date = Date.now();	//leave original date	
		op.update();
		service.PaymentService.updateUserBalance(op.user, op.group);
		return op;
	}
	
	/**
	 * Record a new payment operation
	 * @param	type
	 * @param	amount
	 * @param	name
	 * @param	relation
	 */
	/*public static function makePaymentOperation(user:db.User,group:db.Group,type:String, amount:Float, name:String, ?relation:db.Operation, ?remoteOpId : String ){
		
		var t = new db.Operation();
		t.amount = Math.abs(amount);
		t.date = Date.now();
		t.name = name;
		t.group = group;
		t.pending = true;
		t.user = user;
		t.type = Payment;
		var data : PaymentInfos = { type: type };
		if ( remoteOpId != null ) {
			data.remoteOpId = remoteOpId;
		}
		t.data = data;
		if(relation!=null) t.relation = relation;
		t.insert();*/
	public static function makePaymentOperation(user: db.User, group: db.Group, type: String, amount: Float, name: String, ?relation: db.Operation, ?remoteOpId : String) : db.Operation
	{

		if(type == payment.OnTheSpotPayment.TYPE) 
		{
			var onTheSpotAllowedPaymentTypes = service.PaymentService.getOnTheSpotAllowedPaymentTypes(group);
			if(onTheSpotAllowedPaymentTypes.length == 1)
			{
				//There is only one on the spot payment type so we can directly set it here
				type = onTheSpotAllowedPaymentTypes[0].type;				
			}
			
			if(relation != null)
			{
				var relatedPaymentOperations = relation.getRelatedPayments();
				for (operation in relatedPaymentOperations)
				{
					if(operation.data.type == payment.OnTheSpotPayment.TYPE || Lambda.has(payment.OnTheSpotPayment.getPaymentTypes(), operation.data.type))
					{
						return updatePaymentOperation(user, group, operation, amount);						
					}
				}
			}
		}
		
		var operation = new db.Operation();
		operation.amount = Math.abs(amount);
		operation.date = Date.now();
		operation.name = name;
		operation.group = group;
		operation.pending = true;
		operation.user = user;
		operation.type = Payment;		
		var data : PaymentInfos = { type: type };
		if ( remoteOpId != null ) {
			data.remoteOpId = remoteOpId;
		}
		operation.data = data;
		if(relation != null) operation.relation = relation;
		operation.insert();
		
		service.PaymentService.updateUserBalance(user, group);
		
		return operation;
	}


	/**
	 * Update a payment operation
	 * @param	amount
	 */
	public static function updatePaymentOperation(user: db.User, group: db.Group, operation: db.Operation, amount: Float) : db.Operation
	{

		operation.lock();
		operation.amount += Math.abs(amount);		
		operation.update();
		
		service.PaymentService.updateUserBalance(user, group);
		
		return operation;
	}
	
	/**
	 * when updating a (varying) order , we need to update the existing pending transaction
	 */
	public static function findVOrderOperation(distrib:db.MultiDistrib, user:db.User,?onlyPending=true):db.Operation{
		
		//throw 'find $dkey for user ${user.id} in group ${group.id} , onlyPending:$onlyPending';
		if(distrib==null) throw "Distrib is null";
		if(user==null) throw "User is null";

		var operations  = new List();
		if (onlyPending){
			operations = manager.search($user == user && $group == distrib.getGroup() && $pending == true && $type==VOrder , {orderBy:-date}, true);
		}else{
			operations = manager.search($user == user && $group == distrib.getGroup() && $type==VOrder , {orderBy:-date}, true);
		}
		
		var basket = db.Basket.get(user, distrib);
		if(basket==null) throw new Error('No basket found for user #'+user.id+', md #'+distrib.id );
		
		
		for ( t in operations ){
			switch(t.type){
				case VOrder :
					var data : VOrderInfos = t.data;
					if ( data == null) continue;
					if (data.basketId == basket.id) return t;
				default : 
					continue;				
			}
		}
		
		return null;
	}
	
	/**
	 * when updating a constant order, we need to update the existing operation.
	 */
	public static function findCOrderOperation(contract:db.Catalog, user:db.User):db.Operation{
		
		if (contract.type != db.Catalog.TYPE_CONSTORDERS) throw "catalog type should be TYPE_CONSTORDERS";
		
		var transactions = manager.search($user == user && $group == contract.group && $amount<=0 && $type==COrder, {orderBy:date,limit:100}, true);
		
		for ( t in transactions){
			
			switch(t.type){
				
				case COrder :
					
					//var id = Lambda.find(orders, function(x) return db.UserOrder.manager.get(x, false) != null);					
					//if (id == null) {						
						////all orders in this transaction dont exists anymore
						//t.delete();
						//continue;
					//}else{
						//for ( i in orders){
							//var order = db.UserOrder.manager.get(i);
							//if (order == null) continue;
							//if (order.product.contract.id == contract.id) return t;
						//}	
					//}
					var data : COrderInfos = t.data;
					if (data == null) continue;
					if (data.contractId == contract.id) return t;
					
					
				default : 
					continue;				
			}
		}
		
		return null;
		
	}
	
	/**
		Create/update the needed order operations and returns the related operations.
		Can handle orders happening on different multidistribs.		
	 	Orders are supposed to be from the same user.
	 */
	public static function onOrderConfirm(orders:Array<db.UserOrder>):Array<db.Operation>{
		
		//make sure we dont have null orders in the array
		orders = orders.filter( o -> return o!=null );
		if (orders.length == 0) return null;
		
		for( o in orders){
			if(o.user==null){
				throw new Error("order "+o.id+" has no user");
			} 
			
			if(o.user.id!=orders[0].user.id){
				throw new Error("Those orders are from different users");
			}
		}

		var out = [];
		var user = orders[0].user;
		var group = orders[0].product.catalog.group;
		
		//we consider that ALL orders are from the same contract type : varying or constant
		if (orders[0].product.catalog.type == db.Catalog.TYPE_VARORDER ){
			
			// varying contract :
			//manage separatly orders which occur at different dates
			var ordersGroup = null;
			try{
				ordersGroup = tools.ObjectListTool.groupOrdersByKey(orders);
			}catch(e:Dynamic){
				App.current.logError(service.OrderService.prepare(orders));
				neko.Lib.rethrow(e);
			}
			
			for ( orders in ordersGroup){
				
				//find basket
				var basket = null;
				for ( o in orders) {
					if (o.basket != null) {
						basket = o.basket;
						break;
					}
				}

				var distrib = basket.multiDistrib;
				
				//get all orders for the same multidistrib, in order to update related operation.				
				var allOrders = distrib.getUserOrders(user, db.Catalog.TYPE_VARORDER);	
				
				//existing transaction
				var existing = db.Operation.findVOrderOperation( distrib , user, false);
				
				var op;
				if (existing != null){
					op = db.Operation.updateOrderOperation(existing,allOrders,basket);	
				}else{
					op = db.Operation.makeOrderOperation(allOrders,basket);			
				}
				out.push(op);
				
				//delete order and payment operations if sum of orders qt is 0
				/*var sum = 0.0;
				for ( o in allOrders) sum += o.quantity;
				if ( sum == 0 ) {
					existing.delete();
					op.delete();
				}*/
			}
			
		}else{
			// constant contract
			// create/update a transaction computed like $distribNumber * $price.
			var contract = orders[0].product.catalog;
			
			var existing = db.Operation.findCOrderOperation( contract , user);
			if (existing != null){
				out.push( db.Operation.updateOrderOperation(existing, contract.getUserOrders(user) ) );
			}else{
				out.push( db.Operation.makeOrderOperation( contract.getUserOrders(user) ) );
			}
		}
		
		return out;
	}
	
	public function populate(){
		return App.current.user.getGroup().getMembersFormElementData();
	}
	

	
}