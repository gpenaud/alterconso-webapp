package db;
import sys.db.Object;
import sys.db.Types;
import Common;


enum Right{
	GroupAdmin;					//can manage whole group
	ContractAdmin(?cid:Int);	//can manage one or all contracts
	Membership;					//can manage group members
	Messages;					//can send messages
}

/**
 * A user which is member of a group
 */
@:id(userId,groupId)
class UserGroup extends Object
{
	@:relation(groupId) public var group : db.Group;
	@:relation(userId) public var user : db.User;
	public var rights : SNull<SData<Array<Right>>>;		// rights in this group
	public var rights2 : SNull<SSmallText>; 
	public var balance : SFloat; 						//account balance in group currency
	public static var CACHE = new Map<String,db.UserGroup>();
	
	
	public function new(){
		super();
		balance = 0;
	}
	
	public static function get(user:User, group:db.Group, ?lock = false) {
		if (user == null || group == null) return null;
		//SPOD doesnt cache elements with double primary key, so lets do it manually
		var c = CACHE.get(user.id + "-" + group.id);
		if (c == null) {
			c = manager.select($user == user && $group == group, true/*lock*/);		
			CACHE.set(user.id + "-" + group.id,c);
		}
		return c;	
	}
	
	public static function getOrCreate(user:db.User, group:db.Group){
		var ua = get(user, group);
		if ( ua == null){
			ua = new UserGroup();
			ua.user = user;
			ua.group = group;
			ua.insert();
		}
		return ua;
	}
	
	/**
	 * give right and update DB
	 */
	public function giveRight(r:Right) {
	
		if (hasRight(r)) return;
		if (rights == null) rights = [];
		lock();
		rights.push(r);
		update();
		sync();
	}
		
	/**
	 * remove right and update DB
	 */
	public function removeRight(r:Right) {	
		if (rights == null) return;
		var newrights = [];
		for (right in rights.copy()) {
			if ( !Type.enumEq(right, r) ) {
				newrights.push(right);
			}
		}
		rights = newrights;
		update();
		sync();
	}
	
	public function hasRight(r:Right):Bool {
		if (this.user.isAdmin()) return true;
		if (rights == null) return false;
		for ( right in rights) {
			if ( Type.enumEq(r,right) ) return true;
		}
		return false;
	}
	
	public function getRightName(r:Right):String {
		var t = sugoi.i18n.Locale.texts;
		return switch(r) {
		case GroupAdmin 	: t._("Administrator");
		case Messages 		: t._("Messaging");
		case Membership 	: t._("Members management");
		case ContractAdmin(cid) : 
			if (cid == null) {
				t._("Management of all catalogs");
			}else {
				var c = db.Catalog.manager.get(cid);
				if(c==null) {
					t._("Deleted contract");	
				}else{
					t._("::name:: catalog management",{name:c.name});
				}
			}
		}
	}
	
	public function hasValidMembership():Bool {
		
		if (group.membershipRenewalDate == null) return false;
		var cotis = db.Membership.get(this.user, this.group, this.group.getMembershipYear());
		return cotis != null;
	}
	
	override public function insert(){		
		App.current.event(NewMember(this.user,this.group));
		super.insert();
	}
	
	public function getLastOperations(limit){
		return db.Operation.getLastOperations(user, group, limit);
	}

	public function isGroupManager() {
		return hasRight(Right.GroupAdmin);
	}

	public function canManageAllContracts(){
		if (rights == null) return false;
		for (r in rights) {
			switch(r) {
				case Right.ContractAdmin(cid):
					if(cid==null) return true;
				default:
			}
		}
		return false;			
	}

	/**
		sync old rights to new rights system
	**/
	public function sync(){
		lock();
		var r2 = new Array<{right:String,params:Array<String>}>();
		if(rights==null) return null;
		for(r in rights){
			switch(r){
				case ContractAdmin(cid):					
					r2.push({right:"CatalogAdmin",params:cid==null? null : [Std.string(cid)]});
				case GroupAdmin:
					r2.push({right:"GroupAdmin",params:null});
				case Membership:
					r2.push({right:"Membership",params:null});
				case Messages : 
					r2.push({right:"Messages",params:null});
			}
		}

		this.rights2 = haxe.Json.stringify(r2);
		update();
		return r2;
	}
	
}