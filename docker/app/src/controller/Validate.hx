package controller;
import db.Operation.OperationType;
using Lambda;
import Common;
import sugoi.form.elements.NativeDatePicker.NativeDatePickerType;

/**
 * Distribution validation
 * @author fbarbut
 */
class Validate extends controller.Controller
{
	public var multiDistrib : db.MultiDistrib;
	public var user : db.User;
	
	/**
		Validate a distrib
	**/
	@tpl('validate/user.mtt')
	public function doDefault(){
		view.member = user;
		var place = multiDistrib.getPlace();
		var date = multiDistrib.getDate();
		
		if (!app.user.getGroup().hasShopMode()){
			//get last operations and check balance
			view.operations = db.Operation.getLastOperations(user,place.group,10);
			
		}
		var ug = db.UserGroup.get(user, place.group);
		view.balance = ug==null ? null : ug.balance;
		var b = db.Basket.get(user, multiDistrib);			
		view.orders = service.OrderService.prepare(b.getOrders());
		view.place = place;
		view.date = date;
		view.basket = b;
		view.onTheSpotAllowedPaymentTypes = service.PaymentService.getOnTheSpotAllowedPaymentTypes(app.user.getGroup());
		view.md = multiDistrib;
		view.distribution = multiDistrib;
		view.userGroup = ug;
		view.abs = Math.abs;
		
		checkToken();
	}
	
	/**
		Delete a payment operation
	**/
	public function doDeleteOp(op:db.Operation){
		if (checkToken()){
			
			op.lock();
			op.delete();
			
			service.PaymentService.updateUserBalance(user, app.user.getGroup());
			
			throw Ok("/validate/" + multiDistrib.id + "/" + user.id, t._("Operation deleted"));
		}
	}
	
	public function doValidateOp(operation: db.Operation) 
	{
		if (checkToken()) 
		{
			operation.lock();
			operation.pending = false;
			if (app.params.exists("type"))
			{
				operation.data.type = app.params.get("type"); 				
			}			
			operation.update();
			
			service.PaymentService.updateUserBalance(user, app.user.getGroup());
			
			throw Ok("/validate/"+multiDistrib.id+"/"+user.id, t._("Operation validated"));
		}
	}
	
	@tpl('form.mtt')
	public function doAddRefund() {

		var basketId = Std.parseInt(app.params.get("basketid"));
		var basket = null;
		if(basketId != null) {
			basket = db.Basket.manager.get(basketId, false);			
		}

		if(basket.isValidated()){
			throw Error("/validate/" + multiDistrib.id + "/" + user.id, "Cette commande a déjà été validée, vous ne pouvez plus effectuer de remboursement.");
		}

		//Refund amount
		var refundAmount = basket.getTotalPaid() - basket.getOrdersTotal();		
		if(refundAmount <= 0) {
			//There is nothing to refund
			throw Error("/validate/" + multiDistrib.id + "/" + user.id, t._("There is nothing to refund"));
		}
		
		if (!app.user.isContractManager()) throw t._("Forbidden access");
		
		var operation = new db.Operation();
		operation.user = user;
		operation.date = Date.now();
		
		var b = db.Basket.get(user, multiDistrib );
		var orderOperation = b.getOrderOperation(false);
		if(orderOperation == null) throw "unable to find related order operation";
		
		var f = new sugoi.form.Form(t._("payment"), "/validate/" + multiDistrib.id + "/" + user.id + "/addRefund?basketid=" + basketId);
		f.addElement(new sugoi.form.elements.StringInput("name", t._("Label"), t._("Refund"), true));		
		f.addElement(new sugoi.form.elements.FloatInput("amount", t._("Amount"), refundAmount, true));
		f.addElement(new form.CagetteDatePicker("date", "Date", Date.now(), NativeDatePickerType.date, true));
		var paymentTypes = service.PaymentService.getPaymentTypes(PCManualEntry, app.user.getGroup());
		var out = [];
		for (paymentType in paymentTypes){
			out.push({label: paymentType.name, value: paymentType.type});
		}
		f.addElement(new sugoi.form.elements.StringSelect("Mtype", t._("Payment type"), out, null, true));

		//broadcast event
		var event = PreRefund(f,b,refundAmount);
		App.current.event(event);
		f = event.getParameters()[0];
		
		if (f.isValid()) {
			
			f.toSpod(operation);
			operation.type = db.Operation.OperationType.Payment;
			var data : db.Operation.PaymentInfos = {type:f.getValueOf("Mtype")};
			operation.data = data;
			operation.group = app.user.getGroup();
			operation.user = user;
			operation.relation = orderOperation;
			operation.amount = 0 - Math.abs(operation.amount);
			operation.insert();
			
			App.current.event(NewOperation(operation));
			App.current.event(Refund(operation,basket));
			service.PaymentService.updateUserBalance(user, app.user.getGroup());
						
			throw Ok("/validate/"+multiDistrib.id+"/"+user.id, t._("Refund saved"));
		}
		
		view.title = t._("Key-in a refund for ::user::",{user:user.getCoupleName()});
		view.form = f;		
	}
	
	@tpl('form.mtt')
	public function doAddPayment(){
			
		if (!app.user.isContractManager()) throw Error("/",t._("Forbidden access"));
		
		var o = new db.Operation();
		o.user = user;
		o.date = Date.now();
		
		var f = new sugoi.form.Form("payment");
		f.addElement(new sugoi.form.elements.StringInput("name", t._("Label"), t._("Additional payment"), true));
		f.addElement(new sugoi.form.elements.FloatInput("amount", t._("Amount"), null, true));
		f.addElement(new form.CagetteDatePicker("date", t._("Date"), Date.now(), NativeDatePickerType.date, true));
		var paymentTypes = service.PaymentService.getPaymentTypes(PCManualEntry, app.user.getGroup());
		var out = [];
		for (paymentType in paymentTypes){
			out.push({label: paymentType.name, value: paymentType.type});
		}
		f.addElement(new sugoi.form.elements.StringSelect("Mtype", t._("Payment type"), out, null, true));
		
		var b = db.Basket.get(user, multiDistrib );
		
		if(b.isValidated()){
			throw Error("/validate/" + multiDistrib.id + "/" + user.id, "Cette commande a déjà été validée, vous ne pouvez plus effectuer de remboursement.");
		}

		var op = b.getOrderOperation(false);
		if(op==null) throw "unable to find related order operation";
		
		if (f.isValid()){
			f.toSpod(o);
			o.type = db.Operation.OperationType.Payment;
			var data : db.Operation.PaymentInfos = {type:f.getValueOf("Mtype")};
			o.data = data;
			o.group = app.user.getGroup();
			o.user = user;
			o.relation = op;			
			o.insert();
			
			service.PaymentService.updateUserBalance(user, app.user.getGroup());
			
			throw Ok("/validate/"+multiDistrib.id+"/"+user.id, t._("Payment saved"));
		}
		
		view.title = t._("Key-in a payment for ::user::",{user:user.getCoupleName()});
		view.form = f;	
	}
	
	/**
	Validate a user's basket
	**/
	public function doValidate(){
		
		if (checkToken()) {
			var basket = db.Basket.get(user, multiDistrib );
			try{
				service.PaymentService.validateBasket(basket);
			} catch(e:tink.core.Error) {
				throw Error("/validate/" + multiDistrib.id+"/"+user.id, e.message);
			}
			throw Ok("/distribution/validate/" + multiDistrib.id , t._("Order validated"));			
		}
	}

	
	
}