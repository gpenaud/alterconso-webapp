package controller;
import payment.MoneyPot;
import sugoi.form.elements.Input.InputType;
import sugoi.form.elements.IntInput;
import db.Group.GroupFlags;
import db.UserGroup;
import haxe.Http;
import neko.Web;
import sugoi.form.Form;
import Common;
import sugoi.form.elements.IntSelect;
import sugoi.form.elements.StringInput;
import sugoi.form.elements.FloatInput;


class AmapAdmin extends Controller
{

	public function new() 
	{
		super();
		if (!app.user.isAmapManager()) throw Error("/", t._("Access forbidden"));
		
		//lance un event pour demander aux plugins si ils veulent ajouter un item dans la nav
		var nav = new Array<Link>();
		
		if (app.user.getGroup().hasPayments()) {
			nav.push({id:"payments",link:"/amapadmin/payments",name: t._("Means of payment"),icon:"payment-type" });
		}	
		if(!app.user.getGroup().hasTaxonomy()){
			nav.push({id:"categories",link:"/amapadmin/categories",name: t._("Customized categories"),icon:"tag" });
		}
		

		var e = Nav(nav,"groupAdmin");
		app.event(e);
		view.nav = e.getParameters()[0];
	}
	
	@tpl("form.mtt")
	function doMembership(){
		
		var form = new sugoi.form.Form("membership");
		var group = app.user.getGroup();

		//membership
		form.addElement( new sugoi.form.elements.Checkbox("membership","Gestion des adhésions",group.hasMembership), 13);
		form.addElement( new sugoi.form.elements.IntInput("membershipFee","Montant de l'adhésion (laisser vide si variable)",group.membershipFee), 14);
		var dp = new form.CagetteDatePicker("membershipRenewalDate","Date de renouvellement annuelle des adhésions",group.membershipRenewalDate);
		// dp.format = "D MMMM";
		form.addElement( dp ,15 );
		//avoid modifiying another group
		var groupId = new sugoi.form.elements.IntInput("groupId","groupId",group.id);
		groupId.inputType = InputType.ITHidden;
		form.addElement( groupId );

		if (form.checkToken()) {

			if( form.getValueOf("groupId") != group.id ) throw "Vous avez changé de groupe.";

			group.lock();
			group.hasMembership = form.getValueOf("membership")==true;			
			group.membershipFee = form.getValueOf("membershipFee");
			group.membershipRenewalDate = form.getValueOf("membershipRenewalDate");
			group.update();
			throw Ok("/amapadmin","Paramètres d'adhésion mis à jour");
			
		}

		view.form = form;
		view.title = "Adhésions";
	}

	@tpl("amapadmin/default.mtt")
	function doDefault() {
		var group = app.user.getGroup();
		view.membersNum = UserGroup.manager.count($group == group);
		view.contractsNum = group.getActiveContracts().length;
		
		//visible on map
		#if plugins
		var h = hosted.db.Hosting.getOrCreate(group.id, true);
		var o = h.updateVisible();
		
		var str = "";
		if(!o.cagetteNetwork){
			str += "L'option 'Me lister dans l'annuaire des groupes Alterconso' n'est pas cochée. ";
		}
		if (!o.geoloc){
			str += "Votre lieu de distribution n'a pas pu être géolocaliser, merci de compléter ou corriger son adresse. ";
		}
		if( ! o.distributions ){
			str += "Vous devez avoir des distributions planifiées. ";
		}
		if(!o.members){
			str += "Vous devez avoir au moins 3 personnes dans votre groupe. ";
		}

		view.visibleOnMapText = str;
		view.visibleOnMap = o.visible;

		#else
		view.visibleOnMap = true;
		#end

		
		

		
	}
	
	@tpl("amapadmin/rights.mtt")
	public function doRights() {
		
		view.users = app.user.getGroup().getGroupAdmins();
		view.nav.push( 'rights' );
	}
	
	
	@tpl("form.mtt")
	public function doEditRight(?u:db.User) {
		
		var form = new sugoi.form.Form("editRight");
		
		if (u == null) {
			form.addElement( new IntSelect("user", t._("Member") , app.user.getGroup().getMembersFormElementData(), null, true) );	
		}
		
		var data = [];
		//for (r in Right.getConstructors()) {
			//if (r == "ContractAdmin") continue; //managed later
			//data.push({label:r,value:r});
		//}
		data.push({label:t._("Group administrator"), value:"GroupAdmin"});
		data.push({label:t._("Membership management"),value:"Membership"});
		data.push({label:t._("Messages"),value:"Messages"});
		
		var ua : db.UserGroup = null;
		var populate :Array<String> = null;
		if (u != null) {
			ua = db.UserGroup.get(u, app.user.getGroup(), true);
			if (ua == null) throw "no user";
			if (ua.rights == null) ua.rights = [];
			//populate form
			populate = ua.rights.map(function(x) return x.getName());
		}
		
		form.addElement( new sugoi.form.elements.CheckboxGroup("rights", t._("Rights"), data, populate, true, true) );
		form.addElement( new sugoi.form.elements.Html("html","<hr/>"));
		
		//Rights on contracts
		var data = [];
		var populate :Array<String> = [];
		data.push({value:"contractAll",label:t._("All catalogs")});
		for (r in app.user.getGroup().getActiveContracts(true)) {
			data.push( { label:r.name , value:"contract"+Std.string(r.id) } );
		}
		
		if(ua!=null && ua.rights!=null){
			for ( r in ua.rights) {
				switch(r) {
					case Right.ContractAdmin(cid):
						if (cid == null) {
							populate.push("contractAll");
						}else {
							populate.push("contract"+cid);	
						}
						
					default://
				}
			}
		}
		

		form.addElement( new sugoi.form.elements.CheckboxGroup("rights", t._("Catalogs management") , data, populate, true, true) );
		
		if (form.checkToken()) {
			
			var wasManager = app.user.isAmapManager();
			
			if (u == null) {				
				ua = db.UserGroup.manager.select($userId == Std.parseInt(form.getValueOf("user")) && $groupId == app.user.getGroup().id, true);
			}
			ua.rights = [];

			var arr : Array<String> = cast form.getElement("rights").value;
			for ( r in arr) {
				if (r.substr(0, 8) == "contract") {
					if (r == "contractAll") {
						ua.rights.push( Right.ContractAdmin() );
					}else {
						ua.rights.push( Right.ContractAdmin(Std.parseInt(r.substr(8)) ) );	
					}
					
				}else {
					ua.rights.push( Right.createByName(r) );	
				}
			}
			
			//avoid "cut my own hands" problem
			if (ua.user.id == app.user.id && wasManager ) {
				var isManager = false;
				for ( r in ua.rights) {
					if (r.equals(Right.GroupAdmin)) {
						isManager = true; 
						break;
					}
				}
				if (isManager == false) {
					throw Error("/amapadmin/rights", t._("You cannot strip yourself of admin rights."));
				}
			}
			
			
			if (ua.rights.length == 0) ua.rights = null;
			ua.update();
			if (ua.rights == null) {
				throw Ok("/amapadmin/rights", t._("Rights removed"));
			}else {
				throw Ok("/amapadmin/rights", t._("Rights created or modified"));
			}
			
		}
		
		if (u == null) {
			view.title = t._("Give rights to a user");
		}else {
			view.title = t._("Modify the rights of ::user::",{user:u.getName()});
		}
		
		view.form = form;
		
	}
	
	@tpl('form.mtt')
	public function doVatRates() {
		
		var f = new sugoi.form.Form("vat");
		var a = app.user.getGroup();
		
		if (a.vatRates == null) {
			a.lock();
			var x = new db.Group();
			a.vatRates = x.vatRates;
			a.update();
		}
		
		var i = 1;
		//create field with a value
		for (k in a.vatRates.keys()) {
			f.addElement(new StringInput(i+"-k", t._("Name") +" "+ i, k));
			f.addElement(new FloatInput(i + "-v", t._("Rate") +" "+ i, a.vatRates.get(k) ));
			i++;
		}
		
		//...fill in to get 4 fields
		for (x in 0...5 - i) {
			f.addElement(new StringInput(i+"-k", t._("Name") +" "+ i, null));
			f.addElement(new FloatInput(i + "-v", t._("Rate") +" "+ i, null));
			i++;
		}
		
		if (f.isValid()) {
			var d = f.getData();
			var vats = new Map<String,Float>();
			for (i in 1...5) {
				if (d.get(i + "-k") == null) continue;
				vats.set(d.get(i + "-k"), d.get(i + "-v") );
			}
			a.lock();
			a.vatRates = vats;
			a.update();
			throw Ok("/amapadmin", t._("Rate updated"));
			
		}
		view.title = t._("Edit VAT rates");
		view.form = f;
	}
	
	function doCategories(d:haxe.web.Dispatch) {
		d.dispatch(new controller.amapadmin.Categories());
	}

	function doVolunteers(d:haxe.web.Dispatch) {
		d.dispatch(new controller.amapadmin.Volunteers());
	}

	function doDocuments( dispatch : haxe.web.Dispatch ) {

		dispatch.dispatch( new controller.Documents() );
	}

	/**
	 * Set up group currency. Default is EURO
	 */
	@tpl("form.mtt")
	function doCurrency(){
		
		view.title = t._("Currency used by your group.");
		
		var f = new sugoi.form.Form("curr");
		f.addElement(new sugoi.form.elements.StringInput("currency", t._("Currency symbol"), app.user.getGroup().getCurrency()));
		f.addElement(new sugoi.form.elements.StringInput("currencyCode", t._("3 digit ISO code"), app.user.getGroup().currencyCode));
		
		if ( f.isValid()){
			
			app.user.getGroup().lock();
			app.user.getGroup().currency = f.getValueOf("currency");
			app.user.getGroup().currencyCode = f.getValueOf("currencyCode");
			app.user.getGroup().update();
			
			throw Ok("/amapadmin/currency", t._("Currency updated"));
		}
		
		view.form = f;
	}
	
	/**
	 * payment types config
	 */
	@tpl("form.mtt")
	function doPayments(){
		
		var f = new sugoi.form.Form("paymentTypes");
		var types = service.PaymentService.getPaymentTypes(PCGroupAdmin);
		var formdata = [for (t in types){label:t.name, value:t.type, desc:t.adminDesc, docLink:t.docLink}];		
		var selected = app.user.getGroup().allowedPaymentsType;
		f.addElement(new sugoi.form.elements.CheckboxGroup("paymentTypes", t._("Authorized payment types"),formdata, selected) );
		
		var group = app.user.getGroup();

		if (group.checkOrder == ""){
			group.lock();
			group.checkOrder = app.user.getGroup().name;
			group.update();
		}
		f.addElement( new sugoi.form.elements.StringInput("checkOrder", t._("Make the check payable to"), app.user.getGroup().checkOrder, false)); 
		f.addElement( new sugoi.form.elements.StringInput("IBAN", t._("IBAN of your bank account for transfers"), app.user.getGroup().IBAN, false)); 
		f.addElement( new sugoi.form.elements.Checkbox("allowMoneyPotWithNegativeBalance", t._("Allow money pots with negative balance"), app.user.getGroup().allowMoneyPotWithNegativeBalance));
		//avoid modifiying another group
		var groupId = new sugoi.form.elements.IntInput("groupId","groupId",group.id);
		groupId.inputType = InputType.ITHidden;
		f.addElement( groupId );

		if (f.isValid()){
			
			if( f.getValueOf("groupId") != group.id ) throw "Vous avez changé de groupe.";

			group.lock();
			group.allowedPaymentsType = f.getValueOf("paymentTypes");

			if(group.allowedPaymentsType.has(MoneyPot.TYPE) && group.allowedPaymentsType.length>1) {
				throw Error(sugoi.Web.getURI(),"Le paiement Cagnotte ne peut pas être utilisé en même temps que d'autres moyens de paiements.");
			}

			group.checkOrder = f.getValueOf("checkOrder");
			group.IBAN = f.getValueOf("IBAN");
			group.allowMoneyPotWithNegativeBalance = f.getValueOf("allowMoneyPotWithNegativeBalance");
			group.update();
			
			throw Ok("/amapadmin/payments", t._("Payment options updated"));
			
		}
		
		view.title = t._("Means of payment");
		view.form = f;
	}
	
}
