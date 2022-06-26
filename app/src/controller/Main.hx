package controller;
import db.MultiDistrib;
import db.Distribution;
import db.UserOrder;
import haxe.Json;
import haxe.web.Dispatch;
import sugoi.form.elements.StringInput;
import sugoi.tools.ResultsBrowser;
import Common;
import tools.ArrayTool;

class Main extends Controller {

	public function new(){
		super();

		//init group breadcrumb
		var group = App.current.getCurrentGroup();
		if(group!=null)
			addBc("g"+group.id, "Groupe : "+group.name, "/home");

	}

	function doDefault(?permalink:String){

		if(permalink==null || permalink=="") throw Redirect("/home");
		//if permalink is an ID , could use it for group selection ? www.leportail.org/1/contractAdmin ...
		var p = sugoi.db.Permalink.get(permalink);
		if(p==null) throw Error("/home",t._("The link \"::link::\" does not exists.",{link:permalink}));

		app.event(Permalink({link:p.link,entityType:p.entityType,entityId:p.entityId}));
	}
	
	/**
	 * public pages 
	 */
	function doGroup(d:haxe.web.Dispatch){
		d.dispatch(new controller.Group());
	}

	@tpl("home.mtt")
	function doHome() {

		addBc("home","Commandes","/home");
		
		var group = app.getCurrentGroup();		
		if ( app.user!=null && group == null) {			
			throw Redirect("/user/choose");
		}else if (app.user == null && (group==null || group.regOption!=db.Group.RegOption.Open) ) {
			throw Redirect("/user/login");
		}

		view.amap = group;
		
		//has unconfirmed basket ?
		service.OrderService.checkTmpBasket(app.user,app.getCurrentGroup());

		//contract with open orders
		if(!group.hasShopMode()){
			var openContracts = Lambda.filter(group.getActiveContracts(), function(c) return c.isUserOrderAvailable());
			view.openContracts = openContracts;
		}
		
		//freshly created group
		view.newGroup = app.session.data.newGroup == true;
		
		var n = Date.now();
		var now = new Date(n.getFullYear(), n.getMonth(), n.getDate(), 0, 0, 0);
		var in1Month = DateTools.delta(now, 1000.0 * 60 * 60 * 24 * 14);
		var timeframe = new tools.Timeframe(now,in1Month);

		var distribs = db.MultiDistrib.getFromTimeRange(group,timeframe.from,timeframe.to);

		//special case : only one distrib , far in future.
		if(distribs.length==0) {
			timeframe = new tools.Timeframe(now,DateTools.delta(now, 1000.0 * 60 * 60 * 24 * 30 * 12));
			distribs = db.MultiDistrib.getFromTimeRange(group,timeframe.from,timeframe.to);
		}

		view.timeframe = timeframe;
		view.distribs = distribs;

		//view functions
		view.getWhosTurn = function(orderId:Int, distrib:Distribution) {
			return db.UserOrder.manager.get(orderId, false).getWhosTurn(distrib);
		}
		
		//register to group without ordering block
		var hasOneOpenDistrib = false;
		for( md in distribs){
			if(md.isActive()) {
				hasOneOpenDistrib = true;
				break;
			}
		}

		var isMemberOfGroup = app.user==null ? false : app.user.isMemberOf(group);
		var registerWithoutOrdering = ( !isMemberOfGroup && group.regOption==db.Group.RegOption.Open && !hasOneOpenDistrib );
		view.registerWithoutOrdering = registerWithoutOrdering;
		if(registerWithoutOrdering) service.UserService.prepareLoginBoxOptions(view,group);		

		//event for additionnal blocks on home page
		var e = Blocks([], "home");
		app.event(e);
		view.blocks = e.getParameters()[0];

		//message if phone is required
		if(app.user!=null && group.flags.has(db.Group.GroupFlags.PhoneRequired) && app.user.phone==null){
			app.session.addMessage(t._("Members of this group should provide a phone number. <a href='/account/edit'>Please click here to update your account</a>."),true);
		}
		//message if address is required
		if(app.user!=null && group.flags.has(db.Group.GroupFlags.AddressRequired) && app.user.city==null){
			app.session.addMessage(t._("Members of this group should provide an address. <a href='/account/edit'>Please click here to update your account</a>."),true);
		}

		//Delete demo contracts
		if(checkToken() && app.params.get('action')=='deleteDemoContracts'){
			var contracts = app.getCurrentGroup().deleteDemoContracts();
			if(contracts.length>0 ) throw Ok("/","Contrats suivants effacés : "+contracts.map(function(c) return c.name).join(", "));
		}
		
		view.timeSlotService = function(d:db.MultiDistrib){
			return new service.TimeSlotsService(d);
		}

		view.visibleDocuments = group.getVisibleDocuments( isMemberOfGroup );

	}
	
	//login and stuff
	function doUser(d:Dispatch) {
		// addBc("user","Membres","/user");
		d.dispatch(new controller.User());
	}
	
	function doCron(d:Dispatch) {
		d.dispatch(new controller.Cron());
	}
	
	/**
	 *  JSON REST API Entry point
	 */
	function doApi(d:Dispatch) {
		sugoi.Web.setHeader("Content-Type","application/json");
		try {

			d.dispatch(new controller.Api());

		}catch (e:tink.core.Error){

			//manage tink Errors (service errors)
			sugoi.Web.setReturnCode(e.code);
			Sys.print(Json.stringify( {error:{code:e.code,message:e.message,stack:e.exceptionStack}} ));
			
		}catch (e:Dynamic){

			//manage other errors			
			sugoi.Web.setReturnCode(500);			
			var stack = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
			App.current.logError(e, stack);
			Sys.print(Json.stringify( {error:{code:500,message : Std.string(e), stack: stack }} ));
		}
		
	}
	
	@tpl("cssDemo.mtt")
	function doCssdemo() {
		//debug stringmap haxe4
		var users = new Map<String,String>();
		users["bob"] = "is a nice fellow";
		view.users = users;
	}
	
	@tpl("form.mtt")
	function doInstall(d:Dispatch) {
		d.dispatch(new controller.Install());
	}
	

	function doP(d:Dispatch) {
		
		/*
		 * Invalid array access
Stack (ADMIN|DEBUG)

Called from C:\HaxeToolkit\haxe\std/haxe/web/Dispatch.hx line 463
Called from controller/Main.hx line 117
		 * 
		var plugin = d.parts.shift();
		for ( p in App.plugins) {
			var n = Type.getClassName(Type.getClass(p)).toLowerCase();
			n = n.split(".").pop();
			if (plugin == n) {
				d.dispatch( p.getController() );
				return;
			}
		}
		
		throw Error("/","Plugin '"+plugin+"' introuvable.");
		*/
		
		d.dispatch(new controller.Plugin());
	}
	

	@logged
	function doMember(d:Dispatch) {
		addBc("member","Membres","/member");
		d.dispatch(new controller.Member());
	}
	
	@logged
	function doAccount(d:Dispatch) {
		addBc("account","Mon compte","/account");
		d.dispatch(new controller.Account());
	}

	@logged
	function doVendor(d:Dispatch) {
		addBc("contractAdmin","Producteur","/contractAdmin");
		d.dispatch(new controller.Vendor());
	}
	
	@logged
	function doPlace(d:Dispatch) {
		d.dispatch(new controller.Place());
	}
	
	@logged
	function doTransaction(d:Dispatch) {
		addBc("shop","Boutique","/shop");
		d.dispatch(new controller.Transaction());
	}
	
	@logged
	function doDistribution(d:Dispatch) {
		addBc("distribution","Distributions","/distribution");
		d.dispatch(new controller.Distribution());
	}
	
	function doShop(d:Dispatch) {
		addBc("shop","Boutique","/shop");
		d.dispatch(new controller.Shop());
	}

	@tpl('shop/default2.mtt')
	function doShop2(md:db.MultiDistrib) {

		if( app.getCurrentGroup()==null || app.getCurrentGroup().id!=md.getGroup().id){
			throw  Redirect("/group/"+md.getGroup().id);
		}
		service.OrderService.checkTmpBasket(app.user,app.getCurrentGroup());
		view.category = 'shop';
		view.place = md.getPlace();
		view.date = md.getDate();
		view.md = md;
		view.rights = app.user!=null ? haxe.Serializer.run(app.user.getRights()) : null;
	}
	
	@logged
	function doProduct(d:Dispatch) {
		d.dispatch(new controller.Product());
	}
	
	@logged
	function doAmap(d:Dispatch) {
		addBc("amap","Producteurs","/amap");
		d.dispatch(new controller.Amap());
	}
	
	
	function doContract(d:Dispatch) {
		addBc("contract","Catalogues","/contractAdmin");
		d.dispatch(new Contract());
	}
	
	@logged
	function doContractAdmin(d:Dispatch) {
		addBc("contract","Catalogues","/contractAdmin");
		d.dispatch(new ContractAdmin());
	}

	@logged
	function doDocuments( dispatch : Dispatch ) {

		dispatch.dispatch( new Documents() );
	}

	@logged
	function doSubscriptions( dispatch : Dispatch ) {

		dispatch.dispatch( new Subscriptions() );
	}
	 
	@logged
	function doMessages(d:Dispatch) {
		addBc("messages","Messagerie","/messages");
		d.dispatch(new Messages());
	}
	
	@logged
	function doAmapadmin(d:Dispatch) {
		addBc("amapadmin","Paramètres","/amapadmin");
		d.dispatch(new AmapAdmin());
	}
	
	@logged
	function doValidate(multiDistrib:db.MultiDistrib,user:db.User,d:haxe.web.Dispatch){
		
		var v = new controller.Validate();
		v.multiDistrib = multiDistrib;
		v.user = user;
		d.dispatch(v);
	}
	
	@admin
	function doAdmin(d:Dispatch) {
		d.dispatch(new controller.admin.Admin());
	}
	
	@admin
	function doDb(d:Dispatch) {
		d.parts = []; //disable haxe.web.Dispatch
		sys.db.admin.Admin.handler();
	}

	// @tpl("test.mtt")
	// public function doTest(id: Int) {
	// 	var distrib = db.MultiDistrib.manager.select($id == id);
	// 	var d: Dynamic = distrib;
	// 	d.slotsIsActivated = distrib.slots != null;
	// 	view.distrib = d;
	// }
}
