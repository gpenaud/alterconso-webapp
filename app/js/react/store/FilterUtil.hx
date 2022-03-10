
package react.store;

import js.Promise;
import haxe.Json;

import react.store.types.FilteredProductCatalog;
import Common.ProductInfo;
import Common.CategoryInfo;
import react.store.types.Catalog;

using Lambda;
class FilterUtil
{
    public static function filterProducts(catalog:Catalog, ?filter:{category:Int, ?subcategory:Int, ?tags:Array<String>, ?producteur:Bool} ):FilteredProductCatalog
    {
        var copy:Catalog = {categories:catalog.categories.copy()};
        //
        var producteur = filter != null ? filter.producteur : null;
        var category = filter != null ? filter.category : null;
        var subcategory = filter != null ? filter.subcategory : null;
        var tags = filter != null ? filter.tags : null;

        if( filter != null ) 
        {
            var cat:CatalogCategory = cacheCatalogCategory.get(filter.category);
            if( cat == null ) 
            {
                copy.categories = [{info: cacheCategories.get(filter.category), subcategories: []}];
            }
            else 
            {
                copy.categories = [ Reflect.copy(cat) ];
            }
            
            if( filter.subcategory != null ) 
            {
                var subcat:CatalogSubCategory = cacheCatalogSubCategory.get(filter.subcategory);
                var data = if( subcat == null ) [] else [Reflect.copy(subcat)];
                copy.categories[0].subcategories = data;
            }

            if( filter.tags != null ) 
            {
                throw "To implement";
            }
        }

        //TODO PRODUCTEUR group
        return {catalog:copy, filter:{producteur:producteur, category:category, subcategory:subcategory, search:null}};
    }

    /**
        Search for products
    **/
    public static function searchProducts(catalog:Catalog, criteria:String ):FilteredProductCatalog
    {
        var copy:Catalog = {categories:[]};
        //case non sensitive search
        criteria = criteria.toLowerCase();
        for( cat in catalog.categories ) 
        {
            var inserted:CatalogCategory = null;
            for( subcat in cat.subcategories )
            {
                var subinserted:CatalogSubCategory = null;
                for( p in subcat.products )
                {
                    if( searchProductName(p.name, criteria) ) 
                    {
                        if( inserted == null )
                        {
                            inserted = {
                                info : cat.info,
                                subcategories: [],
                            };
                            copy.categories.push(inserted);
                        }
                        if( subinserted == null )
                        {
                            subinserted = {
                                info : subcat.info,
                                products: [],
                            }
                            inserted.subcategories.push(subinserted);
                        }
                        subinserted.products.push(p);
                    }
                }
            }
        }
        return {catalog:copy, filter:{producteur:null, category:null, subcategory:null, search:criteria}};
    }

    static public function searchProductName(productName:String, criteria:String) 
    {
        return productName.toUpperCase().indexOf(criteria.toUpperCase()) > -1;
    }

    //cache for faster access here to references
    static var cacheCategories : Map<Int, CategoryInfo> = new Map();
    static var cacheSubCategories : Map<Int, CategoryInfo> = new Map();
    
    
    static var cacheCatalogCategory : Map<Int, CatalogCategory> = new Map();
    static var cacheCatalogSubCategory : Map<Int, CatalogSubCategory> = new Map();

    public static function makeCatalog(categories:Array<CategoryInfo>, products:Array<ProductInfo>)
    {
        //make cache first
        for( c in categories )
        {
            cacheCategories.set(c.id, c);
            for( sub in c.subcategories )
                cacheSubCategories.set(sub.id, sub);
        }

        //
        var catalog : Catalog = {categories  : []};

        for( p in products ) 
        {
            var catId = p.categories[0];
            var cat:CatalogCategory = cacheCatalogCategory.get(catId);
            if( cat == null ) 
            {
                var info = cacheCategories.get(catId);
                cat = {
                    info: info,
                    subcategories : [],
                    //products : [],
                }
                cacheCatalogCategory.set(catId, cat);
                catalog.categories.push(cat);
            }

            var subcatId = p.subcategories[0];
            var subcat:CatalogSubCategory = cacheCatalogSubCategory.get(subcatId);
            if( subcat == null ) {
                subcat = {
                    info: cacheSubCategories.get(subcatId),
                    products : [],
                }
                cacheCatalogSubCategory.set(subcatId, subcat);
                cat.subcategories.push(subcat);
            }

            subcat.products.push(p);
        }

        //re-sort categories
        catalog.categories.sort(function(a,b){
            return a.info.displayOrder - b.info.displayOrder;
        });

        return catalog;
    }
}