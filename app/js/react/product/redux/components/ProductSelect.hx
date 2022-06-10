package react.product.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common.ProductInfo;
import react.order.redux.actions.OrderBoxAction;
import react.order.redux.actions.thunk.OrderBoxThunk;


typedef ProductSelectProps = {

	var catalogId : Int;
	var products : Array<ProductInfo>;
	var selectProduct : Int -> Void;	
	var fetchProducts : Int -> Void;
}

/**
 * A Product selector
 * @author fbarbut
 */
@:connect
class ProductSelect extends react.ReactComponentOfProps<ProductSelectProps>
{

	public function new(props) 
	{
		super(props);			
	}

	override public function render(){

		var products = props.products.map(function(product) {
            			
			return jsx('<div key=${product.id} className="col-md-6" onClick=${props.selectProduct.bind(product.id)}>
							<div className="clickable"><Product productInfo=$product /></div>			
						</div>');
		});

		return jsx('<div className="productSelect">${products}</div>');		
	}

	override function componentDidMount() {

		props.fetchProducts( props.catalogId );
	}

	static function mapStateToProps( state: react.order.redux.reducers.OrderBoxReducer.OrderBoxState ): react.Partial<ProductSelectProps> {	
		
		return { products : Reflect.field(state, "reduxApp").products };
	}

	static function mapDispatchToProps( dispatch: redux.Redux.Dispatch ) : react.Partial<ProductSelectProps> {
				
		return { 
			
			selectProduct : function(productId) { 
								dispatch(OrderBoxAction.SelectProduct(productId));
								//Redirects to orderBox when a product is selected
								js.Browser.location.hash = "/";
							},
			fetchProducts : function( catalogId : Int ) {
								dispatch(OrderBoxThunk.fetchProducts( catalogId )); 		
							}			
		}
	}	

}	