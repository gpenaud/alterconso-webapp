import db.User;
import thx.semver.Version;
import Common;
import GitMacros;

class App extends sugoi.BaseApp {

	public static var current : App = null;
	public static var t : sugoi.i18n.translator.ITranslator;
	public static var config = sugoi.BaseApp.config;


	public var eventDispatcher :hxevents.Dispatcher<Event>;
	public var plugins : Array<sugoi.plugin.IPlugIn>;
	public var breadcrumb : Array<Link>;
	/**
	 * Version management
	 * @doc https://github.com/fponticelli/thx.semver
	 */
	public static var VERSION = "1.0.0";

	public function new(){
		super();

		breadcrumb = [];

		if (App.config.DEBUG) {
			this.headers.set('Access-Control-Allow-Origin', "*");
			this.headers.set("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
		}
	}

	public static function main() {

		App.t = sugoi.form.Form.translator = new sugoi.i18n.translator.TMap(getTranslationArray(), "fr");
		sugoi.BaseApp.main();
	}

	/**
	 * Init plugins and event dispatcher just before launching the app
	 */
	override public function mainLoop() {
		eventDispatcher = new hxevents.Dispatcher<Event>();
		plugins = [];
		//internal plugins
		plugins.push(new plugin.Tutorial());

		//optionnal plugins
		#if plugins
		plugins.push( new hosted.HostedPlugIn() );
		plugins.push( new pro.ProPlugIn() );
		plugins.push( new connector.ConnectorPlugIn() );
		//plugins.push( new lemonway.LemonwayEC() );
		//plugins.push( new pro.LemonwayEC() );
		plugins.push( new mangopay.MangopayPlugin() );
		plugins.push( new who.WhoPlugIn() );
		#end

		super.mainLoop();
	}

	public function getCurrentGroup(){
		if (session == null) return null;
		if (session.data == null ) return null;
		var a = session.data.amapId;
		if (a == null) {
			return null;
		}else {
			return db.Group.manager.get(a,false);
		}
	}

	override function beforeDispatch() {

		//send "current page" event
		event( Page(this.uri) );

		super.beforeDispatch();
	}

	public function getPlugin(name:String):sugoi.plugin.IPlugIn {
		for (p in plugins) {
			if (p.getName() == name) return p;
		}
		return null;
	}

	public static function log(t:Dynamic) {
		if(App.config.DEBUG) {
			neko.Web.logMessage(Std.string(t)); //write in Apache error log
			#if weblog
			Weblog.log(t); //write en Weblog console (https://lib.haxe.org/p/weblog/)
			#end
		}
	}

	public function event(e:Event) {
		if(e==null) return null;
		this.eventDispatcher.dispatch(e);
		return e;
	}

	/**
	 * Translate DB objects fields in forms
	 */
	public static function getTranslationArray() {
		//var t = sugoi.i18n.Locale.texts;
		var out = new Map<String,String>();

		out.set("firstName2", "Pr??nom du conjoint");
		out.set("lastName2", "Nom du conjoint");
		out.set("email2", "e-mail du conjoint");
		out.set("zipCode", "code postal");
		out.set("city", "commune");
		out.set("phone", "t??l??phone");
		out.set("phone2", "t??l??phone du conjoint");


		out.set("select", "s??lectionnez");
		out.set("contract", "Contrat");
		out.set("place", "Lieu");
		out.set("name", "Nom");
		out.set("cdate", "Date d'entr??e dans le groupe");
		out.set("quantity", "Quantit??");
		out.set("paid", "Pay??");
		out.set("user2", "(facultatif) partag?? avec ");
		out.set("product", "Produit");
		out.set("user", "Adh??rent");
		out.set("txtIntro", "Texte de pr??sentation du groupe");
		out.set("txtHome", "Texte en page d'accueil pour les adh??rents connect??s");
		out.set("txtDistrib", "Texte ?? faire figurer sur les listes d'??margement lors des distributions");
		out.set("extUrl", "URL du site du groupe.");

		out.set("startDate", "Date de d??but");
		out.set("endDate", "Date de fin");

		out.set("orderStartDate", "Date ouverture des commandes");
		out.set("orderEndDate", "Date fermeture des commandes");
		out.set("openingHour", "Heure d'ouverture");
		out.set("closingHour", "Heure de fermeture");

		out.set("date", "Date de distribution");
		out.set("active", "actif");

		out.set("contact", "Reponsable");
		out.set("vendor", "Producteur");
		out.set("text", "Texte");
		out.set("flags", "Options");
		out.set("4h", "Recevoir des notifications par email 4h avant les distributions");
		out.set("HasEmailNotif4h", "Recevoir des notifications par email 4h avant les distributions");
		out.set("24h", "Recevoir des notifications par email 24h avant les distributions");
		out.set("HasEmailNotif24h", "Recevoir des notifications par email 24h avant les distributions");
		out.set("Ouverture", "Recevoir des notifications par email pour l'ouverture des commandes");
		out.set("Tuto", "Activer tutoriels");
		out.set("HasMembership", "Gestion des adh??sions");
		out.set("DayOfWeek", "Jour de la semaine");
		out.set("Monday", "Lundi");
		out.set("Tuesday", "Mardi");
		out.set("Wednesday", "Mercredi");
		out.set("Thursday", "Jeudi");
		out.set("Friday", "Vendredi");
		out.set("Saturday", "Samedi");
		out.set("Sunday", "Dimanche");
		out.set("cycleType", "R??currence");
		out.set("Weekly", "hebdomadaire");
		out.set("Monthly", "mensuelle");
		out.set("BiWeekly", "toutes les deux semaines");
		out.set("TriWeekly", "toutes les 3 semaines");
		out.set("price", "prix TTC");
		out.set("uname", "Nom");
		out.set("pname", "Produit");
		out.set("organic", "Agriculture biologique");
		out.set("hasFloatQt", "Autoriser quantit??s \"?? virgule\"");

		out.set("membershipRenewalDate", "Adh??sions : Date de renouvellement");
		out.set("membershipPrice", "Adh??sions : Co??t de l'adh??sion");
		out.set("UsersCanOrder", "Les membres peuvent saisir leur commande en ligne");
		out.set("StockManagement", "Gestion des stocks");
		out.set("contact", "Responsable");
		out.set("PercentageOnOrders", "Ajouter des frais au pourcentage de la commande");
		out.set("percentageValue", "Pourcentage des frais");
		out.set("percentageName", "Libell?? pour ces frais");
		out.set("fees", "frais");
		out.set("AmapAdmin", "Administrateur du groupe");
		out.set("Membership", "Acc??s ?? la gestion des membres");
		out.set("Messages", "Acc??s ?? la messagerie");
		out.set("vat", "TVA");
		out.set("desc", "Description");

		//group options
		out.set("ShopMode", "Mode boutique");
		out.set("ComputeMargin", "Appliquer une marge ?? la place des pourcentages");
		out.set("CustomizedCategories", "Cat??gories personnalis??es");
		out.set("HidePhone", "Masquer le t??l??phone du responsable sur la page publique");
		out.set("PhoneRequired", "Saisie du num??ro de t??l??phone obligatoire");
		out.set("AddressRequired", "Saisie de l'adresse obligatoire");


		out.set("ShopV2", "Nouvelle boutique");

		out.set("ref", "R??f??rence");
		out.set("linkText", "Intitul?? du lien");
		out.set("linkUrl", "URL du lien");

		//group type
		out.set("Amap", "AMAP");
		out.set("GroupedOrders", 	"Groupement d'achat");
		out.set("ProducerDrive", 	"En direct d'un collectif de producteurs");
		out.set("FarmShop", 		"En direct d'un producteur");

		out.set("regOption", 	"Inscription de nouveaux membres");
		out.set("Closed", 		"Ferm?? : L'administrateur ajoute les nouveaux membres");
		out.set("WaitingList", 	"Liste d'attente");
		out.set("Open", 		"Ouvert : tout le monde peut s'inscrire");
		out.set("Full", 		"Complet : Le groupe n'accepte plus de nouveaux membres");

		out.set("CagetteNetwork", "Me lister dans l'annuaire des groupes Alterconso");
		out.set("HasPayments", "Gestion des paiements");

		out.set("Soletrader"	, "Micro-entreprise");
		out.set("Organization"	, "Association");
		out.set("Business"		, "Soci??t??");

		out.set("unitType", "Unit??");
		out.set("qt", "Quantit??");
		out.set("Unit", "Pi??ce");
		out.set("Kilogram", "Kilogrammes");
		out.set("Gram", "Grammes");
		out.set("Litre", "Litres");
		out.set("Centilitre", "Centilitres");
		out.set("Millilitre", "Millilitres");
		out.set("htPrice", "Prix H.T");
		out.set("amount", "Montant");
		out.set("percent", "Pourcentage");
		out.set("pinned", "Mets en avant les produits");



		out.set("byMember", "Par adh??rent");
		out.set("byProduct", "Par produit");

		//stock strategy
		out.set("ByProduct"	, "Par produit (produits vrac, stock??s sans conditionnement)");
		out.set("ByOffer"	, "Par offre (produits stock??s d??ja conditionn??s)");

		out.set("variablePrice", "Prix variable selon pes??e");
		return out;
	}

	public function populateAmapMembers() {
		return user.getGroup().getMembersFormElementData();
	}

	public static function getMailer():sugoi.mail.IMailer {

		var mailer : sugoi.mail.IMailer = new sugoi.mail.BufferedMailer();

		// CHANGE TO REMOVE: @gpenaud
		if(App.config.HOST=="pp.leportail.org"){
		//if(App.config.DEBUG || App.config.HOST=="pp.leportail.org" || App.config.HOST=="localhost"){

			//Dev env : emails are written to tmp folder
			mailer = new sugoi.mail.DebugMailer();
		}else{

			untyped mailer.defineFinalMailer("smtp");

			// CHANGE by @gpenaud - Force mailer to SMTP
			/* -----------------------------------------
			if (sugoi.db.Variable.get("mailer") == null){
				var msg = sugoi.i18n.Locale.texts._("Please configure the email settings in a <href='/admin/emails'>this section</a>");
				throw sugoi.ControllerAction.ErrorAction("/",msg);
			}

			if (sugoi.db.Variable.get("mailer") == "mandrill"){
				//Buffered emails with Mandrill
				untyped mailer.defineFinalMailer("mandrill");
			}else{
				//Buffered emails with SMTP
				untyped mailer.defineFinalMailer("smtp");
			} ----------------------------------------- */
		}
		return mailer;
	}

	/**
	 * Send an email
	 */
	public static function sendMail(m:sugoi.mail.Mail, ?group:db.Group, ?listId:String, ?sender:db.User){

		if (group == null) group = App.current.user == null ? null:App.current.user.getGroup();
		current.event(SendEmail(m));
		var params = group==null ? null : {remoteId:group.id};
		getMailer().send(m,params,function(o){});

	}

	public static function quickMail(to:String, subject:String, html:String,?group:db.Group){
		var e = new sugoi.mail.Mail();
		e.setSubject(subject);
		e.setRecipient(to);
		e.setSender(App.config.get("default_email"),"Alterconso");
		var html = App.current.processTemplate("mail/message.mtt", {text:html,group:group});
		e.setHtmlBody(html);
		App.sendMail(e);
	}

	/**
		process a template and returns the generated string
		(used for emails)
	**/
	public function processTemplate(tpl:String, ctx:Dynamic):String {

		//inject usefull vars in view
		Reflect.setField(ctx, 'HOST', App.config.HOST);
		Reflect.setField(ctx, 'hDate', date -> return Formatting.hDate(date) );

		ctx._ = App.current.view._;
		ctx.__ = App.current.view.__;

		var tpl = loadTemplate(tpl);
		var html = tpl.execute(ctx);
		#if php
		if ( html.substr(0, 4) == "null") html = html.substr(4);
		#end
		return html;
	}



}
