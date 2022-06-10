package action;


typedef CartState = {
	var products:Array<ProductInfo>;
	var totalPrice:Float;
    ...
}


enum CartAction {
	UpdateQuantity(product:ProductInfo, quantity:Int);
    AddProductAddQuantity(product:ProductInfo);
    RemoveProductAddQuantity(product:ProductInfo);
}

class CartRdcr implements IReducer<CartAction, CartState> {
	public function new() {}

	public var initState:CartState = {}

	public function reduce(state:CartState, action:CartAction):CartState {
		var partial = switch (action) {
			case UpdateQuantity(product, quantity):// TODO
            case AddProductAddQuantity(product): //TODO
            case RemoveProductAddQuantity(product): //TODO
		}
		return (state == partial ? state : partial);
	}
}



import redux.Redux;
import redux.Store;
import redux.StoreBuilder.*;
import redux.thunk.Thunk;
import redux.thunk.ThunkMiddleware;

private function initStore():Void {
		// Store creation
		var rootReducer = Redux.combineReducers({
			config: mapReducer(ConfigAction, new ConfigRdcr()),
			
		});

		// create middleware normally, excepted you must use
		// 'StoreBuilder.mapMiddleware' to wrap the Enum-based middleware
		var middleWare = Redux.applyMiddleware(mapMiddleware(Thunk, new ThunkMiddleware()));

		store = createStore(rootReducer, null, middleWare);
	}



import redux.Redux.Dispatch;
import cagette.state.State;
import CartAction;

class AppThunk {
	static public function initApp(cb:Void->Void) {

		return redux.thunk.Thunk.Action(function(dispatch:Dispatch, getState:Void->cagette.state.State) {
            
			return dispatch(AnAction("blabla"));
		});
	}
}

