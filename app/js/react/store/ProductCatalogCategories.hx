package react.store;

import Common;
import react.PureComponent;
import react.ReactMacro.jsx;
import mui.core.Grid;
import classnames.ClassNames.fastNull as classNames;
import mui.core.styles.Classes;
import react.store.types.FilteredProductCatalog;
import mui.core.styles.Styles;
import mui.core.Modal;
import js.html.Event;
import mui.core.modal.ModalCloseReason;

using Lambda;

typedef ProductCatalogCategoriesProps = {
	> PublicProps,
};

private typedef PublicProps = {
	var catalog:FilteredProductCatalog;
	var vendors : Array<VendorInfos>;
	var openModal : ProductInfo->VendorInfos->Void;
	var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
}

@:publicProps(PublicProps)
class ProductCatalogCategories extends PureComponentOfProps<ProductCatalogCategoriesProps> {

	function new(p) {
		super(p);
	}

	override public function render() {
		var categories = [
			for( category in props.catalog.catalog.categories ) { 
				var key = category.info==null ? Std.random(1000) : category.info.id;
				jsx('<ProductListCategory key=${key} filter=${props.catalog.filter} catalog=${category} openModal=${props.openModal} vendors=${props.vendors} nav=${props.nav} />');
			}
		];
		return jsx('
			<>
				${categories}
			</>
		');
	}
}
