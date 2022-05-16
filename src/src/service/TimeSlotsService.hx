package service; 
import haxe.Json;
import haxe.DynamicAccess;

class TimeSlotsService{

    var distribution:db.MultiDistrib;

    public function new(d:db.MultiDistrib){
        distribution = d;
	}

	public function isResolved(){

		for( s in distribution.slots ){
			if(s.selectedUserIds.length>0) return true;
		}

		return false;
	}
	
    private function resolveUserMonoSlot(s: Array<SlotResolver>): Array<SlotResolver> {
		var slots = s.copy();
		var potentialUserMap = this.getPotentialUserMap(slots);
		var userIdResolved = new Array<Int>();

		var it = potentialUserMap.keyValueIterator();
		while (it.hasNext()) {
			var v = it.next();
			if (v.value.length == 1 && userIdResolved.indexOf(v.key) == -1) {
				userIdResolved.push(v.key);
				var slot = slots.find(slot -> slot.id == v.value[0]);
				if (slot != null) slot.selectUser(v.key);
			}
		}
		return slots;
	}

    /** */
	private function getPotentialUserMap(slots: Array<SlotResolver>) {
		var userMap = new Map<Int, Array<Int>>();

		for (i in 0...slots.length) {
			var slot = slots[i];
			for (j in 0...slot.potentialUserIds.length) {
				var userId = slot.potentialUserIds[j];
				if (!userMap.exists(userId)) {
					userMap.set(userId, new Array<Int>());
				}
				var values = userMap.get(userId);
				values.push(slot.id);
				userMap.set(userId, values);
			}
		}
		return userMap;
	}

    private function resolve(s: Array<SlotResolver>) {
		var slots = s.copy();
		var workingSlots = slots.filter(slot -> !slot.isResolved());
		if (workingSlots.length == 0) return slots;

		var potentialUserMap = this.getPotentialUserMap(slots);
		var initFold: Null<SlotResolver> = null;
		var workingSlot = Lambda.fold(workingSlots, function(slot, acc) {
			if (acc == null) return slot;

			if (slot.selectedUserIds.length < acc.selectedUserIds.length) {
				return slot;
			}

			if (slot.selectedUserIds.length == acc.selectedUserIds.length) {
				var slotUserWeight = Lambda.fold(slot.potentialUserIds, function(userId, accWeight) {
					return accWeight + potentialUserMap.get(userId).length;
				}, 0);
				var accUserWeight = Lambda.fold(acc.potentialUserIds, function(userId, accWeight) {
					return accWeight + potentialUserMap.get(userId).length;
				}, 0);
				if (slotUserWeight < accUserWeight) return slot;
			}


			// if (slot.selectedUserIds.length < acc.selectedUserIds.length) {
			// 	if (slot.potentialUserIds.length < acc.potentialUserIds.length) {
					// var slotUserWeight = Lambda.fold(slot.potentialUserIds, function(userId, accWeight) {
					// 	return accWeight + potentialUserMap.get(userId).length;
					// }, 0);
					// var accUserWeight = Lambda.fold(acc.potentialUserIds, function(userId, accWeight) {
					// 	return accWeight + potentialUserMap.get(userId).length;
					// }, 0);
			// 		if (slotUserWeight < accUserWeight) return slot;
			// 	}
			// }
			return acc;
		}, initFold);

		var workingUserId = Lambda.fold(workingSlot.potentialUserIds, function(userId, acc) {
			if (acc == null) {
				return userId;
			}
			if (potentialUserMap.get(userId).length < potentialUserMap.get(acc).length) {
				return userId;
			}
			return acc;
		}, null);

		return resolve(slots.map(slot -> {
			if (slot.id == workingSlot.id) {
				slot.selectUser(workingUserId);
			} else {
				slot.removePotentialUser(workingUserId);
			}
			return slot;
		}));
	}

	public function resolveSlots() {
		distribution.lock();
		// distrib slots must be activated
		if (distribution.slots == null) return null;

		var userOrders = distribution.getOrders();

		// on récupère les slots resolvers
		var slots = distribution.slots.map(slot -> 
			return new SlotResolver(slot.id, slot.registeredUserIds.filter(userId -> {
				var founded = userOrders.find(uo -> {
					return  uo.user.id == userId;
				});
				return founded != null;
			}))
		);

		// parse
		var slotResolvers = resolve(resolveUserMonoSlot(slots));

		var registeredAndInNeedUserIds = new Array<Int>();
		var it = distribution.inNeedUserIds.keys();
		while (it.hasNext()) {
			var key = it.next();
			registeredAndInNeedUserIds.push(key);
		}
		slotResolvers.foreach(slot -> {
			registeredAndInNeedUserIds = registeredAndInNeedUserIds.concat(slot.selectedUserIds);
			return true;
		});

		var notInSoltUserOrderIds = distribution.getOrders()
			.filter(userOrder -> registeredAndInNeedUserIds.indexOf(userOrder.user.id) == -1)
			.map(userOrder -> userOrder.user.id);
		

		// RESOLVE 2
		slotResolvers = resolve(slotResolvers.map(resolved -> 
			new SlotResolver(resolved.id, notInSoltUserOrderIds, resolved.selectedUserIds)
		));

		distribution.slots = distribution.slots.map(function (slot) {
			var resolver = slotResolvers.find(r -> r.id == slot.id);
			if (resolver != null) {
				slot.selectedUserIds = resolver.selectedUserIds;
			}
			return slot;
		});

		distribution.update();

		return distribution.slots;
	}

	public function userStatus(userId: Int) {
		var res = {
			registered: this.userIsAlreadyAdded(userId),
			isResolved: false,
			selectedSlotId: null,
			registeredSlotIds: null,
			has: null,
			voluntaryOfId: null,
			voluntaryOf: null,
			voluntaryForIds: null,
			voluntaryFor: null,
		}

		if (distribution.slots == null) {
			return res;
		}

		Lambda.foreach(distribution.slots, slot -> {
			if (res.isResolved == false && slot.selectedUserIds.length > 0) {
				res.isResolved = true;
			}
			if (res.registered == true && slot.selectedUserIds.indexOf(userId) != -1) {
				res.selectedSlotId = slot.id;
			}
			if (res.registered == true && slot.registeredUserIds.indexOf(userId) != -1) {
				if (res.registeredSlotIds == null) res.registeredSlotIds = new Array<Int>();
				res.registeredSlotIds.push(slot.id);
			}
			return true;
		});

		if (distribution.inNeedUserIds.exists(userId) == true) {
			res.has = "inNeed";
			var it = distribution.voluntaryUsers.keyValueIterator();
			var founded = false;
			while (it.hasNext() && founded == false) {
				var next = it.next();
				if (next.value.indexOf(userId) != -1) {
					founded = true;
					if (res.voluntaryOfId == null) res.voluntaryOfId = new Array<Int>();
					res.voluntaryOfId.push(next.key);
					var user = db.User.manager.select($id == next.key);
					res.voluntaryOf = {
						id: user.id,
						firstName: user.firstName,
						lastName: user.lastName
					};
				}
			}
		} else if (distribution.voluntaryUsers.exists(userId) == true) {
			res.has = "voluntary";
			if (distribution.voluntaryUsers.exists(userId)) {
				var inNeedUserId = distribution.voluntaryUsers.get(userId);
				var users = db.User.manager.search($id in inNeedUserId, false).array().map(user -> {
					var data: Dynamic =  {
						id: user.id,
						firstName: user.firstName,
						lastName: user.lastName,
					}
					if (distribution.inNeedUserIds.get(user.id).indexOf("address") != -1) {
						data.address1 = user.address1;
						data.address2 = user.address2;
						data.city = user.city;
						data.zipCode = user.zipCode;
					}
					if (distribution.inNeedUserIds.get(user.id).indexOf("email") != -1) {
						data.email = user.email;
					}
					if (distribution.inNeedUserIds.get(user.id).indexOf("phone") != -1) {
						data.phone = user.phone;
					}
					return data;
				});
				res.voluntaryForIds = inNeedUserId;
				res.voluntaryFor = users;
			}
		} else if (res.registered == true) {
			res.has = "solo";
		}
		return res;
	}

	public function userIsAlreadyAdded(userId: Int) {
		if (distribution.slots == null) return false;

		var founded = Lambda.fold(distribution.slots, function(slot, acc) {
			if (acc == true) return acc;
			if (slot.registeredUserIds.indexOf(userId) != -1) {
				return true;
			}
			return acc;
		}, false);

		if (founded == true) return true;

		if (distribution.inNeedUserIds == null) return false;

		return distribution.inNeedUserIds.exists(userId);
	}
    
    /*** */
	public function generateSlots(mode: String) {
		if (distribution.slots != null) return;

		distribution.lock();

		distribution.slotsMode = mode;

		var slotDuration = 1000 * 60 * 15;
		var nbSlots = Math.floor((distribution.distribEndDate.getTime() - distribution.distribStartDate.getTime()) / slotDuration);
		distribution.slots = new Array<Slot>();
		for (slotId in 0...nbSlots) {
			distribution.slots.push({
				id: slotId,
				distribId: distribution.id,
				selectedUserIds: new Array<Int>(),
				registeredUserIds: new Array<Int>(),
				start: DateTools.delta(distribution.distribStartDate, slotDuration * slotId),
				end: DateTools.delta(distribution.distribStartDate, slotDuration * (slotId + 1)),
			});
		}

		distribution.voluntaryUsers = new Map<Int, Array<Int>>();
		distribution.inNeedUserIds = new Map<Int, Array<String>>();
		
		distribution.update();
	}

	public function registerVoluntary(userId: Int, forUserIds: Array<Int>) {
		if (distribution.slots == null) return false;
		if (distribution.slotsMode == "solo-only") return false;
		if (!userIsAlreadyAdded(userId)) return false;
		if (distribution.voluntaryUsers == null) return false;

		distribution.lock();
		if (distribution.voluntaryUsers.exists(userId)) return false;
		distribution.voluntaryUsers.set(userId, forUserIds);
		distribution.update();

		return true;
	}

	public function updateVoluntary(userId: Int, forUserIds: Array<Int>) {
		if (distribution.slots == null) return false;
		if (distribution.slotsMode == "solo-only") return false;
		if (!distribution.voluntaryUsers.exists(userId)) return false;

		distribution.lock();
		var oldForUserIds =  distribution.voluntaryUsers.get(userId)
			.filter(ui -> forUserIds.indexOf(ui) == -1);
		distribution.voluntaryUsers.set(userId, oldForUserIds.concat(forUserIds));
		distribution.update();

		return true;
	}

	public function registerInNeedUser(userId: Int, allowed: Array<String>) {
		if (distribution.slots == null) return false;
		if (distribution.slotsMode == "solo-only") return false;
		if (distribution.inNeedUserIds == null) return false;
		if (userIsAlreadyAdded(userId)) return false;
		if (distribution.inNeedUserIds.exists(userId)) return false;

		distribution.lock();
		distribution.inNeedUserIds.set(userId, allowed);
		distribution.update();
		return true;
	}

	public function registerUserToSlot(userId: Int, slotIds: Array<Int>) {
		if (distribution.slots == null) return false;
		if (userIsAlreadyAdded(userId)) return false;

		distribution.lock();
		distribution.slots = distribution.slots.map(slot -> {
			if (slotIds.indexOf(slot.id) != -1) {
				slot.registeredUserIds.push(userId);
			}
			return slot;
		});
		distribution.update();
		return true;
	}

	public function updateUserToSlot(userId: Int, slotIds: Array<Int>) {
		if (distribution.slots == null) return false;
		if (!userIsAlreadyAdded(userId)) return false;

		distribution.lock();
		distribution.slots = distribution.slots.map(slot -> {
			slot.registeredUserIds = slot.registeredUserIds.filter(id -> id != userId);
			return slot;
		});
		distribution.slots = distribution.slots.map(slot -> {
			if (slotIds.indexOf(slot.id) != -1) {
				slot.registeredUserIds.push(userId);
			}
			return slot;
		});
		distribution.update();
		return true;
	}

	



}


typedef Slot = {
	id: Int,
  distribId: Int,
  selectedUserIds: Array<Int>,
	registeredUserIds: Array<Int>,
	start: Date,
  end: Date
}

// typedef SlotResolver = {
// 	id: Int,
// 	selectedUserIds: Array<Int>,
//   potentialUserIds: Array<Int>,
// }

class SlotResolver {
	public var id(default, null): Int;
	public var potentialUserIds(default, null): Array<Int>;
	public var selectedUserIds(default, null): Array<Int>;

	public function new (id: Int, potentialUserIds: Array<Int>, ?selectedUserIds: Array<Int>) {
		this.id = id;
		this.potentialUserIds = potentialUserIds;
		this.selectedUserIds = (selectedUserIds == null) ? new Array<Int>() : selectedUserIds;
	}

	public function selectUser(userId: Int) {
		var founded = false;
		this.potentialUserIds = this.potentialUserIds.filter(id -> {
			if (userId == id) {
				founded = true;
				return false;
			}
			return true;
		});
		if (founded == null) return;
		this.selectedUserIds.push(userId);
	}

	public function removePotentialUser(userId: Int) {
		this.potentialUserIds = this.potentialUserIds.filter(id -> id != userId);
	}

	public function isResolved() {
		return this.potentialUserIds.length == 0;
	}
}