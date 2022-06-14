package service;

class VendorService{

	public function new(){}

	/**
		Get or create+link user account related to this vendor.
	**/
	public static function getOrCreateRelatedUser(vendor:db.Vendor){
		if(vendor.user!=null){
			return vendor.user;
		}else{
			var u = service.UserService.getOrCreate(vendor.name,null,vendor.email);
			vendor.lock();
			vendor.user = u;
			vendor.update();
			return u;
		}
	}

	/**
		Get vendors linked to a user account
	**/
	public static function getVendorsFromUser(user:db.User):Array<db.Vendor>{
		//get vendors linked to this account
		//var vendors = Lambda.array( db.Vendor.manager.search($user==user,false) );
		var vendors = [];
		#if plugins
		var vendors2 = Lambda.array(Lambda.map(pro.db.PUserCompany.getCompanies(user),function(c) return c.vendor));
		vendors = vendors2.concat(vendors);
		vendors = tools.ObjectListTool.deduplicate(vendors);
		#end
		return vendors;
	}

	/**
		Send an email to the vendor
	**/
	public static function sendEmailOnAccountCreation(vendor:db.Vendor,source:db.User,group:db.Group){

		return;
		
		// the vendor and the user is the same person
		if(vendor.email==source.email) return;
		if(vendor.user==null) throw "Vendor should have a user";
		if(group==null) throw "a group should be provided";

		#if plugins
		var k = sugoi.db.Session.generateId();
		sugoi.db.Cache.set("validation" + k, vendor.user.id, 60 * 60 * 24 * 30); //expire in 1 month
		
		var e = new sugoi.mail.Mail();
		e.setSubject("Vous êtes référencé sur Alterconso !");
		e.addRecipient(vendor.email,vendor.name);
		e.setSender(App.config.get("default_email"),"Alterconso");			
		
		var html = App.current.processTemplate("mail/vendorInvitation.mtt", { 
			source:source,
			sourceGroup:group,
			vendor:vendor,
			k:k 			
		} );		
		e.setHtmlBody(html);
		
		App.sendMail(e);	
		#end
	}

	/**
		Search vendor by name or email
	**/
	public static function findVendors(name:String,?email:String){
		var vendors = [];
		for( n in name.split(" ")){
			n = n.toLowerCase();
			if(Lambda.has(["le","la","les","du","de","l'","a","à","au","en","sur","qui","ferme","GAEC","EARL","SCEA","jardin","jardins"],n)) continue;
			//search for each term
			//var search = Lambda.array(db.Vendor.manager.unsafeObjects('SELECT * FROM Vendor WHERE name LIKE "%$n%" LIMIT 20',false));
			var search = Lambda.array(db.Vendor.manager.search( $name.like('%$n%'),{limit:20},false));
			vendors = vendors.concat(search);
		}

		//search by mail
		if(email!=null){
			vendors = vendors.concat(Lambda.array(db.Vendor.manager.search($email==email,false)));
		}
		
		vendors = tools.ObjectListTool.deduplicate(vendors);

		#if plugins
		//cpro first
		for( v in vendors.copy() ){
			var cpro = v.getCpro();
			if( cpro !=null ){
				vendors.remove(v);
				//do not display students cpro accounts !
				if(cpro.disabled) continue;
				vendors.unshift(v);
			} 
		}
		#end


		return vendors;
	}


}