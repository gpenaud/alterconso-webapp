import js.html.NodeList;
import js.html.Node;
import js.Browser;
import Common;
import js.jquery.JQuery;
import utils.DOMUtils;
/**
 * JS Shopping Cart
 **/
class ShopCart
{
	public var products : Map<Int,ProductInfo>; //product db
	public var productsArray : Array<ProductInfo>; //to keep order of products
	public var categories : Array<{name:String,pinned:Bool,categs:Array<CategoryInfo>}>; //categ db
	public var pinnedCategories : Array<{name:String,pinned:Bool,categs:Array<CategoryInfo>}>; //categ db
	public var order : TmpBasketData;
	
	// var loader : JQuery; //ajax loader gif
	
	//for scroll mgmt
	var cartTop : Int;
	var cartLeft : Int;
	var cartWidth : Int;
	var jWindow : JQuery;
	var cartContainer : JQuery;
	
	// var date : String;
	// var place : Int;
	var multiDistribId : Int;


	public function new() {
		products = new Map();
		productsArray = [];		
		order = { products:[] };
		categories = [];
		pinnedCategories = [];
	}
	
	public function add(pid:Int) {
		// loader.show();
		toggleLoader(true);
		
		var q = untyped Browser.document.getElementById('productQt' + pid).value;
		var qt = 0.0;
		var p = this.products.get(pid);
		if (p.hasFloatQt) {
			q = StringTools.replace(q, ",", ".");
			qt = Std.parseFloat(q);
		} else {
			qt = Std.parseInt(q);			
		}
		
		if (qt == null) {
			qt = 1;
		}
		
		//add server side
		var r = new haxe.Http('/shop/add/$multiDistribId/$pid/$qt');
		r.onData = function(data:String) {
			// loader.hide();
			toggleLoader(false);
			var d = haxe.Json.parse(data);
			if (!d.success) js.Browser.alert("Erreur : "+d);
			subAdd(pid, qt);
			render();
		}
		r.request();
	}
	
	function subAdd(pid, qt:Float ) {
		for ( p in order.products) {
			if (p.productId == pid) {
				p.quantity += qt;
				render();
				return;
			}
		}
		order.products.push({ productId:pid, quantity:qt });
	}
	
	/**
	 * Render the shopping cart and total
	 */
	function render() {
		var cartEl = Browser.document.getElementById("cart");
		cartEl.innerHTML = "";
		
		//render items in shopping cart
		for (x in order.products) {
			var p = this.products.get(x.productId);
			if (p == null) return;

			var row = Browser.document.createElement("div");
			row.className = "row";
			cartEl.appendChild(row);

			var col1 = Browser.document.createElement("div");
			col1.className = "order col-md-9";
			col1.innerHTML = "<b> " + x.quantity + " </b> x " + p.name;
			row.appendChild(col1);

			var col2 = Browser.document.createElement("div");
			col2.className = "col-md-3";
			row.appendChild(col2);

			var btn = Browser.document.createElement("a");
			btn.className = "btn btn-default btn-xs";
			for (att in [
				{name: "data-toggle", value: "tooltip"},
				{name: "data-placement", value: "top"},
				{name: "title", value: "Retirer de la commande"},
			]) {
				btn.setAttribute(att.name, att.value);
			}
			btn.innerHTML = "<i class='icon icon-delete'></i>";
			btn.onclick = () -> remove(p.id);
			col2.appendChild(btn);
		}
		
		//compute total price
		var total = 0.0;
		for (p in order.products) {
			var pinfo = products.get(p.productId);
			if (pinfo == null) continue;
			total += p.quantity * pinfo.price;
		}
		var ffilter = new sugoi.form.filters.FloatFilter();
		
		var total = ffilter.filterString(Std.string(App.roundTo(total,2)));
		var totalEl = Browser.document.createElement("div");
		totalEl.className = "total";
		totalEl.innerHTML = "TOTAL : " + total;
		cartEl.appendChild(totalEl);
		
		
		if (order.products.length > 0){
			App.instance.setWarningOnUnload(true,"Vous avez une commande en cours. Si vous quittez cette page sans confirmer, votre commande sera perdue.");
		}else{
			App.instance.setWarningOnUnload(false);
		}
	}

	function findCategoryName(cid:Int):String{
		for ( cg in this.categories ){
			for (c in cg.categs){
				if (cid == c.id) {
					return c.name;
				}
			}
		}
		for ( cg in this.pinnedCategories ){
			for (c in cg.categs){
				if (cid == c.id) {
					return c.name;
				}
			}
		}
		return null;
	}

	/**
	 * Dynamically sort products by categories
	 */
	public function sortProductsBy() {
		var groups = new Map<Int,{name:String,products:Array<ProductInfo>}>();
		var pinned = new Map<Int,{name:String,products:Array<ProductInfo>}>();
		var firstCategGroup = this.categories[0].categs;
		var pList = this.productsArray.copy();

		for (p in pList.copy()) {
			untyped p.element.parentNode.removeChild(p.element);
			for (categ in p.categories) {
				if (Lambda.find(firstCategGroup, function(c) return c.id == categ) != null) {
					//is in this category group
					var g = groups.get(categ);
					if ( g == null){
						var name = findCategoryName(categ);
						g = {name:name,products:[]};
					}
					g.products.push(p);
					pList.remove(p);
					groups.set(categ, g);
				} else {
					var isInPinnedCateg = false;
					for (cg in pinnedCategories) {
						if (Lambda.find(cg.categs, function(c) return c.id == categ) != null){
							isInPinnedCateg = true;
							break;
						}
					}
					if (isInPinnedCateg) {
						var c = pinned.get(categ);
						if (c == null) {
							var name = findCategoryName(categ);
							c = {name:name,products:[]};
						}
						c.products.push(p);
						pList.remove(p);
						pinned.set(categ, c);
					} else {
						//not in the selected categ nor in pinned groups
						continue;
					}
				}
			}
		}

		if (pList.length > 0) {
			groups.set(0,{name:"Autres",products:pList});
		}

		var containerEl = Browser.document.querySelector(".shop .body");

		//render firts "pinned" groups , then "groups"
		for (source in [pinned, groups]) {
			for (o in source){
				if (o.products.length == 0) continue;

				var row = Browser.document.createElement("div");
				row.className = "col-md-12 col-xs-12 col-sm-12 col-lg-12";
				row.innerHTML = "<div class='catHeader'>" + o.name + "</div>";
				containerEl.appendChild(row);

				for (p in o.products) {
					if (untyped p.element.parentNode == null || untyped p.element.parentNode.length == 0) {
						containerEl.appendChild(untyped p.element);
					} else {
						var clone = untyped p.element.cloneNode(true);
						containerEl.appendChild(clone);
					}
				}
			}
		}

		var productNodeEls = Browser.document.querySelectorAll(".product");
		for (i in 0...productNodeEls.length) {
			untyped productNodeEls[i].style.display = "block";
		}
	}

	/**
	 * is shopping cart empty ?
	 */
	public function isEmpty(){
		return order.products.length == 0;
	}

	/**
     * submit cart
     */
	public function submit() {
		var req = new haxe.Http("/shop/submit/"+multiDistribId);
		req.onData = function(data) {
			var data : {tmpBasketId:Int,success:Bool} = haxe.Json.parse(data);
			App.instance.setWarningOnUnload(false);
			js.Browser.location.href = "/shop/validate/"+data.tmpBasketId;
		}
		req.addParameter("data", haxe.Json.stringify(order));
		req.request(true);		
	}
	
	/**
	 * filter products by category
	 */
	public function filter(cat:Int) {
		var tags = Browser.document.querySelectorAll(".tag");
		for (i in 0...tags.length) {
			var tag: js.html.Element = cast tags[i];
			tag.classList.remove("active");
			var icon = tag.querySelector("i");
			if (icon != null) tag.removeChild(icon);
		}

		var current = Browser.document.getElementById("tag" + cat);
		current.classList.add("active");
		current.innerHTML = "<i class='icon icon-check'></i> " + current.innerHTML;
		
		//affiche/masque produits
		for (p in products) {
			if (cat==0 || Lambda.has(p.categories, cat)) {
				DOMUtils.fadeIn(Browser.document.querySelector(".shop .product" + p.id));
			}else {
				DOMUtils.fadeOut(Browser.document.querySelector(".shop .product" + p.id));
			}
		}
	}
	
	/**
	 * remove a product from cart
	 * @param	pid
	 */
	public function remove(pid:Int ) {
		// loader.show();
		toggleLoader(true);
		
		//add server side
		var r = new haxe.Http('/shop/remove/$multiDistribId/$pid');
		
		r.onData = function(data:String) {
			// loader.hide();
			toggleLoader(false);
			
			var d = haxe.Json.parse(data);
			if (!d.success) js.Browser.alert("Erreur : "+d);
			
			//remove locally
			for ( p in order.products.copy()) {
				if (p.productId == pid) {
					order.products.remove(p);
					render();
					return;
				}
			}
			render();
		}
		r.request();
	}
	
	/**
	 * loads products DB and existing cart in ajax
	 */
	public function init(multiDistribId:Int) {
		this.multiDistribId = multiDistribId;
		var req = new haxe.Http("/shop/init/"+multiDistribId);
		req.onData = function(data) {
			toggleLoader(false);
			
			var data : { 
				products:Array<ProductInfo>,
				categories:Array<{name:String,pinned:Bool,categs:Array<CategoryInfo>}>,
				order:TmpBasketData } = haxe.Unserializer.run(data);

			//populate local categories lists
			for ( cg in data.categories){
				if (cg.pinned){
					pinnedCategories.push(cg);
				} else {
					categories.push(cg);
				}
			}

			//product DB
			for (p in data.products) {
				//catch dom element for further usage
				untyped p.element = Browser.document.querySelector(".product"+p.id);

				var id : Int = p.id;
				//var id : Int = p.id;
 				//id = id + 1;
				this.products.set(id, p);
				this.productsArray.push(p);
			}
			
			//existing order
			for ( p in data.order.products) {
				subAdd(p.productId,p.quantity );
			}
			render();
			sortProductsBy();
		}
		req.request();
		
		//DISABLED : pb quand le panier est plus haut que l'ecran
		//scroll mgmt, only for large screens. Otherwise let the cart on page bottom.
		/*if (js.Browser.window.matchMedia("(min-width: 1024px)").matches) {
			
			jWindow = App.jq(js.Browser.window);
			cartContainer = App.jq("#cartContainer");
			cartTop = cartContainer.position().top;
			cartLeft = cartContainer.position().left;
			cartWidth = cartContainer.width();
			jWindow.scroll(onScroll);
			
		}*/ 	
	}
	
	/**
	 * keep the cart on top when scrolling
	 * @param	e
	 */
	public function onScroll(e:Dynamic) {
		
		//cart container top position		
		
		if (jWindow.scrollTop() > cartTop) {
			cartContainer.addClass("scrolled");
			cartContainer.css('left', Std.string(cartLeft) + "px");			
			cartContainer.css('top', Std.string(/*cartTop*/10) + "px");
			cartContainer.css('width', Std.string(cartWidth) + "px");
			
		}else {
			cartContainer.removeClass("scrolled");
			cartContainer.css('left',"");
			cartContainer.css('top', "");
			cartContainer.css('width', "");
		}
	}


	private function toggleLoader(show: Bool) {
		Browser.document.getElementById("loader").style.display = show ? "block" : "none";
	}
	
}