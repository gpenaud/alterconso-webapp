package controller;
import service.OrderFlowService;
import Common;
import tools.ArrayTool;
import service.OrderService;

class Shop extends Controller
{
	
	var distribs : List<db.Distribution>;
	var contracts : List<db.Catalog>;
	var tmpBasket : db.TmpBasket;

	@tpl('shop/default.mtt')
	public function doDefault(md:db.MultiDistrib) {

		if(app.getCurrentGroup()==null){
			throw Redirect("/group/"+md.getGroup().id);
		}

		service.OrderService.checkTmpBasket(app.user,app.getCurrentGroup());

		var date = md.getDate();
		var place = md.getPlace();
		if(place.group.betaFlags.has(ShopV2)) throw Redirect('/shop2/${md.id}');

		var products = getProducts(md);
		view.products = products;
		view.place = place;
		view.date = date;
		view.group = place.group;
		view.multiDistrib = md;	

		//various closing dates	
		var infos = ArrayTool.groupByDate(Lambda.array(distribs), "orderEndDate");
		var str = "";
		if (Lambda.count(infos) == 1){
			str = Formatting.hDate( infos.iterator().next()[0].orderEndDate );
		}else{
			str = "<ul>";
			for( k in infos.keys()){
				str+="<li>";
				var dists = infos.get(k);
				
				if (dists.length==1){
					str += dists[0].catalog.name;
				} else {
					var tt = "";
					for(d  in dists) tt  += d.catalog.name + ". ";					
					str += '<span data-toggle="tooltip" title="$tt" style="text-decoration:underline;">Autres</span>';
				}
				
				str += ": "+Formatting.hDate(Date.fromString(k));
				str+="</li>";
			}
			str +="</ul>";
		}
		view.infos = str;


		//message if phone is required
		if(app.user!=null && md.getGroup().flags.has(db.Group.GroupFlags.PhoneRequired) && app.user.phone==null){
			app.session.addMessage(t._("Members of this group should provide a phone number. <a href='/account/edit'>Please click here to update your account</a>."),true);
		}

		//event for additionnal blocks on home page
		var e = Blocks([], "shop");
		app.event(e);
		view.blocks = e.getParameters()[0];
	}

	
	/**
	 * prints the full product list and current cart 
	 */
	public function doInit(md:db.MultiDistrib) {
		
		//init order serverside if needed		
		var tmpBasket = OrderService.getOrCreateTmpBasket(app.user,md);

		var products = [];
		var categs = new Array<{name:String,pinned:Bool,categs:Array<CategoryInfo>}>();		
		
		if (!md.getGroup().flags.has(db.Group.GroupFlags.CustomizedCategories)){			
			//TAXO CATEGORIES
			products = getProducts(md, true);
		}else{			
			//CUSTOM CATEGORIES
			products = getProducts(md, false);
		}
		
		categs = md.getGroup().getCategoryGroups();

		//clean 
		/*for ( p in order.products){
			p.product = null;
		}*/

		Sys.print( haxe.Serializer.run( {
			products:products,
			categories:categs,
			order:tmpBasket.data
		} ) );
	}
	
	/**
	 * Get the available products list
	 */
	private function getProducts(md:db.MultiDistrib,?categsFromTaxo=false):Array<ProductInfo> {

		var date = md.getDate();
		var place = md.getPlace();

		contracts = db.Catalog.getActiveContracts(app.getCurrentGroup());
	
		for (c in Lambda.array(contracts)) {
			//only varying orders
			if (c.type != db.Catalog.TYPE_VARORDER) contracts.remove(c);
			
			if (!c.isVisibleInShop()) contracts.remove(c);
		}

		view.contracts = contracts;
		
		var now = Date.now();
		var cids = Lambda.map(contracts, function(c) return c.id);
		var d1 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
		var d2 = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);

		//distribs open to orders, and where distribDate is in the date given as parameter
		distribs = db.Distribution.manager.search(($catalogId in cids) && $orderStartDate <= now && $orderEndDate >= now && $date > d1 && $end < d2 && $place == place, false);
		var products = [];
		for ( d in distribs){
			for (p in d.catalog.getProducts(true)){
				products.push( p.infos(categsFromTaxo,null,d) );
			}
		}
		return products;

		/*var cids = Lambda.map(distribs, function(d) return d.contract.id);
		var products = db.Product.manager.search(($catalogId in cids) && $active==true, { orderBy:name }, false);

		return Lambda.array(Lambda.map(products, function(p) return p.infos(categsFromTaxo)));*/
	}
	
	/**
	 * Overlay window loaded by Ajax for product Infos
	 */
	@tpl('shop/productInfo.mtt')
	public function doProductInfo(p:db.Product,?args:{distribution:db.Distribution}) {
		var d = args!=null && args.distribution!=null ? args.distribution : null;
		view.p = p.infos(null,null,d);
		view.product = p;
		view.vendor = p.catalog.vendor;
	}
	
	/**
	 * receive cart
	 */
	public function doSubmit(md:db.MultiDistrib) {
		
		var order : TmpBasketData = haxe.Json.parse(app.params.get("data"));
		var tmpBasket = OrderService.getOrCreateTmpBasket(app.user,md);	
		tmpBasket.lock();
		tmpBasket.data = order;
		tmpBasket.update();

		app.session.data.tmpBasketId = null;
		Sys.print( haxe.Json.stringify( {success:true,tmpBasketId:tmpBasket.id} ) );
		
	}
	
	/**
	 * add a product to the cart
	 */
	public function doAdd(md:db.MultiDistrib, productId:Int, quantity:Int) {
	
		var tmpBasket = OrderService.getOrCreateTmpBasket(app.user,md);			
		tmpBasket.data.products.push({ 
			productId:productId,
			quantity:quantity
		});		
		tmpBasket.update();
		Sys.print( haxe.Json.stringify( {success:true} ) );
		
	}
	
	/**
	 * remove a product from cart 
	 */
	public function doRemove(md:db.MultiDistrib, pid:Int) {
	
		var tmpBasket = OrderService.getOrCreateTmpBasket(app.user,md);
		
		for ( p in tmpBasket.data.products.copy()) {
			if (p.productId == pid) {
				tmpBasket.data.products.remove(p);
			}
		}
		tmpBasket.update();
		Sys.print( haxe.Json.stringify( { success:true } ) );		
	}
	
	
	/**
		Confirms the temporary basket.
		The user can come from the old or new shop, or from /transaction/tmpBasket.
		- clean order
		- got to next step in the flow
	**/
	@tpl('shop/needLogin.mtt')
	public function doValidate(tmpBasket:db.TmpBasket){
		
		tmpBasket.lock();
		var md = tmpBasket.multiDistrib;
		var group = md.getGroup();
		
		if (tmpBasket.data.products == null || tmpBasket.data.products.length == 0) {
			throw Error("/", t._("Your basket is empty") );
		}
		
		var products = getProducts(tmpBasket.multiDistrib);

		var errors = [];
		//order.total = 0.0;
		
		//cleaning
		var orders = tmpBasket.data.products;
		for (o in orders.copy()) {
			
			var p = db.Product.manager.get(o.productId, false);
			
			//check that the products are from this group (we never know...)
			if (p.catalog.group.id != group.id){
				throw Error("/", t._("This basket contains products from another group") );
			}
			
			//check if the product is available
			if (Lambda.find(products, function(x) return x.id == o.productId) == null) {
				errors.push( t._("This distribution does not supply the product <b>::pname::</b>",{pname:p.name}) );
				orders.remove(o);
				continue;
			}

			//check quantities ( ie : ordered a floatQt when not permitted )
			if(o.quantity==0){
				orders.remove(o);
			}

			//find distrib
			var d = Lambda.find(distribs, function(d) return d.catalog.id == p.catalog.id);
			if ( d == null ){
				errors.push( t._("This distribution does not supply the product <b>::pname::</b>",{pname:p.name}) );
				orders.remove(o);
				continue;
			}
			
			//moderate order according available stocks
			if (p.stock != null && p.catalog.hasStockManagement() ) {
				if (p.stock - o.quantity < 0) {
					var canceled = o.quantity - p.stock;
					o.quantity -= canceled;
					errors.push(t._("Order of ::pname:: reduced to ::oquantity:: to match remaining stock", {pname:p.name, oquantity:o.quantity}));
				}
			}
		
			//order.total += p.getPrice() * o.quantity;
		}
		
		//order.userId = app.user.id;
		
		if (errors.length > 0) {
			app.session.addMessage(errors.join("<br/>"), true);
		}
		
		//update tmp basket
		tmpBasket.data = {products:orders};		
		tmpBasket.update();


		//whats next
		var flow = new service.OrderFlowService().setPlace(SubmitOrder(tmpBasket));
		throw Redirect(flow.getPlaceUrl(flow.getNextPlace()));		

		
		/*if (group.hasPayments()){			
			//Go to payments page
			throw Redirect("/transaction/pay/"+tmpBasket.id);
		}else{
			//no payments, confirm direclty
			OrderService.confirmTmpBasket(tmpBasket);			
			throw Ok("/contract", t._("Your order has been confirmed") );	
		}*/

	}

	/**
		final confirmation of the basket
	**/
	function doConfirm(tmpBasket:db.TmpBasket){
		if(tmpBasket!=null){
			OrderService.confirmTmpBasket(tmpBasket);
			throw Ok("/contract", t._("Your order has been confirmed") );
		}else{
			throw Redirect("/contract");
		}
	}

	/**
		a user made an order but is not logeed in
		this page handles the login process
	**/
	@tpl('shop/needLogin.mtt')
	function doLogin(tmpBasket:db.TmpBasket){

		//Login is needed : display a loginbox
		if (app.user == null) {

			app.session.data.tmpBasketId = tmpBasket.id;
			view.redirect = sugoi.Web.getURI();
			view.group = tmpBasket.multiDistrib.getGroup();
			view.register = true;
			view.message =  t._("In order to confirm your order, You need to authenticate.");
			

		}else{
			tmpBasket.lock();

			//case where the user just logged in
			if(tmpBasket.user==null){
				tmpBasket.user = app.user;
				tmpBasket.update();
			}

			//Add the user to this group if needed
			var group = tmpBasket.multiDistrib.group;
			if (group.regOption == db.Group.RegOption.Open && db.UserGroup.get(app.user, group) == null){
				app.user.makeMemberOf( group );			
			}

			var flow = new OrderFlowService().setPlace(UserLogsIn(tmpBasket));
			throw Redirect(flow.getPlaceUrl(flow.getNextPlace()));
		}

		
	}

	
}
