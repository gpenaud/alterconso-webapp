package controller.api;
import haxe.Json;
import tink.core.Error;
import service.OrderService;
import Common;

/**
 * Public order API
 */
class Order extends Controller
{
	public function doCatalogs( multiDistrib : db.MultiDistrib, ?args : { catalogType : Int } ) {

		var catalogs = new Array<ContractInfo>();
		var type = ( args != null && args.catalogType != null ) ? args.catalogType : null;
		for( distrib in multiDistrib.getDistributions(type) ) {
			
			var image = distrib.catalog.vendor.image == null ? null : view.file( distrib.catalog.vendor.image );
			catalogs.push( { id : distrib.catalog.id, name : distrib.catalog.name, image : image } );
		}

		Sys.print( Json.stringify({ success : true, catalogs : catalogs }) );

	}

	function checkRights(user:db.User,catalog:db.Catalog,multiDistrib:db.MultiDistrib){

		if( catalog==null && multiDistrib==null ) throw new Error("You should provide at least a catalog or a multiDistrib");
		if( catalog!=null && catalog.type==db.Catalog.TYPE_CONSTORDERS && multiDistrib!=null ) throw new Error("You cant edit a CSA catalog for a multiDistrib");
		
		//rights	
		if (catalog==null && !app.user.canManageAllContracts()) throw new Error(403,t._("Forbidden access"));
		if (catalog!=null && !app.user.canManageContract(catalog)) throw new Error(403,t._("You do not have the authorization to manage this catalog"));
		if ( multiDistrib != null && multiDistrib.isValidated() ) throw new Error(t._("This delivery has been already validated"));
	}

	/**
		Get orders of a user for a multidistrib.
		Possible to filter for a distribution only
		(Used by OrderBox react component)

		catalog arg : we want to edit the orders of one single catalog/contract
		multiDistrib arg : we want to edit the orders of the whole distribution
	 */	
	public function doGet( user : db.User, args : { ?catalog : db.Catalog, ?multiDistrib : db.MultiDistrib } ) {

		checkIsLogged();
		var catalog = ( args != null && args.catalog != null ) ? args.catalog : null;
		var multiDistrib = ( args != null && args.multiDistrib != null ) ? args.multiDistrib : null;

		checkRights( user, catalog, multiDistrib );

		/*var subscription : db.Subscription = null;
		if ( catalog != null && catalog.type == db.Catalog.TYPE_CONSTORDERS ) {

			//The user needs a subscription for this catalog to have orders
			subscription = service.SubscriptionService.getUserCatalogSubscription( user, catalog, true );
			if ( subscription == null ) {				
				throw new Error( "Il n\'y a pas de souscription à ce nom. Il faut d\'abord créer une souscription pour cette personne pour pouvoir ajouter des commandes."  );
			}
		}*/

		var orders : Array<db.UserOrder> = OrderService.getUserOrders( user, catalog, multiDistrib /*, subscription*/ );
		Sys.print( tink.Json.stringify( { success : true, orders : OrderService.prepare(orders) } ) );
	}
	
	/**
	 * Update orders of a user ( from react OrderBox component )
	 * @param	userId
	 */
	public function doUpdate( user : db.User, args : { ?catalog : db.Catalog, ?multiDistrib : db.MultiDistrib } ) {

		checkIsLogged();
		var catalog = ( args != null && args.catalog != null ) ? args.catalog : null;
		var multiDistrib = ( args != null && args.multiDistrib != null ) ? args.multiDistrib : null;
		checkRights( user, catalog, multiDistrib );
		
		//POST payload
		var ordersData = new Array< { id : Int, productId : Int, qt : Float, paid : Bool, invertSharedOrder : Bool, userId2 : Int } >();
		
		var raw = StringTools.urlDecode( sugoi.Web.getPostData() );
		
		if( raw == null ) {

			throw new Error( 'Order datas are null' );
		}
		else {

			ordersData = haxe.Json.parse(raw).orders;
		}

		OrderService.createOrUpdateOrders( user, multiDistrib, catalog, ordersData );
		Sys.print( Json.stringify( { success : true, orders : ordersData } ) );

	}
	
}
