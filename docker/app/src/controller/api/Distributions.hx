package controller.api;
import haxe.DynamicAccess;
import service.TimeSlotsService;
import tink.core.Error;
import db.UserGroup;
import haxe.Json;
import Common;
import db.MultiDistrib;

class Distributions extends Controller {

  private var distrib: db.MultiDistrib;

  public function new(distrib: db.MultiDistrib) {
    super();
    this.distrib = distrib;
  }

  public function doSlots(d:haxe.web.Dispatch) {
		d.dispatch(new controller.api.DistributionsSlots(distrib));
	}	

  private function checkAdminRights(){
    if (!App.current.user.isGroupManager()){
      throw new tink.core.Error(403, "Forbidden, you're not group manager");
    }
    if(app.user.getGroup().id!=this.distrib.getGroup().id) {
      throw new tink.core.Error(403, "Forbidden, this distrib does not belong to the groupe you're connected to");
    }
  }
  
  private function checkIsGroupMember(){
    
    // user must be logged
    if (app.user == null) throw new tink.core.Error(403, "Forbidden, user is null");
    
    // user must be member of group
    if(UserGroup.get(app.user,distrib.getGroup())==null){
      throw new tink.core.Error(403, "User is not member of this group");
    }
  }

  private function checkCanEnableTimeSlots() {
    var now = Date.now();
    if(distrib.orderEndDate==null || distrib.orderEndDate.getTime() < now.getTime() ){
      throw new tink.core.Error(403,"Orders are not open");
    }
  }

  private function isResolved() {
    var resolved = false;
    if (distrib.slots == null) return true;
    distrib.slots.foreach(slot -> {
      if (slot.selectedUserIds.length > 0) resolved = true;
      return true;
    });
    return resolved;
  }

  public function doDefault() {
    if (sugoi.Web.getMethod() != "GET") throw new tink.core.Error(405, "Method Not Allowed");
    checkIsGroupMember();
    json(this.parse());
  }

  /**
    an admin updates the slots
  **/
  public function doActivateSlots() {
    if (sugoi.Web.getMethod() != "POST") throw new tink.core.Error(405, "Method Not Allowed");
    checkAdminRights();
    checkCanEnableTimeSlots();

    var request = sugoi.tools.Utils.getMultipart( 1024 * 1024 * 10 ); //10Mb	
    if (!request.exists("mode")) throw new tink.core.Error(400, "Bad Request - missing mode");
    var mode = request.get("mode");

    if (mode != "solo-only" && mode != "default") throw new tink.core.Error(400, "Bad Request - invalid mode: " + mode);

	  var s = new TimeSlotsService(this.distrib);
    s.generateSlots(mode);    
    json(this.parse());
  }

  /**
   * deactivate slots
   */
  public function doDesactivateSlots() {
    if (sugoi.Web.getMethod() != "POST") throw new tink.core.Error(405, "Method Not Allowed");
    checkAdminRights();

    if (isResolved()) {
      json(this.parse());
      return;
    }
    
    this.distrib.lock();
    this.distrib.slotsMode = null;
    this.distrib.slots = null;
    this.distrib.inNeedUserIds = null;
    this.distrib.voluntaryUsers = null;
    this.distrib.update();

    json(this.parse());
  }

  public function doResolved() {
    if (sugoi.Web.getMethod() != "GET") throw new tink.core.Error(405, "Method Not Allowed");
    checkAdminRights();

    if (this.distrib.slots == null) {
     json(this.parse());
      return;
    }

    var now = Date.now();
    
    if(distrib.orderEndDate==null || distrib.orderEndDate.getTime() > now.getTime()){
      json(this.parse());
      return;
    }

    var it = this.distrib.inNeedUserIds.keys();
    var inNeedUserIds = new Array<Int>();
    while (it.hasNext()) {
      inNeedUserIds.push(it.next());
    }
    var inNeedUsers = db.User.manager.search($id in inNeedUserIds, false).array();

    var userIds = Lambda.fold(this.distrib.slots, (slot, acc: Array<Int>) -> {
      return Lambda.fold(slot.selectedUserIds, (userId, acc2: Array<Int>) -> {
        if (acc2.indexOf(userId) == -1) acc2.push(userId);
        return acc2;
      }, acc);
    }, new Array<Int>());
    var users = db.User.manager.search($id in userIds, false).array();

    var it = this.distrib.voluntaryUsers.keyValueIterator();
    var voluntaryMap = new haxe.DynamicAccess();
    while (it.hasNext()) {
      var v = it.next();
      voluntaryMap.set(Std.string(v.key), v.value);
    }

    var otherUsers =  this.distrib.getOrders().filter(userOrder -> {
      var founded = users.find(u -> u.id == userOrder.user.id);
      if (founded != null) return false;
      founded = inNeedUsers.find(u -> u.id == userOrder.user.id);
      if (founded != null) return false;
      return true;
    });

    json({
      id: this.distrib.id,
      start: this.distrib.distribStartDate,
      end: this.distrib.distribEndDate,
      orderEndDate: this.distrib.orderEndDate,
      slots: this.distrib.slots,
      voluntaryMap: voluntaryMap,
      otherUsers: otherUsers.map(userOrder -> ({
        id: userOrder.user.id,
        firstName: userOrder.user.firstName,
        lastName: userOrder.user.lastName,
      })),
      users: users.map(user -> ({
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
      })),
      inNeedUsers: inNeedUsers.map(user -> {
        var data: Dynamic =  {
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
        }
        if (this.distrib.inNeedUserIds.get(user.id).indexOf("address") != -1) {
          data.address1 = user.address1;
          data.address2 = user.address2;
          data.city = user.city;
          data.zipCode = user.zipCode;
        }
        if (this.distrib.inNeedUserIds.get(user.id).indexOf("email") != -1) {
          data.email = user.email;
        }
        if (this.distrib.inNeedUserIds.get(user.id).indexOf("phone") != -1) {
          data.phone = user.phone;
        }
        return data;
      })
    });
  }

  @admin
  public function doUnresolve() {
    if (sugoi.Web.getMethod() != "GET") throw new tink.core.Error(405, "Method Not Allowed");
    if (this.distrib.slots == null) return json({message: "slot not activated"});
    this.distrib.lock();
    this.distrib.slots.map(slot -> {
      slot.selectedUserIds = [];
      return slot;
    });
    this.distrib.update();
    json({message: "slots unresolved"});
  }

  // TODO: remove
  @admin
  public function doResolve() {
    this.distrib.resolveSlots();
  }

   // TODO: remove
  @admin
  public function doCloseDistrib() {
    this.distrib.lock();
    this.distrib.orderEndDate = DateTools.delta(Date.now(), -(1000 * 60 * 60 * 24));
    this.distrib.update();
    json(this.parse());
  }

   // TODO: remove
  //  @admin
  // public function doDesactivateSlots() {
  //   this.distrib.lock();
  //   this.distrib.slotsMode = null;
  //   this.distrib.slots = null;
  //   this.distrib.inNeedUserIds = null;
  //   this.distrib.voluntaryUsers = null;
  //   this.distrib.orderEndDate  = DateTools.delta(Date.now(), 1000 * 60 * 60 * 24);
  //   this.distrib.update();
  //   json(this.parse());
  // }

  // TODO: remove
  @admin
  public function doRegisterVoluntaryForMe() {

    var userId = App.current.user.id;
    var s = new TimeSlotsService(this.distrib);
    s.registerInNeedUser(userId, ["email"]);
    s.registerVoluntary(1, [55875]);
    
    json(this.parse());
  }

  // TODO : remove
  @admin
  public function doGenerateFakeDatas() {
    var fakeUserIds : Array<Int> = this.distrib.group.getMembers().filter(u -> u.id != 55875).map(u->return u.id).array();

    var s = new TimeSlotsService(this.distrib);
    this.distrib.lock();
    this.distrib.slotsMode = null;
    this.distrib.slots = null;
    this.distrib.inNeedUserIds = null;
    this.distrib.voluntaryUsers = null;
    this.distrib.orderEndDate  = DateTools.delta(Date.now(), 1000 * 60 * 60 * 24);
    this.distrib.update();

    s.generateSlots("default");

    var nbInNeed = Math.round(fakeUserIds.length * .2);

    var inNeedUserIds = new Array<Int>();

    s.registerUserToSlot(fakeUserIds[0], [0, 1]);
    s.registerVoluntary(fakeUserIds[0], []);

    for (userIndex in 1...nbInNeed) {
      s.registerInNeedUser(fakeUserIds[userIndex], ["email"]);
      inNeedUserIds.push(fakeUserIds[userIndex]);
    }

    for (userIndex in nbInNeed...fakeUserIds.length) {
      var slotIds = new Array<Int>();
      for (slotIndex in 0...this.distrib.slots.length) {
        var slot = this.distrib.slots[slotIndex];
        if (Math.random() > 0.7) {
          slotIds.push(slot.id);
        }
      }
      s.registerUserToSlot(fakeUserIds[userIndex], slotIds);

      if (Math.random() > 0.3 && inNeedUserIds.length > 2) {
        var i = Math.round(Math.min(Math.random() * 3 + 1, inNeedUserIds.length - 2));
        var iii = new Array<Int>();
        for (ii in 0...i) {
          iii.push(inNeedUserIds.pop());
        }
        s.registerVoluntary(fakeUserIds[userIndex], iii);
      }
    }
    
    json(this.parse());
  }

  private function parse() {
    var users = new Array();

    if (this.distrib.inNeedUserIds != null) {

      // on récupère la liste des userInNeedIds
      var inNeedUserIds = new Array<Int>();
      var it = this.distrib.inNeedUserIds.keyValueIterator();
      while (it.hasNext()) {
        var v = it.next();
        inNeedUserIds.push(v.key);
        // inNeedUserIds = inNeedUserIds.filter(ui -> ui != v.key);
      }

      // que l'on filtre avec ceux déjà servis
      var it = this.distrib.voluntaryUsers.keyValueIterator();
      while (it.hasNext()) {
        var v = it.next();
        inNeedUserIds = inNeedUserIds.filter(userId ->v.value.indexOf(userId) == -1);
      }

      // que l'on transforme avec les datas aurtorisées
      for (i in 0...inNeedUserIds.length) {
        var user = db.User.manager.select($id == inNeedUserIds[i]);
        var userData: Dynamic = {
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
        };
        if (this.distrib.inNeedUserIds.get(user.id).indexOf("address") != -1) {
          userData.address1 = user.address1;
          userData.address2 = user.address2;
          userData.city = user.city;
          userData.zipCode = user.zipCode;
        }
        users.push(userData);
      }
    };

    return {
      id: this.distrib.id,
      start: this.distrib.distribStartDate,
      end: this.distrib.distribEndDate,
      orderEndDate: this.distrib.orderEndDate,
      mode: this.distrib.slotsMode,
      slots: this.distrib.slots,
      inNeedUsers: users
    }
  }

  

}