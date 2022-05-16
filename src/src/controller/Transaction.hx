package controller;
import db.Operation.OperationType;
import Common;
import service.OrderService;
using Lambda;
#if plugins
import mangopay.Mangopay;
import mangopay.Types;
#end
import sugoi.form.elements.NativeDatePicker.NativeDatePickerType;

/**
 * Transction controller
 * @author fbarbut
 */
class Transaction extends controller.Controller
{

	/**
	 * A manager inserts manually a payment
	 */
	@tpl('form.mtt')
	public function doInsertPayment(user:db.User){
		
		if (!app.user.isContractManager()) throw Error("/", t._("Action forbidden"));	
		var t = sugoi.i18n.Locale.texts;
		
		var op = new db.Operation();
		op.user = user;
		op.date = Date.now();
		
		var f = new sugoi.form.Form("payement");
		f.addElement(new sugoi.form.elements.StringInput("name", t._("Label||label or name for a payment"), null, true));
		f.addElement(new sugoi.form.elements.FloatInput("amount", t._("Amount"), null, true));
		f.addElement(new form.CagetteDatePicker("date", t._("Date"), Date.now(), NativeDatePickerType.date, true));
		var paymentTypes = service.PaymentService.getPaymentTypes(PCManualEntry, app.user.getGroup());
		var out = [];
		for (paymentType in paymentTypes)
		{
			out.push({label: paymentType.name, value: paymentType.type});
		}
		f.addElement(new sugoi.form.elements.StringSelect("Mtype", t._("Payment type"), out, null, true));
		
		//related operation
		var unpaid = db.Operation.manager.search($user == user && $group == app.user.getGroup() && $type != Payment ,{limit:20,orderBy:-date});
		var data = unpaid.map(function(x) return {label:x.name, value:x.id}).array();
		f.addElement(new sugoi.form.elements.IntSelect("unpaid", t._("As a payment for :"), data, null, false));
		
		if (f.isValid()){
			f.toSpod(op);
			op.type = db.Operation.OperationType.Payment;
			var data : db.Operation.PaymentInfos = {type:f.getValueOf("Mtype")};
			op.data = data;
			op.group = app.user.getGroup();
			op.user = user;
			
			if (f.getValueOf("unpaid") != null){
				var t2 = db.Operation.manager.get(f.getValueOf("unpaid"));
				op.relation = t2;
				if (t2.amount + op.amount == 0) {
					op.pending = false;
					t2.lock();
					t2.pending = false;
					t2.update();
				}
			}
			
			op.insert();
			
			service.PaymentService.updateUserBalance(user, app.user.getGroup());
			
			throw Ok("/member/payments/" + user.id, t._("Payment recorded") );
			
		}
		
		view.title = t._("Record a payment for ::user::",{user:user.getCoupleName()}) ;
		view.form = f;		
	}
	
	
	@tpl('form.mtt')
	public function doEdit(op:db.Operation){
		
		if (!app.user.canAccessMembership() || op.group.id != app.user.getGroup().id ) {
			throw Error("/member/payments/" + op.user.id, t._("Action forbidden"));		
		}
		
		App.current.event(PreOperationEdit(op));
		
		op.lock();
		
		var f = new sugoi.form.Form("payement");
		f.addElement(new sugoi.form.elements.StringInput("name", t._("Label||label or name for a payment"), op.name, true));
		f.addElement(new sugoi.form.elements.FloatInput("amount", t._("Amount"), op.amount, true));
		f.addElement(new form.CagetteDatePicker("date", t._("Date"), op.date, NativeDatePickerType.date, true));
		//f.addElement(new sugoi.form.elements.DatePicker("pending", t._("Confirmed"), !op.pending, true));
		//related operation
		var unpaid = db.Operation.manager.search( $user == op.user && $group == op.group && $type != Payment ,{limit:20,orderBy:-date});
		var data = unpaid.map(function(x) return {label:x.name, value:x.id}).array();
		if (op.relation != null) data.push({label:op.relation.name,value:op.relation.id});
		f.addElement(new sugoi.form.elements.IntSelect("unpaid", t._("As a payment for :"), data, op.relation!=null ? op.relation.id : null, false));
		
		
		if (f.isValid()){
			f.toSpod(op);
			op.pending = false;
			
			if (f.getValueOf("unpaid") != null){
				var t2 = db.Operation.manager.get(f.getValueOf("unpaid"));
				op.relation = t2;
				if (t2.amount + op.amount == 0) {
					op.pending = false;
					t2.lock();
					t2.pending = false;
					t2.update();
				}
			}
			
			op.update();
			throw Ok("/member/payments/" + op.user.id, t._("Operation updated"));
		}
		
		view.form = f;
	}	
	
	/**
	 * Delete an operation
	 */
	public function doDelete(op:db.Operation){	
		if (!app.user.canAccessMembership() || op.group.id != app.user.getGroup().id ) throw Error("/member/payments/" + op.user.id, t._("Action forbidden"));	
		
		App.current.event(PreOperationDelete(op));

		//only an admin can delete an order op
		if((op.type == db.Operation.OperationType.VOrder || op.type == db.Operation.OperationType.COrder) && !app.user.isAdmin()){
			throw Error("/member/payments/" + op.user.id, t._("Action forbidden"));
		}

		if (checkToken()){
			op.delete();
			throw Ok("/member/payments/" + op.user.id, t._("Operation deleted"));
		}
	}
	
	
	/**
	 * Payment entry point
	 */
	@tpl("transaction/pay.mtt")
	public function doPay(tmpBasket:db.TmpBasket) {

		view.category = 'home';
		
		if (tmpBasket == null) throw Error("Basket is null");
		tmpBasket.lock();
		if (tmpBasket.data.products.length == 0) throw Error("/", t._("Your cart is empty"));

		//case where the user just logged in
		if(tmpBasket.user==null){
			tmpBasket.user = app.user;
			tmpBasket.update();
		}
		
		var total = tmpBasket.getTotal();
		view.amount = total;		
		view.tmpBasket = tmpBasket;
		view.paymentTypes = service.PaymentService.getPaymentTypes(PCPayment, app.user.getGroup());
		view.allowMoneyPotWithNegativeBalance = app.user.getGroup().allowMoneyPotWithNegativeBalance;	
		view.futurebalance = db.UserGroup.get(app.user, app.user.getGroup()).balance - total;
	}

	@tpl("transaction/tmpBasket.mtt")
	public function doTmpBasket(tmpBasket:db.TmpBasket,?args:{cancel:Bool,confirm:Bool}){

		if(args!=null){
			if(args.cancel){
				tmpBasket.lock();
				tmpBasket.delete();
				throw Ok("/",t._("You basket has been canceled"));
			}else if(args.confirm){				
				throw Redirect("/shop/validate/"+tmpBasket.id);				
			}
		}

		
		#if plugins
		//MANGOPAY : search for "unlinked" confirmed payIns on Mangopay
		if(mangopay.MangopayPlugin.checkTmpBasket(tmpBasket)!=null){
			throw Ok("/home","Votre paiement a été pris en compte et votre commande a bien été enregistrée.");
		}
		#end

		view.tmpBasket = tmpBasket;		
	}
	
	/**
	 * Use the money pot
	 */
	@tpl("transaction/moneypot.mtt")
	public function doMoneypot(tmpBasket:db.TmpBasket){

		if (tmpBasket == null) throw Redirect("/contract");
		if (tmpBasket.data.products.length == 0) throw Error("/", t._("Your cart is empty"));
		var total = tmpBasket.getTotal();
		var futureBalance = db.UserGroup.get(app.user, app.user.getGroup()).balance - total;
		if (!app.user.getGroup().allowMoneyPotWithNegativeBalance && futureBalance < 0) {
			throw Error("/transaction/pay", t._("You do not have sufficient funds to pay this order with your money pot."));
		}
		
		try{
			//record order
			var orders = OrderService.confirmTmpBasket(tmpBasket);
			if(orders.length==0) throw Error('/home',"Votre panier est vide.");
			var ops = db.Operation.onOrderConfirm(orders);
			
		}catch(e:tink.core.Error){
			throw Error("/transaction/pay/",e.message);
		}

		view.amount = total;
		view.balance = db.UserGroup.get(app.user, app.user.getGroup()).balance;
	
	}

	/**
	 * Use on the spot payment
	 */
	@tpl("transaction/onthespot.mtt")
	public function doOnthespot(tmpBasket:db.TmpBasket)
	{
		if (tmpBasket == null) throw Redirect("/contract");
		if (tmpBasket.data.products.length == 0) throw Error("/", t._("Your cart is empty"));
		
		try{
			//record order
			var orders = OrderService.confirmTmpBasket(tmpBasket);
			if(orders.length==0) throw Error('/home',"Votre panier est vide.");
			var orderOps = db.Operation.onOrderConfirm(orders);
			var total = tmpBasket.getTotal();

			view.amount = total;
			//var futureBalance = db.UserGroup.get(app.user, app.user.getGroup()).balance - total;
			view.balance = db.UserGroup.get(app.user, app.user.getGroup()).balance;

			var date = tmpBasket.multiDistrib.getDate();		
			
			//all orders are for the same multidistrib
			var name = t._("Payment on the spot for the order of ::date::", {date:view.hDate(date)});
			db.Operation.makePaymentOperation(app.user,app.user.getGroup(), payment.OnTheSpotPayment.TYPE, total, name, orderOps[0] );	
			
		}catch(e:tink.core.Error){
			throw Error("/transaction/pay/",e.message);
		}
		
	
	}

	/**
	 * Pay by transfer
	 */
	@tpl("transaction/transfer.mtt")
	public function doTransfer(tmpBasket:db.TmpBasket){
		
		if (tmpBasket == null) throw Redirect("/contract");
		if (tmpBasket.data.products.length == 0) throw Error("/", t._("Your cart is empty"));
		
		var md = tmpBasket.multiDistrib;
		var date = md.getDate();	
		var total = tmpBasket.getTotal();
		var code = payment.Check.getCode(date, md.getPlace(), app.user);
		
		view.code = code;
		view.amount = total;
		
		try{			
			//record order
			var orders = OrderService.confirmTmpBasket(tmpBasket);
			if(orders.length==0) throw Error('/home',"Votre panier est vide.");
			var orderOps = db.Operation.onOrderConfirm(orders);
			
			var name = t._("Transfer for the order of ::date::", {date:view.hDate(date)}) + " ("+code+")";
			db.Operation.makePaymentOperation(app.user,app.user.getGroup(),payment.Transfer.TYPE, total, name, orderOps[0] );

			
		}catch(e:tink.core.Error){
			throw Error("/transaction/pay/",e.message);
		}

	}

}