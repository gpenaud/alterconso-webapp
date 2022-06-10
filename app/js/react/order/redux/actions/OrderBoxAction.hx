package react.order.redux.actions;

import Common.ContractInfo;
import Common.ProductInfo;
import Common.UserOrder;
import Common.UserInfo;


enum OrderBoxAction
{
    FetchOrdersSuccess( orders : Array<UserOrder> );
    FetchUsersSuccess( users : Array<UserInfo> );
    SelectUser( userId : Int, userName : String );
    UpdateOrderQuantity( orderId : Int, quantity : Float );
    ReverseOrderRotation( orderId : Int, reverseRotation : Bool );
    UpdateOrderUserId2( orderId : Int, userId2 : Int );
    UpdatePaid( orderId : Int, paid : Bool );    
    FetchCatalogsSuccess( catalogs : Array<ContractInfo> );
    SelectCatalog( catalogId : Int );
    FetchProductsSuccess( products : Array<ProductInfo> );
    SelectProduct( productId : Int );                
    FetchFailure( error : String );
}