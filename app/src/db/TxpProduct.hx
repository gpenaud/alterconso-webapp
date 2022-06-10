package db;
import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author fbarbut
 */
class TxpProduct extends Object
{

	public var id : SId;
	public var name : SString<128>;	
	@:relation(categoryId) public var category : db.TxpCategory;
	@:relation(subCategoryId) public var subCategory : db.TxpSubCategory;
	
	override public function toString(){
		return '#$id-$name';
	}
	
	public function getFullCategorization():Array<String>{
		return [category.name, subCategory.name, name];
		
	}
	
}

