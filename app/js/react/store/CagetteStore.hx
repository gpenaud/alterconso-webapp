package react.store;

import mui.core.grid.GridSpacing;
import js.Promise;
import haxe.Json;
import react.mui.CagetteTheme;
import mui.core.Grid;
import mui.core.CircularProgress;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.PageHeader;
import react.MuiError;

import react.store.types.Catalog;
import react.store.types.FilteredProductCatalog;

import utils.HttpUtil;

import Common;
using Lambda;

typedef CagetteStoreProps = {
	var multiDistribId:Int;
};

typedef CagetteStoreState = {
	var place:PlaceInfos;
	var distributionStartDate : Date;
	var orderByEndDates:Array<OrderByEndDate>;
	var categories:Array<CategoryInfo>;
	var products:Array<ProductInfo>;
	var catalog:Catalog;
	var filter:CatalogFilter;
	var loading:Bool;
	var vendors:Array<VendorInfos>;
	var paymentInfos:String;
	var errorMessage:String;
	var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
};

@:enum
abstract ServerUrl(String) to String {
	var CategoryUrl = '/api/shop/categories';
	var ProductsUrl = '/api/shop/allProducts';
	var InitUrl = '/api/shop/init';
	var ViewUrl = '/place/view';
	var SubmitUrl = '/api/shop/submit';
}

class CagetteStore extends react.ReactComponentOfPropsAndState<CagetteStoreProps, CagetteStoreState> {

	public function new() {
		super();
		state = {
			place: null,
			distributionStartDate : null,
			orderByEndDates: [],
			categories: [],
			filter: {},
			products:[],
			catalog:null,
			loading:true,
			vendors:[],
			paymentInfos:"",
			errorMessage : null,
			nav:{category:null, subcategory:null},
		};
	}

	function onError(msg:String){
		trace("ERROR:", msg);
		setState({errorMessage:msg});
	}

	static function fetch(url:ServerUrl, ?method:HttpMethod = GET, ?params:Dynamic = null, ?accept:FetchFormat = PLAIN_TEXT,
			?contentType:String = JSON):Promise<Dynamic> {
		return HttpUtil.fetch(url, method, params, accept, contentType);
	}

	//TODO CLEAN
	public static var ALL_CATEGORY = {id:0, name:"Tous les produits",image:"/img/taxo/allProducts.png", subcategories:[]};
	//public static var DEFAULT_CATEGORY = {id:-1, name:"Autres"};

	override function componentDidMount() {

		//Check browser compat
		var browser = bowser.Bowser.getParser(js.Browser.window.navigator.userAgent);
		var isValidBrowser = browser.satisfies({
			"chrome" 	: ">=49",
			"chromium" 	: ">=49",
			"firefox" 	: ">=52",
			"safari" 	: ">=10",
			"internet explorer" : ">=11",
			"android webview" 	: ">=70",
			"samsung" 	: ">=6.4",
			"edge" 		: ">=14"
		});
		if(isValidBrowser!=true){
			var navigo = '${browser.getBrowserName()} ${browser.getBrowserVersion()}';
			setState({errorMessage:'Votre navigateur ($navigo) est trop ancien et n\'est pas pris en charge par Alterconso.<br/>
			Installez une version récente de <a href="http://www.mozilla.org/firefox">Firefox</a>
			 ou <a href="https://www.google.com/chrome/">Chrome</a>.'});
		}

		//Loads init datas
		var initRequest = fetch(InitUrl, GET, {multiDistrib: props.multiDistribId}, JSON);
		initRequest.then(function(infos:Dynamic) {
			setState({
				place: infos.place,
				distributionStartDate : Date.fromString(infos.distributionStartDate),
				orderByEndDates: infos.orderEndDates,
				vendors:infos.vendors,
				paymentInfos:infos.paymentInfos
			});
		})
		.catchError(function(error) {
			onError(error);
		});

		//Loads categories list
		var categoriesRequest = fetch(CategoryUrl, GET, {multiDistrib: props.multiDistribId}, JSON);
		categoriesRequest.then(function(results:Dynamic) {
			var categories:Array<CategoryInfo> = results.categories;
			//categories.unshift(DEFAULT_CATEGORY);

			setState({categories: categories});
			
			//Loads products
			fetch(ProductsUrl, GET, {multiDistrib: props.multiDistribId}, JSON)
			.then(function(res:Dynamic){
				var res :{products:Array<ProductInfo>} = res;
				
				res.products = Lambda.array(Lambda.map(res.products, function(p:Dynamic) {
					//default category
					/*if( p.categories == null || p.categories.length == 0 ) {
						p.categories = [DEFAULT_CATEGORY.id];
					}*/
					//convert unit in enum
					if(p.unitType!=null) p = js.Object.assign({}, p, {unitType: Type.createEnumIndex(Unit, p.unitType)});
					return p;
				}));


				var catalog = FilterUtil.makeCatalog(categories, res.products);
				setState({
					products:res.products,
					catalog:catalog,
					loading:false,
					nav:{category:categories[0], subcategory:null},
				});

			}).catchError(function(error) {
				onError(error);
			});

			categories.unshift(ALL_CATEGORY);

		}).catchError(function(error) {
			onError(error);
		});
	}

	function resetFilter() {
		setState({
			filter:{},
			nav: {category:state.categories[0], subcategory:null}
		});
	}

	function filterByCategory(categoryId:Int) {
		var category = Lambda.find(state.categories, function(c) return c.id == categoryId);
		setState({ 
			filter: {category:categoryId, subcategory:null },
			nav: {category:category, subcategory:null}
		});
	}

	function filterBySubCategory(categoryId:Int, subCategoryId:Int) {
		var category = Lambda.find(state.categories, function(c) return c.id == categoryId);
		var subcategory = Lambda.find(category.subcategories, function(c) return c.id == subCategoryId);
		setState({ 
			filter: {category:categoryId, subcategory:subCategoryId },
			nav: {category:category, subcategory:subcategory}
		});
	}

	function toggleFilterTag(tag:String) {
		var tags = state.filter.tags;
		if( tags == null ) tags = [];
		// toggle
		var hadTag = state.filter.tags.remove(tag);
		if( !hadTag ) state.filter.tags.push(tag);
		// assign
		var filter = js.Object.assign({}, state.filter, {tags:tags});
		setState({ filter: filter});
	}
	
	function submitOrder(order:OrderSimple) {
		try{
			var tmpBasket : TmpBasketData = {
				products: order.products.map(function(p:ProductWithQuantity) {
					return {
						productId: p.product.id,
						quantity: p.quantity*1.0
					};
				})
			}
		
			HttpUtil.fetch("/api/shop/submit"+"/"+props.multiDistribId ,POST,{cart:tmpBasket},JSON)
			.then(function(data:Dynamic){
				js.Browser.location.href = "/shop/validate/"+data.tmpBasketId;
			});
		}catch(e:Dynamic){
			onError( Std.string(e) );
		}
		
	}

	/**
	TODO : bloc de mise en avant.
	Par défaut ce sera les produits de la semaine. 
	Les conditions d'affichage sont encore à définir
	**/
	function renderPromo() {
		return null;
	}

	function onSearch(criteria:String) {
		if( criteria != null && criteria.length == 0 ) criteria = null;
		setState({
			filter:{search:criteria},
			nav: {category:state.categories[0], subcategory:null}
		});
	}

	function filterCatalog(p, f:CatalogFilter):FilteredProductCatalog {
		//filtered by a search
		if( f.search != null ) {
			return react.store.FilterUtil.searchProducts(state.catalog, f.search);
		} else {
			//filtered by a category / subcategory
			//trace("FilterCatalog", f);
			var filter = ( f.category == null || f.category == 0 ) ? null : f;
			return FilterUtil.filterProducts(state.catalog, filter);
		}
	}

	function renderLoader() {
		return jsx('
			<Grid  container spacing=${GridSpacing.Spacing_0} direction=${Column} alignItems=${Center} justify=${Center} style={{ minHeight: "50vh" }}>
				<Grid item xs={3}>
					<CircularProgress />
				</Grid>   
			</Grid> 
		');
	}

	function renderProducts() {
		return 	if( state.loading ) renderLoader();
				else jsx('<ProductCatalog catalog=${filterCatalog(state.products, state.filter)} vendors=${state.vendors} nav=${state.nav} />');
	}

	override public function render() {
		
		return jsx('			
			<div className="shop">
				<HeaderWrapper 
					submitOrder=$submitOrder 
					orderByEndDates=${state.orderByEndDates} 
					place=${state.place} 
					paymentInfos=${state.paymentInfos} 
					date=${state.distributionStartDate}
					categories=${state.categories}
					resetFilter=${resetFilter}
					filterByCategory=${filterByCategory}
					filterBySubCategory=${filterBySubCategory}
					toggleFilterTag=${toggleFilterTag}
					onSearch=${onSearch}
					nav=${state.nav}
				/>

				${renderPromo()}
				${renderProducts()}

				${state.errorMessage != null ? jsx('<MuiError errorMessage=${state.errorMessage} onClose=$onErrorDialogClose  />') : null}
				
			</div>
		');
	}

	function onErrorDialogClose(){
		setState({errorMessage:null});
	}
}
