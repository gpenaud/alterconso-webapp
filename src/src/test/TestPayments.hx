package test;import utest.Assert;

/**
 * Test payments
 * 
 * @author web-wizard
 */
class TestPayments extends utest.Test
{
	
	public function new(){
		super();
	}
	
	function setup(){		
		TestSuite.initDB();
		TestSuite.initDatas();
		db.Basket.emptyCache();
	}
	
	function testValidateDistribution() {

		//Take a contract with payments enabled
		//Take 2 users and make orders for each
		var distrib = TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE;
		var contract = distrib.catalog;
		var product = TestSuite.COURGETTES;
		var francoisOrder = service.OrderService.make(TestSuite.FRANCOIS, 1, product, distrib.id);
		var francoisOrderOperation = db.Operation.onOrderConfirm([francoisOrder]);
		var sebOrder = service.OrderService.make(TestSuite.SEB, 3, product, distrib.id);
		var sebOrderOperation = db.Operation.onOrderConfirm([sebOrder]);
		//They both pay by check
		var francoisPayment = db.Operation.makePaymentOperation(TestSuite.FRANCOIS,contract.group, payment.Check.TYPE, product.price, "Payment by check", francoisOrderOperation[0]);
		var sebPayment      = db.Operation.makePaymentOperation(TestSuite.SEB,contract.group, payment.Check.TYPE, 3 * product.price, "Payment by check", sebOrderOperation[0] );	

		var md = distrib.multiDistrib;
		//Autovalidate this old distrib and check that all the payments are validated
		service.PaymentService.validateDistribution(md);
		
		//distrib should be validated
		Assert.isTrue(contract.group.hasPayments());
		Assert.equals(true, md.validated);
		
		//orders should be marked as paid
		Assert.equals(true, francoisOrder.paid);
		Assert.equals(true, sebOrder.paid);

		//order operation is not pending
		var francoisOperation = db.Operation.findVOrderOperation(francoisOrder.distribution.multiDistrib, TestSuite.FRANCOIS, false);
		var sebOperation 	  = db.Operation.findVOrderOperation(sebOrder.distribution.multiDistrib, TestSuite.SEB, false);		
		Assert.equals(francoisOperation.pending, false);
		Assert.equals(sebOperation.pending, false);

		//payment operation is not pending
		Assert.equals(francoisPayment.pending, false);
		Assert.equals(sebPayment.pending, false);

		//basket are validated 
		var b = db.Basket.get(TestSuite.SEB,distrib.multiDistrib);
		Assert.equals(true, b.isValidated());
		var b = db.Basket.get(TestSuite.FRANCOIS,distrib.multiDistrib);
		Assert.equals(true, b.isValidated());
	}

	function testMakeOnTheSpotPaymentOperations()
	{
		//Take a contract with payments enabled
		//Make 2 orders
		var distrib = TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE;
		var contract = distrib.catalog;
		var product1 = TestSuite.COURGETTES;
		var julieOrder1 = service.OrderService.make(TestSuite.JULIE, 1, product1, distrib.id);
		var julieOrderOperation1 = db.Operation.onOrderConfirm([julieOrder1]);
		
		//Payment on the spot
		var juliePayment1 = db.Operation.makePaymentOperation(TestSuite.JULIE,contract.group, payment.OnTheSpotPayment.TYPE, product1.price, "Payment on the spot", julieOrderOperation1[0]);

		var product2 = TestSuite.CARROTS;
		var julieOrder2 = service.OrderService.make(TestSuite.JULIE, 1, product2, distrib.id);
		var julieOrderOperation2 = db.Operation.onOrderConfirm([julieOrder2]);
		
		//Payment on the spot
		var juliePayment2 = db.Operation.makePaymentOperation(TestSuite.JULIE,contract.group, payment.OnTheSpotPayment.TYPE, product2.price, "Payment on the spot", julieOrderOperation2[0]);

		//Check that the second payment is just an update of the first one
		Assert.equals(juliePayment1.id, juliePayment2.id);
	}

}