package db;
import sys.db.Object;
import sys.db.Types;


@:id(userId,amapId)
class WaitingList extends Object
{
	@:relation(amapId) public var group : db.Group;	
	@:relation(userId) public var user : db.User;
	public var date : SDateTime;
	public var message : SText;
	
	public function new(){
		super();
		message = "";
		date = Date.now();		
	}
	
}