package test;
import utest.Assert;
import Common;
import utest.Runner;
import utest.ui.Report;
import service.DistributionService;

/**
 * CAGETTE.NET TEST SUITE
 * @author fbarbut
 */
class TestSuite
{

	static function main() {
		
		connectDb();
		var r = new Runner();

		//Cagette core tests
		r.addCase(new test.TestTools());
		r.addCase(new test.TestUser());
		r.addCase(new test.TestOrders());				
		r.addCase(new test.TestDistributions());
		r.addCase(new test.TestPayments());
		r.addCase(new test.TestReports());
		r.addCase(new test.TestSubscriptions());

		#if plugins
		//Cagette-pro tests, keep in this order
		r.addCase(new pro.test.TestProductService());
		r.addCase(new pro.test.TestRemoteCatalog());		
		r.addCase(new pro.test.TestReports());
		r.addCase(new who.test.TestWho());
		r.addCase(new pro.test.TestStock());
		//r.addCase(new pro.test.TestMarketplacePayment());
		#end
		Report.create(r);
		r.run();
	}

	static function connectDb() {
		var dbstr = Sys.args()[0];
		var dbreg = ~/([^:]+):\/\/([^:]+):([^@]*?)@([^:]+)(:[0-9]+)?\/(.*?)$/;
		if( !dbreg.match(dbstr) )
			throw "Configuration requires a valid database attribute, format is : mysql://user:password@host:port/dbname";
		var port = dbreg.matched(5);
		var dbparams = {
			user:dbreg.matched(2),
			pass:dbreg.matched(3),
			host:dbreg.matched(4),
			port:port == null ? 3306 : Std.parseInt(port.substr(1)),
			database:dbreg.matched(6),
			socket:null
		};
		
		sys.db.Manager.cnx = sys.db.Mysql.connect(dbparams);
		sys.db.Manager.initialize();
	}
	
	
	public static function initDB(){
		//NUKE EVERYTHING BWAAAAH !!
		sys.db.Manager.cleanup(); //cleanup cache objects
		sql("DROP DATABASE tests;");
		sql("CREATE DATABASE tests;");
		sql("USE tests;");

		var tables : Array<Dynamic> = [
			
			//cagette
			db.TxpProduct.manager,
			db.TxpCategory.manager,
			db.TxpSubCategory.manager,
			db.Category.manager,
			db.CategoryGroup.manager,
			db.ProductCategory.manager,

			db.Basket.manager,
			db.UserOrder.manager,
			db.UserGroup.manager,
			db.Operation.manager,

			db.User.manager,
			db.Group.manager,
			db.Catalog.manager,
			db.Product.manager,
			db.Vendor.manager,
			db.Place.manager,
			db.MultiDistrib.manager,
			db.Volunteer.manager,
			db.VolunteerRole.manager,
			db.Distribution.manager,
			db.DistributionCycle.manager,
			db.Subscription.manager,						
			
			//sugoi tables
			sugoi.db.Cache.manager,
			sugoi.db.Error.manager,
			sugoi.db.File.manager,
			sugoi.db.Session.manager,
			sugoi.db.Variable.manager,
		];
	
		for(t in tables) createTable(t);

		#if plugins
		//add Cpro datas : we need those tables even in cagette core tests
		pro.test.ProTestSuite.initDB();
		pro.test.ProTestSuite.initDatas();
		#end
	}
	
	public static function createTable( m  ){
		if ( sys.db.TableCreate.exists(m) ){
			drop(m);
		}
		// Sys.println("Creating table "+ m.dbInfos().name);
		sys.db.TableCreate.create(m);		
	}

	public static function truncate(m){
		sql("TRUNCATE TABLE "+m.dbInfos().name+";");
	}

	public static function drop(m){
		sql("DROP TABLE "+m.dbInfos().name+";");			
	}

	public static function sql(sql){
		return sys.db.Manager.cnx.request(sql);
	}
	
	//shortcut to datas
	public static var FRANCOIS:db.User = null; 
	public static var SEB:db.User = null; 
	public static var JULIE:db.User = null; 
	
	public static var STRAWBERRIES:db.Product = null; 
	public static var APPLES:db.Product = null; 
	
	public static var AMAP_DU_JARDIN:db.Group = null;
	public static var LOCAVORES:db.Group = null;

	public static var PANIER_AMAP_LEGUMES:db.Product = null;
	public static var BOTTE_AMAP:db.Product = null;
	public static var SOUPE_AMAP:db.Product = null;
	public static var VENDOR1:db.Vendor = null;
	public static var VENDOR2:db.Vendor = null;
	public static var VENDOR3:db.Vendor = null;
	public static var DISTRIB_CONTRAT_AMAP:db.Distribution = null;
	public static var DISTRIB_FRUITS_PLACE_DU_VILLAGE:db.Distribution = null;
	public static var DISTRIB_LEGUMES_RUE_SAUCISSE:db.Distribution = null;
	public static var DISTRIB_LAITUE:db.Distribution = null;
	public static var DISTRIB_CAROTTES:db.Distribution = null;
	public static var CONTRAT_AMAP : db.Catalog = null;
	public static var CONTRAT_LEGUMES:db.Catalog = null;
	public static var PLACE_DU_VILLAGE:db.Place = null;	
	
	public static var COURGETTES:db.Product = null;
	public static var CARROTS:db.Product = null;
	public static var POTATOES:db.Product = null; 

	public static var LAITUE:db.Product = null;
	

	public static var FLAN:db.Product = null;
	public static var CROISSANT:db.Product = null;
	public static var DISTRIB_PATISSERIES:db.Distribution = null;
	
	public static function initDatas(){

		//USERS
		
		var f = new db.User();
		f.firstName = "François";
		f.lastName = "BUBR";
		f.email = "francois@alilo.fr";
		f.insert();

		FRANCOIS = f;
		
		var u = new db.User();
		u.firstName = "Seb";
		u.lastName = "ZUKL";
		u.email = "sebastien@alilo.fr";
		u.insert();		

		SEB = u;

		var u = new db.User();
		u.firstName = "Julie";
		u.lastName = "BRBIC";
		u.email = "julie@alilo.fr";
		u.insert();		

		JULIE = u;
		
		initApp(u);
		
		//GROUP "AMAP du Jardin public"
		var a = new db.Group();
		a.name = "AMAP du Jardin public";
		a.contact = f;
		a.flags.set(db.Group.GroupFlags.HasPayments);
		a.insert();
		AMAP_DU_JARDIN = a;
		
		var place = new db.Place();
		place.name = "Place du village";
		place.zipCode = "00000";
		place.city = "St Martin";
		place.group = a;
		place.insert();

		PLACE_DU_VILLAGE = place;
		
		//VENDOR "Ferme de la galinette"
		var v = new db.Vendor();
		v.name = "La ferme de la Galinette";
		v.email = "galinette@gmail.com";
		v.zipCode = "00000";
		v.city = "Bourligheim";
		v.insert();
		
		var c = new db.Catalog();
		c.name = "Contrat AMAP Légumes";
		c.startDate = new Date(2017, 1, 1, 0, 0, 0);
		c.endDate = new Date(2030, 12, 31, 23, 59, 0);
		c.vendor = v;
		c.group = a;
		c.type = db.Catalog.TYPE_CONSTORDERS;
		c.insert();

		CONTRAT_AMAP = c;
		
		var p = new db.Product();
		p.name = "Panier Légumes";
		p.price = 13;
		p.catalog = c;
		p.insert();

		PANIER_AMAP_LEGUMES = p;

		var product = new db.Product();
		product.name = "Botte Oignons";
		product.price = 2;
		product.catalog = c;
		product.insert();

		BOTTE_AMAP = product;

		var product = new db.Product();
		product.name = "Mix pour Soupe";
		product.price = 10.50;
		product.catalog = c;
		product.insert();

		SOUPE_AMAP = product;

		var d = DistributionService.create(
			c,
			new Date(2017, 5, 1, 19, 0, 0),
			new Date(2017, 5, 1, 20, 0, 0),
			place.id,
			new Date(2017, 4, 1, 20, 0, 0),
			new Date(2017, 4, 30, 20, 0, 0)
		);		
		DISTRIB_CONTRAT_AMAP = d;

		//varying contract for strawberries with stock mgmt
		var c = new db.Catalog();
		c.name = "Commande fruits";
		c.vendor = v;
		c.startDate = new Date(2017, 1, 1, 0, 0, 0);
		c.endDate = new Date(2030, 12, 31, 23, 59, 0);
		c.flags.set(db.Catalog.CatalogFlags.StockManagement);
		c.type = db.Catalog.TYPE_VARORDER;
		c.group = a;
		c.insert();
		
		var p = new db.Product();
		p.name = "Fraises";
		p.qt = 1;
		p.unitType = Common.Unit.Kilogram;
		p.price = 10;
		p.organic = true;
		p.catalog = c;
		p.stock = 8;
		p.insert();
		
		STRAWBERRIES = p;
		
		var p = new db.Product();
		p.name = "Pommes";
		p.qt = 1;
		p.unitType = Common.Unit.Kilogram;
		p.price = 6;
		p.organic = true;
		p.catalog = c;
		p.stock = 12;
		p.insert();
		
		APPLES = p;

		var d = service.DistributionService.create(c,new Date(2017, 5, 1, 19, 0, 0),new Date(2017, 5, 1, 20, 0, 0),place.id,new Date(2017, 4, 1, 20, 0, 0),new Date(2017, 4, 30, 20, 0, 0));		
		DISTRIB_FRUITS_PLACE_DU_VILLAGE = d;
		
		//second group : LOCAVORES
		var a = new db.Group();
		a.name = "Les Locavores de la Rue Saucisse";
		a.contact = f;
		a.flags.set(db.Group.GroupFlags.HasPayments);
		a.insert();
		LOCAVORES = a;
		
		var place = new db.Place();
		place.name = "Rue Saucisse";
		place.zipCode = "00000";
		place.city = "St Martin";
		place.group = a;
		place.insert();
		
		/*
		La ferme de la courgette enragée (VENDOR1)
			- courgettes
			- pdt
		*/
		var v = new db.Vendor();
		v.name = "La ferme de la courgette enragée";
		v.email = "courgette@gmail.com";
		v.zipCode = "00000";
		v.city = "Bourligeac";
		v.insert();
		VENDOR1 = v;

		var c = new db.Catalog();
		c.name = "Commande Legumes";
		c.startDate = new Date(2017, 1, 1, 0, 0, 0);
		c.endDate = new Date(2030, 12, 31, 23, 59, 0);
		c.vendor = v;
		c.group = a;
		c.type = db.Catalog.TYPE_VARORDER;
		c.insert();
		
		CONTRAT_LEGUMES = c;

		var p = new db.Product();
		p.name = "Courgettes";
		p.qt = 1;
		p.unitType = Common.Unit.Kilogram;
		p.price = 3.5;
		p.vat = 5.5;
		p.organic = true;
		p.catalog = c;
		p.insert();

		COURGETTES = p;
		
		var p = new db.Product();
		p.name = "Pommes de Terre";
		p.qt = 1.5;
		p.unitType = Common.Unit.Kilogram;
		p.price = 15;
		p.vat = 5.5;
		p.multiWeight = true;
		p.hasFloatQt = true;
		p.catalog = c;
		p.insert();

		POTATOES = p;

		var d = service.DistributionService.create(c,new Date(2017, 5, 1, 19, 0, 0),new Date(2017, 5, 1, 19, 2, 0),place.id,new Date(2017, 4, 10, 19, 0, 0),new Date(2017, 4, 20, 19, 0, 0));		
		DISTRIB_LEGUMES_RUE_SAUCISSE = d;


		//Ferme de la laitue
		// - laitue
		var vendor2 = new db.Vendor();
		vendor2.name = "La ferme de la laitue hystérique";
		vendor2.email = "laitue@gmail.com";
		vendor2.zipCode = "33000";
		vendor2.city = "Auliwoud";
		vendor2.insert();
		VENDOR2 = vendor2;

		var contract2 = new db.Catalog();
		contract2.name = "Commande Laitue";
		contract2.startDate = new Date(2017, 1, 1, 0, 0, 0);
		contract2.endDate = new Date(2017, 12, 31, 23, 59, 0);
		contract2.vendor = vendor2;
		contract2.group = a;
		contract2.type = db.Catalog.TYPE_VARORDER;
		contract2.insert();

		var product2 = new db.Product();
		product2.name = "Laitue";
		product2.qt = 1;
		product2.unitType = Common.Unit.Kilogram;
		product2.price = 2.5;
		product2.organic = true;
		product2.catalog = contract2;
		product2.insert();
		LAITUE = product2;

		var distribution2 = service.DistributionService.create(contract2,new Date(2017, 5, 1, 19, 0, 0),new Date(2017, 5, 1, 20, 0, 0),place.id,new Date(2017, 4, 1, 20, 0, 0),new Date(2017, 4, 30, 20, 0, 0));		
		DISTRIB_LAITUE = distribution2;

		//

		var vendor3 = new db.Vendor();
		vendor3.name = "La ferme des carottes rebelles";
		vendor3.email = "carottes@gmail.com";
		vendor3.zipCode = "47100";
		vendor3.city = "Parmentier";
		vendor3.insert();
		VENDOR3 = vendor3;

		var contract3 = new db.Catalog();
		contract3.name = "Commande Carottes";
		contract3.startDate = new Date(2017, 1, 1, 0, 0, 0);
		contract3.endDate = new Date(2017, 12, 31, 23, 59, 0);
		contract3.vendor = vendor3;
		contract3.group = a;
		contract3.type = db.Catalog.TYPE_VARORDER;
		contract3.insert();

		var p = new db.Product();
		p.name = "Carottes";
		p.qt = 1;		
		p.unitType = Common.Unit.Kilogram;
		p.price = 2.8;
		p.vat = 5.5;
		p.catalog = contract3;
		p.insert();
		
		CARROTS = p;

		var distribution3 = service.DistributionService.create(contract3,new Date(2017, 5, 1, 19, 0, 0),new Date(2017, 5, 1, 20, 0, 0),place.id,new Date(2017, 4, 1, 20, 0, 0),new Date(2017, 4, 30, 20, 0, 0));		
		DISTRIB_CAROTTES = distribution3;

		
		/*
		 Boulangerie Turlupain
		 	- Flan
			- Croissant			
		*/
		var boulanger = new db.Vendor();
		boulanger.name = "Boulangerie Turlupain";
		boulanger.email = "turlupain@gmail.com";
		boulanger.zipCode = "24000";
		boulanger.city = "Parmentier";
		boulanger.insert();

		var c = new db.Catalog();
		c.name = "Commande Pâtisseries";
		c.startDate = new Date(2017, 1, 1, 0, 0, 0);
		c.endDate = new Date(2017, 12, 31, 23, 59, 0);
		c.vendor = boulanger;
		c.group = a;
		c.type = db.Catalog.TYPE_VARORDER;
		c.insert();

		var p = new db.Product();
		p.name = "Flan";
		p.qt = 1;
		p.unitType = Common.Unit.Kilogram;
		p.price = 3.5;
		p.organic = true;
		p.catalog = c;
		p.insert();

		FLAN = p;
		
		var p = new db.Product();
		p.name = "Croissant";
		p.qt = 1;
		p.unitType = Common.Unit.Kilogram;
		p.price = 2.8;
		p.catalog = c;
		p.insert();

		CROISSANT = p;

		var d = service.DistributionService.create(c,new Date(2017, 5, 1, 19, 0, 0),new Date(2017, 5, 1, 20, 0, 0),place.id,new Date(2017, 4, 1, 20, 0, 0),new Date(2017, 4, 30, 20, 0, 0));		
		DISTRIB_PATISSERIES = d;
		
		
	}
	
	static function initApp(u:db.User){
		
		//setup App
		var app = App.current = new App();
		App.config.DEBUG = true;
		app.initLang("en");

		app.eventDispatcher = new hxevents.Dispatcher<Event>();
		app.plugins = [];
		//internal plugins
		app.plugins.push(new plugin.Tutorial());
		
		//optionnal plugins
		#if plugins
		//app.plugins.push( new hosted.HostedPlugIn() );				
		app.plugins.push( new pro.ProPlugIn() );		
		app.plugins.push( new connector.ConnectorPlugIn() );				
		//app.plugins.push( new pro.LemonwayEC() );
		//app.plugins.push( new who.WhoPlugIn() );
		#end
		
		App.current.user = u;
		App.current.view = new View();
	}
}

