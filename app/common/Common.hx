/**
 * Common.hx : Shared entities between server and client
 */
//serialized in DB , so we cant move its place!!!
/*enum Right{
	GroupAdmin;					//can manage whole group
	ContractAdmin(?cid:Int);	//can manage one or all contracts
	Membership;					//can manage group members
	Messages;					//can send messages
}*/
#if sys
typedef Right = db.UserGroup.Right;
#end

//typedef Rights = Array<Right>;

/*@:enum
abstract Entity(String) {
	var User 	= "user";
	var Vendor 	= "vendor";
	var Group 	= "group";
	var Product = "product";
}*/

@:keep
typedef OrderSimple = {
	products: Array<ProductWithQuantity>,
	total:Float,//total price
	count:Int,	//Nombre de produits avec quantité
}

//A temporary order, waiting for being paid and definitely recorded.
/*@:keep
typedef OrderInSession = {
	products:Array <{
		productId:Int,
		quantity:Float,
		#if !js
		?product:db.Product,
		?distributionId:Int,
		#end
	} > ,	
	total:Float, 	//price to pay
	?userId:Int,
	?paymentOp:Int, //payment operation ID
}*/

//OrderInSession v2 for db.TmpBasket
typedef TmpBasketData = {
	products:Array <{
		productId:Int,
		quantity:Float,
	}> ,		
}

@:keep
typedef VendorInfos = {
	id 		: Int,
	name 	: String,
	desc 	: String,
	longDesc: String,
	image 	: String,//logo
	profession : String,
	?offCagette : String,
	?images : {
		logo:String,
		portrait:String,
		banner:String,
		farm1:String,
		farm2:String,
		farm3:String,
		farm4:String,
	},
	zipCode : String,
	city : String,
	linkText:String,
	linkUrl:String,
}

#if plugins 
typedef CagetteProInfo = VendorInfos;
#end

typedef ContractInfo = {
	id:Int,
	name:String,
	image:Null<String>

}

typedef GroupInfo = {
	id : Int,
	name : String,
}

@:keep
typedef ProductInfo = {
	id : Int,
	name : String,
	ref : Null<String>,
	image : Null<String>,	
	price : Float,
	vat : Null<Float>,					//VAT rate
	vatValue : Null<Float>,				//amount of VAT included in the price
	desc : Null<String>,
	categories : Null<Array<Int>>,	//used in old shop
	subcategories : Null<Array<Int>>,  //used in new shop
	orderable : Bool,			//can be currently ordered
	stock: Null<Float>,			//available stock
	hasFloatQt : Bool,
	qt:Null<Float>,
	unitType:Null<Unit>,

	organic:Bool,
	variablePrice:Bool,
	wholesale:Bool,
	active:Bool,
	bulk:Bool,

	catalogId : Int,
	catalogTax : Null<Float>, 		//pourcentage de commission défini dans le contrat
	catalogTaxName : Null<String>,	//label pour la commission : ex: "frais divers"
	?vendorId : Int,
	?distributionId:Null<Int>, //in the context of a distrib
}

//used in shop client
@:keep
typedef ProductWithQuantity = {
	product: ProductInfo,
	quantity: Int
}

@:keep
typedef DistributionInfos = {
	id:Int,
	vendorId:Int,
	groupId:Int,
	groupName:String,
	distributionStartDate:Float,
	distributionEndDate:Float,
	orderStartDate:Float,
	orderEndDate:Float,
	place:PlaceInfos,
}

//This is used by Mangopay to know which document types to ask for KYC compliance

enum Unit{
	Piece;
	Kilogram;
	Gram;
	Litre;
	Centilitre;
	Millilitre;
}

typedef CategoryInfo = {
	id:Int,
	name:String,
	?image : String,
	?subcategories:Array<CategoryInfo>,
	?displayOrder:Int,
}

/**
 * datas used with the "tagger" ajax class
 */
@:keep
typedef TaggerInfos = {
	products:Array<{product:ProductInfo,categories:Array<Int>}>,//tagged products
	categories : Array<{id:Int,categoryGroupName:String,color:String,tags:Array<{id:Int,name:String}>}>, //groupe de categories + tags
}

/**
 * Links in navbars for plugins
 */
typedef Link = {
	id:String,
	link:String,
	name:String,
	?icon:String,
}

typedef Block = {
	id:String,
	title:String,
	?icon:String,
	html:String
}

typedef UserOrder = {
	id:Int,
	?basketId:Int,
	userId:Int,
	userName:String,
	?userEmail : String,
	
	?userId2:Int,
	?userName2:String,
	?userEmail2:String,
	
	//deprecated
	?productId:Int,
	?productRef:String,
	?productName:String,	
	?productPrice:Float,
	?productImage:String,
	?productQt:Float,
	?productUnit:Unit,
	?productHasFloatQt:Bool,
	?productHasVariablePrice:Bool,

	//new way
	?product:ProductInfo,

	quantity:Float,
	smartQt:String,
	subTotal:Float,
	
	?fees:Null<Float>,
	?percentageName:Null<String>,
	?percentageValue:Null<Float>,
	total:Float,
	
	//flags
	paid:Bool,
	invertSharedOrder:Bool,
	?canceled:Bool,	
	?canModify:Bool,
	
	catalogId:Int,
	catalogName:String,
}



typedef PlaceInfos = {
	id:Int,
	name:String,
	address1:String,
	address2:String,
	zipCode:String,
	city:String,
	latitude:Float,
	longitude:Float
}

typedef UserInfo = {
	id:Int,
	name:String,
	firstName:String,
	lastName:String,
	email:String,
	?phone:String,
	?city:String,
	?zipCode:String,
	?address1:String,
	?address2:String,
}

typedef UserList = {
	id:String,
	name:String,
	count:Int
}

typedef GroupOnMap = {
	id:Int,
	name:String,
	image:String,
	place:PlaceInfos,	
}

enum OrderFlags {
	InvertSharedOrder;	//invert order when there is a shared/alternated order
	//Canceled;			//flag for cancelled orders, qt should always be 0
}


typedef OrderByProduct = {
	quantity:Float,
	smartQt:String,
	pid:Int,
	pname:String,
	ref:String,
	priceHT:Float,
	priceTTC:Float,
	vat:Float,
	totalHT:Float,
	totalTTC:Float,
	weightOrVolume:String,
};
typedef OrderByEndDate = {date: String,contracts: Array<String>};


typedef RevenueAndFees = {amount:Float,netAmount:Float,fixedFees:Float,variableFees:Float};

/**
	Event enum used for plugins.
	
	As in most CMS event systems, 
	the events (or "triggers") can be caught by plugins 
	to perform an action or modifiy data carried by the event.
	
**/
enum Event {

	Page(uri:String);							//a page is displayed
	Nav(nav:Array<Link>, name:String, ?id:Int);	//a navigation is displayed, optionnal object id if needed
	Blocks(blocks:Array<Block>, name:String, ?context:Dynamic);	//HTML blocks that can be displayed on a page
	Permalink(permalink:{link:String,entityType:String, entityId:Int}); // a permalink is invoked
	
	#if sys
	SendEmail(message : sugoi.mail.Mail);		//an email is sent
	NewMember(user:db.User,group:db.Group);		//a new member is added to a group
	NewGroup(group:db.Group, author:db.User);	//a new group is created
	
	//Distributions
	PreNewDistrib(contract:db.Catalog);		//when displaying the insert distribution form
	NewDistrib(distrib:db.Distribution);		//when a new distrinbution is created
	PreEditDistrib(distrib:db.Distribution);
	EditDistrib(distrib:db.Distribution);
	DeleteDistrib(distrib:db.Distribution);
	PreNewDistribCycle(cycle:db.DistributionCycle);	
	NewDistribCycle(cycle:db.DistributionCycle);
	MultiDistribEvent(md:db.MultiDistrib);
	
	//Products
	PreNewProduct(contract:db.Catalog);	//when displaying the insert distribution form
	NewProduct(product:db.Product);			//when a new product is created
	PreEditProduct(product:db.Product);
	EditProduct(product:db.Product);
	DeleteProduct(product:db.Product);
	BatchEnableProducts(data:{pids:Array<Int>,enable:Bool});
	ProductInfosEvent(p:ProductInfo,?d:db.Distribution);	//when infos about a product are displayed
	
	//Contracts
	EditContract(contract:db.Catalog,form:sugoi.form.Form);
	DuplicateContract(contract:db.Catalog);
	DeleteContract(contract:db.Catalog);
	
	//crons
	DailyCron(now:Date);
	HourlyCron(now:Date);
	MinutelyCron(now:Date);
	
	//orders
	MakeOrder(orders:Array<db.UserOrder>); 
	StockMove(order:{product:db.Product, move:Float}); //when a stock is modified
	ValidateBasket(basket:db.Basket);
	
	//payments
	GetPaymentTypes(data:{types:Array<payment.PaymentType>});
	NewOperation(op:db.Operation);
	PreOperationDelete(op:db.Operation);
	PreOperationEdit(op:db.Operation);
	PreRefund(form:sugoi.form.Form,basket:db.Basket,refundAmount:Float);
	Refund(operation:db.Operation,basket:db.Basket);
	
	#end
	
}


/*
 * Product Taxonomy structure
 */ 
/*typedef TxpDictionnary = {
	products:Map<Int,{id:Int,name:String,category:Int,subCategory:Int}>,
	categories:Map<Int,CategoryInfo>,
	subCategories:Map<Int,CategoryInfo>,	
}*/


/* 
 * Tutorials
 */
enum TutoAction {
	TAPage(uri:String);
	TANext;
	
}
enum TutoPlacement {
	TPTop;
	TPBottom;
	TPLeft;
	TPRight;
}

typedef TutoInfos = {name:String, steps:Array<{element:String,text:String,action:TutoAction,placement:TutoPlacement}>};

class TutoDatas {

	public static var TUTOS: Map<String,TutoInfos> = null;
	
	#if js
	//async 
	public static function get(tuto:String, callback:Dynamic->Void){
		#if !test
		sugoi.i18n.Locale.init(App.instance.lang, function(t:sugoi.i18n.GetText){			
			App.instance.t = t;
			init(t);
			var tuto = TUTOS.get(tuto);
			callback(tuto);			
		});
		#end
	}
	#else
	//sync 
	public static function get(tuto:String):TutoInfos
	{
		sugoi.i18n.Locale.init(App.current.getLang());
		init(sugoi.i18n.Locale.texts);
		return TUTOS.get(tuto);
	}
	#end
	
	static function init(t:sugoi.i18n.GetText){
			
		TUTOS = [
			"intro" => {
				name:t._("Guided tour for the group administrator"),
				steps:[
					{
						element:null,
						text:t._("<p>In order to better discover Alterconso, we propose to do a guided tour of the user interface of the software. <br/> You will then have a global overview on the different tools that are available to you.</p><p>You will be able to stop and start again this tutorial whenever you want.</p>"),
						action: TANext,
						placement : null
					},
					{
						element:"ul.nav.navbar-left",
						text:t._( "This part of the navigation bar is visible by all members.</br>It allows to access the three main pages:	<ul><li> The <b>order page</b> which displays orders and the delivery planning.</li><li> On the <b>My account</b> page, you can update your personal information and check your orders history</li><li> On the <b>Farmers</b> page,  you can see all farmers and administrators of the group</ul>"),
						action: TANext,
						placement : TPBottom
					},
					{
						element:"ul.nav.navbar-right",
						text:t._("This part is <b>for administrators only.</b> Here you will be able to manage the register of members, orders,  products, etc.<br/><p>Now click on the <b>Members</b> section</p>"),
						action: TAPage("/member"),
						placement : TPBottom

					},{
						element:".article .table td",
						text:t._("The purpose of this section is to administrate the list of your members.<br/>Every time that you register a new membrer, an account will be created for him/her. Now the member can join you at Alterconso and order or consult the planning of the deliveries.<p>Now click on a <b>member</b> in the list</p>"),
						action: TAPage("/member/view/*"),
						placement : TPRight
					},{
						element:".article",
						text:t._("This is the page of a member. Here you can : <ul><li>see and change their contact details</li><li>manage the membership fee of your group</li><li>see a summary of their orders</li></ul>"),
						action: TANext,
						placement : TPRight
					},
					{
						element:"ul.nav #distributions",
						text:t._("Please click on the <b>distributions</b> section."),
						action: TAPage("/distribution"),
						placement : TPBottom
					},{
						element:"div.distrib:nth-child(1)",
						text:t._("In this section, you can manage the global distribution planning. This dashboard gives an overview of the next distributions : are orders open ? , how many farmers are attending ?, how many volunteers do you need..."),
						action: TANext,
						placement : TPBottom

					},					
					{
						element:"ul.nav #contractadmin",
						text:t._("Now let's have a look at the <b>catalogs</b> section."),
						action: TAPage("/contractAdmin"),
						placement : TPBottom
					},{
						element:"#contracts",
						text:t._("Here is the list of <b>catalogs</b>. They include a start date, a end date, and contain the products you can purchase from a specific farmer."),
						action: TANext,
						placement : TPBottom

					}/*,{
					element:"#places",
					   text:t._("Here you can manage the list of <b>delivery places</b>.<br/>Don't forget to key-in the complete address as a map will be displayed based on this address"),
					   action: TANext,
					   placement : TPTop

				   }*/,{
					   element:"#contracts table .btn",
					   text:t._("Let's look closer at how to manage a catalog. <b>Click on this button</b>"),
					   action: TAPage("/contractAdmin/view/*"),
					   placement : TPBottom

				   },{
					   element:".table.table-bordered",
					   text:t._("Here is a summary of the catalog.<br/>There are two types of contracts:<ul><li>CSA contracts: the member commits on buying the same products during the whole duration of the contract</li><li>Variable orders : the member can choose what he buys for each delivery.</li></ul>"),
					   action: TANext,
					   placement : TPRight

				   },{
					   element:"#subnav #products",
					   text:t._("Let's see now the page <b>Products</b>"),
					   action : TAPage("/contractAdmin/products/*"),
					   placement:TPRight
				   },{
					   element:".article .table",
					   text:t._("On this page, you can manage the list of products offered by this supplier.<br/>Define at least the name and the price of products. It is also recommended to add a description and a picture."),
					   action: TANext,
					   placement : TPTop

				   },{
					   element:"#subnav #deliveries",
					   text:t._("Let's see the <b>deliveries</b> page"),
					   action : TAPage("/contractAdmin/distributions/*"),
					   placement:TPRight
				   },{
					   element:".article .table",
					   text:t._("Here you can view the distributions which have been planified from the distribution section.<br/>Everyone who has access to this page can define if the products of this catalog will be available or not to a specific distribution."),
					   action: TANext,
					   placement : TPLeft

				   },{
					   element:"#subnav #orders",
					   text:t._("Let's see now the <b>Orders</b> page"),
					   action : TAPage("/contractAdmin/orders/*"), //can fail if the contract is variable because the uri is different
					   placement:TPRight
				   },{
					   element:".article .table",
					   text:t._("Here we can manage the list of orders for this supplier.<br/>If you choose to \"open orders\" to members, they will be able to make their orders online themselves.<br/>This page will centralize automatically the orders for this supplier.  Otherwise, as a administrator, you will be able to enter orders on behalf of a member."),
					   action: TANext,
					   placement : TPLeft

				   },{
					   element:"ul.nav #messages",
					   text:t._("<p>We have seen the main features related to catalogs.</p><p>Let's see the <b>messaging</b> section.</p>"),
					   action: TAPage("/messages"),
					   placement : TPBottom

				   },{
					   element:null,
					   text:t._("<p>The messaging section allows you to send e-mails to different lists of members. It is not necessary anymore to maintain a lot of lists of e-mails depending on catalogs, as all these lists are automatically generated.</p>  <p>E-mails are sent with your e-mail address as sender, so you will receive answers in your own mailbox.</p>"),
					   action: TANext,
					   placement : null

				   },{
					   element:"ul.nav #amapadmin",
					   text:t._("Click here now on this page"),
					   action : TAPage("/amapadmin"),
					   placement : TPLeft,
				   },{
					   element:"#subnav",
					   text:t._("<p>In this last page, you can configure everything that is related to your group.</p><p>The <b>Administration rights</b> page is important, it's where you can define other administrators among members. They will then be able to manage one or many catalogs, send emails, etc.</p>"),
					   action:TANext,
					   placement : TPBottom
				   },{
					   element:"#helpMenu",
					   text:t._("<p>This is the last step of this tutorial. I hope that it gave you a good overview of this software.<br/>To go further, do not hesitate to look at the <b>documentation</b>. The link is always available at the top-right corner of the screen.</p>"),
					   action:TANext,
					   placement : TPBottom
				   }
			   ]
		   },
		];
		
	}
	
	

}

/**
 * Order Reports
 */
enum OrdersReportGroupOption{
	ByMember;
	ByProduct;
}

enum OrdersReportFormatOption{
	Table;
	Csv;
	PrintableList; //list de distrib ?
}


//Report Options : should be usable in an URL, an API call...
typedef OrdersReportOptions = {
	//time scope
	startDate:Date,
	endDate:Date,
	
	//formatting
	?groupBy:OrdersReportGroupOption,			//group order by...	
	?format:OrdersReportFormatOption,			//table , csv ?
	
	//filters :
	?groups:Array<Int>,
	?contracts:Array<Int>,			//which contracts
	?distributions:Array<Int>,
}

/**
	Opengraph / twittercard datas
**/
typedef SocialShareData = {
	var facebookType: String;
	var url: String;
	var title: String;
	var description: String;
	var imageUrl: String;
	var imageAlt: String;
	var twitterType: String;
	var twitterUsername: String;
} 