import bootstrap.Modal;
import js.Browser;
import Common;
import thx.semver.Version;

//React lib
import react.ReactMacro.jsx;
import react.ReactDOM;
import react.*;

//mui
import react.mui.CagetteTheme;
import mui.core.CssBaseline;
import mui.core.styles.MuiThemeProvider;

//redux
import redux.Redux;
import redux.Store;
import redux.StoreBuilder.*;
import redux.thunk.Thunk;
import redux.thunk.ThunkMiddleware;
import redux.react.Provider as ReduxProvider;

//custom components
import react.file.ImageUploaderDialog;
import react.order.OrdersDialog;
import react.product.*;
import react.store.CagetteStore;
import react.map.*;
import react.user.*;
import react.vendor.*;
import react.CagetteDatePicker;
import react.ReactComponent;

@:jsRequire('cagette-neo', 'NeolithicViewsGenerator')
extern class NeolithicViewsGenerator {
    static public function setApiUrl(
        url: String
    ): Void;
    static public function setGraphUrl(
        url: String
    ): Void;
    static public function placeDialog(elementId: String, props: Dynamic): Void;
}

class App {

    public static var instance : App;    
    public static var VERSION = ([0,14]  : Version).withPre(GitMacros.getGitShortSHA(), GitMacros.getGitCommitDate());
    	
	public var currency : String; //currency symbol like &euro; or $
	public var t : sugoi.i18n.GetText;//gettext translator
	public var Modal = bootstrap.Modal;
    public var Collapse = bootstrap.Collapse;
    public var lang : String;
    public var userId : Int;
    public var userName : String;
    public var userEmail : String;
    


	function new(?lang="fr",?currency="&euro;") {
		//singleton
		instance = this;
		if(lang!=null) this.lang = lang;
		this.currency = currency;
	}

	/**
	**/
	/*public static inline function jq(r:Dynamic):js.jquery.JQuery{
		trace("CALL JQUERY");
		return new js.jquery.JQuery(r);
	}*/

	/**
	 * The JS App will be available as "_" in the document.
	 */
	public static function main() {
        
        untyped js.Browser.window._ = new App();
        
        NeolithicViewsGenerator.setApiUrl("/api");
        // NeolithicViewsGenerator.setGraphUrl(sugoi.db.Variable.get("cagette_api") + "/graphql");
        // NeolithicViewsGenerator.setGraphUrl(App.config.get("cagette_api") + "/graphql");
		untyped js.Browser.window._NeolithicViewsGenerator = NeolithicViewsGenerator;
    }
    

    var sentryInited:Bool;

    public function initSentry(){

        if(sentryInited) return;

        sentry.Sentry.init({
            dsn: "https://505d95e8dea34941be60ceb06195de50@o394906.ingest.sentry.io/5245923",
            release: App.VERSION.toString()
        });

        if(this.userEmail!=null){
            untyped sentry.Sentry.configureScope(function(scope) {
                scope.setUser({
                    "email": this.userEmail,
                    "userName" : this.userName,
                    "id" : this.userId,
                });
            });
        }

        sentryInited = true;
    }

	/**
		Old Shop
	**/
	public function getCart() {
        initSentry();
		return new ShopCart();
	}

	public function getTagger(cid:Int ) {
        initSentry();
		return new Tagger(cid);
	}

	public function getTuto(name:String, step:Int) {
        initSentry();
		new Tuto(name,step);
	}
	
	/**
	 * remove method for IE compat
	 */
	public function remove(el:js.html.Element){
		if (el == null) return;
		el.parentElement.removeChild(el);
	}
	
	public function getVATBox(ttcprice:Float,currency:String,rates:String,vat:Float,formName:String){
		initSentry();
		var input = js.Browser.document.querySelector('form input[name="${formName}_price"]');
		
		remove( js.Browser.document.querySelector('form input[name="${formName}_vat"]').parentElement.parentElement );
		
		ReactDOM.render(jsx('<$VATBox ttc=${ttcprice} currency=${currency} vatRates=${rates} vat=${vat} formName=${formName} />'),  input.parentElement);
	}

	/**
	 * Removes the form element and replace it by a react js component
	 * @param	divId
	 * @param	productName
	 * @param	txpProductId
	 * @param	formName
	 */
	public function getProductInput(divId:String, productName:String, txpProductId:Null<Int>, formName:String ){
        initSentry();
		js.Browser.document.addEventListener("DOMContentLoaded", function(event) {

			//dirty stuff to remove "real" input, and replace it by the react one
			remove(Browser.document.querySelector("form input[name='"+formName+"_name']").parentElement.parentElement);
			remove(Browser.document.querySelector("form select[name='" + formName+"_txpProductId']").parentElement.parentElement);

			ReactDOM.render(jsx('<$ProductInput productName=${productName} txpProductId=${txpProductId} formName=${formName}/>'),  js.Browser.document.getElementById(divId));
		});
	}

	/**
	 * TO DO
	 * @param	divId
	 * @param	vendorId
	 */
	public function getVendorPage(divId:String, vendorId:Int, catalogId:Int ) {
        
		js.Browser.document.addEventListener("DOMContentLoaded", function(event) {

            initSentry();

			//Load data from API
			var vendorInfo:VendorInfos = null;
			var catalogProducts:Array<ProductInfo> = null;
			var nextDistributions:Array<DistributionInfos> = null;

			var promises = [];
			promises.push( utils.HttpUtil.fetch("/api/pro/vendor/"+vendorId, GET, null, JSON) );
			promises.push(  utils.HttpUtil.fetch("/api/pro/vendor/nextDistributions/"+vendorId, GET, null, JSON) );
			if(catalogId!=null) promises.push( utils.HttpUtil.fetch("/api/pro/catalog/"+catalogId, GET, null, JSON) );			
			
			var initRequest = js.Promise.all(promises).then(
				function(data:Dynamic) {
					vendorInfo = data[0];
					nextDistributions = data[1];
					catalogProducts = data[2]==null ? [] : data[2].products;
					
					ReactDOM.render(jsx('
						<MuiThemeProvider theme=${CagetteTheme.get()}>
							<>
								<CssBaseline />
								<$VendorPage vendorInfo=${vendorInfo} catalogProducts=${catalogProducts} nextDistributions=${nextDistributions} />
							</>
						</MuiThemeProvider>'),  js.Browser.document.getElementById(divId));
			}
			).catchError (
				function(error) {
					throw error;
				}
			);

		});
	}

	public function openImageUploader( uploadURL : String, uploadedImageURL : String, width:Int, height:Int, ?formFieldName: String ) {
        initSentry();
		var node = js.Browser.document.createDivElement();
		js.Browser.document.body.appendChild(node);
		ReactDOM.unmountComponentAtNode(node); 
		ReactDOM.render(jsx('
			<div>
				<ImageUploaderDialog uploadURL=$uploadURL uploadedImageURL=$uploadedImageURL width=$width height=$height formFieldName=$formFieldName />
			</div>'), node);
	}
	
	public function initReportHeader(){
        initSentry();
		ReactDOM.render(jsx('<$ReportHeader />'),  js.Browser.document.querySelector('div.reportHeaderContainer'));
	}
	
	public function initOrderBox(userId : Int, multiDistribId : Int, catalogId : Int, catalogType : Int, date : String, place : String, userName : String, currency : String, hasPayments : Bool, callbackUrl : String) {
        initSentry();

		var node = js.Browser.document.createDivElement();
		node.id = "ordersdialog-container";
		js.Browser.document.body.appendChild(node);
		ReactDOM.unmountComponentAtNode(node); //the previous modal DOM element is still there, so we need to destroy it
	
		var store = createOrderBoxReduxStore();
		ReactDOM.render(jsx('
			<ReduxProvider store=${store}>
				<MuiThemeProvider theme=${CagetteTheme.get()}>
					<>
						<CssBaseline />
						<OrdersDialog userId=$userId multiDistribId=$multiDistribId catalogId=$catalogId catalogType=$catalogType
						date=$date place=$place userName=$userName callbackUrl=$callbackUrl currency=$currency hasPayments=$hasPayments />							
					</>
				</MuiThemeProvider>
			</ReduxProvider>
		'), node );

	}

	private function createOrderBoxReduxStore() {
        
		// Store creation
		var rootReducer = Redux.combineReducers({ reduxApp : mapReducer(react.order.redux.actions.OrderBoxAction, new react.order.redux.reducers.OrderBoxReducer()) });
		// create middleware normally, excepted you must use
		// 'StoreBuilder.mapMiddleware' to wrap the Enum-based middleware
		var middleWare = Redux.applyMiddleware(mapMiddleware(Thunk, new ThunkMiddleware()));
		return createStore( rootReducer, null, middleWare );
	}

	

	public static function roundTo(n:Float, r:Int):Float {
		return Math.round(n * Math.pow(10,r)) / Math.pow(10,r) ;
	}


	/**
	 * Ajax loads a page and display it in a modal window
	 * @param	url
	 * @param	title
	 */
	public function overlay(url:String,?title,?large=true) {
		if(title != null) title = StringTools.urlDecode(title);
		var r = new haxe.Http(url);
		r.onData = function(data) {
			//setup body and title

			var modalElement = Browser.document.getElementById("myModal");
			var modal = new Modal(modalElement);
			modalElement.querySelector(".modal-body").innerHTML = data;
			if (title != null) modalElement.querySelector(".modal-title").innerHTML = title;
			if (!large) modalElement.querySelector(".modal-dialog").classList.remove("modal-lg");
			modal.show();
		}
		r.request();
	}

	/**
	 * Displays a login box
	 */
	public function loginBox(redirectUrl:String,?message:String,?phoneRequired=false,?addressRequired=false) {	
        initSentry();

		var modalElement = Browser.document.getElementById("myModal");
		modalElement.querySelector(".modal-title").innerHTML = "S'identifier";
		modalElement.querySelector(".modal-dialog").classList.remove("modal-lg");
		var modal = new bootstrap.Modal(modalElement);
		modal.show();

		ReactDOM.render(
			jsx('<$LoginBox redirectUrl=$redirectUrl message=$message phoneRequired=$phoneRequired addressRequired=$addressRequired/>'),
			js.Browser.document.querySelector('#myModal .modal-body')
		);
		return false;
	}

	/**
	 *  Displays a sign up box
	 */
	public function registerBox(redirectUrl:String,?message:String,?phoneRequired=false,?addressRequired=false) {
        initSentry();

		var modalElement = Browser.document.getElementById("myModal");
		modalElement.querySelector(".modal-title").innerHTML = "S'inscrire";
		modalElement.querySelector(".modal-dialog").classList.remove("modal-lg");
		var modal = new bootstrap.Modal(modalElement);
		modal.show();
		ReactDOM.render(
			jsx('<$RegisterBox redirectUrl=$redirectUrl message=$message phoneRequired=$phoneRequired addressRequired=$addressRequired/>'),
			js.Browser.document.querySelector('#myModal .modal-body')
		);
		return false;
	}

	public function membershipBox(userId:Int,groupId:Int,?callbackUrl:String,?distributionId:Int){
        initSentry();

		var node = js.Browser.document.createDivElement();
		node.id = "membershipBox-container";
		js.Browser.document.body.appendChild(node);
		ReactDOM.unmountComponentAtNode(node); //the previous modal DOM element is still there, so we need to destroy it
	
		ReactDOM.render(jsx('
			<MuiThemeProvider theme=${CagetteTheme.get()}>
				<>
					<CssBaseline />
					<MembershipDialog userId=$userId groupId=$groupId callbackUrl=$callbackUrl distributionId=$distributionId />							
				</>
			</MuiThemeProvider>
		'), node );

	}

	private function createReactStore() {
		// Store creation
		var rootReducer = Redux.combineReducers({
			cart: mapReducer(react.store.redux.action.CartAction, new react.store.redux.state.CartState.CartRdcr()),
		});
		// create middleware normally, excepted you must use
		// 'StoreBuilder.mapMiddleware' to wrap the Enum-based middleware
		var middleWare = Redux.applyMiddleware( mapMiddleware( Thunk, new ThunkMiddleware() ) );
		return createStore(rootReducer, null, middleWare);
	}

	public function browser(){
		return bowser.Bowser.getParser(js.Browser.window.navigator.userAgent);
	}

	/**
		instanciates shop2
	**/
	public function shop(multiDistribId:Int) {
        initSentry();

		var elements = js.Browser.window.document.querySelectorAll('.sticky');
		sticky.Stickyfill.add(elements);

		// Will be merged with default values from mui
		

		var store = createReactStore();
		ReactDOM.render(jsx('
			<ReduxProvider store=${store}>
				<MuiThemeProvider theme=${CagetteTheme.get()}>
					<>
						<CssBaseline />
						<CagetteStore multiDistribId=$multiDistribId />
					</>
				</MuiThemeProvider>
			</ReduxProvider>
		'), js.Browser.document.querySelector('#shop'));
	}

	/**
		init react page header
	**/
	public function pageHeader(groupName:String,_rights:String,userName:String,userId:Int)
	{
		groupName = StringTools.urlDecode(groupName);
		/*var rights : Rights = null;
		if(_rights!=null) rights = haxe.Unserializer.run(_rights);*/
		//ReactDOM.render(jsx('<$PageHeader userRights=$rights groupName=$groupName userName=$userName userId=$userId />'), js.Browser.document.querySelector('#header'));
		ReactDOM.render(jsx('<$PageHeader groupName=$groupName userName=$userName userId=$userId />'), js.Browser.document.querySelector('#header'));
	}

	
	public function groupMap(lat:Float,lng:Float,address:String) {
        initSentry();

		ReactDOM.render(jsx('<$GroupMapRoot lat=$lat lng=$lng address=$address />'),  js.Browser.document.querySelector('#map'));
	}

	/**
	 * Helper to get values of a bunch of checked checkboxes
	 * @param	formSelector
	 */
	public function getCheckboxesId(formSelector:String):Array<String>{
		var out = [];
		var checkboxes = js.Browser.document.querySelectorAll(formSelector + " input[type=checkbox]");
		for ( input in checkboxes ){
			var input : js.html.InputElement = cast input;
			if ( input.checked ) out.push(input.value);
		}
		return out;
	}


	#if plugins
	/*public function getHostedPlugin(){
		return new hosted.js.App();
	}*/
	#end

	/**
	 * set up a warning message when leaving the page
	 */
	public function setWarningOnUnload(active:Bool, ?msg:String){
		if (active){
			js.Browser.window.addEventListener("beforeunload", warn);
		}else{
			js.Browser.window.removeEventListener("beforeunload", warn);
		}

	}

	function warn(e:js.html.Event) {
		var msg = "Voulez vous vraiment quitter cette page ?";
		//js.Browser.window.confirm(msg);
		untyped e.returnValue = msg; //Gecko + IE
		e.preventDefault();
		return msg; //Gecko + Webkit, Safari, Chrome etc.
	}

	/**
	 * Anti Doubleclick with btn elements.
	 * Can be bypassed by adding a .btn-noAntiDoubleClick class
	 */
	public function antiDoubleClick(){

		for( n in js.Browser.document.querySelectorAll(".btn:not(.btn-noAntiDoubleClick)") ){
			n.addEventListener("click",function(e:js.html.MouseEvent){
				var x = untyped e.target;
				x.classList.add("disabled");
				haxe.Timer.delay(function(){
					x.classList.remove("disabled");
				},3000);
			});
		}
		
	}

	/**
		Anti doubleclick link function
	**/
	public static var linkClicked = false;
	public function goto(url:String){
		
		if(!linkClicked) {
			js.Browser.document.location.href=url;
			linkClicked = true;
		}else{
			js.Browser.console.log("double click detected");
		}
	}

	/**
		Display a notif about new features 3 times
	**/
	// public function newFeature(selector:String,title:String,message:String,placement:String){
	// 	var element = js.Browser.document.querySelector(selector);
	// 	if(element==null) return;

	// 	//do not show after 3 times
	// 	var storage = js.Browser.getLocalStorage();
	// 	if (storage.getItem("newFeature."+selector) == "3") return;

	// 	//prepare Bootstrap "popover"
	// 	var x = jq(element).first().attr("title",title);
	// 	var text = "<p>" + message + "</p>";
		
	// 	var options = { container:"body", content:text, html:true , placement:placement};
	// 	untyped  x.popover(options).popover('show');
	// 	//click anywhere to hide
	// 	App.jq("html").click(function(_) {
	// 		untyped x.popover('hide');				
	// 	});
		

	// 	var storage = js.Browser.getLocalStorage();
	// 	var i = storage.getItem("newFeature."+selector);
	// 	if(i==null) i = "0";
	// 	storage.setItem("newFeature."+selector, Std.string( Std.parseInt(i)+1 ) );
		
	// 	//highlight
	// 	App.jq(element).first().addClass("highlight");	
	// }

	public function toggle(selector:String){
		for ( el in js.Browser.document.querySelectorAll(selector)){
			untyped el.classList.toggle("hidden");
		}
	}

	public function show(selector:String){
		for ( el in js.Browser.document.querySelectorAll(selector)){
			untyped el.classList.remove("hidden");
		}
	}

	public function hide(selector:String){
		for ( el in js.Browser.document.querySelectorAll(selector)){
			untyped el.classList.add("hidden");
		}
	}

	public function generateDatePicker(
		selector: String,
		name: String,
		?date: String,
		?type: String = "date",
        ?required: Bool = false,
        ?openTo: String = "date"
	) {
		ReactDOM.render(
			jsx('
				<MuiThemeProvider theme=${CagetteTheme.get()}>
					<>
						<CssBaseline />
						<CagetteDatePicker name=$name value=$date type=$type required=$required openTo=$openTo />
					</>
				</MuiThemeProvider>
			'),
			js.Browser.document.querySelector(selector)
		);
    }

    public function openPlaceDialog(
        selector: String,
        placeId: Int
    ) {
        NeolithicViewsGenerator.placeDialog(selector, {
           placeId: placeId
        });
    }
}


