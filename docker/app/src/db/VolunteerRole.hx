package db;
import sys.db.Object;
import sys.db.Types;
import Common;

class VolunteerRole extends Object
{
	public var id : SId;
	public var name : SString<64>;
	@:relation(groupId) public  var group : db.Group;
	@:relation(catalogId) 	public var catalog : SNull<db.Catalog>;

	public function isGenericRole():Bool{
		return catalog==null;
	}
}