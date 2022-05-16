package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.product.redux.components.ProductSelect;

//Material UI
import react.mui.CagetteTheme;
import mui.core.Button;


typedef InsertOrderProps = {

	var catalogId : Int;
	var selectedCatalogId : Int;
    var error : String;
    
    var userId: Int; // TODO
    var multiDistribId: Int; // TODO
}


/**
 * A box to add an order to a member
 * @author fbarbut
 */
@:connect
class InsertOrder extends react.ReactComponentOfProps<InsertOrderProps>
{

	public function new(props) {

		super(props);
	}	

	override public function render() {

		var catalogId = props.catalogId != null ? props.catalogId : props.selectedCatalogId;

		return 	<div>				
					<h3>Choisissez le produit à ajouter</h3>
					<Button onClick=${function(){ js.Browser.location.hash = props.catalogId != null ? "/" : "/catalogs"; }} size={Medium} variant={Outlined}>
						${CagetteTheme.getIcon("chevron-left")}&nbsp;&nbsp;Retour
					</Button>
					<hr />
					<ProductSelect catalogId=${catalogId} />			
				</div>;
	}	
	
	static function mapStateToProps( state : react.order.redux.reducers.OrderBoxReducer.OrderBoxState ) : react.Partial<InsertOrderProps> {
			
		return { 
			
			selectedCatalogId : Reflect.field(state, "reduxApp").selectedCatalogId
		};
	}
	
}