package db;
import sys.db.Types;


class CategoryGroup extends sys.db.Object
{
	public var id : SId;
	public var name : SString<128>;
	public var color : STinyInt; //color id
	public var pinned : SBool; //if true, the products tagged with these categories will be pinned on top of the shop.
	
	@:relation(amapId) public  var amap:db.Group;
	
	@:skip public static var COLORS = [
		0x7BAD1C, //vert clair
		0x007700, //vert foncé
		0x583816, //marron
		0xD97801, //orange carotte
		0xB1933D, //sable
		0xC91F25, //rouge
		0x6F0D2E, //vin
		0x616161, //gris
	];
	
	public function new(){
		super();
		pinned = false;
		color = 7;
	}
	
	public function getCategories() {
		return db.Category.manager.search($categoryGroup == this, false);
	}
	
	public static function get(amap:db.Group):List<CategoryGroup> {
		return manager.search($amap == amap, false);
	}
	
	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"name" 				=> t._("Category group name"),
			"pinned" 			=> t._("Pinned on top"),
			"color" 			=> t._("Color"),			
		];
	}
}