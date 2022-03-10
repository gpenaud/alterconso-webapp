package controller.api;
import service.MembershipService;
import haxe.Json;
import tink.core.Error;
import service.PaymentService;
import Common;
import jwt.JWT;

/**
 * Public user API
 */
class User extends Controller
{

	public function doDefault(user:db.User){
		//get a user
	}

	public function doMe() {
		if (App.current.user == null) throw new Error(Unauthorized, "Access forbidden");
		var current = App.current.user;

		if (sugoi.Web.getMethod() == "GET") {
			return Sys.print(haxe.Json.stringify(current.infos()));
		} else if (sugoi.Web.getMethod() == "POST") {
			var request = sugoi.tools.Utils.getMultipart( 1024 * 1024 * 10 ); //10Mb	

			current.lock();
			
			if (request.exists("address1")) current.address1 = request.get("address1");
			if (request.exists("address2")) current.address2 = request.get("address2");
			if (request.exists("city")) current.city = request.get("city");
			if (request.exists("zipCode")) current.zipCode = request.get("zipCode");
			if (request.exists("phone")) current.phone = request.get("phone");

			current.update();

			return Sys.print(haxe.Json.stringify(current.infos()));
		} else throw new Error(405, "Method Not Allowed");
	}

	/**
		get membership status of a user in a group
	**/
	public function doMembership(user:db.User,group:db.Group){

		if(!app.user.canAccessMembership()){
			throw new Error(Unauthorized,"Access forbidden");
		}

		var ug = db.UserGroup.get(user,group);
		var ms = new MembershipService(group);

		if(ug==null){
			throw new Error(NotFound,"Not found");
		}else{

			var post = sugoi.Web.getMultipart(1024*1024);
			if(post.count()>0){

				//Add a membership
				var params = post;
				if(params["year"]==null) throw new Error("Missing 'year' param");
				if(params["date"]==null) throw new Error("Missing 'date' param");
				if(group.membershipFee==null && params["membershipFee"]==null) throw new Error("Missing 'membershipFee' param");
				if(group.hasPayments() && params["paymentType"]==null) throw new Error("Missing 'paymentType' param");

				var year = params["year"].parseInt();
				var date = Date.fromString(params["date"]);
				var membershipFee = params["membershipFee"].parseFloat();
				var paymentType = params["paymentType"];
				var distribution = db.MultiDistrib.manager.get(params["distributionId"].parseInt(),false);

				ms.createMembership(user,year,date,membershipFee,paymentType,distribution);

			}

			var out = {
				userName:null,
				availableYears: new Array<{name:String,id:Int}>(),
				memberships: new Array<{name:String,id:Int,date:Date,amount:Float}>(),
				membershipFee:null,
				distributions: new Array<{name:String,id:Int}>(),
				paymentTypes: new Array<{id:String,name:String}>(),
			};

			out.userName = user.getName();
			out.membershipFee = group.membershipFee;
			if(group.hasPayments()){
				out.paymentTypes = PaymentService.getPaymentTypes(PaymentContext.PCManualEntry, group).map(p -> return {id:p.type,name:p.name});
			}
			out.memberships = ms.getUserMemberships(user).map(m->{
				return {
					id : m.year ,
					name : ms.getPeriodName(m.year),
					date : m.date,
					amount : m.operation!=null ? Math.abs(m.operation.amount) : m.amount,
				};
			});

			var from = tools.DateTool.deltaDays(Date.now(),-30);
			var to = tools.DateTool.deltaDays(Date.now(),5);
			out.distributions = db.MultiDistrib.getFromTimeRange(group,from,to).map(d->return {
				id:d.id,
				name:"Distribution du "+Formatting.hDate(d.distribStartDate)
			});

			out.availableYears = [];
			var now = Date.now();
			for ( x in -4...2) {
				var yy = DateTools.delta(now, DateTools.days(365) * x);
				out.availableYears.push({name : group.getPeriodName(yy) , id : group.getMembershipYear(yy)});
			}

			out.availableYears.reverse();
			json(out);
		}
	}


	public function doDeleteMembership(user:db.User,group:db.Group,year:Int){

		if(!app.user.canAccessMembership()){
			throw new Error(Unauthorized,"Not found");
		}

		var ug = db.UserGroup.get(user,group);
		if(ug==null){
			throw new Error(NotFound,"Not found");
		}else{
			var ms = new MembershipService(group);
			var membership = ms.getUserMembership(user,year);
			if(membership!=null){
				ms.deleteMembership(membership);
			}
			var memberships = ms.getUserMemberships(user).map(m->{
				return {
					id : m.year ,
					name : ms.getPeriodName(m.year),
					date : m.date
				};
			});
			json({memberships:memberships});
		}
	}
	

	
	/**
	 * Login
	 */
	public function doLogin(){
		
		//cleaning
		var email = StringTools.trim(App.current.params.get("email")).toLowerCase();
		var pass = StringTools.trim(App.current.params.get("password"));
		var user = service.UserService.login(email, pass);
		var token : String = JWT.sign({ email: email, id: user.id }, App.config.get("key"));
		Sys.print(
			Json.stringify({ 
				success: true,
				token:token 
			})
		);
	}
	
	/**
	 * Register
	 */
	public function doRegister(){

		//cleaning
		var p = app.params;
		var email = StringTools.trim(p.get("email")).toLowerCase();
		var pass = StringTools.trim(p.get("password"));
		var firstName = StringTools.trim(p.get("firstName"));
		var lastName = StringTools.trim(p.get("lastName")).toUpperCase();
		var phone = p.exists("phone") ? StringTools.trim(p.get("phone")) : null;
		var address = p.exists("address1") ? StringTools.trim(p.get("address1")) : null;
		var zipCode = p.exists("zipCode") ? StringTools.trim(p.get("zipCode")) : null;
		var city = p.exists("city") ? StringTools.trim(p.get("city")) : null;
		
		service.UserService.register(firstName, lastName, email, phone, pass, address, zipCode, city);
		
		json({success:true});
	}


	/**
	 *  get users of current group
	 */
	@logged
	function doGetFromGroup(){

		if(!app.user.canAccessMembership() && !app.user.isContractManager()) {
			throw new tink.core.Error(403,"Access forbidden");
		}

		var members:Array<UserInfo> = service.UserService.getFromGroup(app.user.getGroup()).map( m -> m.infos() );
		Sys.print(tink.Json.stringify({users:members}));
	}
	
}