
package react.store.redux.state;

import react.Partial;
import redux.IReducer;
import react.store.redux.action.CartAction;
import Common.ProductInfo;
import Common.OrderSimple;

typedef CartState = OrderSimple;

class CartRdcr implements IReducer<CartAction, CartState> {
	public function new() {}

	public var initState:CartState = {
        products:[], 
        total:0,
        count:0,
    };

	public function reduce(state:CartState, action:CartAction):CartState {
		var partial:Partial<CartState> = switch (action) {

            case ResetCart : initState;
            
			case UpdateQuantity(product, quantity):
                var cp = state.products.copy();
                for( p in cp ) {
                    if( p.product == product ) {
                        if( quantity > 0 )
                          p.quantity = quantity;
                        else
                            cp.remove(p);
                        //
                        break;
                    }
                }
                {products:cp};

            case AddProduct(product): 
                var cp = state.products.copy();
                cp.push({product:product, quantity:1});
                {products:cp};

            case RemoveProduct(product): 
                var cp = state.products.copy();
                for( p in cp ) {
                    if( p.product == product ) {
                        cp.remove(p);
                        break;
                    }
                }
                {products:cp};
		}

        if( state != partial ) {
            var count = 0, total = 0.0;
            for( p in partial.products ) {
                count += p.quantity;
                total += p.quantity * p.product.price;
            }
            partial.count = count;
            partial.total = Math.round(total * 100) / 100;
        }
        
		return (state == partial ? state : js.Object.assign({}, state, partial));
	}
}
