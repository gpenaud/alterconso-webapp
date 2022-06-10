package db;
import sys.db.Object;
import sys.db.Types;
import Common;

/**
 * Category
 * @author fbarbut
 */
class TxpCategory extends Object
{

	public var id : SId;
	public var image : Null<SString<64>>;
	public var displayOrder : STinyInt;
	public var name : SString<128>;	
	
	public function getSubCategories(){
		return db.TxpSubCategory.manager.search($category == this, false);
	}

	public static function all(){
		return manager.search(true,{orderBy:displayOrder},false);
	}
	
	override public function toString(){
		return '#$id-$name';
	}

	public function infos():CategoryInfo{
		return {
			id:id,
			name:name,
			image:'/img/taxo/$image.png',
		};
	}
}