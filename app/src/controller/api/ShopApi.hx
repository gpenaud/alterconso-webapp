package controller.api;
import haxe.Json;
import tink.core.Error;
import Common;
import db.Group;
import tools.ArrayTool;
using tools.ObjectListTool;
using Lambda;

class ShopApi extends Controller
{
	/**
		List available categories
		@doc https://app.swaggerhub.com/apis/Cagette.net/Cagette.net/0.9.2#/shop/get_shop_categories
	 */
	public function doCategories(args:{multiDistrib:db.MultiDistrib}){
		
		var out = new Array<CategoryInfo>();
		var md = args.multiDistrib;
		var group = md.getGroup();
		
		if ( !group.flags.has(CustomizedCategories)){
			
			//TAXO CATEGORIES
			var taxoCategs = db.TxpCategory.manager.search(true,{orderBy:displayOrder});
			for (txp  in taxoCategs){
				
				var c : CategoryInfo = {id:txp.id, name:txp.name,image:'/img/taxo/${txp.image}.png',displayOrder:txp.displayOrder,subcategories:[]};
				for (sc in txp.getSubCategories()){
					c.subcategories.push({id:sc.id,name:sc.name});
				}
				out.push(c);
			}
			
		}else{
			
			throw "Please disable customized categories";
			//CUSTOM CATEGORIES
			/*var catGroups = db.CategoryGroup.get(group);
			for (cat  in catGroups){
				
				var c : CategoryInfo = {id:cat.id, name:cat.name, subcategories:[]};
				for ( sc in cat.getCategories() ){
					c.subcategories.push({id:sc.id,name:sc.name});
				}
				out.push(c);
			}*/
		}
		
		Sys.print(Json.stringify({success:true,categories:out}));	
	}

	/**
		Get All available products
	**/
	public function doAllProducts(args:{multiDistrib:db.MultiDistrib}){
		
		if ( args == null ) throw "You should provide a distrib id";		
			
		var products = getProducts(args.multiDistrib, true );
		
		//to productInfos
		var productsInfos : Array<ProductInfo> = products.map( p -> p.infos(true,true) ).array();
		Sys.print(Json.stringify( {products:productsInfos} ));									
	}
	
	/**
	 * @doc https://app.swaggerhub.com/apis/Cagette.net/Cagette.net/0.9.2#/shop/get_shop_products
	 */
	/*public function doProducts(args:{date:String, place:db.Place, ?category:Int, ?subcategory:Int}){
		
		if ( args == null || (args.category == null && args.subcategory == null)) throw "You should provide a category Id or a subcategory Id";
		//need some optimization : populating all thses objects eats memory, and we need only the ids !		
		var products = getProducts(args.place, Date.fromString(args.date), !args.place.group.flags.has(CustomizedCategories));
		var pids  = products.getIds();
		var categsFromTaxo = !args.place.group.flags.has(CustomizedCategories);		
		var catName = "undefined category";
		
		if( categsFromTaxo ){
			
			
			//  * Use Taxonomy : 
			//  * 	- Category is TxpCatgory
			//  * 	- Subcategory us TxpSubCategory
			//  * 	- Products are linked to TxpProduct which belongs to a TxpCatgory and a TxpSubCategory
			
			var sql = "";
			
			if (args.subcategory != null){
				
				sql = 'SELECT p.* FROM Product p, TxpProduct tp, TxpSubCategory sc 
				WHERE p.txpProductId = tp.id 
				AND tp.subCategoryId = sc.id 
				AND sc.id = ${args.subcategory}
				AND p.id IN ( ${pids.join(",")} )';
				
				var cat = db.TxpSubCategory.manager.get(args.subcategory, false);
				if (cat == null) throw 'unknown subcategory #' + args.subcategory;
				catName = cat.name;
				
			}else if (args.category != null){
				
				sql = 'SELECT p.* FROM Product p, TxpProduct tp, TxpCategory c 
				WHERE p.txpProductId = tp.id 
				AND tp.categoryId = c.id 
				AND c.id = ${args.category}
				AND p.id IN ( ${pids.join(",")} )';
				
				var cat = db.TxpCategory.manager.get(args.subcategory, false);
				if (cat == null) throw 'unknown category #' + args.category;
				catName = cat.name;
			}
			
			products = db.Product.manager.unsafeObjects(sql,false).array();
			
		}else{
			
			
			//  * Use custom categories : 
			//  * 	- Category is CategoryGroup
			//  * 	- Subcategory is Category
			//  *  - Products are tagged with ProductCategory
			 
			var sql = "";
			
			if (args.subcategory != null){
				
				sql = 'SELECT p.* FROM Product p, ProductCategory pc, Category c 
				WHERE pc.productId = p.id 
				AND pc.categoryId = c.id 
				AND c.id = ${args.subcategory}
				AND p.id IN ( ${pids.join(",")} )';
				
				var cat = db.Category.manager.get(args.subcategory, false);
				if (cat == null) throw 'unknown subcategory #' + args.subcategory;
				catName = cat.name;
				
			}else if (args.category != null){
				
				sql = 'SELECT p.* FROM Product p, ProductCategory pc, Category c, CategoryGroup cg 
				WHERE pc.productId = p.id 
				AND pc.categoryId = c.id 
				AND c.categoryGroupId = cg.id
				AND cg.id = ${args.category}
				AND p.id IN ( ${pids.join(",")} )';
				
				var cat = db.CategoryGroup.manager.get(args.category, false);
				if (cat == null) throw 'unknown category #' + args.category;
				catName = cat.name;
			}
			
			products = db.Product.manager.unsafeObjects(sql,false).array();
		}
		
		//to productInfos
		var products : Array<ProductInfo> = products.map( function(p) return p.infos(categsFromTaxo,true) ).array();
		
		if (args.category != null){
			Sys.print(Json.stringify( {success:true, products:products, category:catName} ));					
		}else{
			Sys.print(Json.stringify( {success:true, products:products, subcategory:catName} ));				
		}		
	}*/
	
	/**
		Infos to init the shop : place + order end dates + vendor infos + payment infos
	**/
	public function doInit(args:{multiDistrib:db.MultiDistrib}){
		var md = args.multiDistrib;
		var out = { 
			place : md.getPlace().getInfos(),
			distributionStartDate : md.getDate(),
			orderEndDates : new Array<{date:String,contracts:Array<String>}>(),
			vendors : new Array<VendorInfos>(),
			paymentInfos : service.PaymentService.getPaymentInfosString(md.getGroup())
		};
		
		//order end dates
		var contracts = db.Catalog.getActiveContracts(md.getGroup());
	
		for (c in Lambda.array(contracts)) {			
			if (c.type != db.Catalog.TYPE_VARORDER) contracts.remove(c);//only varying orders
			if (!c.isVisibleInShop()) contracts.remove(c);
		}
		
		var date = args.multiDistrib.getDate();
		var now = Date.now();
		var cids = Lambda.map(contracts, function(c) return c.id);
		var d1 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
		var d2 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);

		var distribs = db.Distribution.manager.search(($catalogId in cids) && $orderStartDate <= now && $orderEndDate >= now && $date > d1 && $end < d2 && $place == args.multiDistrib.getPlace(), false);
		var distribByDate = ArrayTool.groupByDate(Lambda.array(distribs), "orderEndDate");
		out.orderEndDates  = [];
		for ( k in distribByDate.keys() ) {
			out.orderEndDates.push( {date:k , contracts: distribByDate.get(k).map( function(x) return x.catalog.name)} );	
		}

		//vendors
		var vendors = [];
		for( v in args.multiDistrib.getVendors()){
			vendors.push(v.getInfos(true));
		}
		out.vendors = vendors.deduplicate();
		
		
		Sys.print(Json.stringify( out ));	
	}
	
	private function getProductInfos(md:db.MultiDistrib, ?categsFromTaxo = false):Array<ProductInfo>{
		var products = getProducts(md, categsFromTaxo);
		return Lambda.array(Lambda.map(products, function(p) return p.infos(categsFromTaxo)));		
	}
	
	/**
	 * Get the available products list
	 */
	private function getProducts(md:db.MultiDistrib,?categsFromTaxo=false):Array<db.Product> {

		var contracts = db.Catalog.getActiveContracts(md.getGroup());
		var date = md.getDate();
		var place = md.getPlace();
	
		for (c in Lambda.array(contracts)) {			
			if (c.type != db.Catalog.TYPE_VARORDER) contracts.remove(c);//only varying orders
			if (!c.isVisibleInShop()) contracts.remove(c);
		}
		
		var now = Date.now();
		var cids = Lambda.map(contracts, function(c) return c.id);
		var d1 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
		var d2 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);

		var distribs = db.Distribution.manager.search(($catalogId in cids) && $orderStartDate <= now && $orderEndDate >= now && $date > d1 && $end < d2 && $place == place, false);
		
		var cids = Lambda.map(distribs, function(d) return d.catalog.id);
		return Lambda.array(db.Product.manager.search(($catalogId in cids) && $active==true, { orderBy:name }, false));
		
	}

	/**
		Record temporary basket sent from the shop client.
	 */
	public function doSubmit(multiDistrib:db.MultiDistrib) {
		var post:{cart:TmpBasketData} = haxe.Json.parse(sugoi.Web.getPostData());
		
		if(post==null) throw 'Payload is empty';
		if(post.cart==null) throw 'Cart is empty';

		var tmpBasket = service.OrderService.makeTmpBasket(app.user,multiDistrib, post.cart);

		Sys.print(haxe.Json.stringify({success:true,tmpBasketId:tmpBasket.id}));
		
	}
	
	
	
}