package controller;
import db.TmpBasket;
import service.OrderFlowService;
import tools.ObjectListTool;
import db.DistributionCycle;
import db.UserOrder;
import sugoi.form.Form;
import sugoi.form.elements.IntSelect;
import sugoi.form.elements.TextArea;
import sugoi.form.elements.NativeDatePicker.NativeDatePickerType;
import Common;
import service.VolunteerService;
import service.DistributionService;
using tools.DateTool;
using Formatting;
using Std;


class Distribution extends Controller
{

	public function new(){
		super();
		view.category = "distribution";
	}

	function checkHasDistributionSectionAccess(){
		if (!app.user.canManageAllContracts()) throw Error('/', t._('Forbidden action') );
	}

	@tpl('distribution/default.mtt')
	function doDefault(){

		checkHasDistributionSectionAccess();

		var now = Date.now();
		var from = new Date(now.getFullYear(), now.getMonth(), now.getDate()-1, 0, 0, 0);
		var to = DateTools.delta(from, 1000.0 * 60 * 60 * 24 * 28 * 3);
		var timeframe = new tools.Timeframe(from,to);

		var distribs = db.MultiDistrib.getFromTimeRange(app.user.getGroup(),timeframe.from,timeframe.to);

		if( app.user.getGroup().hasPayments() && app.params.get("_from")==null){

			//include unvalidated distribs in the past
			var unvalidated = db.MultiDistrib.getFromTimeRange(app.user.getGroup() , tools.DateTool.deltaDays(from,-60) , tools.DateTool.deltaDays(from,-1) );
			for( md in unvalidated.copy()){
				if( !md.isValidated() ) distribs.unshift(md);				
			}
		}

		view.distribs = distribs.map(distrib -> {
			var d: Dynamic = distrib;
			d.slotsIsActivated = distrib.slots != null;
			return d;
		});
		
		view.cycles = DistributionCycle.getFromTimeFrame(app.user.getGroup(), timeframe);
		view.timeframe = timeframe;

		checkToken();
	}

	/**
	 * Attendance sheet by user-product (single distrib)
	 */
	@tpl('distribution/list.mtt')
	function doList(d:db.Distribution) {
		view.distrib = d;
		view.place = d.place;
		view.contract = d.catalog;
		view.orders = service.OrderService.prepare(d.getOrders());
		//volunteers whose role is linked to this contract
		view.volunteers = Lambda.filter(d.multiDistrib.getVolunteers(),function(v) return v.volunteerRole.catalog!=null && v.volunteerRole.catalog.id==d.catalog.id);		
	}

	/**
	 * Attendance sheet by product-user (single distrib)
	 */
	@tpl('distribution/listByProductUser.mtt')
	function doListByProductUser(d:db.Distribution) {
		view.distrib = d;
		view.place = d.place;
		view.contract = d.catalog;
		// view.orders = UserOrder.prepare(d.getOrders());
		
		//make a 2 dimensons table :  data[userId][productId]
		//WARNING : BUGS WILL APPEAR if there is many Order line for the same product
		var data = new Map<Int,Map<Int,UserOrder>>();
		var products = [];
		var uo = d.getOrders();

		for(o in uo){
			products.push(o.product);
		}

		for ( o in service.OrderService.prepare(uo)) {

			var user = data[o.userId];
			if (user == null) user = new Map();
			user[o.productId] = o;
			data[o.userId] = user;

		}
		
		//products
		var products = tools.ObjectListTool.deduplicate(products);
		products.sort(function(b, a) {
			return (a.name < b.name)?1:-1;
		});
		view.products = products;

		//users
		var users = Lambda.array(d.getUsers());
		// var usersMap = tools.ObjectListTool.toIdMap(users);
		users.sort(function(b, a) {
			return (a.lastName < b.lastName)?1:-1;
		});
		view.users = users;
		// view.usersMap = usersMap;

		view.orders = data;

		//total to pay by user
		view.totalByUser = function(uid:Int){
			var total = 0.0;
			for( o in data[uid]) total+= o.total;
			return total;
		}

		//total qty of product
		view.totalByProduct = function(pid:Int){
			var total = 0.0;
			for( uid in data.keys()){
				var x = data[uid][pid];
				if(x!=null) total+= x.quantity;	
			} 
			return total;
		}

	}
	
	/**
	 * Attendance sheet to print ( mutidistrib )
	 */
	@tpl('distribution/listByDate.mtt')
	function doListByDate(date:Date,place:db.Place, ?type:String, ?fontSize:String) {
		
		if (!app.user.isContractManager()) throw Error('/', t._("Forbidden action"));
		
		view.place = place;		
		view.onTheSpotAllowedPaymentTypes = service.PaymentService.getOnTheSpotAllowedPaymentTypes(app.user.getGroup());
		
		if (type == null) {
		
			//display form			
			var f = new sugoi.form.Form("listBydate", null, sugoi.form.Form.FormMethod.GET);
			f.addElement(new sugoi.form.elements.RadioGroup("type", "Affichage", [
				{ value:"one", label:t._("One person per page") },
				{ value:"contract", label:t._("One person per page sorted by catalog") },
				{ value:"all", label:t._("All") },
				{ value:"allshort", label:t._("All but without prices and totals") },
			],"all"));
			f.addElement(new sugoi.form.elements.RadioGroup("fontSize", t._("Font size"), [
				{ value:"S" , label:"S"  },
				{ value:"M" , label:"M"  },
				{ value:"L" , label:"L"  },
				{ value:"XL", label:"XL" },
			], "S", "S", false));
			
			view.form = f;
			app.setTemplate("form.mtt");
			
			if (f.checkToken()) {
				var suburl = f.getValueOf("type")+"/"+f.getValueOf("fontSize");
				var url = '/distribution/listByDate/' + date.toString().substr(0, 10)+"/"+place.id+"/"+suburl;
				throw Redirect( url );
			}
			
			return;
			
		}else {
			
			view.date = date;
			view.fontRatio = switch(fontSize){
				case "M" : 1; //1em = 16px
				case "L" : 1.25;
				case "XL": 1.50;
				default : 0.75;
			};
			
			switch(type) {
				case "one":
					app.setTemplate("distribution/listByDateOnePage.mtt");
				case "allshort" :
					app.setTemplate("distribution/listByDateShort.mtt");
				case "contract" :
					app.setTemplate("distribution/listByDateOnePageContract.mtt");
			}
			
			var d1 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
			var d2 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);
			var catalogs = app.user.getGroup().getActiveContracts(true);
			var cids = Lambda.map(catalogs, function(c) return c.id);
			var distribs = db.Distribution.manager.search(($catalogId in cids) && $date >= d1 && $date <= d2 && $place==place, false);		
			var orders = db.UserOrder.manager.search($distributionId in ObjectListTool.getIds(distribs)  , { orderBy:userId } );			
			var orders = service.OrderService.prepare(orders);
			view.orders = orders;
			var md = db.MultiDistrib.get(date,place);
			view.volunteers = md.getVolunteers();
			
			if (type == "csv") {
				var data = new Array<Dynamic>();
				
				for (o in orders) {
					data.push( { 
						"userId":o.userId,
						"userName":o.userName,
						"productName":o.productName,
						"ref":o.product.ref,
						"catalogName":o.catalogName,
						"catalogId":o.catalogId,
						"vendorId":o.product.vendorId,
						"price":view.formatNum(o.productPrice),
						"quantity":o.quantity,
						"fees":view.formatNum(o.fees),
						"total":view.formatNum(o.total),
						"paid":o.paid
					});				
				}

				sugoi.tools.Csv.printCsvDataFromObjects(
					data,
					["userId","userName","productName","ref","catalogName","catalogId","vendorId","price", "quantity","fees","total", "paid"],
					"Export-commandes-"+date.toString().substr(0,10)+"-Cagette");
				return;	
			}
		}
	}
	
	/**
		Delete a distribution
	**/
	function doDelete(d:db.Distribution) {
		
		if (!app.user.isContractManager(d.catalog)) throw Error('/', t._("Forbidden action"));
		var contractId = d.catalog.id;
		try {
			service.DistributionService.cancelParticipation(d,false);
		} catch(e:tink.core.Error){
			throw Error("/contractAdmin/distributions/" + contractId, e.message);
		}		
		throw Ok("/contractAdmin/distributions/" + contractId, "Ce producteur ne participe plus à la distribution");
	}

	//same as above but from distribution page
	function doNotAttend(d:db.Distribution) {
		
		if (!app.user.isContractManager(d.catalog)) throw Error('/distribution', t._("Forbidden action"));		
		var contractId = d.catalog.id;
		try {
			service.DistributionService.cancelParticipation(d,false);
		} catch(e:tink.core.Error){
			throw Error('/distribution', e.message);
		}		
		throw Ok('/distribution', "Ce producteur ne participe plus à la distribution");
	}

	/**
		Delete a Multidistribution
	**/
	function doDeleteMd(md:db.MultiDistrib){
		
		if (!app.user.canManageAllContracts()) throw Error('/', t._('Forbidden action') );

		if(checkToken()){
			try{
				service.DistributionService.deleteMd(md);
			}catch(e:tink.core.Error){
				throw Error("/distribution",e.message);
			}
			throw Ok("/distribution",t._("The distribution has been deleted"));
		}else{
			throw Error("/distribution",t._("Bad token"));
		}
	}
	
	/**
		Change order dates of a Distribution
	 */
	@tpl('form.mtt')
	function doEdit(d:db.Distribution,?args:{from:String}) {
		
		if (!app.user.isContractManager(d.catalog)) throw Error('/', t._('Forbidden action') );		
		if(d.catalog.isCSACatalog()) throw Error('/', "Impossible de changer les dates d'ouverture de commande pour un contrat AMAP" );	
		var contract = d.catalog;

		view.text = "Vous pouvez personnaliser les dates d'ouverture et de fermeture de commande uniquement pour ce catalogue.";
		
		var form = form.CagetteForm.fromSpod(d);
		form.removeElementByName("placeId");
		form.removeElementByName("date");
		form.removeElementByName("end");
		form.removeElement(form.getElement("contractId"));		
		form.removeElement(form.getElement("distributionCycleId"));
		form.addElement(new form.CagetteDateTimePicker("orderStartDate", t._("Orders opening date"), d.orderStartDate));	
		form.addElement(new form.CagetteDateTimePicker("orderEndDate", t._("Orders closing date"), d.orderEndDate));
		
		if (form.isValid()) {

			var orderStartDate = form.getValueOf("orderStartDate");
			var orderEndDate = form.getValueOf("orderEndDate");
			var url = if( args!=null && args.from == "distribSection" ){
				'/distribution';
			}else{
				'/contractAdmin/distributions/'+contract.id;
			}
			try{
			
				//do not launch event, avoid notifs for now
				d = DistributionService.editAttendance(
					d,
					d.multiDistrib,
					orderStartDate,
					orderEndDate,
					false
				);							

			} catch(e:tink.core.Error){
				throw Error(sugoi.Web.getURI(),e.message);
			}
			
			if (d.date == null) {
				var msg = t._("The distribution has been proposed to the supplier, please wait for its validation");
				throw Ok('/contractAdmin/distributions/'+contract.id, msg );

			} else {
				throw Ok(url, t._("The distribution has been recorded") );
			}
			
		} else {
			app.event(PreEditDistrib(d));
		}
		
		view.form = form;
		view.title = t._("Attendance of ::farmer:: to the ::date:: distribution",{farmer:d.catalog.vendor.name,date:view.dDate(d.date)});
	}

	/**
		Shift a Distribution
	 */
	@tpl('form.mtt')
	function doShift(d:db.Distribution,?args:{from:String}) {
		if (!app.user.isContractManager(d.catalog)) throw Error('/', t._('Forbidden action') );		
		var contract = d.catalog;

		var text = "Si la date à laquelle vous souhaitez reporter la distribution n'est pas dans la liste, créez la dans l'onglet \"Distributions\".";
		text += "<div class='alert alert-warning'><i class='icon icon-info'></i> Attention, reporter une distribution peut... :<ul>";
		text += "<li>Provoquer une renumérotation des paniers de la distribution cible.</li>";
		text += "<li>Provoquer la modification de le date de fin du catalogue/contrat pour prendre en comtpe la nouvelle date.</li>";
		if(d.catalog.isCSACatalog()){
			text += "<li>Provoquer l'extension des souscriptions pour prendre en compte la nouvelle date tout en préservant le même nombre de distributions. Pensez à vérifier les souscriptions après avec effectué cette action.</li>";
		}
		text +="</ul></div>";
		view.text =  text;
		
		var form = new sugoi.form.Form("distribShifting");
		
		//date
		var from = DateTools.delta(d.multiDistrib.distribStartDate ,-1000.0*60*60*24*30.5*3); 
		if(from.getTime()<Date.now().getTime()) from = Date.now();//$from cannot be in the past
		var to  = DateTools.delta(d.catalog.endDate ,1000.0*60*60*24*30.5*6); //$to is 6 month after the end of catalog
		var mds = db.MultiDistrib.getFromTimeRange(d.catalog.group,from,to);
		//remove validated distribs, and the current one
		mds = mds.filter( md -> return !md.isValidated() && md.id!=d.multiDistrib.id);
		//remove already attended distribs
		mds = mds.filter( md -> return md.getDistributionForContract(d.catalog)==null  );
		var mds = mds.map( md -> return {label:view.hDate(md.getDate()), value:md.id});
		var e = new sugoi.form.elements.IntSelect("md","Reporter la distribution au ", mds ,d.multiDistrib.id);			
		form.addElement(e, 1);
		
		if (form.isValid()) {

			var md : db.MultiDistrib = null;
			var url = if( args!=null && args.from == "distribSection" ){
				'/distribution';
			}else{
				'/contractAdmin/distributions/'+contract.id;
			}

			try{
				var mdid = form.getValueOf("md");
				if(mdid==null) throw "Sélectionnez une date de distribution";
				md = db.MultiDistrib.manager.get(mdid);

				//do not launch event, avoid notifs for now
				d = DistributionService.editAttendance(
					d,
					md,
					d.orderStartDate,
					d.orderEndDate,
					false
				);											

			} catch(e:tink.core.Error){
				throw Error(sugoi.Web.getURI(),e.message);
			}
			
			if (d.date == null) {
				throw Ok(url, t._("The distribution has been proposed to the supplier, please wait for its validation") );

			} else {
				throw Ok(url,"La distribution a été décalée au "+Formatting.hDate(md.distribStartDate));
			}
			
		} else {
			app.event(PreEditDistrib(d));
		}
		
		view.form = form;
		view.title = "Reporter la distribution de "+d.catalog.vendor.name+", initialement prévue le "+view.dDate(d.date);
	}
	
	@tpl('form.mtt')
	function doEditCycle(d:db.DistributionCycle) {
		
		/*checkHasDistributionSectionAccess();
		
		var form = sugoi.form.Form.fromSpod(d);
		form.removeElement(form.getElement("contractId"));
		
		if (form.isValid()) {
			form.toSpod(d); //update model
			d.update();
			throw Ok('/contractAdmin/distributions/'+d.catalog.id, t._("The delivery is now up to date"));
		}
		
		view.form = form;
		view.title = t._("Modify a delivery");*/
	}
	
	/**
		Insert a distribution
	**/
	@tpl("form.mtt")
	public function doInsert(contract:db.Catalog) {
		
		if (!app.user.isContractManager(contract)) throw Error('/', t._('Forbidden action') );
		
		var d = new db.Distribution();
		d.place = contract.group.getMainPlace();
		var form = form.CagetteForm.fromSpod(d);
		form.removeElement(form.getElement("contractId"));
		form.removeElement(form.getElement("distributionCycleId"));
		form.removeElement(form.getElement("end"));
		var x = new form.CagetteDatePicker("end", t._("End time"), null, NativeDatePickerType.time);
		form.addElement(x, 3);
		
		//default values
		form.getElement("date").value = DateTool.now().deltaDays(30).setHourMinute(19, 0);
		form.getElement("end").value = DateTool.now().deltaDays(30).setHourMinute(20, 0);
			
		if (contract.type == db.Catalog.TYPE_VARORDER ) {
			form.addElement(new form.CagetteDatePicker("orderStartDate", t._("Orders opening date"), DateTool.now().deltaDays(10).setHourMinute(8, 0)));	
			form.addElement(new form.CagetteDatePicker("orderEndDate", t._("Orders closing date"), DateTool.now().deltaDays(20).setHourMinute(23, 59)));
		}
		
		if (form.isValid()) {

			var createdDistrib = null;
			var orderStartDate = null;
			var orderEndDate = null;

			try {
				
				if (contract.type == db.Catalog.TYPE_VARORDER ) {
					orderStartDate = form.getValueOf("orderStartDate");
					orderEndDate = form.getValueOf("orderEndDate");
				}

				createdDistrib = service.DistributionService.create(
				contract,
				form.getValueOf("date"),
				form.getValueOf("end"),
				form.getValueOf("placeId"),
				orderStartDate,
				orderEndDate);
			}
			catch(e:tink.core.Error){
				throw Error('/contractAdmin/distributions/' + contract.id,e.message);
			}
			
			if (createdDistrib.date == null) {
				var html = t._("Your request for a delivery has been sent to <b>::supplierName::</b>.<br/>Be patient, you will receive an e-mail indicating if the request has been validated or refused.", {supplierName:contract.vendor.name});
				var btn = "<a href='/contractAdmin/distributions/" + contract.id + "' class='btn btn-primary'>OK</a>";
				App.current.view.extraNotifBlock = App.current.processTemplate("block/modal.mtt",{html:html,title:t._("Distribution request sent"),btn:btn} );
			} else {
				throw Ok('/contractAdmin/distributions/'+ createdDistrib.catalog.id , t._("The distribution has been recorded") );	
			}
			
		}else{
			//event
			app.event(PreNewDistrib(contract));
		
		}
	
		view.form = form;
		view.title = t._("Create a distribution");
	}

	/**
		Invite farmers to a single distrib
	**/
	@tpl("form.mtt")
	function doInviteFarmers(distrib:db.MultiDistrib){
		
		var form = new sugoi.form.Form("invite");
		
		//vendors to add
		var regularVendors = [];
		var checked = [];
		var distributions = distrib.getDistributions();
		for( d in distributions){
			checked.push(Std.string(d.catalog.id));
		}
		#if plugins
		var cproVendors = [];
		var invitationsSent = [];

		for( c in distrib.place.group.getActiveContracts()){
			var rc = connector.db.RemoteCatalog.getFromContract(c);
			if( rc!=null ){
				//is cpro
				if( pro.db.PNotif.getDistributionInvitation(rc.getCatalog(),distrib).length>0 ){
					//has already a pending notif
					invitationsSent.push(c);
				}else{
					//invitable
					cproVendors.push({label: c.vendor.name +" : "+c.name,value:Std.string(c.id)});
				}				
			}else{
				regularVendors.push({label:c.vendor.name +" : "+c.name,value:Std.string(c.id)});
			}
		}
		if(cproVendors.length>0 || invitationsSent.length>0){
			
			var html = "<div class='alert alert-warning'><i class='icon icon-info'></i> Invitez les producteurs Cagette Pro à participer à cette distribution : Si vous cochez une case, le producteur correspondant recevra une demande qu'il pourra accepter ou refuser.</div>";
			form.addElement( new sugoi.form.elements.Html("html1",html,"Producteurs Cagette Pro") );
			form.addElement( new sugoi.form.elements.CheckboxGroup("cproVendors","",cproVendors,checked,true) );
			var html = "";
			for(i in invitationsSent) html += '<div class="disabled">${i.name} : <b>invitation envoyée</b></div>';
			form.addElement(new sugoi.form.elements.Html("invitationSent",html,""));
		}
		#else
		for( c in distrib.place.group.getActiveContracts()){
			regularVendors.push({label:c.vendor.name +" : "+c.name,value:Std.string(c.id)});
		}
		#end
		
		var html = "<div class='alert alert-warning'><i class='icon icon-info'></i> Vous avez la main pour gérer les catalogues de ces producteurs invités. Attention, décocher une case annulera la participation du producteur à cette distribution.</div>";
		form.addElement( new sugoi.form.elements.Html("html2",html,"Producteurs invités") );
		form.addElement( new sugoi.form.elements.CheckboxGroup("invitedVendors","",regularVendors,checked,true) );
		

		

		if(form.isValid()){

			var existingDistributions = distributions;
			var existingCproDistributions = [];
			#if plugins
			//build existing cpro distribution list
			for(d in existingDistributions.copy()){
				if(connector.db.RemoteCatalog.getFromContract(d.catalog)!=null){
					existingDistributions.remove(d);
					existingCproDistributions.push(d);
				}
			}
			#end

			//regular vendors
			var contractIds:Array<Int> = form.getValueOf("invitedVendors").map(Std.parseInt);
			for( cid in contractIds){
				var d = Lambda.find(existingDistributions, function(d) return d.catalog.id==cid );
				if(d==null){
					//create it					
					try{
						var contract = db.Catalog.manager.get(cid,false);
						service.DistributionService.participate(distrib,contract);
					}catch(e:tink.core.Error){
						throw Error("/distribution",e.message);
					}
				}
			}

			// delete it
			for( d in existingDistributions){
				if(!Lambda.has(contractIds,d.catalog.id)){
					try{
						service.DistributionService.cancelParticipation(d);
					}catch(e:tink.core.Error){
						throw Error("/distribution",e.message);
					}
				}
			}

			#if plugins
			//cpro vendors
			if(cproVendors.length>0){
				var contractIds:Array<Int> = form.getValueOf("cproVendors").map(Std.parseInt);
				for( cid in contractIds ){
					var d = Lambda.find(existingCproDistributions, function(d) return d.catalog.id==cid );				
					if(d==null){
						var contract = db.Catalog.manager.get(cid,false);
						var rc = connector.db.RemoteCatalog.getFromContract(contract);
						var hasNotif = pro.db.PNotif.getDistributionInvitation(rc.getCatalog(),distrib).length>0;
						if(!hasNotif){
							//send notif
							var contract = db.Catalog.manager.get(cid,false);
							var rc = connector.db.RemoteCatalog.getFromContract(contract);
							var catalog = rc.getCatalog();
							if(catalog!=null){
								pro.db.PNotif.distributionInvitation(catalog, distrib, app.user);
							}
						}
						
					}
				}

				// delete it
				for( d in existingCproDistributions){
					if(!Lambda.has(contractIds,d.catalog.id)){
						try{
							service.DistributionService.cancelParticipation(d,false);
						}catch(e:tink.core.Error){
							throw Error("/distribution",e.message);
						}
					}
				}
			}
			#end

			throw Ok("/distribution","La liste des producteurs invités à été mise à jour");
		}

		view.form = form;
		view.title = "Ajouter / supprimer des producteurs pour la distribution du "+view.dDate(distrib.getDate());
	}

	@tpl("form.mtt")
	function doInviteFarmersCycle(cycle:db.DistributionCycle){

		view.text = "Fonctionnalité bientôt disponible";
		view.form = new sugoi.form.Form("pouet");
	}

	/**
		Insert a multidistribution
	**/
	@tpl("form.mtt")
	public function doInsertMd() {
		
		checkHasDistributionSectionAccess();
		
		var md = new db.MultiDistrib();
		md.place = app.user.getGroup().getMainPlace();
		var form = form.CagetteForm.fromSpod(md);

		//date
		var e = new form.CagetteDatePicker("date",t._("Distribution date"), null);	
		form.addElement(e, 3);
		
		//start hour
		form.removeElementByName("distribStartDate");
		var x = new form.CagetteDatePicker("startHour", t._("Start time"), null, NativeDatePickerType.time);
		form.addElement(x, 3);
		
		//end hour
		form.removeElementByName("distribEndDate");
		var x = new form.CagetteDatePicker("endHour", t._("End time"), null, NativeDatePickerType.time);
		form.addElement(x, 4);		
		
		//default values		
		form.getElement("date").value 				= DateTool.now().deltaDays(30);
		form.getElement("startHour").value 			= DateTool.now().deltaDays(30).setHourMinute(19, 0);
		form.getElement("endHour").value 			= DateTool.now().deltaDays(30).setHourMinute(20, 0);
		form.getElement("orderStartDate").value 	= DateTool.now().deltaDays(10).setHourMinute(8, 0);	
		form.getElement("orderEndDate").value 		= DateTool.now().deltaDays(20).setHourMinute(23, 59);				
		
		if (form.isValid()) {

			try {
				var date = form.getValueOf("date");
				var startHour = form.getValueOf("startHour");
				var endHour = form.getValueOf("endHour");
				var distribStartDate = 	DateTool.setHourMinute( date, startHour.getHours(), startHour.getMinutes() );
				var distribEndDate = 	DateTool.setHourMinute( date, endHour.getHours(), 	endHour.getMinutes() );
				
				
				md = service.DistributionService.createMd(
					db.Place.manager.get(form.getValueOf("placeId"),false),
					distribStartDate,
					distribEndDate,
					form.getValueOf("orderStartDate"),
					form.getValueOf("orderEndDate")	,
					[]				
				);
				
			}
			catch(e:tink.core.Error) {

				throw Error('/distribution/insertMd/' ,e.message);
			}
			
			/*if(service.VolunteerService.getRolesFromGroup(app.user.getGroup()).length>0){
				throw Ok('/distribution/volunteerRoles/' + md.id, t._("The distribution has been recorded, please define which roles are needed.") );	
			}else{*/
				throw Ok('/distribution/', t._("The distribution has been recorded") );	
			//}
			
		}
	
		view.form = form;
		view.title = t._("Create a general distribution");
	}
	

	/**
		Insert a multidistribution
	**/
	@tpl("form.mtt")
	public function doEditMd(md:db.MultiDistrib) {
		
		checkHasDistributionSectionAccess();
		
		md.place = app.user.getGroup().getMainPlace();
		var form = form.CagetteForm.fromSpod(md);

		//date
		var e = new form.CagetteDatePicker("date",t._("Distribution date"), md.distribStartDate);	
		untyped e.format = "LL";
		form.addElement(e, 3);
		
		//start hour
		form.removeElementByName("distribStartDate");
		md.distribStartDate = md.distribStartDate.setHourMinute( md.distribStartDate.getHours() , Math.floor(md.distribStartDate.getMinutes()/5) * 5 ); //minutes should be a multiple of 5
		var x = new form.CagetteDatePicker("startHour", t._("Start time"), md.distribStartDate, NativeDatePickerType.time );
		form.addElement(x, 3);
		
		//end hour
		form.removeElementByName("distribEndDate");
		md.distribEndDate = md.distribEndDate.setHourMinute( md.distribEndDate.getHours() , Math.floor(md.distribEndDate.getMinutes()/5) * 5 );//minutes should be a multiple of 5
		var x = new form.CagetteDatePicker("endHour", t._("End time"), md.distribEndDate, NativeDatePickerType.time );
		form.addElement(x, 4);

		//override dates
		
		var overrideDates = new sugoi.form.elements.Checkbox("override","Recaler tous les producteurs sur ces horaires",false);		
		form.addElement(overrideDates,7);
		
		
		//contracts
		/*var label = t._("Catalogs");
		var datas = [];
		var checked = [];
		for( c in md.place.group.getActiveContracts()){
			datas.push({label:c.name+" - "+c.vendor.name,value:Std.string(c.id)});
		}
		var distributions = md.getDistributions();
		for( d in distributions){
			checked.push(Std.string(d.catalog.id));
		}
		var el = new sugoi.form.elements.CheckboxGroup("contracts",label,datas,checked,true);
		form.addElement(el);*/
		
		if (form.isValid()) {

			try {

				var date = form.getValueOf("date");
				var startHour = form.getValueOf("startHour");
				var endHour = form.getValueOf("endHour");
				var distribStartDate = 	DateTool.setHourMinute( date, startHour.getHours(), startHour.getMinutes() );
				var distribEndDate = 	DateTool.setHourMinute( date, endHour.getHours(), 	endHour.getMinutes() );

				service.DistributionService.editMd(
					md,
					db.Place.manager.get(form.getValueOf("placeId"),false),
					distribStartDate,
					distribEndDate,
					form.getValueOf("orderStartDate"),
					form.getValueOf("orderEndDate"),
					form.getValueOf("override")==true
				);

			} catch(e:tink.core.Error){
				throw Error('/distribution/editMd/'+md.id  ,e.message);
			}
			
			throw Ok('/distribution' , t._("The distribution has been updated") );	
		}
	
		view.form = form;
		view.title = t._("Edit a general distribution");
	}
	
	/**
	 * create a distribution cycle for a contract
	 */
	@tpl("form.mtt")
	public function doInsertCycle(contract:db.Catalog) {
		
		/*if (!app.user.isContractManager(contract)) throw Error('/', t._("Forbidden action"));
		
		var dc = new db.DistributionCycle();
		dc.place = contract.amap.getMainPlace();
		var form = sugoi.form.Form.fromSpod(dc);
		form.removeElementByName("contractId");
		
		form.getElement("startDate").value = DateTool.now();
		form.getElement("endDate").value  = DateTool.now().deltaDays(30);
		
		//start hour
		form.removeElementByName("startHour");
		var x = new HourDropDowns("startHour", t._("Start time"), DateTool.now().setHourMinute( 19, 0) , true);
		form.addElement(x, 5);
		
		//end hour
		form.removeElement(form.getElement("endHour"));
		var x = new HourDropDowns("endHour", t._("End time"), DateTool.now().setHourMinute(20, 0), true);
		form.addElement(x, 6);
		
		if (contract.type == db.Catalog.TYPE_VARORDER){
			
			form.getElement("daysBeforeOrderStart").value = 10;
			form.getElement("daysBeforeOrderStart").required = true;
			form.removeElementByName("openingHour");
			var x = new HourDropDowns("openingHour", t._("Opening time"), DateTool.now().setHourMinute(8, 0) , true);
			form.addElement(x, 8);
			
			form.getElement("daysBeforeOrderEnd").value = 2;
			form.getElement("daysBeforeOrderEnd").required = true;
			form.removeElementByName("closingHour");
			var x = new HourDropDowns("closingHour", t._("Closing time"), DateTool.now().setHourMinute(23, 0) , true);
			form.addElement(x, 10);
			
		}else{
			
			form.removeElementByName("daysBeforeOrderStart");
			form.removeElementByName("daysBeforeOrderEnd");	
			form.removeElementByName("openingHour");
			form.removeElementByName("closingHour");
		}
		
		if (form.isValid()) {

			var createdDistribCycle = null;
			var daysBeforeOrderStart = null;
			var daysBeforeOrderEnd = null;
			var openingHour = null;
			var closingHour = null;

			try{
				
				if (contract.type == db.Catalog.TYPE_VARORDER) {
					daysBeforeOrderStart = form.getValueOf("daysBeforeOrderStart");
					daysBeforeOrderEnd = form.getValueOf("daysBeforeOrderEnd");
					openingHour = form.getValueOf("openingHour");
					closingHour = form.getValueOf("closingHour");
				}

				createdDistribCycle = service.DistributionService.createCycle(
				contract,
				form.getElement("cycleType").getValue(),
				form.getValueOf("startDate"),	
				form.getValueOf("endDate"),	
				form.getValueOf("startHour"),
				form.getValueOf("endHour"),											
				daysBeforeOrderStart,											
				daysBeforeOrderEnd,											
				openingHour,	
				closingHour,																	
				form.getValueOf("placeId"));
			}
			catch(e:tink.core.Error){
				throw Error('/contractAdmin/distributions/' + contract.id,e.message);
			}

			if (createdDistribCycle != null) {
				throw Ok('/contractAdmin/distributions/'+ contract.id, t._("The delivery has been saved"));
			}
			 
		}
		else{
			dc.contract = contract;
			app.event(PreNewDistribCycle(dc));
		}
		
		view.form = form;
		view.title = t._("Schedule a recurrent delivery");
		*/
	}

	/**
	 * create a multidistribution cycle
	 */
	@tpl("form.mtt")
	public function doInsertMdCycle() {		

		checkHasDistributionSectionAccess();
		
		var dc = new db.DistributionCycle();
		dc.place = app.user.getGroup().getMainPlace();
		var form = form.CagetteForm.fromSpod(dc);
		
		
		form.getElement("startDate").value = DateTool.now();
		form.getElement("endDate").value   = DateTool.now().deltaDays(30);
		
		//start hour
		form.removeElementByName("startHour");
		var x = new form.CagetteDatePicker("startHour", t._("Distributions start time"), DateTool.now().setHourMinute( 19, 0), NativeDatePickerType.time, true);
		form.addElement(x, 5);
		
		//end hour
		form.removeElement(form.getElement("endHour"));
		var x = new form.CagetteDatePicker("endHour", t._("Distributions end time"), DateTool.now().setHourMinute(20, 0), NativeDatePickerType.time, true);
		form.addElement(x, 6);
			
		form.getElement("daysBeforeOrderStart").value = 10;
		form.getElement("daysBeforeOrderStart").required = true;
		form.removeElementByName("openingHour");
		var x = new form.CagetteDatePicker("openingHour", t._("Opening time"), DateTool.now().setHourMinute(8, 0), NativeDatePickerType.time, true);
		form.addElement(x, 8);
		
		form.getElement("daysBeforeOrderEnd").value = 2;
		form.getElement("daysBeforeOrderEnd").required = true;
		form.removeElementByName("closingHour");
		var x = new form.CagetteDatePicker("closingHour", t._("Closing time"), DateTool.now().setHourMinute(23, 55), NativeDatePickerType.time, true);
		form.addElement(x, 10);

		//vendors to add
		/*var datas = [];
		for( c in app.user.getGroup().getActiveContracts()){
			datas.push({label:c.name+" - "+c.vendor.name,value:c.id});
		}
		var el = new sugoi.form.elements.CheckboxGroup("contracts",t._("Catalogs"),datas,null,true);
		form.addElement(el);*/
		
		
		if (form.isValid()) {

			var createdDistribCycle = null;
			var daysBeforeOrderStart = null;
			var daysBeforeOrderEnd = null;
			var openingHour = null;
			var closingHour = null;

			try{
				daysBeforeOrderStart = form.getValueOf("daysBeforeOrderStart");
				daysBeforeOrderEnd = form.getValueOf("daysBeforeOrderEnd");
				openingHour = form.getValueOf("openingHour");
				closingHour = form.getValueOf("closingHour");

				createdDistribCycle = service.DistributionService.createCycle(
					app.user.getGroup(),
					form.getElement("cycleType").getValue(),
					form.getValueOf("startDate"),	
					form.getValueOf("endDate"),	
					form.getValueOf("startHour"),
					form.getValueOf("endHour"),											
					daysBeforeOrderStart,											
					daysBeforeOrderEnd,											
					openingHour,	
					closingHour,																	
					form.getValueOf("placeId"),
					[]/*form.getValueOf("contracts")*/

				);
			} catch(e:tink.core.Error){
				throw Error('/distribution/' , e.message);
			}

			if (createdDistribCycle != null) {
				throw Ok('/distribution/' , t._("The delivery has been saved"));
			}
			 
		}
		
		view.form = form;
		view.title = "Programmer un cycle de distribution";
	}
	
	/**
	 *  Delete a distribution cycle
	 */
	public function doDeleteCycle(cycle:db.DistributionCycle){
		
		checkHasDistributionSectionAccess();
		
		var messages = service.DistributionService.deleteDistribCycle(cycle);
		if (messages.length > 0){			
			App.current.session.addMessage( messages.join("<br/>"),true);	
		}
		
		throw Ok("/distribution/" , t._("Recurrent deliveries deleted"));
	}
	
	
	/**
	 * Validate a multiDistrib (main page)
	 * @param	date
	 * @param	place
	 */
	@tpl('distribution/validate.mtt')
	public function doValidate(multiDistrib:db.MultiDistrib){
		
		checkHasDistributionSectionAccess();
			
		view.users = multiDistrib.getUsers(db.Catalog.TYPE_VARORDER);
		view.distribution = multiDistrib;

	}


	/**
	 * validate a multidistrib
	 */
	public function doAutovalidate(md:db.MultiDistrib){

		checkHasDistributionSectionAccess();
		if(md.isValidated()) throw Redirect( "/distribution/validate/"+md.id);

		try{
			service.PaymentService.validateDistribution(md);
		}catch(e:tink.core.Error){
			throw Error("/distribution/validate/"+md.id, e.message);
		}
			
		throw Ok( "/distribution/validate/"+md.id , t._("This distribution have been validated") );
	}

	@admin
	public function doUnvalidate(md:db.MultiDistrib){
		checkHasDistributionSectionAccess();
		if(!md.validated) return;

		try{
			service.PaymentService.unvalidateDistribution(md);
		}catch(e:tink.core.Error){
			throw Error("/distribution/validate/"+md.id, e.message);
		}
			
		throw Ok( "/distribution/validate/"+md.id ,t._("This distribution have been Unvalidated"));
	}

	/**
		Manage volunteer roles for the specified multidistrib
	**/ 
	@tpl("form.mtt")
	function doVolunteerRoles(distrib: db.MultiDistrib) {
		
		var form = new sugoi.form.Form("volunteerroles");

		var roles = [];

		//Get all the volunteer roles for the group and for the selected contracts
		var allRoles = VolunteerService.getRolesFromGroup(distrib.getGroup());
		var generalRoles = Lambda.filter(allRoles, function(role) return role.catalog == null);
		var checkedRoles = new Array<String>();
		var roleIds : Array<Int> = distrib.volunteerRolesIds != null ? distrib.volunteerRolesIds.split(",").map(Std.parseInt) : [];
		
		//general roles
		for ( role in generalRoles ) {
			roles.push( { label: role.name, value: Std.string(role.id) } );
			if ( Lambda.has(roleIds, role.id) ) {
				checkedRoles.push(Std.string(role.id));
			}			
		}	

		//display roles linked to active contracts in this distrib
		for ( distrib in distrib.getDistributions() ) {
			var cid = distrib.catalog.id;
			var contractRoles = Lambda.filter(allRoles, function(role) return role.catalog!=null && role.catalog.id == cid);
			for ( role in contractRoles ) {
				roles.push( { label: role.name + " - " + distrib.catalog.vendor.name, value: Std.string(role.id) } );
				if ( roleIds == null || Lambda.has(roleIds, role.id) ) {
					checkedRoles.push(Std.string(role.id));
				}
			}
		}
		
		var volunteerRolesCheckboxes = new sugoi.form.elements.CheckboxGroup("roles", "", roles, checkedRoles, true);
		form.addElement(volunteerRolesCheckboxes);
	                                                
		if (form.isValid()) {

			try {
				var roleIds : Array<Int> = form.getValueOf("roles").map(Std.parseInt);
				service.VolunteerService.updateMultiDistribVolunteerRoles( distrib, roleIds );
			}
			catch(e: tink.core.Error){
				throw Error("/distribution/volunteerRoles/" + distrib.id, e.message);
			}

			throw Ok("/distribution", t._("Volunteer Roles have been saved for this distribution"));
		}

		view.title = "Sélectionner les rôles nécéssaires à la distribution du "+view.hDate(distrib.getDate());
		view.form = form;

	}

	/**
		Assign volunteer to roles for the specified multidistrib
	**/  
	@tpl("form.mtt")
	function doVolunteers(distrib: db.MultiDistrib) {
		
		var form = new sugoi.form.Form("volunteers");

		var volunteerRoles = distrib.getVolunteerRoles();
		if ( volunteerRoles == null ) {
			throw Error('/distribution/volunteerRoles/' + distrib.id, t._("You need to first select the volunteer roles for this distribution") );
		}

		var members = Lambda.array(Lambda.map(app.user.getGroup().getMembers(), function(user) return { label: user.getName(), value: user.id } ));
		for ( role in volunteerRoles ) {

			var selectedVolunteer = distrib.getVolunteerForRole(db.VolunteerRole.manager.get(role.id));
			var selectedUserId = selectedVolunteer != null ? selectedVolunteer.user.id : null;
			form.addElement( new IntSelect(Std.string(role.id), db.VolunteerRole.manager.get(role.id).name, members, selectedUserId, false, t._("No volunteer assigned")) );
		}

		if (form.isValid()) {

			try {
				var roleIdsToUserIds = new Map<Int,Int>();
				var datas = form.getData();
				for( k in datas.keys() ) roleIdsToUserIds[Std.parseInt(k)] = datas[k];  
				service.VolunteerService.updateVolunteers(distrib, roleIdsToUserIds );
			} catch(e: tink.core.Error){
				throw Error("/distribution/volunteers/" + distrib.id, e.message);
			}
			
			throw Ok("/distribution", t._("Volunteers have been assigned to roles for this distribution"));
		}

		view.title = t._("Select a volunteer for each role for this multidistrib");
		view.form = form;

	}

	//View volunteers list for this distribution and you can sign up for a role
	@tpl('distribution/volunteersSummary.mtt')
	function doVolunteersSummary(distrib: db.MultiDistrib, ?args: { role: db.VolunteerRole }) {

		var volunteerRoles: Array<db.VolunteerRole> = distrib.getVolunteerRoles();
		if (volunteerRoles == null) {

			throw Error('/distribution/', t._("There are no volunteer roles defined for this distribution") );
		}	

		if (args != null && args.role != null) {

			try {

				service.VolunteerService.addUserToRole(app.user, distrib, args.role);
			}
			catch(e: tink.core.Error){

				throw Error("/distribution/volunteersSummary/" + distrib.id, e.message);
			}
		
			throw Ok("/home/", t._("You have been successfully added to the selected role."));
		}
		
		view.multidistrib = distrib;
		view.roles = volunteerRoles;	
	}

	//Remove user from role for the specified multidistrib
	@tpl("form.mtt")
	function doUnsubscribeFromRole(distrib: db.MultiDistrib, role: db.VolunteerRole, ?args: { returnUrl: String, ?to: String } ) {
		
		if ( args != null && args.returnUrl != null ) {

			var toArg = args.to != null ? "&to=" + args.to : "";
			App.current.session.data.volunteersReturnUrl = args.returnUrl + toArg;						
		}		
		
		var form = new sugoi.form.Form("unsubscribe");

		var returnUrl = App.current.session.data.volunteersReturnUrl != null ? App.current.session.data.volunteersReturnUrl : '/distribution/unsubscribeFromRole/' + distrib.id + '/' + role.id;
		
		var volunteer = distrib.getVolunteerForRole(role);
		if (volunteer == null) {
			throw Error( returnUrl, t._("There is no volunteer to remove for this role!") );
		} else if (volunteer.user.id != app.user.id) {
			throw Error( returnUrl, t._("You can only remove yourself from a role.") );
		}

		form.addElement( new TextArea("unsubscriptionreason", t._("Reason for leaving the role") , null, true, null, "style='width:500px;height:350px;'") );
			
		if (form.isValid()) {

			try {
				service.VolunteerService.removeUserFromRole( app.user, distrib, role, form.getValueOf("unsubscriptionreason") );
			}
			catch(e: tink.core.Error){
				throw Error( returnUrl, e.message );
			}
			
			throw Ok( returnUrl, t._("You have been successfully removed from this role.") );
		}

		view.title = t._("Enter the reason why you are leaving this role.");
		view.form = form;
	}

	/**
		Members can view volunteers planning for each role and multidistrib date
	**/
	@tpl('distribution/volunteersCalendar.mtt')
	function doVolunteersCalendar(?args: { ?distrib: db.MultiDistrib, ?role: db.VolunteerRole, ?_from: Date, ?_to: Date } ) {
		
		var multidistribs : Array<db.MultiDistrib> = [];
		var from: Date = null;
		var to: Date = null;

		if ( args != null ) {

			//register to a role
			if ( args.distrib != null && args.role != null ) {

				try {
					service.VolunteerService.addUserToRole( app.user, args.distrib, args.role );
				} catch(e: tink.core.Error) {
					throw Error("/distribution/volunteersCalendar", e.message);
				}
		
				throw Ok("/distribution/volunteersCalendar", t._("You have been successfully assigned to the selected role."));				
			}
			
			//set timeframe
			if ( args._from != null && args._to != null ) {
				from = args._from;
				to = args._to;
			}
		}

		if ( from == null || to == null ) {
			from = Date.now();
			to = DateTools.delta(from, 1000.0 * 60 * 60 * 24 * app.user.getGroup().daysBeforeDutyPeriodsOpen );			
		}

		view.fromField = new form.CagetteDatePicker("from","Date de début",from );
		view.toField = new form.CagetteDatePicker("to","Date de fin",to );
		

		multidistribs = db.MultiDistrib.getFromTimeRange( app.user.getGroup(), from, to );
		
		//Let's find all the unique volunteer roles for this set of multidistribs	
		var uniqueRoles = [];
		for ( multidistrib in multidistribs ) {

			if (multidistrib.volunteerRolesIds != null) {

				var multidistribVolunteerRoles = multidistrib.getVolunteerRoles();
				for ( role in multidistribVolunteerRoles ) {

					if ( !Lambda.has(uniqueRoles, role) ) {
						uniqueRoles.push(role);								
					}					
				}				
			}
		}		

		view.multidistribs = multidistribs;
		uniqueRoles.sort(function(b, a) { 
			var a_str = (a.catalog == null ? "null" : Std.string(a.catalog.id)) + a.name.toLowerCase();
			var b_str = (b.catalog == null ? "null" : Std.string(b.catalog.id)) + b.name.toLowerCase();
			return  a_str < b_str ? 1 : -1;
		});
		view.uniqueRoles = uniqueRoles;
		//view.initialUrl = args != null && args.from != null && args.to != null ? "/distribution/volunteersCalendar?from=" + args.from + "&to=" + args.to : "/distribution/volunteersCalendar";		
		view.from = from.toString().substr(0,10);
		view.to = to.toString().substr(0,10);

		//duty periods user's participation	
		var me = app.user;
		var timeframe = me.getGroup().getMembershipTimeframe(Date.now());
		view.timeframe = timeframe;	

		var multiDistribs = db.MultiDistrib.getFromTimeRange( me.getGroup(), timeframe.from, timeframe.to );
		var members = me.getGroup().getMembers();
		var genericRolesDone = 0;
		var genericRolesToBeDone = 0;
		var contractRolesDone = 0;
		var contractRolesToBeDone = 0;
		var contractRolesToBeDoneByContractId = new Map<Int,Int>();
		var membersNumByContractId = new Map<Int,Int>();
		var membersListByContractId = new Map<Int,Array<db.User>>();
		for( md in multiDistribs ){
			var roles = md.getVolunteerRoles();
			for( role in roles){
				if(role.isGenericRole()){
					genericRolesToBeDone++;
				}else{
					if(contractRolesToBeDoneByContractId[role.catalog.id]==null){
						contractRolesToBeDoneByContractId[role.catalog.id]=1; 
					} else {
						contractRolesToBeDoneByContractId[role.catalog.id]++;
					}
				}
			}
		}

		//contract roles
		for( cid in contractRolesToBeDoneByContractId.keys()) membersListByContractId[cid] = [];

		for(md in multiDistribs){

			//populate member list by contract id
			for( d in md.getDistributions()){
				if(membersListByContractId[d.catalog.id]==null){
					//this contract has no roles
					continue;
				}
				for( u in members){
					if(d.hasUserOrders(u)){
						membersListByContractId[d.catalog.id].push(u);
					} 
				}
			}

			//volunteers			
			for( v in md.getVolunteers()){
				if(v.user.id!=me.id) continue;
				if(v.volunteerRole.isGenericRole()){
					genericRolesDone++;
				}else{
					contractRolesDone++;
				}
			}
		}

		//roles to be done spread over members
		genericRolesToBeDone = Math.ceil(genericRolesToBeDone / members.length);
		for( cid in membersListByContractId.keys()){
			membersListByContractId[cid] = tools.ObjectListTool.deduplicate(membersListByContractId[cid]);
			membersNumByContractId[cid] = membersListByContractId[cid].length;
		}

		
		for( cid in membersListByContractId.keys()){
			//if this user is involved in this contract
			if(Lambda.find(membersListByContractId[cid],function(u)return u.id==me.id)!=null){
				//role to be done for this user = contract roles to be done for this contract / members num involved in this contract
				contractRolesToBeDone +=  Math.ceil( contractRolesToBeDoneByContractId[cid] / membersNumByContractId[cid] );
			}
		}

		view.toBeDone = genericRolesToBeDone + contractRolesToBeDone;
		view.done = genericRolesDone + contractRolesDone;
		
	}


	/**
		Members can view volunteers planning for each role and multidistrib date
	**/
	@tpl('distribution/volunteersParticipation.mtt')
	function doVolunteersParticipation(?args: { ?from: Date, ?to: Date } ) {
				
		var from: Date = null;
		var to: Date = null;

		if ( args != null ) {
			if ( args.from != null && args.to != null ) {
				from = args.from;
				to = args.to;
			}
		}

		if ( from == null || to == null ) {
			var timeframe = app.user.getGroup().getMembershipTimeframe(Date.now());
			from = timeframe.from;
			to = timeframe.to;
		}

		var multiDistribs = db.MultiDistrib.getFromTimeRange( app.user.getGroup(), from, to );
		var members = app.user.getGroup().getMembers();

		//init + generic roles
		var totalRolesToBeDone = 0;	
		var totalRolesDone = 0;
		var genericRolesToBeDone = 0;
		var genericRolesDoneByMemberId = new Map<Int,Int>();
		var contractRolesDoneByMemberId = new Map<Int,Int>();
		var contractRolesToBeDoneByMemberId = new Map<Int,Int>();
		var contractRolesToBeDoneByContractId = new Map<Int,Int>();
		var membersNumByContractId = new Map<Int,Int>();
		var membersListByContractId = new Map<Int,Array<db.User>>();
		for( u in members ){
			genericRolesDoneByMemberId[u.id] = 0;
			contractRolesDoneByMemberId[u.id] = 0;
			contractRolesToBeDoneByMemberId[u.id] = 0;
		}
		for( md in multiDistribs ){
			var roles = md.getVolunteerRoles();
			for( role in roles){
				totalRolesToBeDone ++;
				if(role.isGenericRole()){
					genericRolesToBeDone++;
				}else{
					if(contractRolesToBeDoneByContractId[role.catalog.id]==null){
						contractRolesToBeDoneByContractId[role.catalog.id]=1; 
					} else {
						contractRolesToBeDoneByContractId[role.catalog.id]++;
					}
				}
			}
		}

		//contract roles
		for( cid in contractRolesToBeDoneByContractId.keys()) membersListByContractId[cid] = [];

		for(md in multiDistribs){

			//populate member list by contract id
			for( d in md.getDistributions()){
				if(membersListByContractId[d.catalog.id]==null){
					//this contract has no roles
					continue;
				}
				for( u in members){
					if(d.hasUserOrders(u)){
					//if(d.getUserOrders(u).length>0){
						membersListByContractId[d.catalog.id].push(u);
					} 
				}
			}

			//volunteers			
			for( v in md.getVolunteers()){
				totalRolesDone++;
				if(v.volunteerRole.isGenericRole()){
					if(genericRolesDoneByMemberId[v.user.id]!=null) 
						genericRolesDoneByMemberId[v.user.id]++;
				}else{
					if(contractRolesDoneByMemberId[v.user.id]!=null) 
						contractRolesDoneByMemberId[v.user.id]++;
				}
			}
			

		}

		//roles to be done spread over members
		genericRolesToBeDone = Math.ceil(genericRolesToBeDone / members.length);
		for( cid in membersListByContractId.keys()){
			membersListByContractId[cid] = tools.ObjectListTool.deduplicate(membersListByContractId[cid]);
			membersNumByContractId[cid] = membersListByContractId[cid].length;
		}

		for( m in members){
			for( cid in membersListByContractId.keys()){
				//if this user is involved in this contract
				if(Lambda.find(membersListByContractId[cid],function(u)return u.id==m.id)!=null){
					//role to be done for this user = contract roles to be done for this contract / members num involved in this contract
					contractRolesToBeDoneByMemberId[m.id] +=  Math.ceil( contractRolesToBeDoneByContractId[cid] / membersNumByContractId[cid] );
				}
			}
		}

		view.members = members;
		view.multiDistribs = multiDistribs;
		view.genericRolesToBeDone = genericRolesToBeDone;
		view.genericRolesDoneByMemberId = genericRolesDoneByMemberId;
		view.contractRolesDoneByMemberId = contractRolesDoneByMemberId;
		view.contractRolesToBeDoneByMemberId = contractRolesToBeDoneByMemberId;
		view.totalRolesToBeDone = totalRolesToBeDone;
		view.totalRolesDone = totalRolesDone;
		
		view.initialUrl = args != null && args.from != null && args.to != null ? "/distribution/volunteersCalendar?from=" + args.from + "&to=" + args.to : "/distribution/volunteersCalendar";		
		view.from = from.toString().substr(0,10);
		view.to = to.toString().substr(0,10);		
	}

	/**
		Remove a product from orders.
	**/
	@tpl('form.mtt')
	function doMissingProduct(distrib:db.MultiDistrib){
		checkHasDistributionSectionAccess();

		var form = new sugoi.form.Form("missingProduct");

		var datas = [];
		for( d in distrib.getDistributions(db.Catalog.TYPE_VARORDER)){
			datas.push({label:d.catalog.name.toUpperCase(),value:null});
			for( p in d.catalog.getProducts(false)){
				datas.push({label:"---- "+p.getName()+" : "+p.getPrice()+view.currency(),value:p.id});
			}
		}

		form.addElement( new sugoi.form.elements.IntSelect("product",t._("Undelivered product"),datas,null,true) );

		if(form.isValid()){
			var pid = form.getValueOf("product");
			var product = db.Product.manager.get(pid,false);
			if(pid==null || pid==0 || product==null){
				throw Error(sugoi.Web.getURI(), t._("Please select a product") );
			} 
			var count = 0;
			for( order in distrib.getOrders(db.Catalog.TYPE_VARORDER)){
				if(product.id==order.product.id){
					//set qt to 0
					service.OrderService.edit(order,0);
					db.Operation.onOrderConfirm([order]);//updates payments
					count++;
				}
			}
			throw Ok("/distribution/validate/"+distrib.id , t._("The undelivered product has been removed from ::n:: orders.",{n:count}));

		}

		view.form = form;
		view.title = t._("Remove an undelivered product from orders");
	}

	/**
		Change a price in orders.
	**/
	@tpl('form.mtt')
	function doChangePrice(distrib:db.MultiDistrib){
		checkHasDistributionSectionAccess();
		var form = new sugoi.form.Form("changePrice");

		var datas = [];
		for( d in distrib.getDistributions(db.Catalog.TYPE_VARORDER)){
			datas.push({label:d.catalog.name.toUpperCase(),value:null});
			for( p in d.catalog.getProducts(false)){
				datas.push({label:"---- "+p.getName()+" : "+p.getPrice()+view.currency(),value:p.id});
			}
		}

		form.addElement( new sugoi.form.elements.IntSelect("product",t._("Product which price has changed"),datas,null,true) );
		form.addElement( new sugoi.form.elements.FloatInput("price",t._("New price"), 0, true));

		if(form.isValid()){
			var pid = form.getValueOf("product");
			var product = db.Product.manager.get(pid,false);
			if(pid==null || pid==0 || product==null){
				throw Error(sugoi.Web.getURI(), t._("Please select a product") );
			}
			var price : Float = form.getValueOf("price");

			var count = 0;
			for( order in distrib.getOrders(db.Catalog.TYPE_VARORDER)){
				if(product.id==order.product.id){
					//change price
					order.lock();
					order.productPrice = price;
					order.update();

					db.Operation.onOrderConfirm([order]);//updates payments
					count++;
				}
			}
			var productName = product.getName();
			var priceStr = price+view.currency();
			throw Ok("/distribution/validate/"+distrib.id , t._("The price of ::product:: has been modified to ::price:: in orders.",{product:productName,price:priceStr}));

		}

		view.form = form;
		view.title = t._("Change the price of a product in orders");
		view.text = "Attention, cette opération met à jour le prix d'un produit dans les commandes de cette distribution, mais ne change pas le prix du produit dans le catalogue.";

	}


	/**
		Counter management
	**/
	@tpl('validate/counter.mtt')
	function doCounter(distribution:db.MultiDistrib){
		checkHasDistributionSectionAccess();

		if(app.params.get("counterBeforeDistrib")!=null){
			distribution.lock();
			distribution.counterBeforeDistrib = Std.parseFloat(app.params.get("counterBeforeDistrib"));
			distribution.update();
		}
		view.distribution = distribution;

		#if plugins
		var sales = mangopay.MangopayPlugin.getMultiDistribDetailsForGroup(distribution);
		view.sales = sales;
		#end

		//memberships
		var membershipAmount = 0.0;
		var membershipNum = 0;
		if(distribution.group.hasMembership){
			//membership num
			
			var ms = new service.MembershipService(distribution.group);
			var memberships = ms.getMembershipsFromDistrib(distribution);
			membershipNum = memberships.length;
			view.membershipNum = membershipNum;

			//membership amount
			
			for( m in memberships){
				membershipAmount += m.operation.amount;
			}
			view.membershipAmount = membershipAmount;
			view.memberships = memberships;

		}

		//orders total by VAT rate	
		var ordersByVat = 	service.ReportService.getOrdersByVAT(distribution);
		view.ordersByVat = ordersByVat;

		//user who have not paid / paid too much / partially paid
		var notPaid = new Array<{user:db.User,amount:Float}>();
		var partiallyPaid = new Array<{user:db.User,amount:Float}>();
		var paidTooMuch = new Array<{user:db.User,amount:Float}>();

		for( basket in distribution.getBaskets() ){
			var orderOp = basket.getOrderOperation(false);
			if(orderOp==null) continue;
			var ops = basket.getPaymentsOperations();
			var paid = 0.0;
			var order = Math.abs(orderOp.amount);

			if(ops.length==0 && order>0){
				notPaid.push({user:basket.getUser(),amount:basket.getOrdersTotal()});
			}else{
					
				for( o in ops) paid+=o.amount;
				if(paid.roundTo(2) > order.roundTo(2)) {					
					paidTooMuch.push({user:basket.getUser(),amount:paid-order});
				}
				if(paid.roundTo(2) < order.roundTo(2)) {
					partiallyPaid.push({user:basket.getUser(),amount:order-paid});
				}


			}
		}

		if(app.params.get("csv")=="1"){
			var out = new Array<Array<String>>();
			out.push(['Fond de caisse avant distribution',distribution.counterBeforeDistrib.string()]);
			#if plugins
			out.push(['Encaissements en liquide',sales.cashTurnover.ttc.string()]);
			out.push(['La caisse doit contenir',(distribution.counterBeforeDistrib+sales.cashTurnover.ttc).string()]);
			out.push(['Encaissements en chèque',sales.checkTurnover.ttc.string()]);
			out.push(['Encaissements en virement',sales.transferTurnover.ttc.string()]);
			#end
			out.push([]);
			out.push(['Total commande par taux de TVA','HT','TTC']);
			for(k in ordersByVat.keys()){
				out.push([ (k/100)+"%" , Formatting.formatNum(ordersByVat[k].ht) , Formatting.formatNum(ordersByVat[k].ttc) ]);
			}
			out.push([]);
			out.push(['Commandes non payées']);
			out.push(['Membre','Montant impayé']);
			for(u in notPaid) out.push( [ u.user.getName(), Formatting.formatNum(u.amount) ] );
			out.push([]);
			out.push(['Commandes payées partiellement']);
			out.push(['Membre','Montant manquant']);
			for(u in partiallyPaid) out.push( [ u.user.getName(), Formatting.formatNum(u.amount) ] );
			out.push([]);
			out.push(['Avoirs']);
			out.push(['Membre','Montant avoir']);
			for(u in paidTooMuch) out.push( [ u.user.getName(), Formatting.formatNum(u.amount) ] );
			out.push([]);
			out.push(['Nombre de cotisations saisies',Formatting.formatNum(membershipNum)]);
			out.push(['Montant des cotisations',Formatting.formatNum(membershipAmount)]);
			

			app.setTemplate(null);
			sugoi.tools.Csv.printCsvDataFromStringArray(out,[],"Encaissements "+view.hDate(distribution.distribStartDate)+".csv");			
		}
		

		view.notPaid = notPaid;
		view.paidTooMuch = paidTooMuch;
		view.partiallyPaid = partiallyPaid;

	}

	/**

	
	@tpl("distribution/userTimeSlot.mtt")
	function doUserTimeSlot(d:db.MultiDistrib){
		view.distribution = d;
	}**/

	/**
		See timeslot resolution for admins
	**/
	@tpl("distribution/timeSlots.mtt")
	function doTimeSlots(d:db.MultiDistrib){

		var s = new service.TimeSlotsService(d);
		if(Date.now().getTime() > d.orderEndDate.getTime() && !s.isResolved()){
			s.resolveSlots();
		}

		view.distribution = d;
	}

	@tpl("distribution/selectTimeSlots.mtt")
	function doSelectTimeSlots(tmpBasket:TmpBasket){
		
		var flow = new OrderFlowService().setPlace(Place.TimeSlotSelection(tmpBasket));
		view.url = flow.getPlaceUrl(flow.getNextPlace());

		view.distribution = tmpBasket.multiDistrib;
	}
}