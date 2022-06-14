package db;
import sys.db.Object;
import sys.db.Types;
import db.UserGroup;
import Common;

enum UserFlags {
	HasEmailNotif4h;	//send notifications by mail 4h before
	HasEmailNotif24h;	//send notifications by mail 24h before
	HasEmailNotifOuverture; //send notifications by mail on command open
	//Tuto;			//enable tutorials
}

/**
 * Site-wide right
 */
enum RightSite {
	Admin;
}

@:index(email,unique) @:index(email2)
class User extends Object {

	public var id : SId;
	public var lang : SString<2>;
	//@:skip public var name(get, set) : String;
	public var pass : STinyText;
	public var rights : SFlags<RightSite>;
	
	public var firstName:SString<32>;
	public var lastName:SString<32>;
	public var email : SString<64>;
	public var phone:SNull<SString<19>>;
	
	public var firstName2:SNull<SString<32>>;
	public var lastName2:SNull<SString<32>>;
	public var email2 : SNull<SString<64>>;
	public var phone2:SNull<SString<19>>;
	
	public var address1:SNull<SString<64>>;
	public var address2:SNull<SString<64>>;
	public var zipCode:SNull<SString<32>>;
	public var city:SNull<SString<25>>;

	public var birthDate : SNull<SDate>;
	public var nationality : SNull<SString<2>>;
	public var countryOfResidence : SNull<SString<2>>;
	
	//@:skip public var amap(get_amap, null) : Amap;
	
	public var cdate : SDate; 				//last creation
	public var ldate : SNull<SDateTime>;	//last connection
	
	public var flags : SFlags<UserFlags>;
	@hideInForms public var tos	 : SBool; //terms of service / CGU	
	@hideInForms public var tutoState : SNull<SData<{name:String,step:Int}>>; //tutorial state
	
	public var apiKey : SNull<SString<128>>; //private API key
	
	public function new() {
		super();
		
		//default values
		cdate = Date.now();
		rights = sys.db.Types.SFlags.ofInt(0);
		flags = sys.db.Types.SFlags.ofInt(0);
		flags.set(HasEmailNotif24h);
		flags.set(HasEmailNotifOuverture);
		lang = "fr";
		pass = "";
		
	}
	
	public override function toString() {
		return getName()+" ["+id+"]";
	}

	public function isAdmin() {
		return rights.has(Admin) || id==1;
	}
	
	public static function login(user:db.User, email:String) {
		
		user.lock();
		user.ldate = Date.now();
		user.update();
		
		App.current.session.setUser(user);
		if (App.current.session.data == null) App.current.session.data = {};
		App.current.session.data.whichUser = (email == user.email) ? 0 : 1; 	
		
	}

	public static function getForm(user:db.User){
		var t = sugoi.i18n.Locale.texts;
		var form = form.CagetteForm.fromSpod(user);
		form.removeElement(form.getElement("lang"));
		form.removeElement(form.getElement("pass"));
		form.removeElement(form.getElement("rights"));
		form.removeElement(form.getElement("cdate"));
		form.removeElement(form.getElement("ldate"));
		form.removeElement( form.getElement("apiKey") );
		form.removeElement(form.getElement("nationality"));
		
		form.addElement(new sugoi.form.elements.StringSelect("nationality", t._("Nationality"), getNationalities(), user.nationality), 15);
		form.removeElement(form.getElement("countryOfResidence"));
		var countryOptions = db.Place.getCountries();
		form.addElement(new sugoi.form.elements.StringSelect("countryOfResidence", t._("Country of residence"), countryOptions, user.countryOfResidence), 16);
		return form;
	}

	public static function getNationalities(){
		var t = sugoi.i18n.Locale.texts;
		var n =  [
			{label:t._("French")	,value:"FR"},
			{label:t._("Belgian")	,value:"BE"},
			{label:t._("Italian")	,value:"IT"},
			{label:t._("Spanish")	,value:"ES"},
			{label:t._("German")	,value:"DE"},
			{label:t._("Swiss")		,value:"CH"},
			{label:t._("Canadian")	,value:"CA"},
		];
		
		//ISO 3166-1
		for( x in ["AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AT", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BF", "BG", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ","BR","BS","BT","BV","BW","BY","BZ","CC","CD","CF","CG","CI","CK","CL","CM","CN","CO","CR","CU","CV","CW","CX","CY","CZ","DJ","DK","DM","DO","DZ","EC","EE","EG","EH","ER","ET","FI","FJ","FK","FM","FO","GA","GB","GD","GE","GF","GG","GH","GI","GL","GM","GN","GP","GQ","GR","GS","GT","GU","GW","GY","HK","HM","HN","HR","HT","HU","ID","IE","IL","IM","IN","IO","IQ","IR","IS","JE","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ","LA","LB","LC","LI","LK","LR","LS","LT","LU","LV","LY","MA","MC","MD","ME","MF","MG","MH","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NL","NO","NP","NR","NU","NZ","OM","PA","PE","PF","PG","PH","PK","PL","PM","PN","PR","PS","PT","PW","PY","QA","RE","RO","RS","RU","RW","SA","SB","SC","SD","SE","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SR","SS","ST","SV","SX","SY","SZ","TC","TD","TF","TG","TH","TJ","TK","TL","TM","TN","TO","TR","TT","TV","TW","TZ","UA","UG","UM","US","UY","UZ","VA","VC","VE","VG","VI","VN","VU","WF","WS","YE","YT","ZA","ZM","ZW"]){
			n.push({label:x,value:x});
		}
		return n;
	}
	
	/**
	 * is this user the manager of the current group
	 */
	public function isAmapManager() {
		var a = getGroup();
		if (a == null) return false;

		if(isAdmin()) return true;

		var ua = getUserGroup(a);
		if (ua == null) return false;

		return ua.hasRight(Right.GroupAdmin);
	}

	public function isGroupManager(){
		return isAmapManager();
	}
	
	public function getUserGroup(amap:db.Group):db.UserGroup {
		return db.UserGroup.get(this, amap);
	}

	public function getUserGroups(){
		return Lambda.array(db.UserGroup.manager.search($user == this, false));
	}
	
	public function isFullyRegistred(){
		return pass != null && pass != "";
	}
	
	public function makeMemberOf(group:db.Group){
		var ua = db.UserGroup.get(this, group);
		if (ua == null) {
			ua = new db.UserGroup();
			ua.user = this;
			ua.group = group;
			ua.insert();
		}
		return ua;
	}

	
	
	/**
	 * Est ce que ce membre a la gestion de ce contrat
	 * si null, est ce qu'il a la gestion d'un des contrat, n'importe lequel (utilse pour afficher 'gestion contrat' dans la nav )
	 * @param	contract
	 */
	public function isContractManager(?contract:db.Catalog ) {
		if (isAdmin()) return true;
		if (contract != null) {			
			return canManageContract(contract);
		}else {
			var ua = getUserGroup(getGroup());
			if (ua == null) return false;
			if (ua.rights == null) return false;
			for (r in ua.rights) {
				switch(r) {
					case Right.ContractAdmin(cid):
						return true;
					default:
				}
			}
			return false;			
		}
	}
	
	public function canManageAllContracts(){
		if (isAdmin()) return true;
		var ua = getUserGroup(getGroup());
		if (ua == null) return false;
		if (ua.rights == null) return false;
		for (r in ua.rights) {
			switch(r) {
				case Right.ContractAdmin(cid):
					if(cid==null) return true;
				default:
			}
		}
		return false;			
	}
	
	public function getRights():Array<Right>{
		var ua = getUserGroup(getGroup());
		if (ua == null) return [];
		return ua.rights;
	}

	public function canAccessMessages():Bool {
		var ua = getUserGroup(getGroup());
		if (ua == null) return false;
		if (ua.hasRight(Right.Messages)) return true;
		return false;
	}
	
	public function canAccessMembership():Bool {
		var ua = getUserGroup(getGroup());
		if (ua == null) return false;
		if (ua.hasRight(Right.Membership)) return true;
		return false;
	}
	
	public function canManageContract(c:db.Catalog):Bool {
		var ua = getUserGroup(c.group);
		if (ua == null) return false;
		if (ua.hasRight(Right.ContractAdmin())) return true;
		if (ua.hasRight(Right.ContractAdmin(c.id))) return true;		
		return false;
	}
	
	public function getContractManager(?lock=false) {
		return db.Catalog.manager.search($group == getGroup() && $contact == this, false);
	}
	
	public function getName() {
		return lastName + " " + firstName;
	}
	
	public function getCoupleName() {
		var n = lastName + " " + firstName;
		if (lastName2 != null) {
			n = n + " / " + lastName2 + " " + firstName2;
		}
		return n;
	}
	
	/**
	 * Encode a user password
	 * @param p 
	 */
	public function setPass(p:String) {
		if (p == null){
			this.pass = "";			
		}else{
			this.pass = haxe.crypto.Md5.encode( App.config.get('key') + StringTools.trim(p));
		} 
		return this.pass;
	}
	
	/**
	 * Renvoie les commandes actuelles du user
	 * @param	_amap		force une amap
	 * @param	lock=false
	 */
	public function getOrders(?_amap:db.Group,?lock = false):List<db.UserOrder> {
		var a = _amap == null ? getGroup() : _amap;
		var c = a.getActiveContracts(true);
		var cids = Lambda.map(c,function(m) return m.id);
		var pids = Lambda.map(db.Product.manager.search($catalogId in cids,false), function(x) return x.id);
		var out =  db.UserOrder.manager.search(($userId == id || $userId2 == id) && $productId in pids, lock);		
		return out;
		
	}
	
	/**
	 * renvoie les commandes à partir d'une liste de contrats
	 */
	public function getOrdersFromContracts(c:Iterable<db.Catalog>):List<db.UserOrder> {
		var cids = Lambda.map(c,function(m) return m.id);
		var pids = Lambda.map(db.Product.manager.search($catalogId in cids,false), function(x) return x.id);
		return db.UserOrder.manager.search(($userId == id || $userId2 == id) && $productId in pids, false);		
	}
	
	/**
	 * renvoie les commandes de contrat variables à partir d'une distribution
	 */
	public function getOrdersFromDistrib(d:db.Distribution):List<db.UserOrder> {
		var pids = Lambda.map(db.Product.manager.search($catalogId == d.catalog.id, false), function(x) return x.id);		
		return db.UserOrder.manager.search(($userId == id || $userId2 == id) && $distributionId==d.id && $productId in pids , false);	
	}
	
	/**
	 * renvoie l'amap selectionnée par le user en cours
	 */
	public function getGroup() {
		
		if (App.current.user != null && id != App.current.user.id) throw "This function is valid only for the current user";
		if (App.current.session == null) return null;
		if (App.current.session.data == null ) return null;
		var a = App.current.session.data.amapId;
		if (a == null) {
			return null;
		}else {			
			return db.Group.manager.get(a,false);
		}
	}
	
	/**
	 * Get groups this user belongs to.	 
	 */
	public function getGroups():Array<db.Group> {
		var ugs = db.UserGroup.manager.search($user == this, false);
		var groups = db.Group.manager.search($id in (ugs.map(ug->return untyped ug.groupId)),false).array();
		groups.sort(function(a,b) return a.name>b.name?1:-1 );
		return groups;

	}
	
	public function isMemberOf(group:db.Group) {
		return UserGroup.manager.select($user == this && $groupId == group.id, false) != null;
	}
	
	
	/**
	 * Renvoie la liste des contrats dans lequel l'adherent a des commandes
	 * @param	lock=false
	 * @return
	 */
	public function getContracts( group : db.Group, ?lock=false ) : Array<db.Catalog> {

		var out = [];
		var ucs = getOrders( group, lock );
		for (uc in ucs) {
			if (!Lambda.has(out, uc.product.catalog)) {
				out.push(uc.product.catalog);
			}	
		}
		return out;
	}
	
	/**
	 * Merge fields of 2 users, then delete the second (u2)
	 * Be carefull : check before calling this function that u2 can be safely deleted !
	 */
	public function merge(u2:db.User) {
		
		this.lock();
		u2.lock();
		
		var m = function(a, b) {
			return a == null || a=="" ? b : a;
		}
		
		this.address1 = m(this.address1, u2.address1);
		this.address2 = m(this.address2, u2.address2);
		this.zipCode = m(this.zipCode, u2.zipCode);
		this.city = m(this.city, u2.city);
		
		//find how to merge the 2 names in each account
		if (this.email == u2.email) {
			
			this.firstName = m(this.firstName, u2.firstName);
			this.lastName = m(this.lastName, u2.lastName);
			this.phone = m(this.phone, u2.phone);
			
		} else if (this.email == u2.email2) {
			
			this.firstName = m(this.firstName, u2.firstName2);
			this.lastName = m(this.lastName, u2.lastName2);
			this.phone = m(this.phone, u2.phone2);
		} 
		
		if (this.email2 == u2.email) {
			
			this.firstName2 = m(this.firstName2, u2.firstName);
			this.lastName2 = m(this.lastName2, u2.lastName);
			this.phone2 = m(this.phone2, u2.phone);
			
		} else if (this.email2 == u2.email2) {
			
			this.firstName2 = m(this.firstName2, u2.firstName2);
			this.lastName2 = m(this.lastName2, u2.lastName2);
			this.phone2 = m(this.phone2, u2.phone2);
			
		}
		
		u2.delete();
		this.update();
		
	}
	
	
	
	/**
	 * Search for similar users in the DB ( same firstName+lastName or same email )
	 */
	public static function __getSimilar(firstName:String, lastName:String, email:String,?firstName2:String, ?lastName2:String, ?email2:String):List<db.User> {
		var out = new Array();
		out = Lambda.array(User.manager.search($firstName.like(firstName) && $lastName.like(lastName), false));
		out = out.concat(Lambda.array(User.manager.search($email.like(email), false)));
		out = out.concat(Lambda.array(User.manager.search($firstName2.like(firstName) && $lastName2.like(lastName), false)));
		out = out.concat(Lambda.array(User.manager.search($email2.like(email), false)));
		
		//recherche pour le deuxieme user
		if (lastName2 != "" && lastName2 != null && firstName2 != "" && firstName2 != null) {
			out = out.concat(Lambda.array(User.manager.search($firstName.like(firstName2) && $lastName.like(lastName2), false)));			
			out = out.concat(Lambda.array(User.manager.search($firstName2.like(firstName2) && $lastName2.like(lastName2), false)));			
		}
		if (email2 != null && email2 != "") {
			out = out.concat(Lambda.array(User.manager.search($email.like(email2), false)));
			out = out.concat(Lambda.array(User.manager.search($email2.like(email2), false)));	
		}		
		
		//dedouble
		var x = new Map<Int,db.User>();
		for ( oo in out) {
			x.set(oo.id, oo);
		}
		return Lambda.list(x);
	}
	
	/**
	 * Search for similar users in the DB ( same email )
	 */
	public static function getSameEmail(email:String, ?email2:String){
		
		var out = new Array();
		out = out.concat(Lambda.array(User.manager.search($email.like(email), false)));
		out = out.concat(Lambda.array(User.manager.search($email2.like(email), false)));
		if (email2 != null && email2 != "") {
			out = out.concat(Lambda.array(User.manager.search($email.like(email2), false)));
			out = out.concat(Lambda.array(User.manager.search($email2.like(email2), false)));	
		}
		return Lambda.list(out);
	}
	
	/**
	 *  Get users with no contracts
	 **/ 
	public static function getUsers_NoContracts(?index:Int,?limit:Int):List<db.User> {
		var productsIds = App.current.user.getGroup().getProducts().map(function(x) return x.id);
		var uc = db.UserOrder.manager.search($productId in productsIds, false);
		var uc2 = uc.map(function(x) return x.user.id); //liste des userId avec un contrat dans cette amap

		// J. Le Clerc - BUGFIX#1 Ne pas oublier les contrats alternés
		for (u in uc) {
			if (u.user2 != null) {
				uc2.add(u.user2.id);
			}
		}
		
		if (uc2.length > 0){
			//les gens qui sont dans cette amap et qui n'ont pas de contrat de cette amap
			var ua = db.UserGroup.manager.unsafeObjects("select * from UserGroup where groupId=" + App.current.user.getGroup().id +" and userId NOT IN(" + uc2.join(",") + ")", false);						
			return Lambda.map(ua, function(x) return x.user);	
		}else{
			return App.current.user.getGroup().getMembers();
		}
		
	}
	
	/**
	 * User with contracts
	 */
	public static function getUsers_Contracts(?index:Int,?limit:Int):List<db.User> {
		var productsIds = App.current.user.getGroup().getProducts().map(function(x) return x.id);
		if (productsIds.length == 0) return new List();
		return db.User.manager.unsafeObjects("select u.* from User u, UserOrder uc where uc.productId IN(" + productsIds.join(",") + ") AND (uc.userId=u.id OR uc.userId2=u.id) group by u.id  ORDER BY u.lastName", false);	
	}
	
	
	public static function getUsers_NewUsers(?index:Int, ?limit:Int):List<db.User> {
		
		var uas = db.UserGroup.manager.search($group == App.current.user.getGroup(), false);
		var ids = Lambda.map(uas, function(x) return x.user.id);
		if (index == null && limit == null) {
			return  db.User.manager.search($pass == "" && ($id in ids), {orderBy:lastName} ,false);
		}else {
			return  db.User.manager.search($pass == "" && ($id in ids), {limit:[index, limit] ,orderBy:lastName} , false);			
		}
		
	}
	
	public function sendInvitation(group:db.Group,?force=false) {
		
		var t = sugoi.i18n.Locale.texts;
		
		if (isFullyRegistred() && !force) throw t._("This user cannot receive an invitation");
		
		//store token
		var k = sugoi.db.Session.generateId();
		sugoi.db.Cache.set("validation" + k, this.id, 60 * 60 * 24 * 30 * 3); //expire in 3 month
		
		var e = new sugoi.mail.Mail();
		if (group != null){
			e.setSubject(t._("Invitation")+" "+group.name);	
		}else{
			e.setSubject(t._("Invitation Alterconso"));
		}
		
		e.addRecipient(this.email,this.getName());
		e.setSender(App.config.get("default_email"),t._("Alterconso"));			
		
		var html = App.current.processTemplate("mail/invitation.mtt", { 
			email:email,
			email2:email2,
			groupName:(group == null?null:group.name),			
			name:firstName,
			k:k 			
		} );		
		e.setHtmlBody(html);
		
		App.sendMail(e);	
	}
	
	/**
	 * cleaning before saving
	 */
	override public function insert() {
		clean();
		super.insert();
	}
	
	override public function update() {
		clean();
		super.update();
	}
	
	function clean() {
		
		//emails
		this.email = this.email.toLowerCase();
		if (this.email2 != null) this.email2 = this.email2.toLowerCase();
		
		//lastname
		if (this.lastName != null) this.lastName = this.lastName.toUpperCase();
		if (this.lastName2 != null) this.lastName2 = this.lastName2.toUpperCase();

		if(pass==null) pass="";
	}

	/**
		get "quit group" link for emails footer
	**/
	public function getQuitGroupLink(group:db.Group){
		var protocol = App.config.DEBUG ? "http://" : "https://";
		return protocol+App.config.HOST+"/user/quitGroup/"+group.id+"/"+this.id+"/"+haxe.crypto.Md5.encode(App.config.KEY+group.id+this.id);
	}
	
	public function infos():UserInfo{
		return {
			id:id,
			name : getName(),
			firstName: firstName,
			lastName: lastName,
			email : email,
			phone: phone,
			city: city,
			zipCode: zipCode,
			address1: address1,
			address2: address2
		};
	}

	/**
	 * get form labels
	 */
	public static function getLabels():Map<String,String>{
		var t = sugoi.i18n.Locale.texts;
		return [
			"firstName"	=>	t._("First name"),
			"lastName"	=>	t._("Last name"),
			"email"		=>	t._("Email"),
			"phone"		=>	t._("Phone"),
			"firstName2"=>	t._("Partner first name"),
			"lastName2"	=>	t._("Partner last name"),
			"email2"	=>	t._("Partner email"),
			"phone2"	=>	t._("Partner phone"),
			"lang"		=>	t._("Language"),
			"address1"	=>	t._("Address 1"),
			"address2"	=>	t._("Address 2"),
			"zipCode"	=>	t._("Zip code"),
			"city"		=>	t._("City"),
			"birthDate"  =>	t._("Birth date"),
			"nationality" =>  t._("Nationality"),
			"countryOfResidence" =>  t._("Country of residence"),
			"rights"	=>	t._("Rights"),
			"cdate"		=>	t._("Registration date"),
			"flags"		=>	t._("Options"),
			"pass"		=>	t._("Password"),
		];
	}

	public function getAddress(){
		var str = new StringBuf();
		if (address1 != null) str.add(address1 + ", \n");
		if (address2 != null) str.add(address2 + ", \n");
		if (zipCode != null) str.add(zipCode);
		if (city != null) str.add(" - "+city);
		if(countryOfResidence != null) str.add(", "+countryOfResidence);
		return str.toString();
	}

	

	public function getUserVoiceInfos():{type:String,id:Int,name:String}{
		var infos = null;
		if(App.current.session.user.id==this.id){
			if(App.current.session.data.userVoiceInfos!=null){
				return App.current.session.data.userVoiceInfos;
			}
		}
		#if plugins
		var uc = pro.db.PUserCompany.manager.select($user==this);
		if(uc==null){
			var g  = this.getGroup();
			if(g==null) return null;
			infos = {
				type:"Administrateur de groupe",
				id:g.id,
				name:g.name
			};
		}else{			
			var vendor = uc.company.vendor;
			infos = {
				type:"Cagette Pro",
				id:vendor.id,
				name:vendor.name
			};
		}
		#end
		App.current.session.data.userVoiceInfos = infos;
		return infos;
	}
	
	
}
