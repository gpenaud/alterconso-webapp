package service;
import db.Group.RegOption;
import tink.core.Error;
import Common;

/**
 * User Service
 * @author fbarbut
 */
class UserService
{
	
	var user : db.User;
	
	public function new(u:db.User) 
	{
		this.user = u;		
	}
	
	/**
	 * User login service
	 * @param	email
	 * @param	password
	 */
	public static function login(email:String, password:String){
		
		var t  = sugoi.i18n.Locale.texts;
		
		//user exists ?
		var user = db.User.manager.select( $email == email || $email2 == email , true);
		if (user == null) throw new Error(404,t._("There is no account with this email"));

		//anti bruteforce
		if(service.UserService.isBanned()){
			throw new Error(403,t._("Since you failed to login more than 4 times, your IP address has been banned for 10 minutes."));		
		}
		
		//new account
		if (!user.isFullyRegistred()) {
			var group = user.getGroups()[0];
			user.sendInvitation(group);
			var text = t._("Your account have not been validated yet. We sent an e-mail to ::email:: to finalize your subscription!",{email:user.email});
			throw new Error(403,text);			
		}
		
		var pass = haxe.crypto.Md5.encode( App.config.get('key') + password );
		
		if (user.pass != pass) {
			service.UserService.recordBadLogin();
			throw new Error(403,t._("Invalid password"));
		}
		
		db.User.login(user, email);
		
		//register the user to the current group if needed
		var group = App.current.getCurrentGroup();	
		if (group != null && group.regOption == db.Group.RegOption.Open && db.UserGroup.get(user, group) == null){
			user.makeMemberOf(group);			
		}
		
		return user;
	}
	
	/**
		Full registration by a user himself
	**/
	public static function register(firstName:String, lastName:String, email:String, phone:String, pass:String,?address:String,?zipCode:String,?city:String){
		
		var t  = sugoi.i18n.Locale.texts;
		
		if (!sugoi.form.validators.EmailValidator.check(email)){
			throw new Error(500,t._("Invalid email address"));
		}
		
		if ( db.User.getSameEmail(email).length > 0 ) {
			throw new Error(409,t._("We already have an account with this email address"));
		}

		var user = new db.User();
		user.email = email;
		user.firstName = firstName;
		user.lastName = lastName;
		user.phone = phone;
		user.address1 = address;
		user.zipCode = zipCode;
		user.city = city;
		user.setPass(pass);
		user.insert();				
				
		var group = App.current.getCurrentGroup();	
		if (group != null && group.regOption == db.Group.RegOption.Open){
			user.makeMemberOf(group);	
		}
		if(group!=null){

			if(group.flags.has(PhoneRequired) && (phone==null || phone=="") ){
				throw new tink.core.Error(t._("Members of this group should provide a phone number"));
			}

			if(group.flags.has(AddressRequired) && (address==null || address=="" || zipCode==null || zipCode=="" || city==null || city=="") ){
				throw new tink.core.Error(t._("Members of this group should provide an address"));
			}

		}
		
		db.User.login(user, email);		
	}

	/**
		Soft registration : 
		- Somebody creates/import a new user , 
		- or pre-registration in a waiting list
	**/
	public static function softRegistration(firstName:String, lastName:String, email:String){
		
		var t  = sugoi.i18n.Locale.texts;
		
		if (!sugoi.form.validators.EmailValidator.check(email)){
			throw new Error(500,t._("Invalid email address")+" : "+email);
		}
		
		if ( db.User.getSameEmail(email).length > 0 ) {
			throw new Error(409,t._("We already have an account with this email address"));
		}

		var user = new db.User();
		user.email = email;
		user.firstName = firstName;
		user.lastName = lastName;
		user.insert();				

		return user;
	}

	public static function getOrCreate(firstName:String, lastName:String, email:String):db.User{

		var t  = sugoi.i18n.Locale.texts;
		
		if (!sugoi.form.validators.EmailValidator.check(email)){
			throw new Error(500,t._("Invalid email address")+" : "+email);
		}

		var u = db.User.manager.select($email == email || $email2 == email, true);
		if (u == null){
			u = new db.User();
			u.firstName = firstName;
			u.lastName = lastName;
			u.email = email;			
			u.insert();
		}
		return u;
	}

	public static function getByEmail(email:String):db.User{
		return db.User.manager.select($email == email || $email2 == email, true);
	}

	/**
	 *  get users belonging to a group
	 *  @param group - 
	 *  @return Array<db.User>
	 */
	public static function getFromGroup(group:db.Group):Array<db.User>{
		return Lambda.array( group.getMembers() );
	}

	public static function isBanned(){		
		var ip = sugoi.Web.getClientIP();
		var badTries:Int = sugoi.db.Cache.get("ip-ban-"+ip);
		if(badTries==null) return false;
		if(badTries>=5) return true;
		return false;
	}

	public static function recordBadLogin(){
		var ip = sugoi.Web.getClientIP();
		var badTries:Int = sugoi.db.Cache.get("ip-ban-"+ip);
		if(badTries==null) badTries = 0;
		sugoi.db.Cache.set("ip-ban-"+ip,badTries+1, 60 * 10);
	}

	/**
	 *  Checks that the user is at least 18 years old
	 *  @param birthday - 
	 *  @return Bool
	 */
	public static function isBirthdayValid(birthday:Date): Bool {
		if(birthday==null) return true;
		//Check that the user is at least 18 years old
		return birthday.getTime() < DateTools.delta(Date.now(), -1000*60*60*24*365.25*18).getTime()	? true : false;	
	}

	public static function prepareLoginBoxOptions(view:Dynamic,?group:db.Group){
		if(group==null) group = App.current.getCurrentGroup();
		var loginBoxOptions : Dynamic = {};
		if(group==null || group.flags==null){
			view.loginBoxOptions = {};
			return;
		} 
		if(group.flags.has(PhoneRequired)) loginBoxOptions.phoneRequired = true;
		if(group.flags.has(AddressRequired)) loginBoxOptions.addressRequired = true;
		view.loginBoxOptions = loginBoxOptions;
	}

	public static function getUserLists(group:db.Group):Array<UserList>{
		var membersNum = group.getMembersNum();
		
		var lists = [
			{id:"all",			name:"Membres du groupe", 			count:membersNum	},
			{id:"hasOrders",	name:"Avec commande",				count:null		},
			{id:"hasNoOrders",	name:"Sans commande",				count:null		},
			{id:"newUsers",		name:"Ne s'est jamais connecté",	count:null		},
		];

		if(group.hasMembership){
			var ms = new service.MembershipService(group);
			var upToDateMemberships = ms.countUpToDateMemberships();
			lists.push({id:"noMembership",	name:"Adhésion à renouveler",	count:membersNum-upToDateMemberships});
			lists.push({id:"membership",	name:"Adhésion à jour",			count:upToDateMemberships	});
		}
		
		//if(group.regOption == RegOption.WaitingList){
			lists.push({id:"waitingList",	name:"Liste d'attente",			count:service.WaitingListService.countUsersInWl(group)	});
		//}

		return lists;
	}

	/*public static function getListBrowseFunction(listId:String){
		switch(listId){
			case "allUsers" : 


		}
	}*/

	
}