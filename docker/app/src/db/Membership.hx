package db;
import sys.db.Object;
import sys.db.Types;

@:id(userId,groupId,year)
class Membership extends Object
{
	@:relation(groupId) public var group : db.Group;
	@:relation(userId) public var user : db.User;
	@:relation(distributionId) public var distribution : SNull<MultiDistrib>;
	@:relation(operationId) public var operation : SNull<Operation>; //membership debt operation
	
	public var amount : SFloat; //membership cost
	public var year : Int; //année de cotisation (année la plus ancienne si a cheval sur deux années : 2014-2015  -> 2014)
	public var date : SNull<SDate>;
	
	public static function get(user:User, group:db.Group,year:Int, ?lock = false) {
		return manager.select($user == user && $group == group && $year == year, lock);
	}	
		
}