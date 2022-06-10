package react.store;

import Common;
import react.ReactComponent;
import react.ReactType;
import react.ReactMacro.jsx;
import mui.core.CircularProgress;
import mui.core.Typography;
import mui.core.Grid;
import classnames.ClassNames.fastNull as classNames;
import mui.core.styles.Classes;
import react.store.types.FilteredProductCatalog;
import mui.core.styles.Styles;
import mui.core.Modal;
import js.html.Event;
import mui.core.modal.ModalCloseReason;
import react.store.ProductCatalog;

using Lambda;

typedef ProductCatalogProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
	var catalog:FilteredProductCatalog;
	var vendors : Array<VendorInfos>;
	var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
}

private typedef ProductCatalogState = {
	@:optional var modalProduct:Null<ProductInfo>;
	@:optional var modalVendor:Null<VendorInfos>;

	var loading:Bool;
}

private typedef TClasses = Classes<[categories,]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class ProductCatalog extends ReactComponentOf<ProductCatalogProps, ProductCatalogState> {

	public static function styles(theme:react.mui.CagetteTheme):ClassesDef<TClasses> {
		return {
			categories : {
                maxWidth: 1240,
                margin : "auto",
                padding: "0 10px",
            },
		}
	}

/*
	static var LazyProductCatalogCategories:ReactType = {
		var p:js.Promise<Module<ReactType>> = new js.Promise(function(resolve:Module<ReactType>->Void, _) {  
			var m:Module<ReactType> = cast new Module(ProductCatalogCategories); 
			resolve(m); 
		});
		React.lazy(function() { return p; });
	}
*/

	function new(p) {
		super(p);
		this.state = {loading:true};
	}

	override public function render() {
		var classes = props.classes;
		//trace('filter catalog', props.catalog.products.length, props.catalog.category);
		//var loading = jsx('<CircularProgress />');
		//<ReactSuspense fallback=${loading}>
		return jsx('
			<div className=${classes.categories}>
			   <ProductModal 	product=${state.modalProduct}
								vendor=${state.modalVendor}
								onClose=${onModalCloseRequest} />
				${renderSearchResult()}
			  	<ProductCatalogCategories catalog=${props.catalog} vendors=${props.vendors} openModal=${openModal} nav=${props.nav} />
			</div>
    	');
	}

	function renderSearchResult() {
		if( props.catalog.filter.search == null ) return null;
		return jsx('
			<Typography style=${{fontSize:'2em','color':'#AAA'}}>
                Résultats de la recherche pour "<i style=${{'color':'#333'}}>${props.catalog.filter.search}</i>"
            </Typography>
		');
	}

	function openModal(product:ProductInfo, vendor:VendorInfos) {
        setState({modalProduct:product, modalVendor:vendor}, function() {trace("modal opened");});
    }

    function onModalCloseRequest(event:js.html.Event, reason:ModalCloseReason) {
        setState({modalProduct:null, modalVendor:null}, function() {trace("modal closed");});
    }

}
