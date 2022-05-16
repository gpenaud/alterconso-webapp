package react.store;

import Common;
import react.ReactComponent;
import react.ReactMacro.jsx;
import mui.core.Grid;
import classnames.ClassNames.fastNull as classNames;
import mui.core.styles.Classes;
import react.store.types.Catalog;
import mui.core.styles.Styles;
import mui.core.Modal;
import mui.core.Typography;
import mui.core.CircularProgress;
import js.html.Event;
import mui.core.modal.ModalCloseReason;
import react.store.types.Catalog;
import react.store.types.FilteredProductCatalog;
using Lambda;

typedef ProductListCategoryProps = {
	> PublicProps,
};

private typedef PublicProps = {
	var catalog:CatalogCategory;
	var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
	var openModal : ProductInfo->VendorInfos->Void;
	var vendors : Array<VendorInfos>;
	var filter: CatalogFilter;
}

private typedef ProductListCategoryState = {
	var currentSubCategoryCount:Int;
	var catalog:CatalogCategory;
	var loadMore:Bool;
	var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
	var filter: CatalogFilter;
}

@:publicProps(PublicProps)
class ProductListCategory extends react.ReactComponentOf<ProductListCategoryProps, ProductListCategoryState> {

	function new(p) {
		super(p);
		this.state = {catalog:null, currentSubCategoryCount:0, loadMore:false, nav:null, filter:null};
	}

	override function componentWillUnmount() {
		if( timer != null ) timer.stop();
		timer = null;
	}

	/**
		Triggered when props are updated
	**/
	static function getDerivedStateFromProps(nextProps:ProductListCategoryProps, currentState:ProductListCategoryState):ProductListCategoryState {
		if( nextProps.catalog == null ) return null;
		/*
		if( currentState.nav != null ) 
		{
			//TODO be careful, need to check other filters later..
			// might be better to send catalog filter instead one
			if( currentState.nav.category == nextProps.nav.category && currentState.nav.subcategory == nextProps.nav.subcategory )
				return null;
		}
		*/
		if( currentState.filter != null ) 
		{
			var f1 = currentState.filter, f2 = nextProps.filter;
			if( f1.search == f2.search && f1.category == f2.category && f1.subcategory == f2.subcategory )
				return null;

		}

		return {catalog:nextProps.catalog, currentSubCategoryCount:0, loadMore:true, nav:nextProps.nav, filter:nextProps.filter};
	}

	var timer:haxe.Timer;
	function loadMore() {
		if( state.catalog.subcategories.length == 0 ) return;
		if( state.currentSubCategoryCount == state.catalog.subcategories.length) return;
		setState({currentSubCategoryCount:state.currentSubCategoryCount+1}, function() {
			timer = haxe.Timer.delay(loadMore, 400);
		});
	}

	override function componentDidMount() {
		//trace("componentDidMount "+state.loadMore);
		if( state.loadMore == true ) {
			//trace("we ask for reloading");
			setState({loadMore:false}, loadMore);
		}
	}
	override function componentDidUpdate(prevProps:ProductListCategoryProps, prevState:ProductListCategoryState) {
		if( state.loadMore == true ) {
			setState({loadMore:false}, loadMore);
		}
	}

	override public function render() {
		var categoryName =  jsx('
			<Typography variant={H4}>
            	${props.catalog.info.name}
            </Typography>
		');
		
		return jsx('
			<div className="category" key=${props.catalog.info.id}>
				${categoryName}
				<div className="subCategories">
					${renderSubCategories()}
				</div>
			</div>
		');
	}

	function renderSubCategories() {

		if( state.catalog.subcategories == null || state.catalog.subcategories.length == 0 ) {
			return jsx('
				<Typography variant={H5} align={Center}>
					Il n\'y a aucun produit dans la catégorie "${props.catalog.info.name}"
				</Typography>
			');
		}

		var shouldOfferDifferedLoading = true;
		var totalProducts = Lambda.fold(state.catalog.subcategories, function(d, count:Int) { return count + d.products.length; }, 0);
		if( totalProducts == 0 ) {
			return jsx('
				<Typography variant={H5} align={Center}>
					Il n\'y a aucun produit dans la catégorie "${props.catalog.info.name}"
				</Typography>
			');
		}

		var list = [for( i in 0...state.currentSubCategoryCount ) {
			var subcategory = state.catalog.subcategories[i];
			jsx('
				<ProductListSubCategory displayAll=${!shouldOfferDifferedLoading} key=${subcategory.info.id} catalog=${subcategory} vendors=${props.vendors} openModal=${props.openModal}  />
			');
		}];

		return jsx('<>${list}</>');
	}
}
