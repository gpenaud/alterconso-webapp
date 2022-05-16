package test;import utest.Assert;
import Common;
import test.TestSuite;
import service.ReportService;
import service.OrderService;

/**
 * Test order reports
 * 
 * @author fbarbut
 */
class TestReports extends utest.Test
{
	
	public function new(){
			
		super();
	}

	function setup(){

		TestSuite.initDB();
		TestSuite.initDatas();

	}


	function testOrdersByProduct(){

		//record orders
		var seb = TestSuite.SEB;
		var francois = TestSuite.FRANCOIS;
		var julie = TestSuite.JULIE;

		//distrib de légumes
		var d = TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE;
		var carrots = TestSuite.CARROTS;
		var courgettes = TestSuite.COURGETTES;
		var potatoes = TestSuite.POTATOES;

		OrderService.make(seb,4,courgettes,d.id);
		OrderService.make(seb,1,potatoes,d.id);

		OrderService.make(francois,6,courgettes,d.id);
		OrderService.make(francois,2,potatoes,d.id);
		OrderService.make(francois,3,carrots,d.id);

		OrderService.make(julie,8,carrots,d.id);
		OrderService.make(julie,3,potatoes,d.id);

		//record orders on ANOTHER distrib
		var d2 = service.DistributionService.create(
			d.catalog,
			new Date(2018,2,12,0,0,0),
			new Date(2018,2,12,0,3,0),
			d.catalog.group.getPlaces().first().id,
			new Date(2018,2,8,0,0,0),
			new Date(2018,2,11,0,0,0)
		);
		OrderService.make(julie,6,carrots,d2.id);
		OrderService.make(julie,1,potatoes,d2.id);

		var orders = ReportService.getOrdersByProduct(d);

		//courgettes x 10
		var courgettesOrder = Lambda.find(orders, function(o) return o.pid==courgettes.id);
		Assert.equals( 10.0 , courgettesOrder.quantity );
		Assert.equals( 35.0 , courgettesOrder.totalTTC );
		Assert.equals( 33.18 , tools.FloatTool.clean(courgettesOrder.totalHT) );

		//the report stays the same, even if the product has a new price.
		courgettes.lock();
		courgettes.price+=4;
		courgettes.update();
		var orders = ReportService.getOrdersByProduct(d);
		var courgettesOrder = Lambda.find(orders, function(o) return o.pid==courgettes.id);
		Assert.equals( 10.0 , courgettesOrder.quantity );
		Assert.equals( 35.0 , courgettesOrder.totalTTC );
		Assert.equals( 33.18 , tools.FloatTool.clean(courgettesOrder.totalHT) );


	}

	/**
	
		ENABLE THIS FOR MANGOPAY MARKETPLACE PAYMENTS
	**/
	/*function testVendorOrdersByProduct(){
		// Take 3 vendors
		// Each has their own distrib for one inactive multidistrib
		// Take 3 users
		// Each user makes different purchases in this multidistrib but also for other distribs
		// Check that totals are what we expect by vendor products

		//User 1 buys products for a multidistrib
		var francoisOrder1 = OrderService.make(TestSuite.FRANCOIS, 1, TestSuite.POTATOES, TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE.id);
		var francoisOrder2 = OrderService.make(TestSuite.FRANCOIS, 2, TestSuite.LAITUE, TestSuite.DISTRIB_LAITUE.id);
		var francoisOrderOperation = db.Operation.onOrderConfirm([francoisOrder1, francoisOrder2]);

		//User 2 buys products for a multidistrib
		var sebOrder1 = OrderService.make(TestSuite.SEB, 3, TestSuite.COURGETTES, TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE.id);
		var sebOrder2 = OrderService.make(TestSuite.SEB, 7, TestSuite.CARROTS, TestSuite.DISTRIB_CAROTTES.id);
		var sebOrderOperation = db.Operation.onOrderConfirm([sebOrder1, sebOrder2]);

		//User 3 buys products for the same multidistrib
		var julieOrder1 = OrderService.make(TestSuite.JULIE, 3, TestSuite.LAITUE, TestSuite.DISTRIB_LAITUE.id);
		var julieOrder2 = OrderService.make(TestSuite.JULIE, 5, TestSuite.CARROTS, TestSuite.DISTRIB_CAROTTES.id);
		var julieOrderOperation = db.Operation.onOrderConfirm([julieOrder1, julieOrder2]);
		
		//They all pay by credit card
		// var francoisPayment = db.Operation.makePaymentOperation(TestSuite.FRANCOIS,distrib1.catalog.amap, payment.Transfer.TYPE, TestSuite.POTATOES.price + 2 * TestSuite.LAITUE.price, "Payment by transfer", francoisOrderOperation[0]);
		// var sebPayment = db.Operation.makePaymentOperation(TestSuite.SEB,distrib1.catalog.amap, payment.Transfer.TYPE, 3 * TestSuite.COURGETTES.price + 7 * TestSuite.CAROTTES.price, "Payment by transfer", sebOrderOperation[0]);
		// var juliePayment = db.Operation.makePaymentOperation(TestSuite.JULIE,distrib1.catalog.amap, payment.Transfer.TYPE, 3 * TestSuite.LAITUE.price + 5 * TestSuite.CAROTTES.price, "Payment by transfer", julieOrderOperation[0]);
		
		//Get all the repartition
		var vendorDataByVendorId = service.ReportService.getMultiDistribVendorOrdersByProduct(distrib1.date, distrib1.place);

		//Check this is what we expect for each vendor
		Assert.equals( 3 * TestSuite.COURGETTES.price, vendorDataByVendorId.get(TestSuite.VENDOR1.id).orders[0].total);
		Assert.equals( 1 * TestSuite.POTATOES.price	, vendorDataByVendorId.get(TestSuite.VENDOR1.id).orders[1].total );
		Assert.equals( 5 * TestSuite.LAITUE.price 	, vendorDataByVendorId.get(TestSuite.VENDOR2.id).orders[0].total);
		Assert.equals( 12 * TestSuite.CARROTS.price	, vendorDataByVendorId.get(TestSuite.VENDOR3.id).orders[0].total);
		
		//Assert.equals(null, db.Operation.manager.get(operationId), null); //op should have been deleted
	}*/
	
	/**
	 * run once at the beginning
	 */
	/*function setup(){
		
		sys.db.Manager.cnx.request("TRUNCATE TABLE UserOrder;");
		
		var bubar = db.User.manager.get(1);
		var seb = db.User.manager.get(2);
		
		//fruits from group 1
		var fraises = db.Product.manager.get(2);
		fraises.stock = 30;
		var pommes = db.Product.manager.get(3);
		var distrib = fraises.catalog.getDistribs().first();
		
		db.UserOrder.make(bubar, 4, fraises, distrib.id);
		db.UserOrder.make(seb, 2, pommes, distrib.id);
		
		//vegetables from group 2
		var courgettes = db.Product.manager.get(4);
		var carottes = db.Product.manager.get(5);
		var distrib = courgettes.catalog.getDistribs().first();
		
		db.UserOrder.make(bubar, 1, carottes ,distrib.id);
		db.UserOrder.make(seb, 5, courgettes ,distrib.id);
	}*/
	

	/**
	 * test a simple report with just a time frame
	 */
	/*public function testTimeFrameReport(){
		
		var fraises = db.Product.manager.get(2);
		var pommes = db.Product.manager.get(3);
		var courgettes = db.Product.manager.get(4);
		var carottes = db.Product.manager.get(5);
		
		//check we got the right products
		Assert.equals("Fraises",fraises.name);
		Assert.equals("Pommes",pommes.name);
		Assert.equals("Courgettes",courgettes.name);
		Assert.equals("Carottes", carottes.name);
		
		var options = { startDate:new Date(2017, 5, 1, 0, 0, 0), endDate:new Date(2017, 5, 31, 0, 0, 0), groups:[], contracts:[] };
		
		var rep = new pro.OrderReport(options);
		
		var data = rep.byProduct();
		
		Assert.equals(4,data.length); //should be the 4 products
		
		for ( d in data){
			switch(d.pname){
				case "Fraises": Assert.equals(d.qt, 4);
				case "Pommes": Assert.equals(d.qt, 2);
				case "Carottes": Assert.equals(d.qt, 1);
				case "Courgettes": Assert.equals(d.qt, 5);			
			}
		}
		
	}*/
	
	
	/**
	 * test a report with time frame + group
	 */
	/*public function testGroupReport(){
		
		var options = { startDate:new Date(2017, 5, 1, 0, 0, 0), endDate:new Date(2017, 5, 31, 0, 0, 0), groups:[1], contracts:[] };
		
		var rep = new pro.OrderReport(options);
		var data = rep.byProduct();
		Assert.equals(2,data.length); //should be the 2 products
		
		for ( d in data){
			switch(d.pname){
				case "Fraises": Assert.equals(d.qt, 4);
				case "Pommes": Assert.equals(d.qt, 2);				
			}
		}
	}*/
	
	
	
}