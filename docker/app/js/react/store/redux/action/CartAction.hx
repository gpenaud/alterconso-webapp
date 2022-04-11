package react.store.redux.action;

import Common.ProductInfo;

enum CartAction {
	UpdateQuantity(product:ProductInfo, quantity:Int);
    AddProduct(product:ProductInfo);
    RemoveProduct(product:ProductInfo);
    ResetCart;
}

