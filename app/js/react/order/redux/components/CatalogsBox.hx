package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;

//Material UI
import react.mui.CagetteTheme;
import mui.core.Button;


typedef CatalogsBoxProps = {
	
	var multiDistribId : Int;
}


/**
 * A box to select a catalog to then choose related products to be added to the orders of the user
 * @author web-wizard
 */
@:connect
class CatalogsBox  extends react.ReactComponentOfProps<CatalogsBoxProps>
{

	public function new(props) {

		super(props);		
	}	

	override public function render() {	

		return <div>								
					<h3>Choisissez le catalogue dont vous voulez voir les produits</h3>
					<Button onClick=${function(){ js.Browser.location.hash = "/"; }} size={Medium} variant={Outlined}>
						${CagetteTheme.getIcon("chevron-left")}&nbsp;&nbsp;Retour
					</Button>
					<hr />
					<CatalogSelector multiDistribId=${props.multiDistribId} />						
				</div>;
	}
	
}