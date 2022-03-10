package service;
import Common;

enum PaymentContext{
	PCAll;
	PCGroupAdmin;
	PCPayment;
	PCManualEntry;
}

/**
 * Payment Service
 * @author web-wizard,fbarbut
 */
class PaymentService
{
	/**
	 * Retuns an array of payment types depending on the use case
	 * @param context 
	 * @param group 
	 * @return Array<payment.PaymentType>
	 */
	public static function getPaymentTypes(context: PaymentContext, ?group: db.Group) : Array<payment.PaymentType>
	{
		var out : Array<payment.PaymentType> = [];

		switch(context)
		{
			//every payment type
			case PCAll:
				var types = [
					new payment.Cash(),
					new payment.Check(),
					new payment.Transfer(),	
					new payment.MoneyPot(),
					new payment.OnTheSpotPayment(),
					new payment.OnTheSpotCardTerminal()						
				];
				var e = App.current.event(GetPaymentTypes({types:types}));
				out = switch(e) {
						case GetPaymentTypes(d): d.types;
						default : null;
					}

			//when selecting wich payment types to enable
			case PCGroupAdmin:
				var allPaymentTypes = getPaymentTypes(PCAll);
				//Exclude On the spot payment
				var onTheSpot = Lambda.find(allPaymentTypes, function(x) return x.type == payment.OnTheSpotPayment.TYPE);
				allPaymentTypes.remove(onTheSpot);
				out = allPaymentTypes;


			//For the payment page
			case PCPayment:
				if ( group.allowedPaymentsType == null ) return [];
				//ontheSpot payment type replaces checks or cash
			
				var hasOnTheSpotPaymentTypes = false;
				var all = getPaymentTypes(PCAll);
				for ( paymentTypeId in group.allowedPaymentsType ){
					var found = all.find(function(a) return a.type == paymentTypeId);
					if (found != null)  {
						if(found.onTheSpot==true){
							hasOnTheSpotPaymentTypes = true;
						}else{
							out.push(found);
						}
					}
				}
				if(hasOnTheSpotPaymentTypes){
					out.push(new payment.OnTheSpotPayment());
				}

			
			//For when a coordinator does a manual refund or adds manually a payment
			case PCManualEntry:
				//Exclude the MoneyPot payment
				var paymentTypesInAdmin = getPaymentTypes(PCGroupAdmin);
				var moneyPot = Lambda.find(paymentTypesInAdmin, function(x) return x.type == payment.MoneyPot.TYPE);
				paymentTypesInAdmin.remove(moneyPot);
				#if plugins
				//cannot make a mgp payment manually !!
				var mgp = paymentTypesInAdmin.find( x -> x.type == pro.payment.MangopayMPPayment.TYPE || x.type == pro.payment.MangopayECPayment.TYPE );
				paymentTypesInAdmin.remove(mgp);
				#end
				out = paymentTypesInAdmin;
		}

		return out;
	}


	/**
	 * Returns all the payment types that are on the spot and that are allowed for this group
	 * @param group 
	 * @return Array<payment.PaymentType>
	 */
	public static function getOnTheSpotAllowedPaymentTypes(group: db.Group) : Array<payment.PaymentType>
	{
		if ( group.allowedPaymentsType == null ) return [];
		var onTheSpotAllowedPaymentTypes : Array<payment.PaymentType> = [];
		var onTheSpotPaymentTypes = payment.OnTheSpotPayment.getPaymentTypes();
		var all = getPaymentTypes(PCAll);
		for (paymentType in onTheSpotPaymentTypes)
		{
			if (Lambda.has(group.allowedPaymentsType, paymentType))
			{
				var found = Lambda.find(all, function(a) return a.type == paymentType);
				if (found != null) 
				{
					onTheSpotAllowedPaymentTypes.push(found);
				}			
			}
		}
	
		return onTheSpotAllowedPaymentTypes;
	}

	/**
	 * Auto validate a distribution.
	 * This is called by the hourly cron
	 *  
	 * @param distrib
	 */
	public static function validateDistribution(distrib:db.MultiDistrib) {
		distrib.lock();
		
		//cannot be in future
		if(distrib.distribStartDate.getTime() > Date.now().getTime()){
			throw new tink.core.Error("Vous ne pouvez pas valider cette distribution car elle n'a pas encore commencé");
		}

		for ( user in distrib.getUsers()){
			var basket = db.Basket.get(user, distrib );
			validateBasket(basket);
		}
		//finally validate distrib		
		distrib.validated = true;
		distrib.update();
	}

	public static function unvalidateDistribution(distrib:db.MultiDistrib) {

		for ( user in distrib.getUsers()){
			var basket = db.Basket.get(user, distrib);
			unvalidateBasket(basket);
		}
		//finally validate distrib
		distrib.lock();
		distrib.validated = false;
		distrib.update();
	}

	/**
	 * Auto validate a basket
	 *  
	 * @param basket
	 */
	public static function validateBasket(basket:db.Basket) {

		if (basket == null || basket.isValidated()) return false;

		//This will throw an error if for example there are pending payments of type on the spot
		basket.canBeValidated();
		
		//mark orders as paid
		var orders = basket.getOrders();
		for ( order in orders ){

			order.lock();
			order.paid = true;
			order.update();				
		}

		//validate order operation and payments
		var operation = basket.getOrderOperation(false);
		if (operation != null){

			operation.lock();
			operation.pending = false;
			operation.update();
			
			for ( payment in basket.getPaymentsOperations()){

				if ( payment.pending){
					payment.lock();
					payment.pending = false;
					payment.update();
				}
			}

			var o = orders[0];
			if(o.distribution==null) throw o.id+" order has no distrib";
			updateUserBalance(o.user, o.distribution.place.group);	
		}

		App.current.event(ValidateBasket(basket));

		return true;
	}

	public static function unvalidateBasket(basket:db.Basket) {

		if (basket == null || !basket.isValidated()) return false;

		//mark orders as paid
		var orders = basket.getOrders();
		for ( order in orders ){

			order.lock();
			order.paid = false;
			order.update();				
		}

		//validate order operation and payments
		var operation = basket.getOrderOperation(false);
		if (operation != null){

			operation.lock();
			operation.pending = true;
			operation.update();
			
			for ( payment in basket.getPaymentsOperations()){

				if (!payment.pending){
					payment.lock();
					payment.pending = true;
					payment.update();
				}
			}

			var o = orders[0];
			updateUserBalance(o.user, o.distribution.place.group);	
		}

		return true;
	}


	/**
	 * update user balance
	 */
	public static function updateUserBalance(user:db.User,group:db.Group){
		
		var ua = db.UserGroup.getOrCreate(user, group);
		var b = sys.db.Manager.cnx.request('SELECT SUM(amount) FROM Operation WHERE userId=${user.id} and groupId=${group.id} and !(type=2 and pending=1)').getFloatResult(0);
		b = Math.round(b * 100) / 100;
		ua.balance = b;
		ua.update();
	}


	public static function getPaymentInfosString(group:db.Group):String {
		var out = "";
		var allowedPaymentTypes = getPaymentTypes(PCPayment,group);
		out = Lambda.map(allowedPaymentTypes,function(m) return m.name).join(", ");
		return out;
	}

	/**
		Get multidistrib turnover by payment type
	**/
	public static function getMultiDistribTurnoverByPaymentType(md:db.MultiDistrib):Map<String,{ht:Float,ttc:Float}>{
		var out = new Map<String,{ht:Float,ttc:Float}>();

		/*for( b in md.getBaskets()){
			for( op in b.getPaymentsOperations()){
				
			}
		}*/
		return out;
	}
}