package controller.api;

import haxe.DynamicAccess;
import service.TimeSlotsService;
import tink.core.Error;
import db.UserGroup;
import haxe.Json;
import Common;
import db.MultiDistrib;

class DistributionsSlots extends Controller {

	private var distrib: db.MultiDistrib;
	private var availableModes = ["solo", "voluntary", "inNeed"];

	public function new(distrib: db.MultiDistrib) {
		super();
		this.distrib = distrib;
	}

	public function doRegisterMe() {
		if (sugoi.Web.getMethod() != "POST") throw new tink.core.Error(405, "Method Not Allowed");
		checkIsGroupMember();
		checkOrdersAreOpen();

		var s = new TimeSlotsService(this.distrib);
		var userId = App.current.user.id;
		var request = sugoi.tools.Utils.getMultipart( 1024 * 1024 * 10 ); //10Mb	

		if (s.userIsAlreadyAdded(userId)) {
			var status = s.userStatus(userId);

			if (status.has == "voluntary" && request.exists("userIds")) {
				var userIds = request.get("userIds").split(",").map(Std.parseInt);
				var success = s.updateVoluntary(App.current.user.id, userIds);
				if (success == false) throw new tink.core.Error(500, "Can't update voluntary");
			} 
			
			if ((status.has == "solo" || status.has == "voluntary") && request.exists("slotIds")) {
				var slotIds = request.get("slotIds").split(",").map(Std.parseInt);
				if (slotIds.length < 1) throw new tink.core.Error(400, "Bad Request - no slot");
				slotIds.foreach(slotId -> {
					if (this.distrib.slots.find(slot -> slot.id == slotId) == null) throw new tink.core.Error(400, "Bad Request - unknow slot id");
					return true;
				});
				var success = s.updateUserToSlot(App.current.user.id, slotIds);
				if (success == false) throw new tink.core.Error(500, "Can't update");
			}

			return json(s.userStatus(userId));
		}

		if (!request.exists("has")) throw new tink.core.Error(400, "Bad Request - has required");
		var has = request.get("has");
		if (availableModes.indexOf(has) == -1) throw new tink.core.Error(400, "Bad Request - unknow has");

		if (distrib.slotsMode == "solo-only") has = "solo";

		if (has == "inNeed") {
			if (!request.exists("allowed")) throw new tink.core.Error(400, "Bad Request - allowed required");
			var success = s.registerInNeedUser(App.current.user.id, request.get("allowed").split(","));
			if (success == false) throw new tink.core.Error(500, "Can't register");
			json(s.userStatus(userId)); 
			return;
		}

		var slotIds = new Array<Int>();
		if (!request.exists("slotIds")) throw new tink.core.Error(400, "Bad Request - slotIds required");
		slotIds = request.get("slotIds").split(",").map(Std.parseInt);
		if (slotIds.length < 1) throw new tink.core.Error(400, "Bad Request - no slot");
		slotIds.foreach(slotId -> {
			if (this.distrib.slots.find(slot -> slot.id == slotId) == null) throw new tink.core.Error(400, "Bad Request - unknow slot id");
			return true;
		});

		var success = s.registerUserToSlot(userId, slotIds);
		if (success == false) throw new tink.core.Error(500, "Can't register");

		if (has == "voluntary") {
			var userIds: Array<Int>;
			if (request.exists("userIds")) {
				userIds = request.get("userIds").split(",").map(Std.parseInt);
			} else {
				userIds = [];
			}
			success = s.registerVoluntary(App.current.user.id, userIds);
			if (success == false) throw new tink.core.Error(500, "Can't register voluntary");
		}

		json(s.userStatus(userId)); 
	}



	public function doMe() {
		if (sugoi.Web.getMethod() != "GET") throw new tink.core.Error(405, "Method Not Allowed");
		checkIsGroupMember();
		var userId = App.current.user.id;
		var s = new TimeSlotsService(this.distrib);
		json(s.userStatus(userId)); 
	}


	/**
	 * PRIVATE
	 */
	private function checkAdminRights(){
		if (!App.current.user.isAmapManager() || app.user.getGroup().id!=this.distrib.getGroup().id){
			throw new tink.core.Error(403, "Forbidden");
		} 
	}
	
	private function checkIsGroupMember(){
		// user must be logged
		if (app.user == null) throw new tink.core.Error(403, "Forbidden");
		
		// user must be member of group
		if(UserGroup.get(app.user,distrib.getGroup())==null){
			throw new tink.core.Error(403, "User is not member of this group");
		}
	}

	private function checkOrdersAreOpen() {
		var now = Date.now();
		var orderStartDate = distrib.getOrdersStartDate(true);
		var orderEndDate = distrib.getOrdersEndDate(true);

		if(orderEndDate==null || !(orderStartDate.getTime() < now.getTime() && orderEndDate.getTime() > now.getTime()) ){
			throw new Error(403,"Orders are not open");
		}
	}
}