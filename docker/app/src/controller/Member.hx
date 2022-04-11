package controller;
import service.SubscriptionService;
import haxe.macro.Expr.Catch;
import payment.Check;
import service.WaitingListService;
import db.Catalog;
import service.OrderService;
import db.MultiDistrib;
import Common;
import haxe.Utf8;
import sugoi.form.Form;
import sugoi.form.elements.Selectbox;
import sugoi.form.validators.EmailValidator;
import sugoi.tools.Utils;


class Member extends Controller
{

	public function new()
	{
		super();
		if (!app.user.canAccessMembership()) throw Redirect("/");
	}
	
	@logged
	@tpl('member/default.mtt')
	function doDefault(?args: { ?search:String, ?list:String } ) {
		checkToken();
		
		var browse:Int->Int->Iterable<Dynamic>;
		var uids = db.UserGroup.manager.search($group == app.user.getGroup(), false);
		var uids = Lambda.map(uids, function(ua) return ua.user.id);
		if (args != null && args.search != null) {
			
			//SEARCH			
			browse = function(index:Int, limit:Int) {
				var search = "%"+StringTools.trim(args.search)+"%";
				return db.User.manager.search( 
					($lastName.like(search) ||
					$lastName2.like(search) || 
					$address1.like(search) ||
					$address2.like(search) ||
					$firstName.like(search) ||
					$firstName2.like(search)					
					) && $id in uids , { orderBy:-id }, false);
			}
			view.search = args.search;
			
		}else{
			
			//SELECTION
			
			switch(args.list) {
				case "hasNoOrders":
					if (app.params.exists("csv")) {
						sugoi.tools.Csv.printCsvDataFromObjects(Lambda.array(db.User.getUsers_NoContracts()), ["firstName", "lastName", "email"], t._("Without contracts"));
						return;
					}else {
						browse = function(index:Int, limit:Int) { return db.User.getUsers_NoContracts(index, limit); }	
					}
				case "hasOrders":
					
					if (app.params.exists("csv")) {
						sugoi.tools.Csv.printCsvDataFromObjects(Lambda.array(db.User.getUsers_Contracts()), ["firstName", "lastName", "email"], t._("With orders"));
						return;
					}else {
						browse = function(index:Int, limit:Int) { return db.User.getUsers_Contracts(index, limit); }	
					}
					
				case "noMembership" :
					var ms = new service.MembershipService(app.user.getGroup());
					if (app.params.exists("csv")) {
						sugoi.tools.Csv.printCsvDataFromObjects( ms.getNoMembershipUsers(), ["firstName", "lastName", "email"], t._("Memberships to be renewed"));
						return;
					}else {
						browse = ms.getNoMembershipUsers;
					}
				case "membership" :
					var ms = new service.MembershipService(app.user.getGroup());
					if (app.params.exists("csv")) {
						sugoi.tools.Csv.printCsvDataFromObjects( ms.getMembershipUsers() , ["firstName", "lastName", "email"], "Adhérents à jour" );
						return;
					}else {
						browse = ms.getMembershipUsers;
					}

				case "waitingList" :
					throw Redirect("/member/waiting");

				case "newUsers" :
					if (app.params.exists("csv")) {
						sugoi.tools.Csv.printCsvDataFromObjects(Lambda.array(db.User.getUsers_NewUsers()), ["firstName", "lastName", "email"], t._("Never connected"));
						return;
					}else {
						browse = function(index:Int, limit:Int) { return db.User.getUsers_NewUsers(index, limit); }
					}
				default:
					//all users
					if (app.params.exists("csv")) {
						var headers = ["id","firstName", "lastName", "email","phone", "firstName2", "lastName2","email2","phone2", "address1","address2","zipCode","city"];
						sugoi.tools.Csv.printCsvDataFromObjects(Lambda.array(db.User.manager.search( $id in uids, {orderBy:lastName}, false)), headers, t._("Members"));
						return;
					}else {
						browse = function(index:Int, limit:Int) {
							return db.User.manager.search( $id in uids, { limit:[index,limit], orderBy:lastName }, false);
						}
					}
			}
			view.list = args.list;
			
		}
		
		var count = uids.length;
		var rb = new sugoi.tools.ResultsBrowser(count, (args.list!=null||args.search!=null)?1000:10, browse);
		view.members = rb;
		
		var userLists = service.UserService.getUserLists(app.user.getGroup());
		view.userLists = userLists;
		view.getListName = function(listId){
			var list = Lambda.find(userLists, l -> return l.id==listId );
			return list==null ? "Liste inconnue" : list.name;
		}
		
	}
	
	/**
	 * Move to waiting list
	 */
	function doMovetowl(u:db.User){
		try{
			WaitingListService.moveBackToWl(u,app.user.getGroup(),"Remis en liste d'attente par "+app.user.getName());
		}catch(e:tink.core.Error){
			throw Error("/member/view/"+u.id, e.message );
		}
		
		throw Ok("/member", u.getName() +" "+ t._("is now on waiting list.") );
	}
	
	/**
	 * Display waiting list
	 */
	@tpl('member/waiting.mtt')
	function doWaiting(?args:{?add:db.User,?remove:db.User}){
		
		if (args != null){
			if (args.add != null){
				
				service.WaitingListService.approveRequest(args.add,app.user.getGroup());
				throw Ok("/member/waiting", t._("Membership request accepted") );
				
			}else if (args.remove != null){
				
				service.WaitingListService.cancelRequest(args.remove,app.user.getGroup());
				throw Ok("/member/waiting", t._("Membership request refused") );
				
			}
		}
		
		view.waitingList = db.WaitingList.manager.search($group == app.user.getGroup(),{orderBy:-date});
	}

	/**
		Batch actions on members
	**/
	function doBatch(){
		if(!app.user.canAccessMembership()) throw "Forbidden";

		var action = "";
		var value = "";
		for( k => v in app.params){
			action = k;
			value = v;
			break;
		}
		var users = value.split("|").map(id -> return db.User.manager.get(id.parseInt()));
		
		var msg = [];
		var group = app.user.getGroup();
		var count = 0;
		switch (action){
			case "waitingList" :
				users.remove(app.user);//do not cut my hands				
				for( u in users){
					count++;
					try{
						WaitingListService.moveBackToWl(u,group,"Mis en liste d'attente par "+app.user.getName()+" le "+Formatting.hDate(Date.now()));
					}catch(e:tink.core.Error){
						count--;
						msg.push("Erreur : "+e.message);
					}
				}
				msg.push("Vous avez placé "+count+" membres en liste d'attente.");

			case "exclude" : 
				users.remove(app.user);//do not cut my hands
				for( u in users){
					var ug = u.getUserGroup(group);
					if(ug!=null){
						ug.lock();
						ug.delete();
					}
				}
				msg.push("Vous avez retiré "+users.length+" membres du groupe.");

			case "membership" :
				var ms = new service.MembershipService(app.user.getGroup());
				var now = Date.now();
				for( u in users){
					count++;
					try{
						ms.createMembership(u,now.getFullYear(),now,null,Check.TYPE);
					}catch(e:tink.core.Error){
						count--;
						msg.push("Erreur : "+e.message);
					}
				}
				msg.push("Vous avez saisi "+count+" cotisations.");
				

			default : throw "Unknown action";
		}

		throw Ok("/member",msg.join("<br/>"));
	}
	
	/**
	 * Send an invitation to a new member
	 */
	function doInviteMember(u:db.User){
		
		if (checkToken() ) {
			u.sendInvitation(app.user.getGroup());
			throw Ok('/member/view/'+u.id, t._("Invitation sent.") );
		}
		
	}
	
	/**
	 * Invite 'never logged' users
	 */
	function doInvite() {
		
		if (checkToken()) {
			
			var users = db.User.getUsers_NewUsers();
			try{
				for ( u in users) {
					u.sendInvitation(app.user.getGroup());
					Sys.sleep(0.2);
				}
			}catch (e:String){
				if (e.indexOf("curl") >-1) {
					App.current.logError(e, haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
					throw Error("/member", t._("An error occurred while sending emails, please retry"));
				}
			}
			
			throw Ok('/member', t._("Congratulations, you just sent <b>::userLength::</b> invitations", {userLength:users.length}));
		}
		
	}
	
	
	@tpl("member/view.mtt")
	function doView(member:db.User) {
		
		view.member = member;
		var userGroup = db.UserGroup.get(member, app.user.getGroup());
		if (userGroup == null) throw Error("/member", t._("This person does not belong to your group"));
		
		view.userGroup = userGroup; 
		view.canLoginAs = (db.UserGroup.manager.count($userId == member.id) == 1 && app.user.isAmapManager()) || app.user.isAdmin(); 
		
		/*
		//orders
		var row = {constOrders:new Array<UserOrder>(), varOrders:{distribution:null,orders:new Array<UserOrder>>()};
			
		//CSA orders
		var contracts = db.Catalog.manager.search($type == db.Catalog.TYPE_CONSTORDERS && $group == app.user.getGroup() && $endDate > DateTools.delta(Date.now(),-1000.0*60*60*24*30), false);
		var orders = member.getOrdersFromContracts(contracts);
		row.constOrders = service.OrderService.prepare(orders);
		
		//commandes variables groupées par date de distrib
		var contracts = db.Catalog.manager.search($type == db.Catalog.TYPE_VARORDER && $group == app.user.getGroup() && $endDate > DateTools.delta(Date.now(),-1000.0*60*60*24*30), false);
		var distribs = new Map<String,List<db.UserOrder>>();
		for (c in contracts) {
			var ds = c.getDistribs();
			for (d in ds) {
				var k = d.date.toString().substr(0, 10);
				var orders = member.getOrdersFromDistrib(d);
				if (orders.length > 0) {
					if (!distribs.exists(k)) {
						distribs.set(k, orders);
					}else {
						
						var v = distribs.get(k);
						for ( o in orders  ) v.add(o);
						distribs.set(k, v);
					}	
				}
			}
		}
		for ( k in distribs.keys()){
			var d = distribs.get(k);
			var d2 = service.OrderService.prepare(d);
			row.varOrders.set(k,d2);
		}
		
		
		view.userContracts = row;
		*/

		var now = Date.now();
		var from = new Date(now.getFullYear(), now.getMonth(), now.getDate()-7, 0, 0, 0);
		var to = DateTools.delta(from, 1000.0 * 60 * 60 * 24 * 28 * 3);
		var timeframe = new tools.Timeframe(from,to);
		var distribs = db.MultiDistrib.getFromTimeRange(app.user.getGroup(),timeframe.from,timeframe.to);

		//variable orders
		view.distribs = distribs;
		view.getUserOrders = function(md:db.MultiDistrib){
			return OrderService.prepare(md.getUserOrders(member,db.Catalog.TYPE_VARORDER));
		}

		//const orders subscriptions
		view.subscriptionService = service.SubscriptionService;
		view.subscriptionsByCatalog = SubscriptionService.getUserActiveSubscriptionsByCatalog(member,app.user.getGroup());

		checkToken(); //to insert a token in tpl
	}	
	
	/**
	 * Admin : Log in as this user for debugging purpose
	 * @param	user
	 * @param	amap
	 */	
	function doLoginas(member:db.User, amap:db.Group) {
	
		if (!app.user.isAdmin()){
			if (!app.user.isAmapManager()) return;
			if (member.isAdmin()) return;
			if ( db.UserGroup.manager.count($userId == member.id) > 1 ) return;
			
		}
		
		App.current.session.setUser(member);
		App.current.session.data.amapId = amap.id;
		throw Redirect("/member/view/" + member.id );
	}
	
	@tpl('member/lastMessages.mtt')
	function doLastMessages(member:db.User){
		
		var out = new Array<{date:Date,subject:String,success:String,failure:String}>();
		var threeMonth = DateTools.delta(Date.now(), -1000.0 * 60 * 60 * 24 * 30.5 * 3);
		
		for ( m in sugoi.db.BufferedMail.manager.search($remoteId == app.user.getGroup().id && $cdate > threeMonth, {limit:10, orderBy:-cdate})){
			
			var status : sugoi.mail.IMailer.MailerResult = m.status;
			
			if ( status!=null && status.get(member.email)!=null ){
				
				var r = m.getMailerResultMessage(member.email);
				out.push( {date:m.cdate,subject:m.title,success:r.success,failure:r.failure} );	
			}
			
		}
		view.emails = out;
	}
	
	/**
	 * Edit a Member
	 */
	@tpl('form.mtt')
	function doEdit(member:db.User) {
		
		if (member.isAdmin() && !app.user.isAdmin()) throw Error("/", t._("You cannot modify the account of an administrator"));
		
		var form = db.User.getForm(member);
		
		
		var isReg = member.isFullyRegistred();
		var groupNum = db.UserGroup.manager.count($userId == member.id);
		
		//an administrator can modify a user's email only if he's not member elsewhere
		if (groupNum > 1){			
			form.removeElementByName("email");
			form.removeElementByName("email2");
			app.session.addMessage(t._("For security reasons, you cannot modify the e-mail of this person because this person is a member of more than 1 group."));
		}
		
		//an administrator can modify a user's pass only if he's a not registred user.
		if (!isReg){
			app.session.addMessage(t._("This person did not define yet a password. You are exceptionaly authorized to do it. Please don't forget to tell this person."));
			//form.getElement("pass").required = false;
			form.addElement(new sugoi.form.elements.StringInput("pass",t._("Password")));
		}else{
			form.removeElement( form.getElement("pass") );
		}
		
		if (form.checkToken()) {
			
			if (app.user.getGroup().flags.has(db.Group.GroupFlags.PhoneRequired) && form.getValueOf("phone") == null ){
				throw Error("/member/edit/"+member.id, t._("Phone number is required in this group."));
			}
			
			form.toSpod(member); 

			//check that the given emails are not already used elsewhere
			var sim = db.User.getSameEmail(member.email,member.email2);
			for ( s in sim) {				
				if (s.id == member.id) sim.remove(s);
			}
			if (sim.length > 0) {
				
				//Let's merge the 2 users if it has no orders.
				var id = sim.first().id;
				if (db.UserOrder.manager.search( $userId == id || $userId2 == id , false).length == 0) {
					//merge
					member.merge( sim.first() );
					app.session.addMessage(t._("This e-mail was used by another user account. As this user account was not used, it has been merged into the current user account."));
					
				} else {
					var str = t._("Warning, this e-mail or this name already exists for another account : ");
					str += Lambda.map(sim, function(u) return "<a href='/member/view/" + u.id + "'>" + u.getCoupleName() + "</a>").join(",");
					str += " "+t._("These accounts can't be merged because the second account has orders");
					throw Error("/member/edit/" + member.id, str);	
				}
			}	
			
			if (!isReg) member.setPass(form.getValueOf("pass"));
			
			member.update();
			
			if (!App.config.DEBUG && groupNum == 1) {
				
				//warn the user that his email has been updated
				if (form.getValueOf("email") != member.email) {
					var m = new sugoi.mail.Mail();
					m.setSender(App.config.get("default_email"), t._("Cagette.net"));
					m.addRecipient(member.email);
					m.setSubject(t._("Change your e-mail in your account Cagette.net"));
					m.setHtmlBody( app.processTemplate("mail/message.mtt", { text:app.user.getName() + t._(" just modified your e-mail in your account Cagette.net.<br/>Your e-mail is now:")+form.getValueOf("email")  } ) );
					App.sendMail(m);
					
				}
				if (form.getValueOf("email2") != member.email2 && member.email2!=null) {
					var m = new sugoi.mail.Mail();
					m.setSender(App.config.get("default_email"),"Cagette.net");
					m.addRecipient(member.email2);
					m.setSubject(t._("Change the e-mail of your account Cagette.net"));
					m.setHtmlBody( app.processTemplate("mail/message.mtt", { text:app.user.getName() +t._(" just modified your e-mail in your account Cagette.net.<br/>Your e-mail is now:")+form.getValueOf("email2")  } ) );
					App.sendMail(m);
				}	
			}
			
			throw Ok('/member/view/'+member.id, t._("This member has beed updated"));
		}
		
		view.form = form;
		
	}
	
	/**
	 * Remove a user from this group
	 */
	function doDelete(user:db.User,?args:{confirm:Bool,token:String}) {
		
		if (checkToken()) {
			if (!app.user.canAccessMembership()) throw t._("You cannot do that.");
			if (user.id == app.user.id) throw Error("/member/view/" + user.id, t._("You cannot delete yourself."));
			if ( Lambda.count(user.getOrders(app.user.getGroup()),function(x) return x.quantity>0) > 0 && !args.confirm) {
				throw Error("/member/view/"+user.id, t._("Warning, this account has orders. <a class='btn btn-default btn-xs' href='/member/delete/::userid::?token=::argstoken::&confirm=1'>Remove anyway</a>", {userid:user.id, argstoken:args.token}));
			}
		
			var ua = db.UserGroup.get(user, app.user.getGroup(), true);
			if (ua != null) {
				ua.delete();
				throw Ok("/member", t._("::user:: has been removed from your group",{user:user.getName()}));
			}else {
				throw Error("/member", t._("This person does not belong to \"::amapname::\"", {amapname:app.user.getGroup().name}));
			}	
		}else {
			throw Redirect("/member/view/"+user.id);
		}
	}
	
	@tpl('form.mtt')
	function doMerge(user:db.User) {
		
		if (!app.user.canAccessMembership()) throw Error("/","Action interdite");
		
		view.title = t._("Merge an account with another one");
		view.text = t._("This action allows you to merge two accounts (when you have duplicates in the database for example).<br/>Orders of account 2 will be moved to account 1, and account 2 will be deleted. Warning, it is not possible to cancel this action.");
		
		var form = new Form("merge");
		
		var members = app.user.getGroup().getMembers();
		var members = Lambda.array(Lambda.map(members, function(x) return { key:Std.string(x.id), value:x.getName() } ));
		var mlist = new Selectbox("member1", t._("Account 1"), members, Std.string(user.id));
		form.addElement( mlist );
		var mlist = new Selectbox("member2", t._("Account 2"), members);
		form.addElement( mlist );
		
		if (form.checkToken()) {
		
			var m1 = Std.parseInt(form.getElement("member1").value);
			var m2 = Std.parseInt(form.getElement("member2").value);
			var m1 = db.User.manager.get(m1,true);
			var m2 = db.User.manager.get(m2,true);
			
			//if (m1.amapId != m2.amapId) throw "ils ne sont pas de la même amap !";
			
			//on prend tout à m2 pour donner à m1			
			//change usercontracts
			var contracts = db.UserOrder.manager.search($user==m2 || $user2==m2,true);
			for (c in contracts) {
				if (c.user.id == m2.id) c.user = m1;
				if (c.user2!=null && c.user2.id == m2.id) c.user2 = m1;
				c.update();
			}
			
			//group memberships
			var adh = db.UserGroup.manager.search($user == m2, true);
			for ( a in adh) {
				a.user = m1;
				a.update();
			}
			
			//change contacts
			var contacts = db.Catalog.manager.search($contact==m2,true);
			for (c in contacts) {
				c.contact = m1;
				c.update();
			}
			//if (m2.amap.contact == m2) {
				//m1.amap.lock();
				//m1.amap.contact = m1;
				//m1.amap.update();
			//}
			
			m2.delete();
			
			throw Ok("/member/view/" + m1.id, t._("Both accounts have been merged"));
			
			
		}
		
		view.form = form;
		
	}
	
	
	@tpl('member/import.mtt')
	function doImport(?args: { confirm:Bool } ) {
		
		var step = 1;
		var request = Utils.getMultipart(1024 * 1024 * 4); //4mb
		
		//on recupere le contenu de l'upload
		var data = request.get("file");
		if ( data != null) {
			
			var csv = new sugoi.tools.Csv();
			csv.setHeaders([t._("Firstname"), t._("Lastname"), t._("E-mail"), t._("Mobile phone"), t._("Partner's firstname"), t._("Partner's lastname"), t._("Partner's e-mail"), t._("Partner's Mobile phone"), t._("Address 1"), t._("Address 2"), t._("Post code"), t._("City")]);
			
			//utf8 encode if needed
			data = Formatting.utf8(data);
			var unregistred = csv.importDatas(data);
			
			/*var checkEmail = function(email){
				if ( !sugoi.form.validators.EmailValidator.check(email) ) {
					throw Error("/member", t._("The email <b>::email::</b> is invalid, please update your CSV file",{email:email}) );
				}
			}*/

			//cleaning
			for ( user in unregistred.copy() ) {
				
				//check nom+prenom
				if (user[0] == null || user[1] == null) {
					throw Error("/member/import", t._("You must fill the name and the firstname of the person. This line is incomplete: ") + user);
				}
				if (user[2] == null) {
					throw Error("/member/import", t._("Each person must have an e-mail to be able to log in. ::user0:: ::user1:: don't have one. ", {user0:user[0], user1:user[1]}) +user);
				}
				//uppercase du nom
				if (user[1] != null) user[1] = user[1].toUpperCase();
				if (user[5] != null) user[5] = user[5].toUpperCase();
				//lowercase email
				if (user[2] != null){
					user[2] = user[2].toLowerCase();
					//checkEmail(user[2]);
				} 
				if (user[6] != null){
					user[6] = user[6].toLowerCase();
					//checkEmail(user[6]);
				} 
			}
			
			//utf-8 check
			for ( row in unregistred.copy()) {
				
				for ( i in 0...row.length) {
					var t = row[i];
					if (t != "" && t != null) {
						row[i] = t;
					}
				}
			}
			
			//put already registered people in another list
			var registred = [];
			for (r in unregistred.copy()) {
				//var firstName = r[0];
				//var lastName = r[1];
				var email = r[2];

				//var firstName2 = r[4];
				//var lastName2 = r[5];
				var email2 = r[6];
				
				var us = db.User.getSameEmail(email, email2);
				
				if (us.length > 0) {
					unregistred.remove(r);
					registred.push(r);
				}
			}
			
			
			app.session.data.csvUnregistered = unregistred;
			app.session.data.csvRegistered = registred;
			
			view.data = unregistred;
			view.data2 = registred;
			step = 2;
		}
		
		
		if (args != null && args.confirm) {
			
			//import unregistered members
			var i : Iterable<Dynamic> = cast app.session.data.csvUnregistered;
			for (u in i) {
				if (u[0] == null || u[0] == "null" || u[0] == "") continue;
								
				var user = new db.User();
				user.firstName = u[0];
				user.lastName = u[1];
				user.email = u[2];
				if (user.email != null && user.email != "null" &&!EmailValidator.check(user.email)) {
					throw t._("The E-mail ::useremail:: is invalid, please modify your file", {useremail:user.email});
				}
				user.phone = u[3];
				
				user.firstName2 = u[4];
				user.lastName2 = u[5];
				user.email2 = u[6];
				if (user.email2 != null && user.email2 != "null" && !EmailValidator.check(user.email2)) {
					App.log(u);
					throw t._("The E-mail of the partner of ::userFirstName:: ::userLastName:: '::userEmail::' is invalid, please check your file", {userFirstName:user.firstName, userLastName:user.lastName, userEmail:user.email2});
				}
				user.phone2 = u[7];				
				user.address1 = u[8];
				user.address2 = u[9];
				user.zipCode = u[10];
				user.city = u[11];				
				user.insert();
				
				var ua = new db.UserGroup();
				ua.user = user;
				ua.group = app.user.getGroup();
				ua.insert();
			}
			
			//import registered members
			var i : Iterable<Array<String>> = cast app.session.data.csvRegistered;
			for (u in i) {
				var email = u[2];
				var email2 = u[6];
				
				var us = db.User.getSameEmail(email, email2);
				var userAmaps = db.UserGroup.manager.search($group == app.user.getGroup() && $userId in Lambda.map(us, function(u) return u.id), false);
				
				//member exists but is not member of this group.
				if (userAmaps.length == 0) {					
					var ua = new db.UserGroup();
					ua.user = us.first();
					ua.group = app.user.getGroup();
					ua.insert();
				}
			}
			
			view.numImported = app.session.data.csvUnregistered.length + app.session.data.csvRegistered.length;
			app.session.data.csvUnregistered = null;
			app.session.data.csvRegistered = null;
			
			step = 3;
		}
		
		if (step == 1) {
			//reset import when back to import page
			app.session.data.csvUnregistered = null;
			app.session.data.csvRegistered = null;
		}
		
		view.step = step;
	}
	
	@tpl("user/insert.mtt")
	public function doInsert() {
		
		if (!app.user.canAccessMembership()) throw Error("/", t._("Forbidden action"));
		
		var m = new db.User();
		var form = db.User.getForm(m);
		form.addElement(new sugoi.form.elements.Checkbox("warnAmapManager", t._("Send an E-mail to the person in charge of the group"), true));
		form.getElement("email").addValidator(new EmailValidator());
		form.getElement("email2").addValidator(new EmailValidator());
		
		if (form.isValid()) {
			
			//check doublon de User et de UserAmap
			var userSims = db.User.getSameEmail(form.getValueOf("email"),form.getValueOf("email2"));
			view.userSims = userSims;
			var userAmaps = db.UserGroup.manager.search($group == app.user.getGroup() && $userId in Lambda.map(userSims, function(u) return u.id), false);
			view.userAmaps = userAmaps;
			
			if (userAmaps.length > 0) {
				//user deja enregistré dans cette amap
				throw Error('/member/view/' + userAmaps.first().user.id, t._("This person is already member of this group"));
				
			}else if (userSims.length > 0) {
				//des users existent avec ce nom , 
				//if (userSims.length == 1) {
					// si yen a qu'un on l'inserte
					var ua = new db.UserGroup();
					ua.user = userSims.first();
					ua.group = app.user.getGroup();
					ua.insert();	
					throw Ok('/member/', t._("This person already had an account on Cagette.net, and is now member of your group."));
				/*}else {
					//demander validation avant d'inserer le userAmap
					//TODO
					throw Error('/member', t._("Not possible to add this person because there are already some people in the database having the same firstname and name. Please contact the administrator.")+userSims);
				}*/
				return;
			}else {
				
				if (app.user.getGroup().flags.has(db.Group.GroupFlags.PhoneRequired) && form.getValueOf("phone") == null ){
					throw Error("/member/insert", t._("Phone number is required in this group."));
				}
				
				//insert user
				var u = new db.User();
				form.toSpod(u); 
				u.lang = app.user.lang;
				u.insert();
				
				//insert userAmap
				var ua = new db.UserGroup();
				ua.user = u;
				ua.group = app.user.getGroup();
				ua.insert();	
				
				if (form.getValueOf("warnAmapManager") == "1") {
					var url = "http://" + App.config.HOST + "/member/view/" + u.id;
					var text = t._("::admin:: just keyed-in contact details of a new member: <br/><strong>::newMember::</strong><br/> <a href='::url::'>See contact details</a>",{admin:app.user.getName(),newMember:u.getCoupleName(),url:url});
					App.quickMail(
						app.user.getGroup().contact.email,
						app.user.getGroup().name +" - "+ t._("New member") + " : " + u.getCoupleName(),
						app.processTemplate("mail/message.mtt", { text:text } ) 
					);
				}
				
				throw Ok('/member/', t._("This person is now member of the group"));
				
			}
		}
		
		view.form = form;
	}
	
	
	/**
	 * user payments history
	 */
	@tpl('member/payments.mtt')
	function doPayments(m:db.User){
		
		service.PaymentService.updateUserBalance(m, app.user.getGroup());		
       var browse:Int->Int->List<Dynamic>;
		
		//default display
		browse = function(index:Int, limit:Int) {
			return db.Operation.getOperationsWithIndex(m,app.user.getGroup(),index,limit,true);
		}
		
		var count = db.Operation.countOperations(m,app.user.getGroup());
		var rb = new sugoi.tools.ResultsBrowser(count, 10, browse);
		view.rb = rb;
		view.member = m;
		view.balance = db.UserGroup.get(m, app.user.getGroup()).balance;
		
		checkToken();
	}
	
	@tpl('member/balance.mtt')
	function doBalance(){
		view.balanced = db.UserGroup.manager.search($group == app.user.getGroup() && $balance == 0.0, false);
		view.credit = db.UserGroup.manager.search($group == app.user.getGroup() && $balance > 0, false);
		view.debt = db.UserGroup.manager.search($group == app.user.getGroup() && $balance < 0, false);
	}

	/**
		invoice for user
	**/
	@tpl('member/invoice.mtt')
	function doInvoice(m:db.User,md:db.MultiDistrib){
		
		//orders grouped by vendors
		var orders = service.OrderService.prepare(md.getUserOrders(m));
		var ordersByVendors = new Map<Int,Array<UserOrder>>();
		for( o in orders) {
			var or = ordersByVendors.get(o.product.vendorId);
			if(or==null) or = [];
			or.push(o);
			ordersByVendors.set(o.product.vendorId,or);
		}

		//grouped by VAT
		var ordersByVat = new Map<Int,{ht:Float,ttc:Float}>();
		for( o in orders){
			var key = Math.round(o.product.vat*100);
			if(ordersByVat[key]==null) ordersByVat[key] = {ht:0.0,ttc:0.0};
			var total = o.quantity * o.productPrice;
			ordersByVat[key].ttc += total;
			ordersByVat[key].ht += (total/(1+o.product.vat/100));
		}
		view.ordersByVat = ordersByVat;

		var basket = md.getUserBasket(m);
		var paymentOps = basket.getPaymentsOperations();

		view.member = m;
		view.ordersByVendors = ordersByVendors;
		view.md = md;
		view.getVendor = function(id) return db.Vendor.manager.get(id,false);
		view.paymentOps = paymentOps;


	}


	
}