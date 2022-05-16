package db;
import sys.db.Types;

@:id(productId,categoryId)
class ProductCategory extends sys.db.Object
{
	
	@:relation(productId)
	public var product : db.Product;
	
	@:relation(categoryId)
	public var category : db.Category;
	
	public static function getOrCreate(product, category){
		
		var x = db.ProductCategory.manager.select($product==product && $category==category,true);
		if(x==null){
			x = new db.ProductCategory();
			x.product = product;
			x.category = category;
			x.insert();
		}		
		return x;
		
	}
	
}