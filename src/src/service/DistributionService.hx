package service;
import db.Subscription;
import service.PaymentService.PaymentContext;
import Common;
import tink.core.Error;
using tools.DateTool;

/**
 * Distribution Service
 * @author web-wizard
 */
class DistributionService
{
	/**
	 *  It will update the name of the operation with the new number of distributions
	 *  as well as the total amount
	 *  @param contract - 
	 */
	public static function updateAmapContractOperations(contract:db.Catalog) {

		//Update all operations for this amap contract when payments are enabled
		if (contract.type == db.Catalog.TYPE_CONSTORDERS && contract.group.hasPayments()) {
			//Get all the users who have orders for this contract
			var users = contract.getUsers();
			for ( user in users ){

				//Get the one operation for this amap contract and user
				var operation = db.Operation.findCOrderOperation(contract, user);

				if (operation != null)
				{
					//Get all the orders for this contract and user
					var orders = contract.getUserOrders(user);
					//Update this operation with the new number of distributions, this will affect the name of the operation
					//as well as the total amount to pay
					db.Operation.updateOrderOperation(operation, orders);
				}

			}
		}
	}


	public static function checkMultiDistrib(d:db.MultiDistrib){

		var t = sugoi.i18n.Locale.texts;

		if (d.distribStartDate==null) {
			throw new Error(t._("This distribution has no date."));
		}else{		
			// distrib end date is the same day as distrib start date
			d.distribEndDate = new Date(d.distribStartDate.getFullYear(), d.distribStartDate.getMonth(), d.distribStartDate.getDate(), d.distribEndDate.getHours(), d.distribEndDate.getMinutes(), 0);
			d.update();
		}

		if ( d.orderStartDate==null || d.orderEndDate==null ) {
			throw new Error(t._("This distribution should have an order opening date and an order closing date."));
		}
		
		if (d.distribStartDate.getTime() < d.orderEndDate.getTime() ){
			throw new Error(t._("The distribution start date must be set after the orders end date."));
		} 

		if (d.orderStartDate.getTime() > d.orderEndDate.getTime() ){
			throw new Error(t._("The orders end date must be set after the orders start date !"));
		} 
		
	}
	
	/**
	 * checks if dates are correct and if that there is no other distribution in the same time range
	 *  and for the same contract and place
	 * @param d
	 */
	public static function checkDistrib(d:db.Distribution) {

		var t = sugoi.i18n.Locale.texts;
		var view = App.current.view;
		var catalog = d.catalog;

		/*var distribs1;
		var distribs2;	
		var distribs3;	
		//We are checking that there is no existing distribution with an overlapping time frame for the same place and contract
		if (d.id == null) { //We need to check there the id as $id != null doesn't work in the manager.search
			//Looking for existing distributions with a time range overlapping the start of the about to be created distribution
			distribs1 = db.Distribution.manager.search($contract == c && $place == d.place && $date <= d.date && $end >= d.date, false);
			//Looking for existing distributions with a time range overlapping the end of the about to be created distribution
			distribs2 = db.Distribution.manager.search($contract == c && $place == d.place && $date <= d.end && $end >= d.end, false);	
			//Looking for existing distributions with a time range included in the time range of the about to be created distribution		
			distribs3 = db.Distribution.manager.search($contract == c && $place == d.place && $date >= d.date && $end <= d.end, false);	
		}
		else {
			//Looking for existing distributions with a time range overlapping the start of the about to be created distribution
			distribs1 = db.Distribution.manager.search($contract == c && $place == d.place && $date <= d.date && $end >= d.date && $id != d.id, false);
			//Looking for existing distributions with a time range overlapping the end of the about to be created distribution
			distribs2 = db.Distribution.manager.search($contract == c && $place == d.place && $date <= d.end && $end >= d.end && $id != d.id, false);	
			//Looking for existing distributions with a time range included in the time range of the about to be created distribution		
			distribs3 = db.Distribution.manager.search($contract == c && $place == d.place && $date >= d.date && $end <= d.end && $id != d.id, false);	
		}
			
		if (distribs1.length != 0 || distribs2.length != 0 || distribs3.length != 0) {
			throw new Error(t._("There is already a distribution at this place overlapping with the time range you've selected."));
		}*/
		var catalogStartDate = DateTool.setHourMinute(catalog.startDate,0,0);
		var catalogEndDate = DateTool.setHourMinute(catalog.endDate,23,59);
		// trace(catalogEndDate);
		if (d.date.getTime() > catalogEndDate.getTime()){
			throw new Error(t._("The date of the delivery must be prior to the end of the catalog (::contractEndDate::)", {contractEndDate:view.hDate(catalog.endDate)}));
		}

		if (d.date.getTime() < catalogStartDate.getTime()){
			throw new Error(t._("The date of the delivery must be after the begining of the catalog (::contractBeginDate::)", {contractBeginDate:view.hDate(catalog.startDate)}));
		} 
		
		if (catalog.type == db.Catalog.TYPE_VARORDER ) {
			if (d.date.getTime() < d.orderEndDate.getTime() ) throw new Error(t._("The distribution start date must be set after the orders end date."));
			if (d.orderStartDate.getTime() > d.orderEndDate.getTime() ) throw new Error(t._("The orders end date must be set after the orders start date !"));
		}
	}

	 /**
	  	Creates a new distribution (attendance to a multidistribution)
		@deprecated
	  */
	 public static function create(contract:db.Catalog,date:Date,end:Date,placeId:Int,orderStartDate:Date,orderEndDate:Date,?distributionCycle:db.DistributionCycle,?dispatchEvent=true,?md:db.MultiDistrib):db.Distribution {

		var d = new db.Distribution();
		d.catalog = contract;
		d.date = date;
		d.place = db.Place.manager.get(placeId);
		//d.distributionCycle = distributionCycle;

		if(contract.type==db.Catalog.TYPE_VARORDER){
			d.orderStartDate = orderStartDate;
			d.orderEndDate = orderEndDate;
		}

		//end date cleaning			
		if (end == null) {
			d.end = DateTools.delta(d.date, 1000.0 * 60 * 60);
		} else {
			d.end = new Date(d.date.getFullYear(), d.date.getMonth(), d.date.getDate(), end.getHours(), end.getMinutes(), 0);
		} 
		
		//link to a multiDistrib
		if(md==null){
			md = db.MultiDistrib.get(d.date, d.place, true);
		}
		if(md==null){
			md = createMd(d.place, d.date, d.end, orderStartDate, orderEndDate,[] );
		}
		d.multiDistrib = md;

		//check role if needed
		var roles = service.VolunteerService.getRolesFromContract(contract);
		if(roles.length>0){			
			var roleIds = md.getVolunteerRoleIds();
			roleIds = roleIds.concat(roles.map( function(r) return r.id ));
			md.volunteerRolesIds = roleIds.join(",");
		}
		
		md.update();
		
		checkDistrib(d);
		
		if(distributionCycle == null && dispatchEvent) {
			var e :Event = NewDistrib(d);
			App.current.event(e);
		}
		
		if (d.date == null){
			return d;
		} else {
			d.insert();

			//In case this is a distrib for an amap contract with payments enabled, it will update all the operations
			//names and amounts with the new number of distribs
			updateAmapContractOperations(d.catalog);

			return d;
		}
	}

	public static function createMd(place:db.Place,distribStartDate:Date,distribEndDate:Date,orderStartDate:Date,orderEndDate:Date,contractIds:Array<Int>,?cycle:db.DistributionCycle):db.MultiDistrib{

		
		if(db.MultiDistrib.get(distribStartDate,place) != null){
			throw new Error(Conflict,'Il y a déjà une distribution à cette date.');
		}
		
		var md = new db.MultiDistrib();
		md.group = place.group;
		md.place = place;
		md.distribStartDate = distribStartDate;
		md.distribEndDate 	= distribEndDate;
		md.orderStartDate 	= orderStartDate;
		md.orderEndDate 	= orderEndDate;
		if(cycle!=null) md.distributionCycle = cycle;
		md.place = place;
		

		//add default general roles
		var roles = service.VolunteerService.getRolesFromGroup(place.group);
		var generalRoles = Lambda.array(Lambda.filter(roles,function(r) return r.catalog==null));
		md.volunteerRolesIds = generalRoles.map( function(r) return Std.string(r.id) ).join(",");
		md.insert();
			
		checkMultiDistrib(md);

		for( cid in contractIds){
			var contract = db.Catalog.manager.get(cid,false);
			service.DistributionService.participate(md,contract);
		}

		return md;
	}

	/**
		Edit a multidistrib.		
	**/
	public static function editMd(md:db.MultiDistrib, place:db.Place,distribStartDate:Date,distribEndDate:Date,orderStartDate:Date,orderEndDate:Date,?overrideDates=false):db.MultiDistrib{
		
		md.lock();

		if(db.MultiDistrib.manager.select($distribStartDate==distribStartDate && $place==place && $id!=md.id) != null){
			throw new Error(Conflict,'Il y a déjà une distribution à cette date.');
		}

		if(md.slots!=null){
			if(md.distribStartDate.getTime()!=distribEndDate.getTime() || md.distribEndDate.getTime()!=distribEndDate.getTime() ){
				throw new Error(Conflict,'Vous ne pouvez plus changer les horaires de distribution car vous avez activé la gestion des créneaux horaires.');
			}
		}
		

		var oldDistrib = {
			distribStartDate : md.distribStartDate,
			distribEndDate   : md.distribEndDate,
			orderStartDate   : md.orderStartDate,
			orderEndDate     : md.orderEndDate,
		};

		md.distribStartDate = distribStartDate;
		md.distribEndDate 	= distribEndDate;
		md.orderStartDate 	= orderStartDate;
		md.orderEndDate 	= orderEndDate;
		md.place = place;
		md.update();

		checkMultiDistrib(md);

		//update related distributions
		for( d in md.getDistributions()){
			d.lock();
			d.date  = distribStartDate;
			d.end   = distribEndDate;
			d.place = place;			
			
			if(overrideDates || d.orderStartDate==null){
				d.orderStartDate = md.orderStartDate;
				d.orderEndDate = md.orderEndDate;
			}else{
				//update startDate and endDate if was the same
				if(d.orderStartDate.getTime()==oldDistrib.orderStartDate.getTime()){
					d.orderStartDate = md.orderStartDate;
				}
				if(d.orderEndDate.getTime()==oldDistrib.orderEndDate.getTime()){
					d.orderEndDate = md.orderEndDate;
				}
			}
			d.update();
		}

		//sync
		for( d in md.getDistributions()){
			d.lock();
			
			d.update();
		}

		return md;
	}

	/**
		Delete a multidistribution
	**/
	public static function deleteMd(md:db.MultiDistrib){
		var t = sugoi.i18n.Locale.texts;
		md.lock();
		for(d in md.getDistributions()){
			cancelParticipation(d,false);
		}
		md.delete();
	}

	/**
		Participate to a multidistrib.
	**/
	public static function participate(md:db.MultiDistrib,catalog:db.Catalog){
		var t = sugoi.i18n.Locale.texts;
		md.lock();

		for( d in md.getDistributions()){
			if(d.catalog.id==catalog.id){
				throw new Error(t._("This vendor is already participating to this distribution"));
			}
		}

		if( catalog.type == db.Catalog.TYPE_VARORDER){
			if(md.orderStartDate==null || md.orderEndDate==null){
				var url = "/distribution/editMd/" + md.id;
				throw new Error(t._("You can't participate to this distribution because no order start date has been defined. <a href='::url::' target='_blank'>Please update the general distribution first</a>.",{url:url}));
			}
		}

		if( catalog.isCSACatalog() ){
			//if there is at least one validated subscription, cancelation is not possible
			if( db.Subscription.manager.count( $catalogId == catalog.id && $isValidated ) > 0){
				throw new Error("Vous ne pouvez pas participer à cette distribution car il y a déjà des souscriptions validées. Vous devez maintenir le même nombre de distributions dans les souscriptions des adhérents.");
			} else if( db.Subscription.manager.count( $catalogId == catalog.id  ) > 0 ){
				App.current.session.addMessage( "Attention, vous avez déjà des souscriptions enregistrées pour ce contrat. Si vous créez des distributions supplémentaires, le montant à payer va varier." , true);
			}
		}

		md.deleteProductsExcerpt();
		
		return create(catalog,md.distribStartDate,md.distribEndDate,md.place.id,md.orderStartDate,md.orderEndDate,null,true,md);

	}

	 /**
	  *  Modifies an existing distribution and prevents distribution overlapping and other checks
	  	@deprecated !
	 */
	 public static function edit(d:db.Distribution,date:Date,end:Date,placeId:Int,orderStartDate:Date,orderEndDate:Date,?dispatchEvent=true):db.Distribution {

		//We prevent others from modifying it
		d.lock();
		var t = sugoi.i18n.Locale.texts;

		if(d.multiDistrib.validated) {
			throw new Error(t._("You cannot edit a distribution which has been already validated."));
		}

		//cannot change to a different date than the multidistrib
		if(date.toString().substr(0,10) != d.multiDistrib.distribStartDate.toString().substr(0,10) ){
			if(d.multiDistrib.getDistributions().length==1){
				//can change if its the only one
				d.multiDistrib.lock();
				d.multiDistrib.distribStartDate = date;
				d.multiDistrib.distribEndDate = end; 
				if(d.catalog.type==db.Catalog.TYPE_VARORDER){
					d.multiDistrib.orderStartDate = orderStartDate;
					d.multiDistrib.orderEndDate = orderEndDate;
				}
				d.multiDistrib.update();
			}else{
				throw new Error(t._("The distribution date is different from the date of the general distribution."));
			}
			
		}

		//cannot change the place
		if(placeId != d.multiDistrib.place.id ){
			if(d.multiDistrib.getDistributions().length==1){
				//can change if its the only one
				d.multiDistrib.lock();
				d.multiDistrib.place = db.Place.manager.get(placeId);
				d.multiDistrib.update();
			}else{
				throw new Error(t._("The distribution place is different from the place of the general distribution."));
			}			
		}

		d.date = date;
		d.place = db.Place.manager.get(placeId);
		if(d.catalog.type==db.Catalog.TYPE_VARORDER){
			d.orderStartDate = orderStartDate;
			d.orderEndDate = orderEndDate;
		}
					
		if (end == null) {
			d.end = DateTools.delta(d.date, 1000.0 * 60 * 60);
		} else {
			d.end = new Date(d.date.getFullYear(), d.date.getMonth(), d.date.getDate(), end.getHours(), end.getMinutes(), 0);
		} 
		
		checkDistrib(d);

		if(dispatchEvent) App.current.event(EditDistrib(d));
		
		if (d.date == null){
			return d;
		} else {
			d.update();
			return d;
		}
	}

	/**
		Edit attendance of a farmer to a distribution(md)
	**/
	public static function editAttendance(d:db.Distribution,newMd:db.MultiDistrib,orderStartDate:Date,orderEndDate:Date,?dispatchEvent=true):db.Distribution {

		//We prevent others from modifying it
		d.lock();
		var t = sugoi.i18n.Locale.texts;

		if(d.multiDistrib.validated) {
			throw new Error(t._("You cannot edit a distribution which has been already validated."));
		}

		//Distribution shift
		if(newMd.id!=d.multiDistrib.id){

			//check that the vendor does not already participate
			if( newMd.getDistributionForContract(d.catalog) != null){
				throw new Error(d.catalog.vendor.name+" participe déjà à la distribution du "+Formatting.hDate(newMd.getDate()));
			}

			/* 
			FORBID THIS WITH CREDIT CARD PAYMENTS 
			because it would make the order and payment ops out of sync
			*/
			var orders = d.getOrders();
			#if plugins
			if(d.catalog.group.hasPayments() && orders.length>0){
				var paymentTypes = PaymentService.getPaymentTypes( PaymentContext.PCPayment , newMd.getGroup() );
				if( paymentTypes.find( p -> return p.type==MangopayECPayment.TYPE || p.type==MangopayMPPayment.TYPE ) != null ){
					throw new Error("Les décalages de distributions sont interdits lorsque le paiement en ligne est activé et que des commandes sont déjà enregistrées.");
				}
			}
			#end

			//different multidistrib id : should change the baskets	
			for ( o in orders ){
				o.lock();
				//find new basket
				o.basket = db.Basket.getOrCreate(o.user, newMd);
				o.update();
			}

			//renumbering baskets
			for( b in newMd.getBaskets()){
				b.renumber();
			}

			//extends contract if needed
			if( newMd.distribStartDate.getTime() > d.catalog.endDate.getTime() ){
				var catalog = d.catalog;
				catalog.lock();
				catalog.endDate = newMd.distribStartDate;
				catalog.update();
				// trace(catalog.endDate);
			}

			//extends subscriptions ?
			if(d.catalog.hasSubscriptions()){
				//get subscriptions that were concerned by this distribution
				var subscriptions = Subscription.manager.search($catalog==d.catalog && $startDate <= d.date && $endDate >= d.date , true );
				for ( sub in subscriptions ){
					//if the subscription is closing before the new date, extends it
					if(sub.endDate.getTime() < newMd.getDate().getTime()){
						SubscriptionService.updateSubscription(sub, sub.startDate, newMd.getDate(), null, sub.isValidated );
					}					
				}
				/**
				2020-03-04 francois :
				il peut se produire un bug pour une souscription concernée par la distrib reportée, si cette souscription est terminée de maniere anticipée.
				le code actuel va reporter sa date de fin à la distrib reportée, ce qui va certainement englober d'autres distribs non souhaitées.
				**/
			}
			
		}

		d.multiDistrib = newMd;
		d.date = newMd.distribStartDate;
		d.end = newMd.distribEndDate;
		
		if(d.catalog.type==db.Catalog.TYPE_VARORDER){
			d.orderStartDate = orderStartDate;
			d.orderEndDate = orderEndDate;
		}
		
		checkDistrib(d);

		if(dispatchEvent) App.current.event(EditDistrib(d));
		
		if (d.date == null){
			return d;
		} else {
			d.update();
			return d;
		}
	}


	/**
	 *  Checks whether there are orders with non zero quantity for non amap contract
	 *  @param d - 
	 *  @return Bool
	 */
	public static function canDelete(d:db.Distribution):Bool{

		if (d.catalog.type == db.Catalog.TYPE_CONSTORDERS) return true;
		
		var quantity = 0.0;
		for ( order in d.getOrders() ){
			quantity += order.quantity;
		}
		return quantity == 0.0;
		
	}


	/**
	 *  Cancel participation of a farmer to a multidistrib
	 */
	public static function cancelParticipation(d:db.Distribution,?dispatchEvent=true) {
		var t = sugoi.i18n.Locale.texts;
		
		if( d.catalog.isCSACatalog() ){
			//if there is at least one validated subscription, cancelation is not possible
			if( db.Subscription.manager.count( $catalogId == d.catalog.id && $isValidated ) > 0){
				throw new Error("Vous ne pouvez pas annuler cette distribution car il y a déjà des souscriptions validées. Vous pouvez cependant décaler cette distribution en fin de contrat afin de maintenir le même nombre dans les souscriptions des adhérents. Pour décaler une distribution, cliquez sur le bouton \"Dates\".");
			} else if( db.Subscription.manager.count( $catalogId == d.catalog.id  ) > 0 ){
				App.current.session.addMessage( "Attention, vous avez déjà des souscriptions enregistrées pour ce contrat. Si vous supprimez des distributions, le montant à payer va varier." , true);
			}
		}

		if ( !canDelete(d) ) {
			throw new Error(t._("Deletion not possible: orders are recorded for ::vendorName:: on ::date::.",{vendorName:d.catalog.vendor.name,date:Formatting.hDate(d.date)}));
		}

		var contract = d.catalog;
		d.lock();
		if (dispatchEvent) {
			App.current.event(DeleteDistrib(d));
		}

		//erase zero qt orders
		for ( order in d.getOrders() ){
			if(order.quantity==0.0 || order.quantity==0) {
				order.lock();
				order.delete();
			}
		}

		//uncheck volunteers roles
		var roles = service.VolunteerService.getRolesFromContract(d.catalog);
		if(roles.length>0){			
			var roleIds = d.multiDistrib.getVolunteerRoleIds();
			for( roleId in roleIds.copy()){
				
				if(Lambda.find(roles, function(r) return r.id==roleId)!=null){
					roleIds.remove(roleId);
				} 
			}
			d.multiDistrib.lock();
			d.multiDistrib.volunteerRolesIds = roleIds.join(",");
			d.multiDistrib.update();
		}

		d.multiDistrib.deleteProductsExcerpt();

		d.delete();

		//In case this is a distrib for an amap contract with payments enabled, it will update all the operations
		//names and amounts with the new number of distribs
		updateAmapContractOperations(contract);

		//delete multidistrib if needed
		/*if(d.multiDistrib!=null){
			if(d.multiDistrib.getDistributions().length == 0){
				deleteMd(d.multiDistrib);
			}
		}*/

	}

	/**
	 *  Computes the correct start and end dates
	 *  @param dc - 
	 *  @param datePointer - 
	 */
	public static function getDates(dc:db.DistributionCycle, datePointer:Date) {

		//Generic variables 
		var t = sugoi.i18n.Locale.texts;

		var startDate = new Date(datePointer.getFullYear(),datePointer.getMonth(),datePointer.getDate(),dc.startHour.getHours(),dc.startHour.getMinutes(),0);
		var orderStartDate = null;
		var orderEndDate = null;
		//if (dc.contract.type == db.Catalog.TYPE_VARORDER){
			
			if (dc.daysBeforeOrderEnd == null || dc.daysBeforeOrderStart == null) throw new Error(t._("daysBeforeOrderEnd or daysBeforeOrderStart is null"));
			
			var a = DateTools.delta(startDate, -1.0 * dc.daysBeforeOrderStart * 1000 * 60 * 60 * 24);
			var h : Date = dc.openingHour;
			orderStartDate = new Date(a.getFullYear(), a.getMonth(), a.getDate(), h.getHours(), h.getMinutes(), 0);
			
			var a = DateTools.delta(startDate, -1.0 * dc.daysBeforeOrderEnd * 1000 * 60 * 60 * 24);
			var h : Date = dc.closingHour;
			orderEndDate = new Date(a.getFullYear(), a.getMonth(), a.getDate(), h.getHours(), h.getMinutes(), 0);			
		//}
		return { date: startDate, orderStartDate: orderStartDate, orderEndDate: orderEndDate };
	}

	/**
	 *  Creates all the distributions from the first date
	 *  @param dc - 
	 */
	static function createCycleDistribs(dc:db.DistributionCycle,contractIds:Array<Int>) {

		//Generic variables 
		var t = sugoi.i18n.Locale.texts;

		//switch end date to 23:59 to avoid the last distribution to be skipped
		dc.endDate = tools.DateTool.setHourMinute(dc.endDate,23,59);
		
		if (dc.id == null) throw new Error(t._("this distributionCycle has not been recorded"));
		
		//iterations
		//For first distrib
		var datePointer = new Date(dc.startDate.getFullYear(), dc.startDate.getMonth(), dc.startDate.getDate(), 12, 0, 0);
		//why hour=12 ? because if we set hour to 0, it switch to 23 (-1) or 1 (+1) on daylight saving time switch dates, thus changing the day!!
		var firstDistribDate = new Date(datePointer.getFullYear(),datePointer.getMonth(),datePointer.getDate(),dc.startHour.getHours(),dc.startHour.getMinutes(),0);
		for(i in 0...100) {

			if(i != 0){ //All distribs except the first one
				var oneDay = 1000 * 60 * 60 * 24.0;
				switch(dc.cycleType) {
					case Weekly :
						datePointer = DateTools.delta(datePointer, oneDay * 7.0);
						//App.log("on ajoute "+(oneDay * 7.0)+"millisec pour ajouter 7 jours");
						//App.log('pointer : $datePointer');
						
					case BiWeekly : 	
						datePointer = DateTools.delta(datePointer, oneDay * 14.0);
						
					case TriWeekly : 	
						datePointer = DateTools.delta(datePointer, oneDay * 21.0);
						
					case Monthly :
						var n = tools.DateTool.getWhichNthDayOfMonth(firstDistribDate);
						var dayOfWeek = firstDistribDate.getDay();
						var nextMonth = new Date(datePointer.getFullYear(), datePointer.getMonth() + 1, 1, 0, 0, 0);
						datePointer = tools.DateTool.getNthDayOfMonth(nextMonth.getFullYear(), nextMonth.getMonth(), dayOfWeek, n);
						if (datePointer.getMonth() != nextMonth.getMonth()) {
							datePointer = tools.DateTool.getNthDayOfMonth(nextMonth.getFullYear(), nextMonth.getMonth(), dayOfWeek, n - 1);
						}
				}
			}
					
			//stop if cycle end is reached
			if (datePointer.getTime() > dc.endDate.getTime()) {				
				break;
			}
			
			var dates = getDates(dc, datePointer);
			
			createMd(
				dc.place,
				dates.date,
				new Date(datePointer.getFullYear(),datePointer.getMonth(),datePointer.getDate(),dc.endHour.getHours(),dc.endHour.getMinutes(),0),
				dates.orderStartDate,
				dates.orderEndDate,
				contractIds,
				dc
			);

		}
	}
	
	/**
	 *   Deletes all distributions which are part of this cycle
	 *  @param cycle - 
	 */
	public static function deleteDistribCycle(cycle:db.DistributionCycle):Array<String>{

		cycle.lock();
		var messages = [];
		
		var children = db.MultiDistrib.manager.search($distributionCycle == cycle, true);
				
		for ( d in children ){			
			try{
				deleteMd(d);
			}catch(e:tink.core.Error){
				messages.push(e.message);
			}
		}

		cycle.delete();
		return messages;
	}

	 /**
	  *  Creates a new distribution cycle
	  */
	 public static function createCycle(group:db.Group,cycleType:db.DistributionCycle.CycleType,startDate:Date,endDate:Date,
	 startHour:Date,endHour:Date,daysBeforeOrderStart:Null<Int>,daysBeforeOrderEnd:Null<Int>,openingHour:Null<Date>,closingHour:Null<Date>,
	 placeId:Int,contractIds:Array<Int>):db.DistributionCycle {

		 //Generic variables 
		var t = sugoi.i18n.Locale.texts;
		var view = App.current.view;
		
		var dc = new db.DistributionCycle();
		dc.group = group;
		dc.cycleType = cycleType;
		dc.startDate = startDate;
		dc.endDate = endDate;
		dc.startHour = startHour;
		dc.endHour = endHour;
		dc.place = db.Place.manager.get(placeId);
		dc.daysBeforeOrderStart = daysBeforeOrderStart;
		dc.daysBeforeOrderEnd = daysBeforeOrderEnd;
		dc.openingHour = openingHour;
		dc.closingHour = closingHour;			
		
				
		/*if (dc.endDate.getTime() > contract.endDate.getTime()) {
			throw new Error(t._("The date of the delivery must be prior to the end of the contract (::contractEndDate::)", {contractEndDate:view.hDate(contract.endDate)}));
		}
		if (dc.startDate.getTime() < contract.startDate.getTime()) {
			throw new Error(t._("The date of the delivery must be after the begining of the contract (::contractBeginDate::)", {contractBeginDate:view.hDate(contract.startDate)}));
		}*/

		/*if(dispatchEvent){
			App.current.event(NewDistribCycle(dc));
		}*/
		
		dc.insert();
		createCycleDistribs(dc,contractIds);

		return dc;

	}


}