package controller.api;
import sys.io.File;
import haxe.crypto.Base64;
import Common;

/**
 * Product API
 * @author fbarbut
 */
class Product extends Controller
{
	
	public function  doDefault(product:db.Product) {
		Sys.print(haxe.Json.stringify(product.infos()));
	}
	
	
	
	/**
		List all products of a conctract
	**/
	public function doGet( args : { ?catalogId : db.Catalog } ) {
	
		if( args == null || args.catalogId == null ) throw "invalid params";

		var out = { products:new Array<ProductInfo>() };
		for( p in args.catalogId.getProducts(false) ) out.products.push( p.infos(false,false) ); 
		Sys.print( tink.Json.stringify(out) );
	}

	/**
		Get full categories tree
	**/
	public function doCategories(){
		var out = new Array<CategoryInfo>();

		//1st Level
		for( cat in db.TxpCategory.all()){

			var catInfos = cat.infos();

			//2nd level
			catInfos.subcategories = [];
			for( subcat in cat.getSubCategories()){

				var subCatInfos = subcat.infos();
				subCatInfos.subcategories = [];
				for( prod in subcat.getProducts()){
					subCatInfos.subcategories.push({
						name:prod.name,
						id:prod.id,
					});
				}

				

				catInfos.subcategories.push(subCatInfos);
			}

			out.push(catInfos);

		}

		Sys.print(tink.Json.stringify(out));

	}

	
	function doImage(product:db.Product) {
		
		if (!app.user.canManageContract(product.catalog)) throw t._("Forbidden access");
		
		var request = sugoi.tools.Utils.getMultipart(1024 * 1024 * 12); //12Mb
		//var request = app.params;
		
		if (request.exists("file")) {
			
			//Image
			var image = request.get("file");
			if (image != null && image.length > 0) {
				
				var img = sugoi.db.File.createFromDataUrl(request.get("file"), request.get("filename"));

				product.lock();
				if (product.image != null) {
					//efface ancienne
					product.image.lock();
					product.image.delete();
				}				
				product.image = img;
				product.update();
				Sys.print(haxe.Json.stringify({success:true}));
			}
		}else{
			Sys.print(haxe.Json.stringify({success:false}));
		}
	}	
	
}