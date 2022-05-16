package db;
import sys.db.Object;
import sys.db.Types;
import Common;

@:id(userId, multiDistribId,volunteerRoleId)
class Volunteer extends Object
{
	@:relation(userId) public var user : db.User;
	@:relation(multiDistribId) public var multiDistrib : db.MultiDistrib;
	@:relation(volunteerRoleId) public var volunteerRole : db.VolunteerRole;

	/**
		key to replace primary key 
	**/
	public function key():String{
		return user.id+'-'+multiDistrib.id+'-'+volunteerRole.id;
	}
}