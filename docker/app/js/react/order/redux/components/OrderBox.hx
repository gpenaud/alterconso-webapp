package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common.UserOrder;
import react.router.HashRouter;
import react.router.Route;
import react.router.Switch;
import react.order.redux.actions.OrderBoxAction;
import react.order.redux.actions.thunk.OrderBoxThunk;
import react.user.redux.components.UserSelector;

//Material UI
import react.mui.CagetteTheme;
import mui.core.Button;


typedef OrderBoxProps = {

	var userId : Int;
	var selectedUserId : Int;
	var selectedUserName : String;
	var multiDistribId : Int;
	var catalogId : Int;
	var catalogType : Int;
	var date : String;
	var place : String;
	var userName : String;
	var callbackUrl : String;
	var currency : String;
	var hasPayments : Bool;
	var orders : Array<UserOrder>;
	var fetchOrders : Int -> Int -> Int -> Int -> Void;
	var ordersWereFetched : Bool;
	var updateOrders : Int -> String -> Int -> Int -> Void;
	var error : String;	
};

typedef OrderBoxState = {
    var processing: Bool;
};

/**
 * A box to edit/add orders of a member
 * @author fbarbut
 */
@:connect
class OrderBox extends react.ReactComponentOfPropsAndState<OrderBoxProps, OrderBoxState> {

	public function new(props: OrderBoxProps) {
        super(props);
        state = { processing: false };
	}	
	
	override function componentDidMount() {
		var userId = this.getCurrentUserId();
		if( userId != null ) {
			props.fetchOrders( userId, props.multiDistribId, props.catalogId, props.catalogType );		
		}
	}
	
	override public function render() {

		js.html.Console.log( "OrderBox render");

		var userId = this.getCurrentUserId();
		var userName = props.userName != null ? props.userName : props.selectedUserName;

		//If there is no orders the user is redirected to the next screen
		if ( props.ordersWereFetched && ( props.orders == null || props.orders.length == 0 ) ) {
			js.Browser.location.hash = props.catalogId == null ? "/catalogs" : "/insert";
		}
		
		//Let's group orders by catalog id to display them for each catalog
		var ordersByCatalogId = new Map<Int, Array<UserOrder>>();
		for( order in props.orders ) {
			if( ordersByCatalogId[order.catalogId] == null ) {
				ordersByCatalogId[order.catalogId] = [];
			}			
			ordersByCatalogId[order.catalogId].push(order);			
		}

		var ordersByCatalog = [];
		var totalPrice = 0.0;
		
		for( catalogId in ordersByCatalogId.keys() ) {
		
			ordersByCatalog.push( jsx('<h4 key=$catalogId>${ordersByCatalogId[catalogId][0].catalogName}</h4>') );			

			for ( order in ordersByCatalogId[catalogId] ) {

				var key : String = if( order.id != null ) {
					Std.string(order.id);
				}else {
					order.product.id + "-" + Std.random(99999);
				};

				ordersByCatalog.push( jsx( '<Order key=${key} order=${order} currency=${props.currency} hasPayments=${props.hasPayments} catalogType=${props.catalogType} />' ));
				totalPrice += order.quantity * order.product.price;
			}	
		}

		var className1 = "";
		var className2 = "";
		var className3 = "";
		var className4 = "";

		if ( props.catalogType != 0 ) {

			className1 = "col-md-5 text-center";
			className2 = "col-md-3 ref text-center";
			className3 = "col-md-2 text-center";
			className4 = "col-md-2 text-center";

			if ( !props.hasPayments ) {

				className2 = "col-md-2 ref text-center";
			}
		}
		else {

			className1 = "col-md-3 text-center";
			className2 = "col-md-2 ref text-center";
			className3 = "col-md-1 text-center";
			className4 = "col-md-2 text-center";

			if ( !props.hasPayments ) {

				className2 = "col-md-1 ref text-center";
			}
		}		

		ordersByCatalog.push(jsx('<div className="row">			
			<div className=${className1}></div>
			<div className=${className2}><b>TOTAL</b></div>
			<div className=${className3}><b>${Formatting.formatNum(totalPrice)}&nbsp;&euro;</b></div>
			<div className=${className4}></div>
			</div>'));
			
		var delivery = 	props.date == null ? null : jsx('<p>Pour la livraison du <b>${props.date}</b> à <b>${props.place}</b></p>');

        var validateButton = jsx('
            <Button 
                onClick=$onValidateClick
                variant={Contained}
                style=${{
                    color:CGColors.White,
                    backgroundColor: this.state.processing ? CGColors.LightGrey : CGColors.Secondary
                }}
                disabled=${this.state.processing} >
                ${CagetteTheme.getIcon("chevron-right")}&nbsp;Valider
            </Button>');				
		
		//Display user selector in the case we don't have a userId
		var renderUserSelector = function( props : react.router.RouteRenderProps ) : react.ReactFragment {
			js.html.Console.log( "renderUserSelector");
			return jsx('<UserSelector multiDistribId=${this.props.multiDistribId} catalogId=${this.props.catalogId} catalogType=${this.props.catalogType} />');
		} 
				
        var renderOrderBox = function( props : react.router.RouteRenderProps ) : react.ReactFragment { 

			js.html.Console.log( "renderOrderBox");

			if ( userId != null ) {

				return jsx('<div onKeyPress=${onKeyPress}>
							<h3>Commandes de $userName</h3>
							$delivery							
							<hr/>
							<div key="header" className="row tableHeader" >
								<div key="prod" className=${className1}>Produits</div>
								<div key="ref" className=${className2}>Ref.</div>
								<div key="price" className=${className3}>Prix</div>
								<div key="qty" className=${className4}>Qté</div>
								${ !this.props.hasPayments ? jsx('<div key="paid" className="col-md-1 text-center">Payé</div>') : null }
								${ this.props.catalogType == 0 ? jsx('<div key="alternated" className="col-md-3 text-center">Alterné avec</div>') : null }
							</div>
							${ordersByCatalog}	
							<div key="footer" style=${{marginTop: 20}}>
								${validateButton}						
								&nbsp;																
                                <Button
                                    onClick=${function() { js.Browser.location.hash = this.props.catalogId == null ? "/catalogs" : "/insert"; }}
                                    size={Medium}
                                    variant={Outlined}
                                    disabled=${this.state.processing}>
									${CagetteTheme.getIcon("plus")}&nbsp;&nbsp;Ajouter un produit
								</Button>			
							</div>
						</div>');
			} else {
				js.html.Console.log( "js.Browser.location.hash = /user" );
				js.Browser.location.hash = "/user";
				return null;
			}
			
		}

		//Display catalogs box
		var renderCatalogsBox = function( props : react.router.RouteRenderProps ) : react.ReactFragment {
			js.html.Console.log( "renderCatalogsBox");
			return <CatalogsBox multiDistribId=${this.props.multiDistribId} />;
		} 

		//insert product box
		var renderInsertBox = function( props : react.router.RouteRenderProps ) : react.ReactFragment {
			js.html.Console.log( "renderInsertBox");
			return <InsertOrder catalogId=${this.props.catalogId} userId=${userId} multiDistribId=${this.props.multiDistribId} />;
		} 

		return  <div>
					<Error error=${this.props.error} />
					<HashRouter>
						<Switch>
							${ userId != null ? null : <Route key="user" path="/user" exact=$true render=$renderUserSelector /> }
							<Route key="orders" path="/" exact=$true render=$renderOrderBox />
							${ props.catalogId != null ? null : <Route key="catalogs" path="/catalogs" exact=$true render=$renderCatalogsBox /> }
							<Route key="products" path="/insert" exact=$true render=$renderInsertBox />
						</Switch>
					</HashRouter>
				</div>;
    }

    function getCurrentUserId() {
        return this.props.userId != null ? this.props.userId : this.props.selectedUserId;
    }
    
    function onValidateClick() {
        this.setState({ processing: true });
        this.props.updateOrders(this.getCurrentUserId(), props.callbackUrl, props.multiDistribId, props.catalogId);
    }

	function onKeyPress(e : js.html.KeyboardEvent) {
		
		if ( e.key == "Enter" ) {
			var userId = this.getCurrentUserId();
			props.updateOrders( userId, props.callbackUrl, props.multiDistribId, props.catalogId );
		} 
	}	

	static function mapStateToProps( state: react.order.redux.reducers.OrderBoxReducer.OrderBoxState ): react.Partial<OrderBoxProps> {		

		return {	selectedUserId : Reflect.field(state, "reduxApp").selectedUserId,
					selectedUserName : Reflect.field(state, "reduxApp").selectedUserName,
					orders : Reflect.field(state, "reduxApp").orders,
					ordersWereFetched : Reflect.field(state, "reduxApp").ordersWereFetched,
					error : Reflect.field(state, "reduxApp").error };
	}

	static function mapDispatchToProps( dispatch : redux.Redux.Dispatch ) : react.Partial<OrderBoxProps> {
				
		return { 
			
			fetchOrders : function( userId : Int, multiDistribId : Int, catalogId : Int, catalogType : Int ) {
							return dispatch( OrderBoxThunk.fetchOrders( userId, multiDistribId, catalogId, catalogType ) );
						  },
			updateOrders : function( userId : Int, callbackUrl : String, multiDistribId : Int, catalogId : Int ) {
							return dispatch( OrderBoxThunk.updateOrders( userId, callbackUrl, multiDistribId, catalogId ) );
						  }
		}

	}	
	
}