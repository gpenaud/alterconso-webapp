package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common.ContractInfo;
import react.order.redux.actions.OrderBoxAction;
import react.order.redux.actions.thunk.OrderBoxThunk;


typedef CatalogSelectorProps = {
	var multiDistribId : Int;
	var catalogs : Array<ContractInfo>;
	var selectCatalog : Int-> Void;	
	var fetchCatalogs : Int -> Void;
}

/**
 * A Catalog selector
 * @author web-wizard
 */
@:connect
class CatalogSelector extends react.ReactComponentOfProps<CatalogSelectorProps>
{

	public function new(props) {
		super(props);			
	}

	override public function render() {

		//if there is only one catalog, skip this step
		if(props.catalogs.length==1){
			props.selectCatalog(props.catalogs[0].id);
			return null;
		}

		var catalogs = props.catalogs.map(function( catalog ){
			return jsx('<div key=${catalog.id} className="col-md-6" onClick=${props.selectCatalog.bind(catalog.id)}>
							<div className="clickable"><Catalog catalog=$catalog /></div>			
						</div>');
		});

		return jsx('<div className="catalogSelector">${catalogs}</div>');		
	}

	override function componentDidMount() {

		props.fetchCatalogs( props.multiDistribId );
	}

	static function mapStateToProps( state: react.order.redux.reducers.OrderBoxReducer.OrderBoxState ): react.Partial<CatalogSelectorProps> {	
		
		return { catalogs: Reflect.field(state, "reduxApp").catalogs };
	}

	static function mapDispatchToProps( dispatch : redux.Redux.Dispatch ) : react.Partial<CatalogSelectorProps> {
				
		return { 
			
			selectCatalog : function( catalogId : Int ) { 
								dispatch(OrderBoxAction.SelectCatalog( catalogId ));
								//Redirects to InsertOrder when a catalog is selected	
								js.Browser.location.hash = "/insert";
							},
			fetchCatalogs : function( multiDistribId : Int ) {
								dispatch(OrderBoxThunk.fetchCatalogs( multiDistribId ));
							}
		}
	}	

}	