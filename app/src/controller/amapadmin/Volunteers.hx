package controller.amapadmin;
import sugoi.form.elements.IntInput;
import sugoi.form.elements.IntSelect;
import sugoi.form.elements.StringInput;
import sugoi.form.elements.TextArea;
import service.VolunteerService;

class Volunteers extends controller.Controller
{
	@tpl("amapadmin/volunteers/default.mtt")
	function doDefault() {

		view.volunteerRoles = VolunteerService.getRolesFromGroup(app.user.getGroup());
		
		checkToken();

		var form = new sugoi.form.Form("msg");
		form.addElement( new IntInput("dutyperiodsopen", t._("Number of days before duty periods open to volunteers (between 7 and 180"), app.user.getGroup().daysBeforeDutyPeriodsOpen, true) );
		
		form.addElement( new IntInput("maildays", t._("Number of days before duty period to send mail"), app.user.getGroup().volunteersMailDaysBeforeDutyPeriod, true) );
		form.addElement( new TextArea("volunteersMailContent", t._("Email body sent to volunteers"), app.user.getGroup().volunteersMailContent, true, null, "style='height:300px;'") );
		form.addElement( new sugoi.form.elements.Html("html1","<b>Variables utilisables dans l'email :</b><br/>
				[DATE_DISTRIBUTION] : Date de la distribution<br/>
				[LIEU_DISTRIBUTION] : Lieu de la distribution<br/> 
				[LISTE_BENEVOLES] : Liste des bénévoles inscrits à cette permanence"));
		form.addElement( new IntInput("alertmaildays", t._("Number of days before duty period to send mail for vacant volunteer roles"), app.user.getGroup().vacantVolunteerRolesMailDaysBeforeDutyPeriod, true) );
		form.addElement( new TextArea("alertMailContent", t._("Alert email body"), app.user.getGroup().alertMailContent, true, null, "style='height:300px;'") );
		form.addElement( new sugoi.form.elements.Html("html2","<b>Variables utilisables dans l'email :</b><br/>
				[DATE_DISTRIBUTION] : Date de la distribution<br/>
				[LIEU_DISTRIBUTION] : Lieu de la distribution<br/> 
				[ROLES_MANQUANTS] : Rôles restant à pourvoir"));

		if (form.isValid()) {

			try {
				VolunteerService.isNumberOfDaysValid( form.getValueOf("dutyperiodsopen"), "volunteersCanJoin" );
				VolunteerService.isNumberOfDaysValid( form.getValueOf("maildays"), "instructionsMail" );
				VolunteerService.isNumberOfDaysValid( form.getValueOf("alertmaildays"), "vacantRolesMail" );
			}
			catch(e: tink.core.Error) {
				throw Error("/amapadmin/volunteers", e.message);
			}			

			var group  = app.user.getGroup();
			group.lock();
			group.daysBeforeDutyPeriodsOpen = form.getValueOf("dutyperiodsopen");
			group.volunteersMailDaysBeforeDutyPeriod = form.getValueOf("maildays");
			group.volunteersMailContent = form.getValueOf("volunteersMailContent");
			group.vacantVolunteerRolesMailDaysBeforeDutyPeriod = form.getValueOf("alertmaildays");
			group.alertMailContent = form.getValueOf("alertMailContent");
			group.update();
			
			throw Ok("/amapadmin/volunteers", t._("Your changes have been successfully saved."));
			
		}
		
		view.form = form;
		view.nav.push( 'volunteers' );

	}

	/**
		Insert a volunteer role
	**/
	@tpl("form.mtt")
	function doInsertRole() {

		var role = new db.VolunteerRole();
		var form = new sugoi.form.Form("volunteerrole");

		form.addElement( new StringInput("name", t._("Volunteer role name"), null, true) );
		var activeContracts = Lambda.array(Lambda.map(app.user.getGroup().getActiveContracts(), function(contract) return { label: contract.name, value: contract.id }));
		form.addElement( new IntSelect('contract',t._("Related catalog"), activeContracts, null, false, t._("None")) );
	                                                
		if (form.isValid()) {
			
			role.name = form.getValueOf("name");
			role.group = app.user.getGroup();
			var contractId = form.getValueOf("contract");
		
			if (contractId != null)  
			{
				role.catalog = db.Catalog.manager.get(contractId);
			}
			role.insert();
			throw Ok("/amapadmin/volunteers", t._("Volunteer Role has been successfully added"));
			
		}

		view.title = t._("Create a volunteer role");
		view.form = form;

	}

	/**
	 * Edit a volunteer role
	 */
	@tpl('form.mtt')
	function doEditRole(role:db.VolunteerRole) {

		var form = new sugoi.form.Form("volunteerrole");

		form.addElement( new StringInput("name", t._("Volunteer role name"), role.name, true) );
		var activeContracts = Lambda.array(Lambda.map(app.user.getGroup().getActiveContracts(), function(contract) return { label: contract.name, value: contract.id }));
		var defaultContractId = role.catalog != null ? role.catalog.id : null;
		form.addElement( new IntSelect('contract',t._("Related catalog"), activeContracts, defaultContractId, false, t._("None")) );
	                                                
		if (form.isValid()) {
			
			role.lock();

			role.name = form.getValueOf("name");
			var contractId = form.getValueOf("contract");
			role.catalog = contractId != null ? db.Catalog.manager.get(contractId) : null;
			
			role.update();

			throw Ok("/amapadmin/volunteers", t._("Volunteer Role has been successfully updated"));
			
		}

		view.title = t._("Create a volunteer role");
		view.form = form;

	}

	/**
	 * Delete a volunteer role
	 */
	function doDeleteRole(role: db.VolunteerRole, args: { token:String , ?force:Bool}) {

		if ( checkToken() ) {

			try {
				VolunteerService.deleteVolunteerRole(role,args.force);
			}
			catch(e: tink.core.Error){
				throw Error("/amapadmin/volunteers", e.message);
			}

			throw Ok("/amapadmin/volunteers", t._("Volunteer Role has been successfully deleted"));
		} else {
			throw Redirect("/amapadmin/volunteers");
		}
	}
	
}
