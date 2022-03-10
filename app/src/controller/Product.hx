package controller;
import sys.db.RecordInfos;
import neko.Utf8;
import haxe.io.Encoding;
import haxe.io.Bytes;
import sugoi.form.Form;
import Common;
import sugoi.form.ListData.FormData;
import sugoi.form.elements.FloatInput;
import sugoi.form.elements.FloatSelect;
import sugoi.form.elements.IntSelect;
using Std;

class Product extends Controller
{
	public function new()
	{
		super();
		view.nav = ["contractadmin","products"];
	}
	
	@tpl('form.mtt')
	function doEdit(product:db.Product) {
		
		if (!app.user.canManageContract(product.catalog)) throw t._("Forbidden access");
		
		var f = form.CagetteForm.fromSpod(product);
		
		//stock mgmt ?
		if (!product.catalog.hasStockManagement()){
			f.removeElementByName('stock');	
		} else {
			if(product.catalog.isCSACatalog()){
				//manage stocks by distributions for CSA contracts
				var stock = f.getElement("stock");
				stock.label = "Stock (par distribution)";				 
				if(product.stock!=null){
					stock.value = Math.floor( product.stock / product.catalog.getDistribs(false).length );
				}
				
			}
		}
		
		//VAT selector
		f.removeElement( f.getElement('vat') );		
		var data :FormData<Float> = [];
		for (k in app.user.getGroup().vatRates.keys()) {
			data.push( { label:k, value:app.user.getGroup().vatRates[k] } );
		}
		f.addElement( new FloatSelect("vat", "TVA", data, product.vat ) );

		f.removeElementByName("catalogId");
		
		//Product Taxonomy:
		if(!product.catalog.group.flags.has(CustomizedCategories)){
			var txId = product.txpProduct == null ? null : product.txpProduct.id;
			var html = service.ProductService.getCategorizerHtml(product.name,txId,f.name);
			f.addElement(new sugoi.form.elements.Html("html",html, 'Nom'),1);
		}else{
			f.removeElementByName("txpProductId");
		}
		
		if (f.isValid()) {
			f.toSpod(product);

			//manage stocks by distributions for CSA contracts
			if(product.catalog.isCSACatalog() && product.stock!=null){
				product.stock = (f.getValueOf("stock"):Float) * product.catalog.getDistribs(false).length;
			}

			app.event(EditProduct(product));
			product.update();
			throw Ok('/contractAdmin/products/'+product.catalog.id, t._("The product has been updated"));
		}else{
			app.event(PreEditProduct(product));
		}
		
		view.form = f;
		view.title = t._("Modify a product");
	}
	
	@tpl("form.mtt")
	public function doInsert(contract:db.Catalog ) {
		
		if (!app.user.isContractManager(contract)) throw Error("/", t._("Forbidden action")); 
		
		var d = new db.Product();
		var f = form.CagetteForm.fromSpod(d);
		
		f.removeElementByName("catalogId");
		
		//stock mgmt ?
		if (!contract.hasStockManagement()) f.removeElementByName('stock');
		
		//vat selector
		f.removeElement( f.getElement('vat') );
		var data = [];
		for (k in app.user.getGroup().vatRates.keys()) {
			data.push( { value:app.user.getGroup().vatRates[k], label:k } );
		}
		f.addElement( new FloatSelect("vat", "TVA", data, d.vat ) );
		
		var formName = f.name;
		var html = service.ProductService.getCategorizerHtml("",null,formName);
		f.addElement(new sugoi.form.elements.Html("html",html, 'Nom'),1);
		
		if (f.isValid()) {
			f.toSpod(d);
			d.catalog = contract;
			app.event(NewProduct(d));
			d.insert();
			throw Ok('/contractAdmin/products/'+d.catalog.id, t._("The product has been saved"));
		}else{
			app.event(PreNewProduct(contract));
		}
		
		view.form = f;
		view.title = t._("Key-in a new product");
	}
	
	public function doDelete(p:db.Product) {
		
		if (!app.user.canManageContract(p.catalog)) throw t._("Forbidden access");
		
		if (checkToken()) {
			
			app.event(DeleteProduct(p));
			
			var orders = db.UserOrder.manager.search($productId == p.id, false);
			if (orders.length > 0) {
				throw Error("/contractAdmin", t._("Not possible to delete this product because some orders are referencing it"));
			}
			var cid = p.catalog.id;
			p.lock();
			p.delete();
			
			throw Ok("/contractAdmin/products/"+cid, t._("Product deleted"));
		}
		throw Error("/contractAdmin", t._("Token error"));
	}
	
	
	@tpl('product/import.mtt')
	function doImport(c:db.Catalog, ?args: { confirm:Bool } ) {
		
		if (!app.user.canManageContract(c)) throw t._("Forbidden access");
			
		var csv = new sugoi.tools.Csv();
		csv.step = 1;
		var request = sugoi.tools.Utils.getMultipart(1024 * 1024 * 4);
		csv.setHeaders( ["productName","price","ref","desc","qt","unit","organic","floatQt","vat","stock"] );
		view.contract = c;
		
		// get the uploaded file content
		if (request.get("file") != null) {
			var csvData = request.get("file");
			csvData = Formatting.utf8(csvData);
			var datas = csv.importDatasAsMap(csvData);
			
			app.session.data.csvImportedData = datas;
			
			csv.step = 2;
			view.csv = csv;
		}
		
		if (args != null && args.confirm) {
			var i : Iterable<Map<String,String>> = cast app.session.data.csvImportedData;
			var fv = new sugoi.form.filters.FloatFilter();
			
			for (p in i) {
				
				if (p["productName"] != null){

					var product = new db.Product();
					product.name = p["productName"];
					product.price = fv.filterString(p["price"]);
					product.ref = p["ref"];
					product.desc = p["desc"];
					product.vat = fv.filterString(p["vat"]);
					product.qt = fv.filterString(p["qt"]);
					if(p["unit"]!=null){
						product.unitType = switch(p["unit"].toLowerCase()){
							case "kg" : Kilogram;
							case "g" : Gram;
							case "l" : Litre;
							case "cl" : Centilitre;
							case "litre" : Litre;
							case "ml" : Millilitre;
							default : Piece;
						}
					}
					if (p["stock"] != null) product.stock = fv.filterString(p["stock"]);
					product.organic = p["organic"] != null;
					product.hasFloatQt = p["floatQt"] != null;
					
					product.catalog = c;
					product.insert();
				}
				
			}
			
			view.numImported = app.session.data.csvImportedData.length;
			app.session.data.csvImportedData = null;
			
			csv.step = 3;
		}
		
		if (csv.step == 1) {
			//reset import when back to import page
			app.session.data.csvImportedData =	null;
		}
		
		view.step = csv.step;
	}
	
	@tpl("product/categorize.mtt")
	public function doCategorize(contract:db.Catalog) {
		
		
		if (!app.user.canManageContract(contract)) throw t._("Forbidden access");
		
		if (db.CategoryGroup.get(app.user.getGroup()).length == 0) throw Error("/contractAdmin", t._("You must first define categories before you can assign a category to a product"));
		
		//var form = new sugoi.form.Form("cat");
		//
		//for ( g in db.CategoryGroup.get(app.user.getGroup())) {
			//var data = [];
			//for ( c in g.getCategories()) {
				//data.push({key:Std.string(c.id),value:c.name});
			//}
			//form.addElement(new sugoi.form.elements.Selectbox("cats"+g.id,g.name,data));
		//}
		//
		//view.form = form;
		view.c = contract;
		
	}
	
	/**
	 * init du Tagger
	 * @param	contract
	 */	
	public function doCategorizeInit(contract:db.Catalog) {
		
		if (!app.user.canManageContract(contract)) throw t._("Forbidden access");
		
		var data : TaggerInfos = {
			products:[],
			categories:[]
		}
		
		for (p in contract.getProducts()) {
			
			data.products.push({product:p.infos(),categories:Lambda.array(Lambda.map(p.getCategories(),function(x) return x.id))});
		}
		
		for (cg in db.CategoryGroup.get(app.user.getGroup())) {
			
			var x = { id:cg.id, categoryGroupName:cg.name, color:Formatting.intToHex(db.CategoryGroup.COLORS[cg.color]),tags:[] };
			
			for (t in cg.getCategories()) {
				x.tags.push({id:t.id,name:t.name});
			}
			data.categories.push(x);
			
		}
		
		Sys.print(haxe.Json.stringify(data));
	}
	
	public function doCategorizeSubmit(contract:db.Catalog) {
		
		if (!app.user.canManageContract(contract)) throw t._("Forbidden access");
		
		var data : TaggerInfos = haxe.Json.parse(app.params.get("data"));
		
		db.ProductCategory.manager.unsafeDelete("delete from ProductCategory where productId in (" + Lambda.map(contract.getProducts(), function(t) return t.id).join(",")+")");
		
		for (p in data.products) {
			for (t in p.categories) {
				var x = new db.ProductCategory();
				x.category = db.Category.manager.get(t, false);
				x.product = db.Product.manager.get(p.product.id,false);
				x.insert();				
			}
		}
		
		Sys.print(t._("Modifications saved"));
	}
	
	


	
	/*@tpl('product/compose.mtt')
	function doCompose(){}
	*/

	//use API now !
	/*function doGetTaxo(){
		
		var out : TxpDictionnary = {products:new Map(), categories:new Map(), subCategories:new Map()};
		
		for ( p in db.TxpProduct.manager.all()){
			out.products.set(p.id, {id:p.id, name:p.name, category:p.category.id, subCategory:p.subCategory.id});			
		}
		
		for ( c in db.TxpCategory.manager.all()){
			out.categories.set(c.id, c.infos());
		}
		
		for ( c in db.TxpSubCategory.manager.all()){
			out.subCategories.set(c.id, c.infos());
		}
		
		Sys.print(haxe.Serializer.run(out));
		
	}*/

	
	
	
	
}