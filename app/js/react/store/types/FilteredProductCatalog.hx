package react.store.types;

import Common;
import react.store.types.Catalog;

typedef CatalogFilter = {
	@:optional var producteur:Bool;//TODO
	@:optional var category:Int;
	@:optional var search:Null<String>;
	@:optional var subcategory:Int;
	@:optional var tags:Array<String>;//TODO
}

typedef FilteredProductCatalog = {
	var catalog: Catalog;
	var filter: CatalogFilter;
	
}
