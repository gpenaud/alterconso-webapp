package controller;
import service.GraphService;
import haxe.CallStack;
import haxe.display.Display.CompletionModeKind;
import db.MultiDistrib;
import sugoi.tools.TransactionWrappedTask;
import sugoi.db.Cache;
import sugoi.Web;
import sugoi.mail.Mail;
import Common;
using Lambda;
using tools.DateTool;

class Cron extends Controller
{
	var now : Date;

	public function new(){
		super();

		//For testing purposes you can add an arg to build a "fake now"
		this.now = App.current.params.exists("now") ? Date.fromString(App.current.params.get("now")) : Date.now();
		Sys.println("now is "+this.now.toString());
	}

	public function doDefault(){}

	/**
	 * CLI only en prod
	 */
	function canRun() {
		if (App.current.user != null && App.current.user.isAdmin()){
			return true;
		}else if (App.config.DEBUG) {
			return true;
		}else {

			if (Web.isModNeko) {
				Sys.print("only CLI.");
				return false;
			}else {
				return true;
			}
		}
	}

  //////////////////////////////////////////////////////////////////////////////

	/**
		Function executed by CLI
	**/
	public function doTestmail() {
		Sys.println("execution of doTestmail()");

		for( e in sugoi.db.BufferedMail.manager.search($mailerType=="smtp",{limit:[0,1],orderBy:-cdate},true) ){
			Sys.println("execution of e.finallySend()");
			e.finallySend();
		}
	}

	//////////////////////////////////////////////////////////////////////////////

	/**
		Cron executed every minute
	**/
	public function doMinute() {
		if (!canRun()) return;

		app.event(MinutelyCron(this.now));

		//managing buffered emails
		for( i in 0...5){
			var task = new TransactionWrappedTask("Send 10 Emails from Buffer");
			task.setTask(
				function(){
					sendEmailsfromBuffer(i*10,task);
				}
			);
			task.execute(!App.config.DEBUG);
		}

		//warns admin about emails that cannot be sent
		var task = new TransactionWrappedTask("warns admin about emails that cannot be sent");
		task.setTask(function(){
			for( e in sugoi.db.BufferedMail.manager.search($tries>20,{limit:50,orderBy:-cdate},true)  ){
				if(e.sender.email != App.config.get("default_email")){
					var str = t._("Sorry, the email entitled <b>::title::</b> could not be sent.",{title:e.title});
					App.quickMail(e.sender.email,t._("Email not sent"),str);
				}
				e.delete();
			}
		});
		task.execute(!App.config.DEBUG);

		//Delete old emails
		var task = new TransactionWrappedTask("Delete Old mails");
		task.setTask(function(){
			var threeMonthsAgo = DateTools.delta(Date.now(), -1000.0*60*60*24*30*3);
			sugoi.db.BufferedMail.manager.delete($cdate < threeMonthsAgo);
		});
		task.execute(!App.config.DEBUG);
	}

	/**
	 *  Hourly Cron
	 *  this can be locally tested with `neko index.n cron/hour > cron.log`
	 */
	public function doHour() {

		app.event(HourlyCron(this.now));

		//instructions for dutyperiod volunteers
		var task = new TransactionWrappedTask("Volunteers instruction mail");
		task.setTask(function() {
			//Let's get all the multidistribs that start in the right time range
			var fromNow = now.setHourMinute( now.getHours(), 0 );
			var toNow = now.setHourMinute( now.getHours() + 1, 0);
			var multidistribs: Array<db.MultiDistrib> = db.MultiDistrib.manager.unsafeObjects(
				'SELECT distrib.*
				FROM MultiDistrib distrib INNER JOIN `Group` g
				ON distrib.groupId = g.id
				WHERE distrib.distribStartDate >= DATE_ADD(\'${fromNow}\', INTERVAL g.volunteersMailDaysBeforeDutyPeriod DAY)
				AND distrib.distribStartDate < DATE_ADD(\'${toNow}\', INTERVAL g.volunteersMailDaysBeforeDutyPeriod DAY);', false).array();

			for (multidistrib  in multidistribs) {

				var volunteers: Array<db.Volunteer> = multidistrib.getVolunteers();
				if ( volunteers.length != 0 ) {
					task.log(multidistrib.getGroup().name+" : "+multidistrib.getDate());
					var mail = new Mail();
					mail.setSender(App.config.get("default_email"),"Cagette.net");
					var volunteersList = "<ul>";
					for ( volunteer in  volunteers ) {

						mail.addRecipient( volunteer.user.email, volunteer.user.getName() );
						if ( volunteer.user.email2 != null ) {
							mail.addRecipient( volunteer.user.email2 );
						}
						volunteersList += "<li>"+volunteer.volunteerRole.name + " : " + volunteer.user.getCoupleName() + "</li>";
					}
					volunteersList += "</ul>";

					mail.setSubject( "["+multidistrib.group.name+"] "+ t._("Instructions for the volunteers of the ::date:: distribution",{date : view.hDate(multidistrib.distribStartDate)}) );

					//Let's replace all the tokens
					var ddate = t._("::date:: from ::startHour:: to ::endHour::",{date:view.dDate(multidistrib.distribStartDate),startHour:view.hHour(multidistrib.distribStartDate),endHour:view.hHour(multidistrib.distribEndDate)});
					var emailBody = StringTools.replace( multidistrib.group.volunteersMailContent, "[DATE_DISTRIBUTION]", ddate );
					emailBody = StringTools.replace( emailBody, "[LIEU_DISTRIBUTION]", multidistrib.place.name );
					emailBody = StringTools.replace( emailBody, "[LISTE_BENEVOLES]", volunteersList );
					mail.setHtmlBody( app.processTemplate("mail/message.mtt", { text: emailBody, group: multidistrib.group  } ) );
					App.sendMail(mail);
				}
			}
		});
		task.execute(!App.config.DEBUG);


		var task = new TransactionWrappedTask("Volunteers alerts");
		task.setTask(function() {

			//Let's get all the multidistribs that start in the right time range
			var fromNow = now.setHourMinute( now.getHours(), 0 );
			var toNow = now.setHourMinute( now.getHours() + 1, 0);
			var multidistribs: Array<db.MultiDistrib> = Lambda.array( db.MultiDistrib.manager.unsafeObjects(
				'SELECT distrib.*
				FROM MultiDistrib distrib INNER JOIN `Group` g
				ON distrib.groupId = g.id
				WHERE distrib.distribStartDate >= DATE_ADD(\'${fromNow}\', INTERVAL g.vacantVolunteerRolesMailDaysBeforeDutyPeriod DAY)
				AND distrib.distribStartDate < DATE_ADD(\'${toNow}\', INTERVAL g.vacantVolunteerRolesMailDaysBeforeDutyPeriod DAY);', false));

			var vacantVolunteerRolesMultidistribs = Lambda.filter( multidistribs, function(multidistrib) return multidistrib.hasVacantVolunteerRoles() );

			for (multidistrib  in vacantVolunteerRolesMultidistribs) {
				task.log(multidistrib.getGroup().name+" : "+multidistrib.getDate());
				var mail = new Mail();
				mail.setSender(App.config.get("default_email"),"Cagette.net");
				for ( member in multidistrib.group.getMembers() ) {
					mail.addRecipient( member.email, member.getName() );
					if ( member.email2 != null ) {
						mail.addRecipient( member.email2 );
					}
				}

				//vacant roles
				var vacantVolunteerRolesList = "<ul>"+Lambda.map( multidistrib.getVacantVolunteerRoles(),function (r) return "<li>"+r.name+"</li>").join("\n")+"</ul>";
				mail.setSubject( t._("[::group::] We need more volunteers for ::date:: distribution",{group : multidistrib.group.name, date : view.hDate(multidistrib.distribStartDate)}) );

				//Let's replace all the tokens
				var ddate = t._("::date:: from ::startHour:: to ::endHour::",{date:view.dDate(multidistrib.distribStartDate),startHour:view.hHour(multidistrib.distribStartDate),endHour:view.hHour(multidistrib.distribEndDate)});
				var emailBody = StringTools.replace( multidistrib.group.alertMailContent, "[DATE_DISTRIBUTION]", ddate );
				emailBody = StringTools.replace( emailBody, "[LIEU_DISTRIBUTION]", multidistrib.place.name );
				emailBody = StringTools.replace( emailBody, "[ROLES_MANQUANTS]", vacantVolunteerRolesList );
				mail.setHtmlBody( app.processTemplate("mail/message.mtt", { text: emailBody, group: multidistrib.getGroup()  } ) );

				App.sendMail(mail);
			}
		});
		task.execute(!App.config.DEBUG);

		//Send warnings about subscriptions that are not validated yet and for which there is a distribution that starts in the right time range
		var task = new TransactionWrappedTask( "Subscriptions to validate alert emails");
		task.setTask(function() {

			var fromNow = now.setHourMinute( now.getHours(), 0 );
			var toNow = now.setHourMinute( now.getHours() + 1, 0);
			var subscriptionsToValidate : Array< db.Subscription > = Lambda.array( db.Subscription.manager.unsafeObjects(
				'SELECT DISTINCT Subscription.*
				FROM Subscription INNER JOIN Catalog
				ON Subscription.catalogId = Catalog.id
				INNER JOIN Distribution
				ON Distribution.catalogId = Catalog.id
				WHERE Subscription.isValidated = false
				AND Distribution.date >= DATE_ADD(\'${fromNow}\', INTERVAL 3 DAY)
				AND Distribution.date < DATE_ADD(\'${toNow}\', INTERVAL 3 DAY);', false ) );

			var subscriptionsToValidateByCatalog = new Map< db.Catalog, Array< db.Subscription > >();
			for ( subscription in subscriptionsToValidate ) {
				if ( subscriptionsToValidateByCatalog[ subscription.catalog ] == null ) {
					subscriptionsToValidateByCatalog[ subscription.catalog ] = new Array< db.Subscription >();
				}
				subscriptionsToValidateByCatalog[ subscription.catalog ].push( subscription );
			}

			//List of subscriptions grouped by catalog
			for ( catalog in subscriptionsToValidateByCatalog.keys() ) {

				task.log( catalog.name );

				var message : String = 'Bonjour, <br /><br />
				Attention, les souscriptions suivantes n\'ont pas été validées, alors qu\'une distribution approche.
				Vous devez au plus vite valider ou effacer ces souscriptions et vous assurer qu\'elles correspondent
				bien au contrat signé, et aux produits que l\'adhérent a commandés.';

				message += '<h3> Catalogue : ' + catalog.name + '</h3> <ul>';
				subscriptionsToValidateByCatalog[ catalog ].sort( function(b, a) {

					return  a.user.getName() < b.user.getName() ? 1 : -1;
				} );
				for ( subscription in subscriptionsToValidateByCatalog[ catalog ] ) {
					message += '<li>' + subscription.user.getName() + '</li>';
				}
				message += '</ul>';
				App.quickMail( catalog.contact.email, catalog.name + ' : Il y a des souscriptions à valider', message, catalog.group );
			}

		});
		task.execute(!App.config.DEBUG);

		//Distrib notifications
		var task = new TransactionWrappedTask("Distrib notifications");
		task.setTask(function(){
			distribNotif(task,this.now,4,db.User.UserFlags.HasEmailNotif4h); //4h before
			distribNotif(task,this.now,24,db.User.UserFlags.HasEmailNotif24h); //24h before
			distribNotif(task,this.now,0, db.User.UserFlags.HasEmailNotifOuverture); //on command open
		});
		task.execute(!App.config.DEBUG);

		//Distrib Validation notifications
		var task = new TransactionWrappedTask("Distrib Validation notifications");
		task.setTask(distribValidationNotif.bind(task));
		task.execute(!App.config.DEBUG);

		//time slot assignement when orders are closing
		var task = new TransactionWrappedTask("Time slots assignement");
		task.setTask(function(){
			var range = tools.DateTool.getLastHourRange( now );
			task.log('get distribs whith order ending between ${range.from} and ${range.to}');
			var distribs = MultiDistrib.manager.search($orderEndDate >= range.from && $orderEndDate < range.to && $slots!=null ,true);
			for( d in distribs){

				var s = new service.TimeSlotsService(d);
				var slots = s.resolveSlots();
				var group = d.getGroup();
				task.log('Resolve slots for '+group.name);

				//send an email to group admins
				var admins = group.getGroupAdmins().filter(ug-> return ug.isGroupManager() );
				try{
					var m = new Mail();
					m.setSender(App.config.get("default_email"), "Cagette.net");
					for ( u in admins )	m.addRecipient(u.user.email, u.user.getName());
					m.setSubject( '[${group.name}] Créneaux horaires pour la distribution du '+Formatting.hDate(d.distribStartDate) );
					var text = 'La commande vient de fermer, les créneaux horaires ont été attribués en fonction des choix des membres du groupe : <a href="https://${App.config.HOST}/distribution/timeSlots/${d.id}">Voir le récapitulatif des créneaux horaires</a>.';
					m.setHtmlBody( app.processTemplate("mail/message.mtt", { text:text,group:group } ) );
					App.sendMail(m , d.getGroup() );
				}catch (e:Dynamic){
					task.warning(e);
					app.logError(e); //email could be invalid
				}
			}
		});
		task.execute(!App.config.DEBUG);


	}

	/**
		Daily cron job
	**/
	public function doDaily() {
		if (!canRun()) return;

		app.event(DailyCron(this.now));

		var task = new TransactionWrappedTask( "Send errors to admin by email", function() {
			var n = Date.now();
			var yest24h = new Date(n.getFullYear(), n.getMonth(), n.getDate(), 0, 0, 0);
			var yest0h = DateTools.delta(yest24h, -1000 * 60 * 60 * 24);

			var errors = sugoi.db.Error.manager.search( $date < yest24h && $date > yest0h  );
			if (errors.length > 0) {
				var report = new StringBuf();
				report.add("<h1>" + App.config.NAME + " : ERRORS</h1>");
				for (e in errors) {
					report.add("<div><pre>"+e.error + " at URL " + e.url + " ( user : " + (e.user!=null?e.user.toString():"none") + ", IP : " + e.ip + ")</pre></div><hr/>");
				}

				var m = new Mail();
				m.setSender(App.config.get("default_email"),"Cagette.net");
				m.addRecipient(App.config.get("webmaster_email"));
				m.setSubject(App.config.NAME+" Errors");
				m.setHtmlBody( app.processTemplate("mail/message.mtt", { text:report.toString() } ) );
				App.sendMail(m);
			}
		});
		task.execute(!App.config.DEBUG);

		var task = new TransactionWrappedTask( "Old datas cleaning", function() {
			task.log("Delete old messages");
			db.Message.manager.delete($date < DateTools.delta(Date.now(), -1000.0 * 60 * 60 * 24 * 30 * 3));
			task.log("Delete old sessions");
			sugoi.db.Session.clean();
			task.log("Delete old demo catalogs");
			var sevenDaysAgo = DateTools.delta(Date.now(), -1000.0 * 60 * 60 * 24 * 7);
			var heightDaysAgo = DateTools.delta(Date.now(), -1000.0 * 60 * 60 * 24 * 8);
			for( g in db.Group.manager.search($cdate<sevenDaysAgo && $cdate>heightDaysAgo) ){
				g.deleteDemoContracts();
			}
		});
		task.execute(!App.config.DEBUG);


		//Delete old documents of catalogs that have ended 18 months ago
		var task = new TransactionWrappedTask( "Delete old documents", function() {
			var eighteenMonthsAgo = DateTools.delta( Date.now(), -1000.0 * 60 * 60 * 24 * 30 * 18 );
			var oneDayBefore = DateTools.delta( eighteenMonthsAgo, -1000 * 60 * 60 * 24 );
			task.log('Catalogs that have ended between $oneDayBefore and $eighteenMonthsAgo');
			//Catalogs that have ended during that time range
			var endedCatalogs = db.Catalog.manager.search( $endDate >= oneDayBefore && $endDate < eighteenMonthsAgo, false );
			var documents : Array<sugoi.db.EntityFile>  = null;
			for ( catalog in endedCatalogs ) {

				documents = sugoi.db.EntityFile.getByEntity( 'catalog', catalog.id, 'document' );
				for ( document in documents ) {

					document.file.delete();
					document.delete();
				}
			}
		});
		task.execute(!App.config.DEBUG);

		//stats
		var task = new TransactionWrappedTask( "Stats", function() {
			var yesterday = new Date(now.getFullYear(), now.getMonth(), now.getDate()-1, 0, 0, 0);

			for( k in GraphService.getAllGraphKeys()){
				GraphService.getDay(k,yesterday);
			}

		});
		task.execute();
	}

	/**
	 * Send email notifications to users before a distribution
	 * @param	hour
	 * @param	flag
	 */
	function distribNotif(task:TransactionWrappedTask,now:Date,hour:Int, flag:db.User.UserFlags) {

		//trouve les distrib qui commencent dans le nombre d'heures demandé
 		//on recherche celles qui commencent jusqu'à une heure avant pour ne pas en rater
 		var from = DateTools.delta(now, 1000.0 * 60 * 60 * (hour-1));
 		var to = DateTools.delta(now, 1000.0 * 60 * 60 * hour);

		// dans le cas HasEmailNotifOuverture la date à prendre est le orderStartDate
		// et non pas date qui est la date de la distribution
		var distribs;
		if ( db.User.UserFlags.HasEmailNotifOuverture == flag ){
			task.title('$flag : Look for distribs with orderStartDate between $from to $to');
			distribs = db.Distribution.manager.search( $orderStartDate >= from && $orderStartDate <= to , false);
		} else {
			task.title('$flag : Look for distribs happening between $from to $to');
			distribs = db.Distribution.manager.search( $date >= from && $date < to , false);
		}

		//on s'arrete immédiatement si aucune distibution trouvée
 		if (distribs.length == 0) return;

		//on vérifie dans le cache du jour que ces distrib n'ont pas deja été traitées lors d'un cron précédent
		var dist :Array<Int> = [];
		var cacheId = Date.now().toString().substr(0, 10)+Std.string(flag);
		if(!App.config.DEBUG) {
			dist = sugoi.db.Cache.get(cacheId);
			if (dist != null) {
				for (d in Lambda.array(distribs)) {
					if (Lambda.exists(dist, function(x) return x == d.id)) {
						// Comment this line in case of local test
						distribs.remove(d);
					}
				}
			}else {
				dist = [];
			}
		}


		//toutes les distribs trouvées ont deja été traitées
		if (distribs.length == 0) return;

		//stocke cache
		for (d in distribs) {
			dist.push(d.id);
			task.log("Distrib : "+d.date+" de "+d.catalog.name+", groupe : "+d.catalog.group.name);
		}
		if(!App.config.DEBUG) Cache.set(cacheId, dist, 24 * 60 * 60);



		//We have now the distribs we want to notify about.
		/*var distribsByContractId = new Map<Int,db.Distribution>();
		for (d in distribs) {
			if (d == null || d.catalog==null) continue;
			distribsByContractId.set(d.catalog.id, d);
		}*/

		//Boucle sur les distributions pour gerer le cas de plusieurs distributions le même jour sur le même contrat
 		var orders = [];
 		for (d in distribs) {
			if (d == null || d.catalog==null) continue;
 			//get orders for both type of catalogs
			for ( x in d.catalog.getOrders(d)) orders.push(x);
		}

		/*
		 * Group orders by users-group to receive separate emails by groups for the same user.
		 * Map key is $userId-$groupId
		*/
		var users = new Map <String,{
			user:db.User,
			distrib:db.MultiDistrib,
			orders:Array<db.UserOrder>,
			vendors:Array<db.Vendor>
		}>();

		for (o in orders) {

			var x = users.get(o.user.id+"-"+o.product.catalog.group.id);
			if (x == null) x = {user:o.user,distrib:null,orders:[],vendors:[]};
			x.distrib = o.distribution.multiDistrib;
			x.orders.push(o);
			users.set(o.user.id+"-"+o.product.catalog.group.id, x);

			// Prévenir également le deuxième user en cas des commandes alternées
 			if (o.user2 != null) {
 				var x = users.get(o.user2.id+"-"+o.product.catalog.group.id);
 				if (x == null) x = {user:o.user2,distrib:null,orders:[],vendors:[]};
 				x.distrib = o.distribution.multiDistrib;
 				x.orders.push(o);
				users.set(o.user2.id+"-"+o.product.catalog.group.id, x);
 			}
		}

		//remove zero qt orders
		for( k in users.keys()){
			var x = users.get(k);
			var total = 0.0;
			for( o in x.orders) total += o.quantity;
			if(total==0.0) users.remove(k);
		}

		// Dans le cas de l'ouverture de commande, ce sont tous les users qu'il faut intégrer
		if ( db.User.UserFlags.HasEmailNotifOuverture == flag )
		{
 			for (d in distribs) {
				var memberList = d.catalog.group.getMembers();
				for (u in memberList) {
					var x = users.get(u.id+"-"+d.catalog.group.id);
					if (x == null) x = {user:u,distrib:null,orders:[],vendors:[]};
					x.distrib = d.multiDistrib;
					x.vendors.push(d.catalog.vendor);
					users.set(u.id+"-"+d.catalog.group.id, x);
				}
			}
		}

		for ( u in users) {
			if (u.user.flags.has(flag) ) {
				if (u.user.email != null) {
					var group = u.distrib.group;
					task.log("=== "+u.user.getName()+" de "+group.name);
					this.t = sugoi.i18n.Locale.init(u.user.lang); //switch to the user language

					var text;
					if ( db.User.UserFlags.HasEmailNotifOuverture == flag )
					{
						//order opening notif
						text = t._("Opening of orders for the delivery of <b>::date::</b>", {date:view.hDate(u.distrib.distribStartDate)});
						text += "<br/>";
						text += t._("The following suppliers are involved :");
						text += "<br/><ul>";
						for ( v in u.vendors) {
							text += "<li>" + v + "</li>";
						}
						text += "</ul>";

					}else{
						//Distribution notif to the users
						var d = u.distrib;
						text = t._("Do not forget the delivery on <b>::day::</b> from ::from:: to ::to::<br/>", {day:view.dDate(d.distribStartDate),from:view.hHour(d.distribStartDate),to:view.hHour(d.distribEndDate)});
						text += t._("Your products to collect :") + "<br/><ul>";
						for ( p in u.orders) {
							text += "<li>"+p.quantity+" x "+p.product.getName();
							// Gerer le cas des contrats en alternance
							if (p.user2 != null) {
								text += " " + t._("alternated with") + " ";
								if (u.user == p.user)
									text += p.user2.getCoupleName();
								else
									text += p.user.getCoupleName();
							}
							text += "</li>";
						}
						text += "</ul>";
					}

					try{
						var m = new Mail();
						m.setSender(App.config.get("default_email"), "Cagette.net");
						if(group.contact!=null) m.setReplyTo(group.contact.email, group.name);
						m.addRecipient(u.user.email, u.user.getName());
						if (u.user.email2 != null) m.addRecipient(u.user.email2);
						m.setSubject( group.name+" : "+t._("Distribution on ::date::",{date:app.view.hDate(u.distrib.distribStartDate)})  );

						//time slots
						var status = null;
						if(u.distrib.slots!=null){
							status = new service.TimeSlotsService(u.distrib).userStatus(u.user.id);
						}

						m.setHtmlBody( app.processTemplate("mail/orderNotif.mtt", { text:text,group:group,multiDistrib:u.distrib,user:u.user,status:status,hHour:Formatting.hHour } ) );
						App.sendMail(m , u.distrib.group);

						if(App.config.DEBUG){
							//task.log("distrib is "+u.distrib);
							task.title(u.user.getName());
							task.log(m.getHtmlBody());
						}

					}catch (e:Dynamic){
						app.logError(e); //email could be invalid
						task.warning(e);
						task.warning(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
					}

				}
			}
		}
	}


	/**
	 * Check if there is a multi-distrib to validate.
	 *
	 * Autovalidate it after 10 days
	 */
	function distribValidationNotif(task){

		var now = Date.now();

		var from = now.setHourMinute( now.getHours(), 0 );
		var to = now.setHourMinute( now.getHours()+1 , 0);

		var explain = t._("<p>This step is important in order to:</p>");
		explain += t._("<ul><li>Update orders if delivered quantities are different from ordered quantities</li>");
		explain += t._("<li>Confirm the reception of payments (checks, cash, transfers) in order to mark orders as 'paid'</li></ul>");

		/*
		 * warn administrator if a distribution just ended
		 */
		var distribs = db.MultiDistrib.manager.search( !$validated && ($distribStartDate >= from) && ($distribStartDate < to) , false);

		for ( d in Lambda.array(distribs)){
			if ( !d.getGroup().hasPayments() ){
				distribs.remove(d);
			}
		}
		var view = App.current.view;
		for ( d in distribs ){
			var subj = t._("[::group::] Validation of the ::date:: distribution",{group : d.getGroup().name , date : view.hDate(d.distribStartDate)});
			var url = "http://" + App.config.HOST + "/distribution/validate/"+d.id;
			var html = t._("<p>Your distribution just finished, don't forget to <b>validate</b> it</p>");
			html += explain;
			html += t._("<p><a href='::distriburl::'>Click here to validate the distribution</a> (You must be connected to your group Cagette)", {distriburl:url});
			App.quickMail(d.getGroup().contact.email, subj, html);
		}

		/*
		 * warn administrator if a distribution ended 3 days ago
		 */

		var from = now.setHourMinute( now.getHours() , 0 ).deltaDays(-3);
		var to = now.setHourMinute( now.getHours()+1 , 0).deltaDays(-3);

		//warn administrator if a distribution just ended
		var distribs = db.MultiDistrib.manager.search( !$validated && ($distribStartDate >= from) && ($distribStartDate < to) , false);

		for ( d in Lambda.array(distribs)){
			if ( !d.getGroup().hasPayments() ){
				distribs.remove(d);
			}
		}

		for ( d in distribs ){

			var subj = t._("[::group::] Validation of the ::date:: distribution",{group : d.getGroup().name , date : view.hDate(d.distribStartDate)});
			var url = "http://" + App.config.HOST + "/distribution/validate/"+d.id;
			var html = t._("<p>Reminder: you have a delivery to validate.</p>");
			html += explain;
			html += t._("<p><a href='::distriburl::'>Click here to validate the delivery</a> (You must be connected to your Cagette group)", {distriburl:url});

			App.quickMail(d.getGroup().contact.email, subj, html);
		}


		/*
		 * Autovalidate unvalidated distributions after 10 days
		 */
		/*var from = now.setHourMinute( now.getHours() , 0 ).deltaDays( 0 - db.Distribution.DISTRIBUTION_VALIDATION_LIMIT );
		var to = now.setHourMinute( now.getHours() + 1 , 0).deltaDays( 0 - db.Distribution.DISTRIBUTION_VALIDATION_LIMIT );
		task.log('<h3>Autovalidation of unvalidated distribs</h3>');
		task.log('Find distributions from $from to $to');
		var distribs = db.MultiDistrib.manager.search( !$validated && ($distribStartDate >= from) && ($distribStartDate < to) , false);
		for ( d in Lambda.array(distribs)){
			if ( !d.getGroup().hasPayments() ){
				distribs.remove(d);
			}
		}

		for (d in distribs){
			task.log(d.toString());
			try	{
				service.PaymentService.validateDistribution(d);
			}catch(e:tink.core.Error){
				task.log(e.message);
				continue;
			}
		}
		//email
		for ( d in distribs ){
			if(d.getGroup().contact==null) continue;
			var subj = t._("[::group::] Validation of the ::date:: distribution",{group : d.getGroup().name , date : view.hDate(d.distribStartDate)});
			var html = t._("<p>As you did not validate it manually after 10 days, <br/>the delivery of the ::deliveryDate:: has been validated automatically</p>", {deliveryDate:App.current.view.hDate(d.distribStartDate)});
			App.quickMail(d.getGroup().contact.email, subj, html);
		}*/

	}

	/**
	 * Send emails from buffer.
	 *
	 * Warning, if the cron is executed each minute,
	 * you should consider the right amount of emails to send each minute in order to avoid overlaping and getting in concurrency problems.
	 * (like "SELECT * FROM BufferedMail WHERE sdate IS NULL ORDER BY cdate DESC LIMIT 100 FOR UPDATE Lock wait timeout exceeded; try restarting transaction")
	 */
	function sendEmailsfromBuffer(index:Int,task:TransactionWrappedTask){
		//send
		for( e in sugoi.db.BufferedMail.manager.search($sdate==null,{limit:[index,10],orderBy:-cdate},true)  ){
			if(e.isSent()) continue;
			task.log('#${e.id} - ${e.title}');
			e.finallySend();
		}
	}

	/**
	 *  Email product report when orders close
	 **/
	function sendOrdersByProductWhenOrdersClose(){

		var range = tools.DateTool.getLastHourRange();
		// Sys.println("Time is "+Date.now()+"<br/>");
		// Sys.println('Find all distributions that have closed in the last hour from ${range.from} to ${range.to} \n<br/>');

		for ( d in db.Distribution.manager.search($orderEndDate >= range.from && $orderEndDate < range.to, false)){
			service.OrderService.sendOrdersByProductReport(d);
		}
	}

	public static function print(text:Dynamic){
		var text = Std.string(text);
		Sys.println( "<pre>"+ text + "</pre>" );
	}

	public static function printTitle(title){
		Sys.println("<h2>"+title+"</h2>");
	}
}
