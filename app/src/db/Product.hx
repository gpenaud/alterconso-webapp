package db;
import sys.db.Object;
import sys.db.Types;
import Common;
using tools.FloatTool;

/**
 * Product
 */
class Product extends Object
{
	public var id : SId;
	public var name : SString<128>;	
	public var ref : SNull<SString<32>>;	//référence produit
	
	@hideInForms  @:relation(catalogId) public var catalog : db.Catalog;
	
	//prix TTC
	public var price : SFloat;
	public var vat : SFloat;			//VAT rate in percent
	
	public var desc : SNull<SText>;
	public var stock : SNull<SFloat>; //if qantity can be float, stock should be float
	
	public var unitType : SNull<SEnum<Unit>>; // Kg / L / g / units
	public var qt : SNull<SFloat>;
	
	public var organic : SBool;
	public var variablePrice : Bool; 	//price can vary depending on weighting of the product
	public var multiWeight : Bool;		//product cannot be cumulated in one order record

	//https://docs.google.com/document/d/1IqHN8THT6zbKrLdHDClKZLWgKWeL0xw6cYOiFofw04I/edit
	@hideInForms public var wholesale : Bool;	//this product is a wholesale product (crate,bag,pallet)
	@hideInForms public var retail : Bool;		//this products is a fraction of a wholesale product
	@hideInForms public var bulk : Bool;		//(vrac) warn the customer this product is not packaged
	public var hasFloatQt:SBool; //deprecated : this product can be ordered in "float" quantity
	
	@hideInForms @:relation(imageId) public var image : SNull<sugoi.db.File>;
	@:relation(txpProductId) public var txpProduct : SNull<db.TxpProduct>; //taxonomy	
	
	public var active : SBool; 	//if false, product disabled, not visible on front office
	
	
	public function new() 
	{
		super();
		//type = 0;
		organic = false;
		hasFloatQt = false;
		active = true;
		variablePrice = false;
		multiWeight = false;
		wholesale = false;
		retail = false;
		bulk = false;
		vat = 5.5;
		unitType = Unit.Piece;
		qt = 1;
		
	}
	
	/**
	 * Returns product image URL
	 */
	public function getImage() {
		if (image == null) {
			if (txpProduct != null){				
				return "/img/taxo/grey/" + txpProduct.category.image + ".png";
			}else{
				return "/img/taxo/grey/fruits-legumes.png";
			}			
		}else {
			return App.current.view.file(image);
		}
	}
	
	public function getName(){	
		if (unitType != null && qt != null && qt != 0){
			return name +" " + qt + " " + Formatting.unit(unitType);
		}else{
			return name;
		}
	}
	
	override function toString() {
		return getName();
	}
	
	/**
	 * get price including margins
	 */
	public function getPrice():Float{
		return (price + catalog.computeFees(price)).clean();
	}
	
	/**
	   get product infos as an anonymous object 
	   @param	CategFromTaxo=false
	   @param	populateCategories=tru
	   @return
	**/
	public function infos(?categFromTaxo=false,?populateCategories=true,?distribution:db.Distribution):ProductInfo {
		var o :ProductInfo = {
			id : id,
			ref : ref,
			name : name,
			image : getImage(),
			price : getPrice(),
			vat : vat,
			vatValue: (vat != 0 && vat != null) ? (  this.price - (this.price / (vat/100+1))  )  : null,
			catalogTax : catalog.percentageValue,
			catalogTaxName : catalog.percentageName,
			desc : App.current.view.nl2br(desc),
			categories : null,
			subcategories:null,
			orderable : this.catalog.isUserOrderAvailable(),
			stock : catalog.hasStockManagement() ? this.stock : null,
			hasFloatQt : hasFloatQt,
			qt:qt,
			unitType:unitType,
			organic:organic,
			variablePrice:variablePrice,
			wholesale:wholesale,
			bulk:bulk,
			active: active,
			distributionId : distribution==null ? null : distribution.id,
			catalogId : catalog.id,
			vendorId : catalog.vendor.id,
		}
		
		if(populateCategories){
			//custom categories 
			if (this.catalog.group.flags.has(CustomizedCategories)){

				o.categories = Lambda.array(Lambda.map(getCategories(), function(c) return c.id));
				o.subcategories = o.categories;
				
			}else{
				//standard categories
				if(txpProduct!=null){
					o.categories = [txpProduct.category.id];
					o.subcategories = [txpProduct.subCategory.id];
				}else{
					//get the "Others" category
					var txpOther = db.TxpProduct.manager.get(679,false);
					if(txpOther!=null){
						o.categories = [txpOther.category.id];
						o.subcategories = [txpOther.subCategory.id];
					}
				}
				
			}
		}

		App.current.event(ProductInfosEvent(o,distribution));
		
		return o;
	}
	
	/**
	 * customs categs
	 */
	public function getCategories() {		
		//"Types de produits" categGroup first
		//var pc = db.ProductCategory.manager.search($productId == id, {orderBy:categoryId}, false);		
		return Lambda.map(db.ProductCategory.manager.search($productId == id,{orderBy:categoryId},false), function(x) return x.category);
	}
	
	/**
	 * general categs
	 */
	public function getFullCategorization(){
		if (txpProduct == null) return [];
		return txpProduct.getFullCategorization();
	}
	
	public static function getByRef(c:db.Catalog, ref:String){
		var pids = tools.ObjectListTool.getIds(c.getProducts(false));
		return db.Product.manager.select($ref == ref && $id in pids, false);
	}

	function check(){		
		//Fix values that will make mysql 5.7 scream
		if(this.vat==null) this.vat=0;
		if(this.name.length>128) this.name = this.name.substr(0,128);
		if(qt==0.0) qt = null;
		//round like 0.00
		price = Formatting.roundTo(price,2);
	}

	override public function update(){
		check();
		super.update();
	}

	override public function insert(){
		check();
		super.insert();
	}

	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"name" 				=> t._("Product name"),
			"ref" 				=> t._("Product ID"),
			"price" 			=> t._("Price"),
			"desc" 				=> t._("Description"),
			"stock" 			=> t._("Stock"),
			"unitType" 			=> t._("Base unit"),
			"qt" 				=> t._("Quantity"),			
			"hasFloatQt" 		=> t._("Allow fractional quantities"),			
			"active" 			=> t._("Available"),			
			"organic" 			=> t._("Organic agriculture"),			
			"vat" 				=> t._("VAT Rate"),			
			"variablePrice"		=> t._("Variable price based on weight"),			
			"multiWeight" 		=> t._("Multi-weighing"),	
		];
	}
	
}

