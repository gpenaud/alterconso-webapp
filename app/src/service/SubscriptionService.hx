package service;
import db.Group.RegOption;
import db.Subscription;
import db.Catalog;
import Common;
import tink.core.Error;
using tools.DateTool;
using Lambda;

enum SubscriptionServiceError {
	NoSubscription;
	PastDistributionsWithoutOrders;
	PastOrders;
	OverlappingSubscription;
	InvalidParameters;
}

/**
 * Subscription service
 * @author web-wizard
 */
class SubscriptionService
{
	/**
		Get user subscriptions in active catalogs
	**/
	public static function getUserActiveSubscriptions(user:db.User,group:db.Group){
		var catalogIds = group.getActiveContracts().filter(c -> return c.type==Catalog.TYPE_CONSTORDERS).map(c -> return c.id);
		return db.Subscription.manager.search( $user == user && ($catalogId in catalogIds), false );
	}

	public static function getUserActiveSubscriptionsByCatalog(user,group):Map<db.Catalog,Array<db.Subscription>>{
		var memberSubscriptions = SubscriptionService.getUserActiveSubscriptions(user,group);
		var subscriptionsByCatalog = new Map<Catalog,Array<Subscription>>();
		for ( subscription in memberSubscriptions ) {
			if ( subscriptionsByCatalog[subscription.catalog] == null ) {
				subscriptionsByCatalog[subscription.catalog] = [];
			}
			subscriptionsByCatalog[subscription.catalog].push( subscription );
		}
		return subscriptionsByCatalog;
	}

	public static function hasUserCatalogSubscription( user : db.User, catalog : db.Catalog, isValidated : Bool ) : Bool {
		return db.Subscription.manager.count( $user == user && $catalog == catalog && $isValidated == isValidated ) != 0;
	}

	public static function getUserCatalogSubscription( user : db.User, catalog : db.Catalog, ?isValidated : Bool ) : db.Subscription {
		if(isValidated!=null){
			return db.Subscription.manager.select( $user == user && $catalog == catalog && $isValidated == isValidated, false );
		}else{
			return db.Subscription.manager.select( $user == user && $catalog == catalog , false );
		}		
	}

	public static function getUserCatalogSubscriptions( user : db.User, catalog : db.Catalog ) : Array<db.Subscription> {
		return db.Subscription.manager.search( $user == user && $catalog == catalog , false ).array();
	}

	public static function getSubscriptionDistributions( subscription : db.Subscription ) : Array<db.Distribution> {

		return db.Distribution.manager.search( $catalog == subscription.catalog && $date >= subscription.startDate && $end <= subscription.endDate,{orderBy:date}, false ).array();
	}

	public static function getSubscriptionNbDistributions( subscription : db.Subscription ) : Int {

		return db.Distribution.manager.count( $catalog == subscription.catalog && $date >= subscription.startDate && $date <= subscription.endDate );
	}

	public static function getSubscriptionTotalPrice( subscription : db.Subscription ) : Float {

		var orders = db.UserOrder.manager.search( $subscription == subscription, false );
		var totalPrice = 0.0;
		
		for ( order in orders ) {

			totalPrice += Formatting.roundTo( order.quantity * order.productPrice, 2 );
		}

		return Formatting.roundTo( totalPrice, 2 );
	}

	public static function getSubscriptionAllOrders( subscription : db.Subscription ) : List<db.UserOrder> {

		return db.UserOrder.manager.search( $subscription == subscription, false );
	}

	public static function getSubscriptionOrders( subscription : db.Subscription ) : Array<db.UserOrder> {

		var oneDistrib = db.Distribution.manager.search( $catalog == subscription.catalog && $date >= subscription.startDate && $date <= subscription.endDate, false ).first();
		return Lambda.array( db.UserOrder.manager.search( $subscription == subscription && $distribution == oneDistrib, false ) );
	}

	public static function isSubscriptionPaid( subscription : db.Subscription ) : Bool {

		/*
		var orders = db.UserOrder.manager.search( $subscription == subscription, false );
		for ( order in orders ) {
			if ( !order.paid ) {
				return false;
			}
		}
		return true;*/
		return subscription.isPaid;

	}

	public static function getDescription( subscription : db.Subscription ) {

		var subscriptionOrders = getSubscriptionOrders( subscription );
		if( subscriptionOrders.length == 0 )  return null;
		var label : String = '';
		for ( order in subscriptionOrders ) {
			label += tools.FloatTool.clean( order.quantity ) + " x " + order.product.name + "<br />";
		}

		return label;
	}

	/**
	 * Checks if dates are correct and if there is no other subscription for this user in that same time range
	 * @param subscription
	 */
	public static function isSubscriptionValid( subscription : db.Subscription, ?previousStartDate : Date, ?previousEndDate : Date  ) : Bool {

		var subName = ' (souscription de ${subscription.user.getName()})';

		//invalid dates
		if(subscription.startDate.getTime() >= subscription.endDate.getTime()){
			throw TypedError.typed( 'La date de début de la souscription doit être antérieure à la date de fin.', InvalidParameters );			
		}

		//dates should be inside catalog dates
		var catalogStartDate = new Date( subscription.catalog.startDate.getFullYear(), subscription.catalog.startDate.getMonth(), subscription.catalog.startDate.getDate(), 0, 0, 0 );
		var catalogEndDate = new Date( subscription.catalog.endDate.getFullYear(), subscription.catalog.endDate.getMonth(), subscription.catalog.endDate.getDate(), 23, 59, 59 );
		if ( subscription.startDate.getTime() < catalogStartDate.getTime() || subscription.startDate.getTime() >= catalogEndDate.getTime() ) {
			throw new Error( 'La date de début de la souscription doit être comprise entre les dates de début et de fin du catalogue.'+subName );
		}
		if ( subscription.endDate.getTime() <= catalogStartDate.getTime() || subscription.endDate.getTime() > catalogEndDate.getTime() ) {
			throw new Error( 'La date de fin de la souscription doit être comprise entre les dates de début et de fin du catalogue.'+subName );
		}

		//dates overlap check
		var subscriptions1;
		var subscriptions2;	
		var subscriptions3;	
		//We are checking that there is no existing subscription with an overlapping time frame for the same user and catalog
		if ( subscription.id == null ) { //We need to check there the id as $id != null doesn't work in the manager.search

			//Looking for existing subscriptions with a time range overlapping the start of the about to be created subscription
			subscriptions1 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog 
															&& $startDate <= subscription.startDate && $endDate >= subscription.startDate, false );
			//Looking for existing subscriptions with a time range overlapping the end of the about to be created subscription
			subscriptions2 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog 
															&& $startDate <= subscription.endDate && $endDate >= subscription.endDate, false );	
			//Looking for existing subscriptions with a time range included in the time range of the about to be created subscription		
			subscriptions3 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog 
															&& $startDate >= subscription.startDate && $endDate <= subscription.endDate, false );	
		} else {
			//Looking for existing subscriptions with a time range overlapping the start of the about to be created subscription
			subscriptions1 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog && $id != subscription.id 
															&& $startDate <= subscription.startDate && $endDate >= subscription.startDate, false );
			//Looking for existing subscriptions with a time range overlapping the end of the about to be created subscription
			subscriptions2 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog && $id != subscription.id 
															&& $startDate <= subscription.endDate && $endDate >= subscription.endDate, false );	
			//Looking for existing subscriptions with a time range included in the time range of the about to be created subscription		
			subscriptions3 = db.Subscription.manager.search( $user == subscription.user && $catalog == subscription.catalog && $id != subscription.id 
															&& $startDate >= subscription.startDate && $endDate <= subscription.endDate, false );	
		}
			
		if ( subscriptions1.length != 0 || subscriptions2.length != 0 || subscriptions3.length != 0 ) {
			var subs = subscriptions1.concat(subscriptions2).concat(subscriptions3);
			throw TypedError.typed( 'Il y a déjà une souscription pour ce membre pendant la période choisie.'+"("+subs.join(',')+")", OverlappingSubscription );
		}

		if ( subscription.isValidated ) {

			var view = App.current.view;

			if ( subscription.id != null && hasPastDistribOrdersOutsideSubscription( subscription ) ) {
				throw TypedError.typed( 
					'La nouvelle période sélectionnée exclue des commandes déjà passées, Il faut élargir la période sélectionnée $subName.',
					PastOrders
				);
			}

			if ( hasPastDistribsWithoutOrders( subscription ) ) {
				throw TypedError.typed(
					'La nouvelle période sélectionnée inclue des distributions déjà passées auxquelles le membre n\'a pas participé, Il faut choisir une date ultérieure $subName.',
					PastDistributionsWithoutOrders
				);
			}
		}
		
		return true;
	}

	 /**
	  *  Creates a new subscription and prevents subscription overlapping and other checks
	  *  @return db.Subscription
	  */
	 public static function createSubscription( user : db.User, catalog : db.Catalog, startDate : Date, endDate : Date,
	 ordersData : Array< { productId : Int, quantity : Float, userId2 : Int, invertSharedOrder : Bool } >, ?isValidated : Bool = true ) : db.Subscription {

		if ( startDate == null || endDate == null ) {
			throw new Error( 'La date de début et de fin de la souscription doivent être définies.' );
		}

		//if the user is not a member of the group
		if(!user.isMemberOf(catalog.group)){
			if(catalog.group.regOption==RegOption.Open){
				user.makeMemberOf(catalog.group);
			}else{
				throw new Error(user.getName()+" n'est pas membre de "+catalog.group.name);
			}
		}

		var subscription = new db.Subscription();
		subscription.user = user;
		subscription.catalog = catalog;
		subscription.startDate 	= new Date( startDate.getFullYear(), startDate.getMonth(), startDate.getDate(), 0, 0, 0 );
		subscription.endDate 	= new Date( endDate.getFullYear(), endDate.getMonth(), endDate.getDate(), 23, 59, 59 );
		subscription.isValidated = isValidated;

		if ( isSubscriptionValid( subscription ) ) {

			subscription.insert();
			createCSARecurrentOrders( subscription, ordersData );
			
		}

		return subscription;

	}


	public static function updateSubscription( subscription : db.Subscription, startDate : Date, endDate : Date, 
	 ?ordersData : Array<{ productId:Int, quantity:Float, userId2:Int, invertSharedOrder:Bool }>, ?validateSubscription:Bool ) {

		if ( startDate == null || endDate == null ) {
			throw new Error( 'La date de début et de fin de la souscription doivent être définies.' );
		}

		subscription.lock();

		if ( validateSubscription ) {
			subscription.isValidated = true;
		}
		subscription.startDate = new Date( startDate.getFullYear(), startDate.getMonth(), startDate.getDate(), 0, 0, 0 );
		subscription.endDate = new Date( endDate.getFullYear(), endDate.getMonth(), endDate.getDate(), 23, 59, 59 );

		if ( isSubscriptionValid( subscription ) ) {
			subscription.update();
			createCSARecurrentOrders( subscription, ordersData );	
		}

	}

	public static function validate(subscription:Subscription){
		subscription.lock();
		subscription.isValidated = true;
		subscription.isPaid = true;
		subscription.update();
	}

	 /**
	  *  Deletes a subscription if there is no orders that occurred in the past
	  *  @return db.Subscription
	  */
	 public static function deleteSubscription( subscription : db.Subscription ) {

		if ( hasPastDistribOrders( subscription ) && subscription.catalog.vendor.email != 'jean@leportail.org' && subscription.catalog.vendor.email != 'galinette@leportail.org' ) {

			throw TypedError.typed( 'Impossible de supprimer cette souscription car il y a des distributions passées avec des commandes.', PastOrders );
		}

		//Delete all the orders for this subscription
		var subscriptionOrders = db.UserOrder.manager.search( $subscription == subscription, false );
		for ( order in subscriptionOrders ) {

			order.lock();
			order.delete();
		}
		//Delete the subscription
		subscription.lock();
		subscription.delete();

	}

	/**
	 *  Checks whether there are orders with non zero quantity in the past
	 *  @param d - 
	 *  @return Bool
	 */
	public static function hasPastDistribOrders( subscription : db.Subscription ) : Bool {

		if ( !subscription.isValidated || !hasPastDistributions( subscription ) ) {

			return false;
		}
		else {

			var now = Date.now();
			var endOfToday = new Date( now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59 );
			var pastDistributions : List<db.Distribution> = db.Distribution.manager.search( $catalog == subscription.catalog  && $date <= endOfToday && $date >= subscription.startDate && $date <= subscription.endDate, false );
			for ( distribution in pastDistributions ) {

				if ( db.UserOrder.manager.count( $distribution == distribution && $subscription == subscription ) != 0 ) {
					
					return true;
				}

			}
		}
		
		return false;
		
	}


	public static function hasPastDistribOrdersOutsideSubscription( subscription : db.Subscription ) : Bool {
		//trace("hasPastDistribOrdersOutsideSubscription for sub "+subscription.startDate.toString().substr(0,10)+" to "+subscription.endDate.toString().substr(0,10));
		var now = Date.now();
		var endOfToday = new Date( now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59 );
		var orders =  db.UserOrder.manager.search( $subscription == subscription, false ).array();
		for ( order in orders ) {
			if (order.distribution !=null){
				//trace(order.distribution.date);
				if ( order.distribution.date.getTime() <= endOfToday.getTime() && ( order.distribution.date.getTime() < subscription.startDate.getTime() || order.distribution.date.getTime() > subscription.endDate.getTime() ) ) {					
					return true;
				}
			}
			
		}
		
		return false;
		
	}

	public static function hasPastDistribsWithoutOrders( subscription : db.Subscription ) : Bool {

		if ( !hasPastDistributions( subscription ) ) {

			return false;
		}
		else {

			var now = Date.now();
			var endOfToday = new Date( now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59 );
			var pastDistributions : List<db.Distribution> = db.Distribution.manager.search( $catalog == subscription.catalog  && $date <= endOfToday && $date >= subscription.startDate && $date <= subscription.endDate, false );
			for ( distribution in pastDistributions ) {

				if ( db.UserOrder.manager.count( $distribution == distribution && $subscription == subscription ) == 0 ) {
					
					return true;
				}

			}
		}
		
		return false;
	}

	
	public static function hasPastDistributions( subscription : db.Subscription ) : Bool {

		//Check if there are distributions in the past for this subscription
		var now = Date.now();
		var endOfToday = new Date( now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59 );
		return db.Distribution.manager.count( $catalog == subscription.catalog  && $date <= endOfToday && $date >= subscription.startDate && $date <= subscription.endDate ) != 0;
	}


	public static function createCSARecurrentOrders( subscription : db.Subscription,
		ordersData : Array< { productId : Int, quantity : Float, userId2 : Int, invertSharedOrder : Bool } > ) : Array<db.UserOrder> {

		if ( ordersData == null || ordersData.length == 0 ) {

			ordersData = new Array< { productId : Int, quantity : Float, userId2 : Int, invertSharedOrder : Bool } >();
			var subscriptionOrders = getSubscriptionOrders( subscription );
			for ( order in subscriptionOrders ) {

				ordersData.push( { productId : order.product.id, quantity : order.quantity, userId2 : order.user2 != null ? order.user2.id : null, invertSharedOrder : order.hasInvertSharedOrder() } );
			}
		}
		else if ( hasPastDistribOrders( subscription ) ) {

			throw TypedError.typed( 'Il y a des commandes pour des distributions passées. Les commandes du passé ne pouvant être modifiées il faut modifier la date de fin de
			la souscription et en recréer une nouvelle pour la nouvelle période. Vous pourrez ensuite définir une nouvelle commande pour cette nouvelle souscription.', SubscriptionService.SubscriptionServiceError.PastOrders );
		}

		var subscriptionAllOrders = getSubscriptionAllOrders( subscription );
		for ( order in subscriptionAllOrders ) {

			order.lock();
			order.delete();
		}

		var subscriptionDistributions = getSubscriptionDistributions( subscription );

		var t = sugoi.i18n.Locale.texts;
	
		var orders : Array<db.UserOrder> = [];
		for ( distribution in subscriptionDistributions ) {

			for ( order in ordersData ) {

				if ( order.quantity > 0 ) {

					var product = db.Product.manager.get( order.productId, false );
					// User2 + Invert
					var user2 : db.User = null;
					var invert = false;
					if ( order.userId2 != null && order.userId2 != 0 ) {

						user2 = db.User.manager.get( order.userId2, false );
						if ( user2 == null ) throw new Error( t._( "Unable to find user #::num::", { num : order.userId2 } ) );
						if ( subscription.user.id == user2.id ) throw new Error( t._( "Both selected accounts must be different ones" ) );
						if ( !user2.isMemberOf( product.catalog.group ) ) throw new Error( t._( "::user:: is not part of this group", { user : user2 } ) );
						
						invert = order.invertSharedOrder;
					}
					
					var newOrder =  OrderService.make( subscription.user, order.quantity , product,  distribution.id, false, subscription, user2, invert );
					if ( newOrder != null ) orders.push( newOrder );

				}

			}
		}
		
		App.current.event( MakeOrder( orders ) );
		db.Operation.onOrderConfirm( orders );

		return orders;
		
	}
	
}