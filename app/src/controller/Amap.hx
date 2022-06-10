package controller;
import sugoi.form.elements.StringInput;
import sugoi.form.elements.Checkbox;
import db.UserOrder;
import sugoi.form.Form;

class Amap extends Controller
{

	public function new() 
	{
		super();
	}
	
	@tpl("amap/default.mtt")
	function doDefault() {
		var contracts = db.Catalog.getActiveContracts(app.user.getGroup(), true, false);
		for ( c in Lambda.array(contracts).copy()) {
			if (c.endDate.getTime() < Date.now().getTime() ) contracts.remove(c);
		}
		view.contracts = contracts;
	}
	
	@tpl("form.mtt")
	function doEdit() {
		
		if (!app.user.isAmapManager()) throw t._("You don't have access to this section");
		
		var group = app.user.getGroup();
		
		var form = form.CagetteForm.fromSpod(group);

		//remove "membership", "shop mode", "marge a la place des %", "unused" from flags
		var flags = form.getElement("flags");
		untyped flags.excluded = [0,1,3,9];

		//add a custom field for "shopmode"
		var data = [
			{label:t._("Shop Mode"),value:"shop"},
			{label:t._("CSA Mode"),value:"CSA"},
		];
		var selected = group.flags.has(db.Group.GroupFlags.ShopMode) ? "shop" : "CSA";
		form.addElement( new sugoi.form.elements.RadioGroup("mode",t._("Ordering Mode"),data, selected), 8);

		
	
		if (form.checkToken()) {
			
			if(form.getValueOf("id") != app.user.getGroup().id) {
				var editedGroup = db.Group.manager.get(form.getValueOf("id"),false);
				throw Error("/amap/edit",'Erreur, vous êtes en train de modifier "${editedGroup.name}" alors que vous êtes connecté à "${app.user.getGroup().name}"');
			}
			
			form.toSpod(group);

			if(form.getValueOf("mode")=="shop") group.flags.set(db.Group.GroupFlags.ShopMode) else group.flags.unset(db.Group.GroupFlags.ShopMode);

			if(group.betaFlags.has(db.Group.BetaFlags.ShopV2) && group.flags.has(db.Group.GroupFlags.CustomizedCategories)){
				App.current.session.addMessage("Vous ne pouvez pas activer les catégories personnalisées et la nouvelle boutique. La nouvelle boutique ne fonctionne pas avec les catégories personnalisées.",true);
				group.flags.unset(db.Group.GroupFlags.CustomizedCategories);
				group.update();
			}

			//warning AMAP+payments
			if( !group.flags.has(db.Group.GroupFlags.ShopMode) &&  group.hasPayments() ){
				//App.current.session.addMessage("ATTENTION : nous ne vous recommandons pas d'activer la gestion des paiements si vous êtes une AMAP. Ce cas de figure n'est pas bien géré par Cagette.net.",true);
				App.current.session.addMessage("L'activation de la gestion des paiements n'est pas autorisée si vous êtes une AMAP. Ce cas de figure n'est pas bien géré par Cagette.net.",true);
				group.flags.unset(db.Group.GroupFlags.HasPayments);
				group.update();
			}
			
			if (group.extUrl != null){
				if ( group.extUrl.indexOf("http://") ==-1 &&  group.extUrl.indexOf("https://") ==-1 ){
					group.extUrl = "http://" + group.extUrl;
				}
			}
			
			group.update();
			throw Ok("/amapadmin", t._("The group has been updated."));
		}
		
		view.form = form;
	}
	
}