package db;
import sys.db.Types;
import Common;

class Category extends sys.db.Object
{
	public var id : SId;
	public var name :SString<128>;

	@:relation(categoryGroupId) public var categoryGroup:db.CategoryGroup;
	
	/**
	 * get category color in hexa
	 */
	public function getColor():String {
		return Formatting.intToHex(db.CategoryGroup.COLORS[categoryGroup.color]);
	}
	
	public function infos():CategoryInfo{
		return {id:id, name:name, /*parent:categoryGroup.id, /*pinned:categoryGroup.pinned*/};
	}
}