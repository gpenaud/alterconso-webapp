
package react.order.redux.actions.thunk;

import utils.HttpUtil;
import Common.ContractInfo;
import Common.ProductInfo;
import Common.UserInfo;
import Common.UserOrder;
import react.order.redux.reducers.OrderBoxReducer.OrderBoxState;
import redux.thunk.Thunk;


class OrderBoxThunk {


    public static function fetchOrders( userId : Int, multiDistribId : Int, catalogId: Int, catalogType: Int ) {
    
        return Thunk.Action( function( dispatch : redux.Redux.Dispatch, getState : Void -> OrderBoxState ) {

            //Fetches all the orders for this user and this multiDistrib and for a given catalog if it's specified otherwise for any catalog of this multiDistrib
            return HttpUtil.fetch( "/api/order/get/" + userId, GET, { catalog : catalogId, multiDistrib : multiDistribId }, PLAIN_TEXT )
            .then( function( data : String ) {
                
                var data : { orders : Array<UserOrder> } = tink.Json.parse(data);
                dispatch( OrderBoxAction.FetchOrdersSuccess( data.orders ) );

                //Load users for amap type catalogs
                if ( catalogType == 0 ) { 

                    getUsers( dispatch );
                }
            })
            .catchError(function(data) {
               
                handleError( data, dispatch );
            });
        });

    }

    static function getUsers( dispatch : redux.Redux.Dispatch ) {

        //Fetches all the orders for this user and this multiDistrib and for a given catalog if it's specified otherwise for any catalog of this multiDistrib
        return HttpUtil.fetch( "/api/user/getFromGroup/", GET, {}, PLAIN_TEXT )
        .then( function( data : String ) {

            var data : { users : Array<UserInfo> } = tink.Json.parse(data);
            dispatch( OrderBoxAction.FetchUsersSuccess( data.users ) );
        })
        .catchError(function(data) {

            handleError( data, dispatch );
        });

    }

     public static function fetchUsers() {
    
        return Thunk.Action( function( dispatch : redux.Redux.Dispatch, getState : Void -> OrderBoxState ) {

            return getUsers( dispatch );
           
        });

    }

    public static function updateOrders( userId : Int, callbackUrl : String, multiDistribId : Int, catalogId: Int ) {
    
        return Thunk.Action( function( dispatch : redux.Redux.Dispatch, getState : Void -> OrderBoxState ) {

            var data = new Array<{ id : Int, productId : Int, qt : Float, paid : Bool, invertSharedOrder : Bool, userId2 : Int }>();
            var state : OrderBoxState = Reflect.field(getState(), "reduxApp");           

            for ( order in state.orders) {

                data.push( { id : order.id,
                            productId : order.product.id,
                            qt : order.quantity,
                            paid : order.paid,
                            invertSharedOrder : order.invertSharedOrder,
                            userId2 : order.userId2 } );
            } 

            var args = "";
            if ( multiDistribId != null ) {

                args +=  "?multiDistrib=" + multiDistribId;

                if( catalogId != null ) {

                    args +=  "&catalog=" + catalogId;
                }
            }
            else if ( catalogId != null ) {

                args +=  "?catalog=" + catalogId;
            }

            return HttpUtil.fetch( "/api/order/update/" + userId + args, POST, { orders : data }, JSON )
            .then( function( data : Dynamic ) {
                js.Browser.location.href = callbackUrl;
            })
            .catchError( function(data) {
                handleError( data, dispatch );
            });
        });

    }
    

    static var CATALOGS_CACHE = new Array<ContractInfo>();

    public static function fetchCatalogs( multiDistribId : Int ) {

        return Thunk.Action( function( dispatch : redux.Redux.Dispatch, getState : Void -> OrderBoxState ) {

            if(CATALOGS_CACHE.length==0) {
               
                //Loads all the catalogs (of variable type only) for the given multiDistrib
                return HttpUtil.fetch( "/api/order/catalogs/" + multiDistribId, GET, { catalogType: 1 }, PLAIN_TEXT )
                .then( function( data : String ) {             
                    var data : { catalogs : Array<ContractInfo> } = tink.Json.parse(data);  
                    CATALOGS_CACHE = data.catalogs;             
                    dispatch( OrderBoxAction.FetchCatalogsSuccess( data.catalogs ) );
                })
                .catchError( function(data) {                                    
                    handleError( data, dispatch );
                });
            
            }
            else {

                //from cache
                return new js.Promise(function(resolve,reject){resolve("");})
                .then(function(data){
                    dispatch( OrderBoxAction.FetchCatalogsSuccess( CATALOGS_CACHE ) );
                });
            }
        });

    }

    static var PRODUCTS_CACHE = new Map<Int,Array<ProductInfo>>(); //key is catalogId

    public static function fetchProducts( catalogId : Int ) {
    
        return redux.thunk.Thunk.Action( function( dispatch : redux.Redux.Dispatch, getState : Void -> OrderBoxState ) {
               
            //Loads all the products for the current catalog
            return HttpUtil.fetch( "/api/product/get/", GET, { catalogId : catalogId }, PLAIN_TEXT )
            .then( function( data : String ) {

            if(PRODUCTS_CACHE[catalogId]==null){

                //Loads all the products for the current catalog
                return HttpUtil.fetch( "/api/product/get/", GET, { catalogId : catalogId }, PLAIN_TEXT )
                .then( function( data : String ) {

                    var data : { products : Array<ProductInfo> } = tink.Json.parse(data);  
                    PRODUCTS_CACHE[catalogId] = data.products;             
                    dispatch( OrderBoxAction.FetchProductsSuccess( data.products ) );                                     
                })
                .catchError( function(data) {

                    handleError( data, dispatch );
                });

            }else{

                //from cache
                return new js.Promise(function(resolve,reject){resolve("");})
                .then(function(data){
                    trace("get products from cache catalog "+catalogId);
                    dispatch( OrderBoxAction.FetchProductsSuccess( PRODUCTS_CACHE[catalogId] ) );
                });

            }                  
        });

        });

    }

    static function handleError( data : Dynamic, dispatch : redux.Redux.Dispatch ) {

        var data = Std.string(data);
        if( data.substr(0,1) == "{" ) { //json error from server
            
            var data : ErrorInfos = haxe.Json.parse(data);                
            dispatch( OrderBoxAction.FetchFailure( data.error.message ) );
        }
        else { //js error
            
            dispatch( OrderBoxAction.FetchFailure( data ) );
        }
    }
	
}