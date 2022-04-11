package test;
import tools.DateTool;
import db.Subscription;
import Common;
import service.DistributionService;
import service.OrderService;
import service.SubscriptionService;
import service.SubscriptionService.SubscriptionServiceError;
import utest.Assert;

/**
 * Test subscriptions
 * 
 * @author web-wizard
 */
class TestSubscriptions extends utest.Test
{
	
	public function new(){
		super();
	}
	
	var catalog : db.Catalog;
	var micheline : db.User;
	var botteOignons : db.Product;
	var panierAmap : db.Product;
	var soupeAmap : db.Product;
	var bob : db.User;
	var in14days : Date;
	
	/**
	 * get a contract + a user + a product + empty orders
	 */
	function setup(){

		TestSuite.initDB();
		TestSuite.initDatas();

		catalog = TestSuite.CONTRAT_AMAP;

		botteOignons = TestSuite.BOTTE_AMAP;
		panierAmap = TestSuite.PANIER_AMAP_LEGUMES;
		soupeAmap = TestSuite.SOUPE_AMAP;

		micheline = db.User.manager.get(1);
		bob = TestSuite.FRANCOIS;

		//we already have a distrib in the past : 2017
		
		//distrib on today+14 days
		in14days = DateTools.delta( Date.now(), 1000.0 * 60 * 60 * 24 * 14 );

		DistributionService.create( 
			catalog,
			DateTool.setHourMinute(in14days,19,0),
			DateTool.setHourMinute(in14days,20,0),
			TestSuite.PLACE_DU_VILLAGE.id,
			DateTools.delta( in14days, 1000.0 * 60 * 60 * 24 * -10 ),
			DateTools.delta( in14days, 1000.0 * 60 * 60 * 24 * -2 )
		);

		//distrib on 2030-07-1 (future)
		DistributionService.create(
			catalog,
			new Date(2030, 6, 1, 19, 0, 0),
			new Date(2030, 6, 1, 20, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			new Date(2030, 5, 1, 20, 0, 0),
			new Date(2030, 5, 30, 20, 0, 0)
		);		


	}

	public function testDeleteSubscription() {

		var ordersData = new Array< { productId : Int, quantity : Float, invertSharedOrder : Bool, userId2 : Int } >();
		ordersData.push( { productId : panierAmap.id, quantity : 1, invertSharedOrder : false, userId2 : null } );
		var subscription : db.Subscription = null;
		var error = null;

		//-----------------------------------------------
		//Test case : There are orders for past distribs
		//-----------------------------------------------
		try {
			
			subscription = SubscriptionService.createSubscription( bob, catalog, catalog.startDate, catalog.endDate, ordersData, false );
			subscription.isValidated = true;
			subscription.update();
			SubscriptionService.deleteSubscription( subscription );
		}
	    catch( e : tink.core.Error ) {

			error = e;
		}
		Assert.equals( error.data, PastOrders );
		Assert.isTrue( subscription != null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 1 );
		Assert.equals( SubscriptionService.getSubscriptionOrders( subscription ).length, 1 );

		//No error for a pending subscription
		//------------------------------------
		subscription.isValidated = false;
		subscription.update();
		error = null;
		try {

			SubscriptionService.deleteSubscription( subscription );
		}
	    catch( e : tink.core.Error ) {

			error = e;
		}
		Assert.equals( error, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );
		Assert.equals( SubscriptionService.getSubscriptionOrders( subscription ).length, 0 );


		//---------------------------------------
		//Test case : There are no past distribs
		//---------------------------------------
		error = null;
		subscription = null;
		try {
			
			subscription = SubscriptionService.createSubscription( bob, catalog, Date.now(), catalog.endDate, ordersData );
			SubscriptionService.deleteSubscription( subscription );
		}
	    catch( e : tink.core.Error ) {

			error = e;
		}
		Assert.equals( error, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );
		Assert.equals( SubscriptionService.getSubscriptionOrders( subscription ).length, 0 );


	}

	// Test subscription creation and cases that generate errors
	// @author web-wizard
	function testCreateSubscription() {

		var ordersData = new Array< { productId : Int, quantity : Float, invertSharedOrder : Bool, userId2 : Int } >();
		ordersData.push( { productId : panierAmap.id, quantity : 1, invertSharedOrder : false, userId2 : null } );
		var subscription : db.Subscription = null;
		var error = null;
		//----------------------------------------
		//Test case : Start and end dates are null
		//----------------------------------------
		try {
			subscription = SubscriptionService.createSubscription( bob, catalog, null, null, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull( error );
		Assert.equals( subscription, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );

		//--------------------------------------------------------------
		//Test case : Start date is outside catalog start and end dates
		//--------------------------------------------------------------
		error = null;
		subscription = null;
		try {
			subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2000, 5, 1, 19, 0, 0), catalog.endDate, ordersData  );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull( error );
		Assert.equals( subscription, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );

		//-----------------------------------------------------------
		//Test case : End date is outside catalog start and end dates
		//-----------------------------------------------------------
		error = null;
		subscription = null;
		try {
			subscription = SubscriptionService.createSubscription( bob, catalog, catalog.startDate, new Date(2036, 5, 1, 19, 0, 0), ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull( error );
		Assert.equals( subscription, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );

		//----------------------------
		//Test case : User 2 not found
		//----------------------------
		error = null;
		subscription = null;
		ordersData = [ { productId : panierAmap.id, quantity : 1, invertSharedOrder : false, userId2 : 999999 } ];
		try {
			subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2019, 5, 1, 19, 0, 0), catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull( error );
		Assert.equals( subscription, null );
		SubscriptionService.deleteSubscription( db.Subscription.manager.select( $user == bob ) );

		//-----------------------
		//Test case : Same User 2
		//-----------------------
		error = null;
		subscription = null;
		ordersData = [ { productId : panierAmap.id, quantity : 1, invertSharedOrder : false, userId2 : bob.id } ];
		try {			
			subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2019, 5, 1, 19, 0, 0), catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull( error , 'should have error like "Both selected accounts must be different ones"' );
		Assert.equals( subscription, null );
		SubscriptionService.deleteSubscription( db.Subscription.manager.select( $user == bob ) );

		//------------------------------------------------------------
		//Test case : Creating a subscription with past distributions
		//------------------------------------------------------------
		error = null;
		subscription = null;
		try {			
			subscription = SubscriptionService.createSubscription( bob, catalog, catalog.startDate, catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.equals( error.data, PastDistributionsWithoutOrders );
		Assert.equals( subscription, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 0 );


		//------------------------------------------------
		//Test case : Successfully creating a subscription
		//------------------------------------------------
		var error = null;
		var ordersData = new Array< { productId : Int, quantity : Float, invertSharedOrder : Bool, userId2 : Int } >();
		ordersData.push( { productId : botteOignons.id, quantity : 3, invertSharedOrder : false, userId2 : null } );
		ordersData.push( {  productId : panierAmap.id, quantity : 2, invertSharedOrder : false, userId2 : null } );
		try {

			subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2019, 5, 1, 19, 0, 0), catalog.endDate, ordersData );
		}
		catch( e : tink.core.Error ) {

			error = e;
		}
		Assert.equals( error, null );
		Assert.isTrue( subscription != null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 1 );

		var subscriptionDistributions = SubscriptionService.getSubscriptionDistributions( subscription );
		Assert.equals( 2 , subscriptionDistributions.length , "should have 2 distribs in the subscription");

		var subscriptionAllOrders = SubscriptionService.getSubscriptionAllOrders( subscription );
		Assert.equals( subscriptionAllOrders.length, 2 * subscriptionDistributions.length );

		for ( distribution in subscriptionDistributions ) {

			var distribOrders = db.UserOrder.manager.search( $user == bob && $subscription == subscription && $distribution == distribution, false );
			Assert.equals( distribOrders.length, 2 );
			var order1 = Lambda.array( distribOrders )[0];
			var order2 = Lambda.array( distribOrders )[1];
			Assert.equals( order1.product.id, botteOignons.id );
			Assert.equals( order1.quantity, 3 );
			Assert.equals( order2.product.id, panierAmap.id );
			Assert.equals( order2.quantity, 2 );
			var distribOrders2 = subscriptionAllOrders.filter( function ( order ) return order.distribution.id == distribution.id );
			Assert.equals( distribOrders2.length, 2 );
			var otherOrder1 = Lambda.array( distribOrders2 )[0];
			var otherOrder2 = Lambda.array( distribOrders2 )[1];
			Assert.equals( otherOrder1.product.id, botteOignons.id );
			Assert.equals( otherOrder1.quantity, 3 );
			Assert.equals( otherOrder2.product.id, panierAmap.id );
			Assert.equals( otherOrder2.quantity, 2 );
		}

		var subscriptionOrders = SubscriptionService.getSubscriptionOrders( subscription );

		Assert.equals( subscriptionOrders.length, 2 );
		var order1 = Lambda.array( subscriptionOrders )[0];
		var order2 = Lambda.array( subscriptionOrders )[1];
		Assert.equals( order1.product.id, botteOignons.id );
		Assert.equals( order1.quantity, 3 );
		Assert.equals( order2.product.id, panierAmap.id );
		Assert.equals( order2.quantity, 2 );

	}

	// Test subscription update and cases that generate errors
	// @author web-wizard
	function testUpdateSubscription() {

		var ordersData = [
			{ productId : botteOignons.id	,quantity : 3.0, invertSharedOrder : false, userId2 : null },
			{ productId : panierAmap.id		,quantity : 2.0, invertSharedOrder : false, userId2 : null }
		];

		/*
		3 distribs : 
		2017-06-01
		in14days
		2030-07-01
		*/

		var delete = function(sub:db.Subscription){
			sub.lock();
			db.UserOrder.manager.delete($subscription==sub);			
			sub.delete();
		}

		//-----------------------------------------------------------------------------------------------------------
		//Test case : Moving the subscription start date to an earlier date when there are already past distributions
		//-----------------------------------------------------------------------------------------------------------
		Assert.equals( 0, db.Subscription.manager.count( $user == bob ) );
		var subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2019, 5, 1, 0, 0, 0), catalog.endDate, ordersData, true );
		Assert.equals( 2, SubscriptionService.getSubscriptionDistributions(subscription).length );
		Assert.isTrue(subscription.isValidated);
		var error = null;
		try {
			SubscriptionService.updateSubscription( subscription, catalog.startDate, catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.equals( PastDistributionsWithoutOrders, error.data  );
		delete(subscription);

		//--------------------------------------------------------------------------------------------------
		//Test case : Moving the subscription start date to a later date when there are already past orders
		//--------------------------------------------------------------------------------------------------
		
		//trick to create a valid subscription that has been created in the past.
		var subscription = SubscriptionService.createSubscription( bob, catalog, catalog.startDate, catalog.endDate, ordersData, false );
		subscription.isValidated = true;
		subscription.update();

		error = null;
		try {						
			SubscriptionService.updateSubscription( subscription, in14days, catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.notNull(error);
		Assert.equals( PastOrders, error.data , "found error is : "+error.message);
		Assert.isTrue(subscription.id!=null);
		Assert.isTrue( SubscriptionService.getUserCatalogSubscriptions(bob,catalog).length==1 , "bob should have one sub");
		delete(subscription);


		//--------------------------------------------------------------------------------------------------
		//Test case : Moving the subscription end date to an earlier date when there are already future orders
		//--------------------------------------------------------------------------------------------------
		
		//trick to create a valid subscription that has been created in the past.
		var subscription = SubscriptionService.createSubscription( bob, catalog, catalog.startDate, catalog.endDate, ordersData, false );
		subscription.isValidated = true;
		subscription.update();

		error = null;
		try {
			SubscriptionService.updateSubscription( subscription, subscription.startDate, new Date(2029, 5, 1, 19, 0, 0), null );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.equals( error, null );
		Assert.equals( 2 , service.SubscriptionService.getSubscriptionNbDistributions( subscription ));
		var subscriptionDistributions = SubscriptionService.getSubscriptionDistributions( subscription );
		var subscriptionAllOrders = SubscriptionService.getSubscriptionAllOrders( subscription );
		Assert.equals( subscriptionAllOrders.length, 2 * subscriptionDistributions.length );

	}

	// Test subscription overlap
	// @author web-wizard
	function testSubscriptionsOverlap() {

		var ordersData = [
			{ productId : botteOignons.id, quantity : 3.0, invertSharedOrder : false, userId2 : null },
			{ productId : panierAmap.id, quantity : 2.0, invertSharedOrder : false, userId2 : null }
		];

		var subscription = SubscriptionService.createSubscription( bob, catalog, new Date(2019, 5, 1, 19, 0, 0), catalog.endDate, ordersData );

		Assert.isTrue( subscription != null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 1 );

		SubscriptionService.updateSubscription( subscription, new Date(2019, 5, 1, 19, 0, 0), new Date(2025, 5, 1, 19, 0, 0), null );
		Assert.equals( db.Subscription.manager.get( subscription.id ).endDate.toString(), "2025-06-01 23:59:59" );

		//----------------------------------------------------------------------
		//Test case : When creating an overlapping subcription there is an error
		//----------------------------------------------------------------------
		var subscription2 = null;
		var error = null;
		try {

			subscription2 = SubscriptionService.createSubscription( bob, catalog, new Date(2025, 4, 1, 19, 0, 0), catalog.endDate, ordersData );
		}
		catch( e : tink.core.Error ) {

			error = e;
		}
		Assert.equals( error.data, OverlappingSubscription );
		Assert.equals( subscription2, null );
		Assert.equals( db.Subscription.manager.count( $user == bob ), 1 );

		//------------------------------------------------------------------------------------------------------
		//Test case : Successfully creating another subscription that is after the current subscription period
		//------------------------------------------------------------------------------------------------------
		error = null;
		try {
			subscription2 = SubscriptionService.createSubscription( bob, catalog, new Date(2025, 5, 2, 19, 0, 0), catalog.endDate, ordersData );
		} catch( e : tink.core.Error ) {
			error = e;
		}
		Assert.isNull( error );
		Assert.notNull( subscription2  );
		Assert.equals( 2 , db.Subscription.manager.count( $user == bob ), "there should be 2 subscriptions for bob" );

	}

	/**
		Test distribution shifting (décalage de date en contrat AMAP)
	**/
	function testDistributionShifting(){

		var amapDistrib = TestSuite.DISTRIB_CONTRAT_AMAP;
		var contract = amapDistrib.catalog;
		var panier = TestSuite.PANIER_AMAP_LEGUMES;

		//Add a distrib cycle in the future
		var weeklyDistribCycle = DistributionService.createCycle(
			contract.group,
			Weekly,
			new Date(2029, 11, 24, 0, 0, 0),
			new Date(2030, 0, 24, 0, 0, 0),
			new Date(2029, 5, 4, 13, 0, 0),
			new Date(2029, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2029, 5, 4, 8, 0, 0),
			new Date(2029, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[contract.id, TestSuite.APPLES.catalog.id]
		);

		var distributions = weeklyDistribCycle.getDistributions();
		/**
			create : 
			#5 Multidistrib à Place du village le 2029-12-24 13:00:00,
			#6 Multidistrib à Place du village le 2029-12-31 13:00:00,
			#7 Multidistrib à Place du village le 2030-01-07 13:00:00,
			#8 Multidistrib à Place du village le 2030-01-14 13:00:00,
			#9 Multidistrib à Place du village le 2030-01-21 13:00:00
			with 2 catalogs linked
		**/	
				
		
		//create subscription for 2 users for this cycle
		var orders = [{productId:panier.id,quantity: 1.0,userId2:null,invertSharedOrder: null}];
		var francoisSub = SubscriptionService.createSubscription(TestSuite.FRANCOIS,contract,weeklyDistribCycle.startDate,weeklyDistribCycle.endDate,orders,false);
		var sebSub = SubscriptionService.createSubscription(TestSuite.SEB,contract,weeklyDistribCycle.startDate,weeklyDistribCycle.endDate,orders,false);

		
		//we should have 5 distribs
		//SubscriptionService.getSubscriptionDistributions(sebSub).map(d -> trace("dist du "+d.date));
		Assert.equals(SubscriptionService.getSubscriptionDistributions(sebSub).length , 5);
		Assert.equals(SubscriptionService.getSubscriptionTotalPrice(sebSub) , (panier.price*5) );

		//create a new MD out of subscriptions
		var tpl = distributions[0];
		var newMd = DistributionService.createMd(
			tpl.getPlace(),
			new Date(2030,2,3,19,0,0),
			new Date(2030,2,3,20,0,0),
			new Date(2030,2,3,10,0,0),
			new Date(2030,2,3,18,0,0),
			[]
		);

		//distrib of 2030-01-07 is shifted to 2030-03-03
		var distrib = distributions[2].getDistributionForContract(contract);
		Assert.equals(distrib.date.toString().substr(0,10) , "2030-01-07");
		distrib = DistributionService.editAttendance( distrib, newMd, distrib.orderStartDate, distrib.orderEndDate, false );

		Assert.equals( distrib.date.toString().substr(0,10) , "2030-03-03" );
		sebSub = Subscription.manager.get(sebSub.id);//re-get
		var sebDistribs = SubscriptionService.getSubscriptionDistributions(sebSub);
		Assert.equals(sebDistribs.length , 5);
		Assert.equals(SubscriptionService.getSubscriptionTotalPrice(sebSub) , (panier.price*5) );
		// trace(sebDistribs);
		Assert.equals(sebDistribs[4].id , distrib.id, "the last distrib of the subscription should be the one we shifted");

		
		// var sebBasket1 = d1.getUserBasket(TestSuite.SEB);
		// Assert.isTrue(sebBasket1.num == 2);

	}
}