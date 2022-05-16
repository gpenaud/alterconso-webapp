
package react.order.redux.reducers;

import redux.IReducer;
import react.order.redux.actions.OrderBoxAction;
import Common.ContractInfo;
import Common.ProductInfo;
import Common.UserInfo;
import Common.UserOrder;


typedef OrderBoxState = {
    var orders : Array<UserOrder>;
    var ordersWereFetched : Bool;
    var users : Array<UserInfo>;    
    var selectedUserId : Int;
    var selectedUserName : String;
    var catalogs : Array<ContractInfo>;
    var selectedCatalogId : Int;
	var products : Array<ProductInfo>;	
    var error : String;
};


class OrderBoxReducer implements IReducer<OrderBoxAction, OrderBoxState> {

	public function new() {}

	public var initState: OrderBoxState = {

        orders : [],
        ordersWereFetched : false,        
        users : null,
        selectedUserId : null,
        selectedUserName : null,
        catalogs : [],
        selectedCatalogId : null,
        products : [],
        error : null
    };


	public function reduce( state : OrderBoxState, action : OrderBoxAction ) : OrderBoxState {
        
		var partial : Partial<OrderBoxState> = switch (action) {

            case FetchOrdersSuccess( orders ):
                { orders : orders, ordersWereFetched : true, error : null };

            case FetchUsersSuccess( users ):
                { users : users, error : null };
            
            case SelectUser( userId, userName ):
                { selectedUserId : userId, selectedUserName : userName };

            case UpdateOrderQuantity( orderId, quantity ):
                var copiedOrders = state.orders.copy();
                for( order in copiedOrders ) {

                    if( order.id == orderId ) {

                        if( quantity >= 0 ) {

                            order.quantity = quantity;
                        }                          
                        break;
                    }
                }
                { orders : copiedOrders };

            case ReverseOrderRotation( orderId, reverseRotation ):
                var copiedOrders = state.orders.copy();
                for( order in copiedOrders ) {

                    if( order.id == orderId ) {

                        order.invertSharedOrder = reverseRotation;
                        break;
                    }
                }
                { orders : copiedOrders };

            case UpdateOrderUserId2( orderId, userId2 ):
                var copiedOrders = state.orders.copy();
                for( order in copiedOrders ) {

                    if( order.id == orderId ) {

                        order.userId2 = userId2;
                        break;
                    }
                }
                { orders : copiedOrders };

            case UpdatePaid( orderId, paid ):
                var copiedOrders = state.orders.copy();
                for( order in copiedOrders ) {

                    if( order.id == orderId ) {

                        order.paid = paid;
                        break;
                    }
                }
                { orders : copiedOrders };

            case FetchCatalogsSuccess( catalogs ):
                { catalogs : catalogs, error : null };
            
            case SelectCatalog( catalogId ):
                { selectedCatalogId : catalogId };
            
            case FetchProductsSuccess( products ):
                { products : products, error : null };

            case SelectProduct( productId ):
                var copiedOrders = state.orders.copy();
                var orderFound : Bool = false;
                for( order in copiedOrders ) {

                    if( order.product.id == productId ) {

                        order.quantity += 1;
                        orderFound = true;
                        break;
                    }
                }
                
                if ( !orderFound ) {

                    var selectedProduct = Lambda.find( state.products, function( product ) return product.id == productId );
                    var catalog = Lambda.find( state.catalogs, function( catalog ) return catalog.id == selectedProduct.catalogId );
                    var order : UserOrder = cast {};
                    order.id =  0 - Std.random(1000000);
                    order.catalogId =  selectedProduct.catalogId;
                    order.catalogName =  catalog != null ? catalog.name : null;
                    order.product =  selectedProduct;
                    order.quantity =  1;                  			
                    order.paid = false;
                    
                    copiedOrders.push(order);

                }
                { orders : copiedOrders };

            case FetchFailure( error ):
                { error : error };

        }       
        
		return ( state == partial ? state : js.Object.assign({}, state, partial) );
	}
}