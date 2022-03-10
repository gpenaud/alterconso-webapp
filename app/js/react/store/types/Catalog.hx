package react.store.types;
import Common;

typedef Catalog = {
    var categories:Array<CatalogCategory>;
}
typedef CatalogCategory = {
    var info:CategoryInfo;
    var subcategories:Array<CatalogSubCategory>;
    //var products:Array<ProductInfo>;
}
typedef CatalogSubCategory = {
    var info:CategoryInfo;
    var products:Array<ProductInfo>;
}