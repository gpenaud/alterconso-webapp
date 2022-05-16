package test;import service.SubscriptionService;
import utest.Assert;
import service.DistributionService;

/**
 * Test distributions
 */
class TestDistributions extends utest.Test
{
	
	public function new(){
		super();
	}
	
	/**
	 * 
	 */
	function setup(){		
		TestSuite.initDB();
		TestSuite.initDatas();
	}
	
	/**
	 * Check that we can add a distribution outside existing time range for a specific contract and place
	 * Check that we can't add a distribution overlapping with existing distribution for a specific contract and place
	 */
	/*function testOverlapping() {        
    	var existingDistrib = TestSuite.DISTRIB_FRUITS_PLACE_DU_VILLAGE;
		var e1 = null;
		try {
			var distrib1 = service.DistributionService.create(existingDistrib.contract,new Date(2018, 5, 1, 18, 0, 0),new Date(2018, 5, 1, 18, 30, 0),
			existingDistrib.place.id,new Date(2018, 4, 1, 18, 0, 0),new Date(2018, 4, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error) {
			e1 = x;
		}
		Assert.equals(e1, null);

		//existingDistrib.date <= distrib2.date && existingDistrib.end >= distrib2.date
		var e2 = null;
		try {
			var distrib2 = service.DistributionService.create(existingDistrib.contract,new Date(2017, 5, 1, 19, 30, 0),new Date(2017, 5, 1, 20, 30, 0),
			existingDistrib.place.id,new Date(2017, 4, 1, 18, 0, 0),new Date(2017, 4, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error) {
			e2 = x;
		}
		Assert.equals(e2.message, "There is already a distribution at this place overlapping with the time range you've selected.");

		//existingDistrib.date <= distrib3.end && existingDistrib.end >= distrib3.end
		var e3 = null;
		try{
			var distrib3 = service.DistributionService.create(existingDistrib.contract,new Date(2017, 5, 1, 17, 30, 0),new Date(2017, 5, 1, 19, 30, 0),
			existingDistrib.place.id,new Date(2017, 4, 1, 18, 0, 0),new Date(2017, 4, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error){
			e3 = x;
		}
		Assert.equals(e3.message, "There is already a distribution at this place overlapping with the time range you've selected.");

		//existingDistrib.date >= distrib4.date && existingDistrib.end <= distrib4.end
		var e4 = null;
		try{
			var distrib4 = service.DistributionService.create(existingDistrib.contract,new Date(2017, 5, 1, 17, 30, 0),new Date(2017, 5, 1, 21, 30, 0),
			existingDistrib.place.id,new Date(2017, 4, 1, 18, 0, 0),new Date(2017, 4, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error){
			e4 = x;
		}
		Assert.equals(e4.message, "There is already a distribution at this place overlapping with the time range you've selected.");

		//existingDistrib.date  > distrib5.end
		var e5 = null;
		try{
			var distrib5 = service.DistributionService.create(existingDistrib.contract,new Date(2017, 5, 1, 17, 30, 0),new Date(2017, 5, 1, 18, 59, 0),
			existingDistrib.place.id,new Date(2017, 4, 1, 18, 0, 0),new Date(2017, 4, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error){
			e5 = x;
		}
		Assert.equals(e5, null);

		//existingDistrib.date  > distrib6.end
		var e6 = null;
		try{
			var distrib6 = service.DistributionService.create(existingDistrib.contract,new Date(2017, 3, 1, 17, 30, 0),new Date(2017, 3, 1, 18, 59, 0),
			existingDistrib.place.id,new Date(2017, 2, 1, 18, 0, 0),new Date(2017, 3, 30, 18, 30, 0));
		}
		catch(x:tink.core.Error){
			e6 = x;
		}
		Assert.equals(e6.message, "The distribution start date must be set after the orders end date.");

	}*/


	/**
		test distributions cycles
	**/
	function testCreateCycle() {
		TestSuite.CONTRAT_LEGUMES.startDate = new Date(2018, 0, 1, 0, 0, 0);
		TestSuite.CONTRAT_LEGUMES.endDate = new Date(2019, 11, 31, 23, 59, 0);
		TestSuite.CONTRAT_LEGUMES.update();
		//create a cycle for LOCAVORES
		var weeklyDistribCycle = service.DistributionService.createCycle(
			TestSuite.LOCAVORES,
			Weekly,
			new Date(2018, 11, 24, 0, 0, 0),
			new Date(2019, 0, 24, 0, 0, 0),
			new Date(2018, 5, 4, 13, 0, 0),
			new Date(2018, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2018, 5, 4, 8, 0, 0),
			new Date(2018, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[TestSuite.CONTRAT_LEGUMES.id]);

		var weeklyDistribs = weeklyDistribCycle.getDistributions();
		Assert.equals(weeklyDistribs.length, 5);
		Assert.equals(weeklyDistribs[0].distribStartDate.toString(), new Date(2018, 11, 24, 13, 0, 0).toString());
		Assert.equals(weeklyDistribs[0].distribEndDate.toString(), new Date(2018, 11, 24, 14, 0, 0).toString());
		Assert.equals(weeklyDistribs[1].distribStartDate.toString(), new Date(2018, 11, 31, 13, 0, 0).toString());
		Assert.equals(weeklyDistribs[1].distribEndDate.toString(), new Date(2018, 11, 31, 14, 0, 0).toString());
		Assert.equals(weeklyDistribs[2].distribStartDate.toString(), new Date(2019, 0, 7, 13, 0, 0).toString());
		Assert.equals(weeklyDistribs[2].distribEndDate.toString(), new Date(2019, 0, 7, 14, 0, 0).toString());
		Assert.equals(weeklyDistribs[3].distribStartDate.toString(), new Date(2019, 0, 14, 13, 0, 0).toString());
		Assert.equals(weeklyDistribs[3].distribEndDate.toString(), new Date(2019, 0, 14, 14, 0, 0).toString());
		Assert.equals(weeklyDistribs[4].distribStartDate.toString(), new Date(2019, 0, 21, 13, 0, 0).toString());
		Assert.equals(weeklyDistribs[4].distribEndDate.toString(), new Date(2019, 0, 21, 14, 0, 0).toString());
		DistributionService.deleteDistribCycle(weeklyDistribCycle);

		var monthlyDistribCycle = service.DistributionService.createCycle(
			TestSuite.LOCAVORES,
			Monthly,
			new Date(2018, 9, 30, 0, 0, 0),
			new Date(2019, 2, 31, 0, 0, 0),
			new Date(2018, 5, 4, 13, 0, 0),
			new Date(2018, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2018, 5, 4, 8, 0, 0),
			new Date(2018, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[TestSuite.CONTRAT_LEGUMES.id]);

		var monthlyDistribs = monthlyDistribCycle.getDistributions();
		Assert.equals(monthlyDistribs.length, 6);
		Assert.equals(monthlyDistribs[0].distribStartDate.toString(), new Date(2018, 9, 30, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[0].distribEndDate.toString(), new Date(2018, 9, 30, 14, 0, 0).toString());
		Assert.equals(monthlyDistribs[1].distribStartDate.toString(), new Date(2018, 10, 27, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[1].distribEndDate.toString(), new Date(2018, 10, 27, 14, 0, 0).toString());
		Assert.equals(monthlyDistribs[2].distribStartDate.toString(), new Date(2018, 11, 25, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[2].distribEndDate.toString(), new Date(2018, 11, 25, 14, 0, 0).toString());
		Assert.equals(monthlyDistribs[3].distribStartDate.toString(), new Date(2019, 0, 29, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[3].distribEndDate.toString(), new Date(2019, 0, 29, 14, 0, 0).toString());
		Assert.equals(monthlyDistribs[4].distribStartDate.toString(), new Date(2019, 1, 26, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[4].distribEndDate.toString(), new Date(2019, 1, 26, 14, 0, 0).toString());
		Assert.equals(monthlyDistribs[5].distribStartDate.toString(), new Date(2019, 2, 26, 13, 0, 0).toString());
		Assert.equals(monthlyDistribs[5].distribEndDate.toString(), new Date(2019, 2, 26, 14, 0, 0).toString());
		DistributionService.deleteDistribCycle(monthlyDistribCycle);
		
		var biweeklyDistribCycle = DistributionService.createCycle(
			TestSuite.LOCAVORES,
			BiWeekly,
			new Date(2018, 9, 30, 0, 0, 0),
			new Date(2019, 0, 31, 0, 0, 0),
			new Date(2018, 5, 4, 13, 0, 0),
			new Date(2018, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2018, 5, 4, 8, 0, 0),
			new Date(2018, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[TestSuite.CONTRAT_LEGUMES.id]
		);

		var biweeklyDistribs = biweeklyDistribCycle.getDistributions();
		Assert.equals(biweeklyDistribs.length, 7);
		Assert.equals(biweeklyDistribs[0].distribStartDate.toString(), new Date(2018, 9, 30, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[0].distribEndDate.toString(), new Date(2018, 9, 30, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[1].distribStartDate.toString(), new Date(2018, 10, 13, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[1].distribEndDate.toString(), new Date(2018, 10, 13, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[2].distribStartDate.toString(), new Date(2018, 10, 27, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[2].distribEndDate.toString(), new Date(2018, 10, 27, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[3].distribStartDate.toString(), new Date(2018, 11, 11, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[3].distribEndDate.toString(), new Date(2018, 11, 11, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[4].distribStartDate.toString(), new Date(2018, 11, 25, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[4].distribEndDate.toString(), new Date(2018, 11, 25, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[5].distribStartDate.toString(), new Date(2019, 0, 8, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[5].distribEndDate.toString(), new Date(2019, 0, 8, 14, 0, 0).toString());
		Assert.equals(biweeklyDistribs[6].distribStartDate.toString(), new Date(2019, 0, 22, 13, 0, 0).toString());
		Assert.equals(biweeklyDistribs[6].distribEndDate.toString(), new Date(2019, 0, 22, 14, 0, 0).toString());
		DistributionService.deleteDistribCycle(biweeklyDistribCycle);
	
		var triweeklyDistribCycle = DistributionService.createCycle(
			TestSuite.LOCAVORES,
			TriWeekly,
			new Date(2018, 9, 30, 0, 0, 0),
			new Date(2019, 0, 31, 0, 0, 0),
			new Date(2018, 5, 4, 13, 0, 0),
			new Date(2018, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2018, 5, 4, 8, 0, 0),
			new Date(2018, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[TestSuite.CONTRAT_LEGUMES.id]
			);

		var triweeklyDistribs = triweeklyDistribCycle.getDistributions();
		Assert.equals(triweeklyDistribs.length, 5);
		Assert.equals(triweeklyDistribs[0].distribStartDate.toString(), new Date(2018, 9, 30, 13, 0, 0).toString());
		Assert.equals(triweeklyDistribs[0].distribEndDate.toString(), new Date(2018, 9, 30, 14, 0, 0).toString());
		Assert.equals(triweeklyDistribs[1].distribStartDate.toString(), new Date(2018, 10, 20, 13, 0, 0).toString());
		Assert.equals(triweeklyDistribs[1].distribEndDate.toString(), new Date(2018, 10, 20, 14, 0, 0).toString());
		Assert.equals(triweeklyDistribs[2].distribStartDate.toString(), new Date(2018, 11, 11, 13, 0, 0).toString());
		Assert.equals(triweeklyDistribs[2].distribEndDate.toString(), new Date(2018, 11, 11, 14, 0, 0).toString());
		Assert.equals(triweeklyDistribs[3].distribStartDate.toString(), new Date(2019, 0, 1, 13, 0, 0).toString());
		Assert.equals(triweeklyDistribs[3].distribEndDate.toString(), new Date(2019, 0, 1, 14, 0, 0).toString());
		Assert.equals(triweeklyDistribs[4].distribStartDate.toString(), new Date(2019, 0, 22, 13, 0, 0).toString());
		Assert.equals(triweeklyDistribs[4].distribEndDate.toString(), new Date(2019, 0, 22, 14, 0, 0).toString());
		DistributionService.deleteDistribCycle(triweeklyDistribCycle);
	}

	function testDelete() { 
		//A variable contract with a distribution that has orders
		var ordersDistrib = TestSuite.DISTRIB_LEGUMES_RUE_SAUCISSE;
		var ordersDistribId = ordersDistrib.id;
		var POTATOES = TestSuite.POTATOES;
		var order = service.OrderService.make(TestSuite.FRANCOIS, 1, POTATOES, ordersDistrib.id);

		var e = null;
		try{
			DistributionService.cancelParticipation(ordersDistrib);
		}
		catch(x:tink.core.Error){
			e = x;
		}
		Assert.isTrue( e!=null && e.message.indexOf("Deletion") > -1 ); //deletion not possible
		Assert.isTrue( db.Distribution.manager.get(ordersDistribId) != null );

		//A variable contract with a distribution that has no orders
		var noOrdersDistrib = TestSuite.DISTRIB_FRUITS_PLACE_DU_VILLAGE;
		var noOrdersDistribId = noOrdersDistrib.id;
		
		var e = null;
		try{
			DistributionService.cancelParticipation(noOrdersDistrib);
		}
		catch(x:tink.core.Error){
			e = x;
		}
		Assert.equals(e, null);
		Assert.equals(db.Distribution.manager.get(noOrdersDistribId), null);

		//An Amap contract with a distribution that has orders
		var amapDistrib = TestSuite.DISTRIB_CONTRAT_AMAP;
		var amapDistribId = amapDistrib.id;
		var panier = TestSuite.PANIER_AMAP_LEGUMES;
		var amapOrder = service.OrderService.make(TestSuite.FRANCOIS, 1, panier, amapDistrib.id);

		var e = null;
		try{
			DistributionService.cancelParticipation(amapDistrib);
		}
		catch(x:tink.core.Error){
			e = x;
		}
		Assert.equals(e, null);
		Assert.equals(db.Distribution.manager.get(amapDistribId), null);
		
	}

	function testUpdateAmapContractOperations(){

		var t = sugoi.i18n.Locale.texts;

		//Take an amap contract with payments enabled
		//Take 2 users and make orders for each
		var amapDistrib = TestSuite.DISTRIB_CONTRAT_AMAP;
		var contract = amapDistrib.catalog;
		var panier = TestSuite.PANIER_AMAP_LEGUMES;
		var francoisOrder = service.OrderService.make(TestSuite.FRANCOIS, 1, panier, amapDistrib.id);
		db.Operation.onOrderConfirm([francoisOrder]);
		var sebOrder = service.OrderService.make(TestSuite.SEB, 3, panier, amapDistrib.id);
		db.Operation.onOrderConfirm([sebOrder]);

		//Check initial operation names and amounts
		var francoisOperation = db.Operation.findCOrderOperation(contract, TestSuite.FRANCOIS);
		Assert.equals(francoisOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 1 deliveries");
		Assert.equals(francoisOperation.amount, -13);
		var sebOperation = db.Operation.findCOrderOperation(contract, TestSuite.SEB);
		Assert.equals(sebOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 1 deliveries");
		Assert.equals(sebOperation.amount, -39);

		//Add a distrib
		var distrib = null;
		var e = null;
		try{
			distrib = DistributionService.create(
				contract,
				new Date(2018, 5, 1, 18, 0, 0),
				new Date(2018, 5, 1, 18, 30, 0),
				amapDistrib.place.id,
				new Date(2018, 4, 1, 18, 0, 0),
				new Date(2018, 4, 30, 18, 30, 0)
			);
		}
		catch(x:tink.core.Error){
			e = x;
		}
		//Check names and amounts are modified accordingly
		Assert.equals(francoisOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 2 deliveries");
		Assert.equals(francoisOperation.amount, -26);
		var sebOperation = db.Operation.findCOrderOperation(contract, TestSuite.SEB);
		Assert.equals(sebOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 2 deliveries");
		Assert.equals(sebOperation.amount, -78);

		//Add a distrib cycle
		var weeklyDistribCycle = DistributionService.createCycle(
			contract.group,
			Weekly,
			new Date(2018, 11, 24, 0, 0, 0),
			new Date(2019, 0, 24, 0, 0, 0),
			new Date(2018, 5, 4, 13, 0, 0),
			new Date(2018, 5, 4, 14, 0, 0),
			10,
			2,
			new Date(2018, 5, 4, 8, 0, 0),
			new Date(2018, 5, 4, 23, 0, 0),
			TestSuite.PLACE_DU_VILLAGE.id,
			[contract.id]
		);
		//Check names and amounts are modified accordingly
		Assert.equals(francoisOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 7 deliveries");
		Assert.equals(francoisOperation.amount, -91);
		var sebOperation = db.Operation.findCOrderOperation(contract, TestSuite.SEB);
		Assert.equals(sebOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 7 deliveries");
		Assert.equals(sebOperation.amount, -273);

		//Delete the distrib cycle
		DistributionService.deleteDistribCycle(weeklyDistribCycle);
		//Check names and amounts are modified accordingly
		Assert.equals(francoisOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 2 deliveries");
		Assert.equals(francoisOperation.amount, -26);
		var sebOperation = db.Operation.findCOrderOperation(contract, TestSuite.SEB);
		Assert.equals(sebOperation.name, "Contrat AMAP Légumes (La ferme de la Galinette) 2 deliveries");
		Assert.equals(sebOperation.amount, -78);
	}

	/**
		cant have 2 multidistribs on same day, same place
	**/
	function testCantCreateDistribOnSameDay(){
		//create first ditribs
		var md1 = DistributionService.createMd(
			TestSuite.PLACE_DU_VILLAGE,
			new Date(2020,1,1,19,0,0),
			new Date(2020,1,1,21,0,0),
			new Date(2020,0,1,0,0,0),
			new Date(2020,0,30,0,0,0),
			[]
		);
		
		Assert.isTrue(md1 != null,"md1 should be created");

		//cant create a multidistrib on same day
		Assert.raises(
			() -> DistributionService.createMd(md1.place,md1.distribStartDate,md1.distribEndDate,md1.orderStartDate,md1.orderEndDate,[]),
			tink.core.Error,
			"an error should have been thrown"
		);

		// can create on another day
		var md2 = DistributionService.createMd(
			TestSuite.PLACE_DU_VILLAGE,
			new Date(2020,2,1,19,0,0),
			new Date(2020,2,1,21,0,0),
			new Date(2020,1,1,0,0,0),
			new Date(2020,1,30,0,0,0),
			[]
		);
		Assert.isTrue(md2 != null,"md2 should be created");

		//cannot update it to same date as md1
		Assert.raises(
			() -> DistributionService.editMd(md2,md2.place,md1.distribStartDate,md1.distribEndDate,md1.orderStartDate,md1.orderEndDate),
			tink.core.Error,
			"an error should have been thrown"
		);

		//can edit it and plan it on another day
		md2 = DistributionService.editMd(
			md2,
			md2.place,
			new Date(2020,1,20,19,0,0),
			new Date(2020,1,20,20,0,0),
			md1.orderStartDate,
			md1.orderEndDate
		);
		Assert.isTrue(md2 != null,"md2 should be created");
		Assert.equals(md2.distribStartDate.toString(),new Date(2020,1,20,19,0,0).toString());

	}

	

}