package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common.Unit;
import Common.UserInfo;
import Common.UserOrder;
import react.product.Product;
import react.order.redux.actions.OrderBoxAction;
import mui.core.input.InputAdornmentPosition;
import mui.core.Checkbox;
import mui.core.FormControlLabel;
import mui.core.TextField;
import mui.core.InputAdornment;
import mui.core.OutlinedInput;
import mui.core.NativeSelect;


typedef OrderProps = {

	var order : UserOrder;
	var users : Null<Array<UserInfo>>;
	var currency : String;
	var hasPayments : Bool;
	var catalogType : Int;	
	var updateOrderQuantity : Float -> Void;
	var updatePaid : Bool -> Void;
	var reverseRotation : Bool -> Void;
	var updateOrderUserId2 : Int -> Void;
}

typedef OrderState = {

	var quantityInputValue : String;
	var paid : Bool;
	var userId2Value : Int;
	var invertSharedOrder : Bool;
}


/**
 * A User order
 * @author fbarbut
 */
@:connect
class Order extends react.ReactComponentOfPropsAndState<OrderProps, OrderState>
{
	// var paymentsEnabled : Bool;

	public function new(props) {

		super(props);
		if (props.order.product.qt == null) props.order.product.qt = 1;
		state = { quantityInputValue : getDisplayQuantity(), paid : props.order.paid, userId2Value : props.order.userId2, invertSharedOrder : props.order.invertSharedOrder };
		// paymentsEnabled = props.hasPayments;
	}
	
	override public function render() {

		var inputProps = { endAdornment: jsx('<InputAdornment position={End}>${getProductUnit()}</InputAdornment>') };
		var input =  isSmartQtInput() ?
		jsx('<TextField key=${"input-" + props.order.id} variant={Outlined} type={Text} value=${state.quantityInputValue} onChange=${updateQuantity} InputProps=${cast inputProps} />') :
		jsx('<TextField key=${"input-" + props.order.id} variant={Outlined} type={Text} value=${state.quantityInputValue} onChange=${updateQuantity} /> ');

		//constant orders
		var alternated = if( props.catalogType == 0 && props.users != null ) {			

			var options = props.users.map(function(x) return jsx('<option key=${x.id} value=${x.id}>${x.name}</option>') );
			var inputSelect = jsx('<OutlinedInput labelWidth={0} />');
			var checkboxProps = jsx('<Checkbox key=${"checkbox-" + props.order.id} checked=${state.invertSharedOrder} onChange=$reverseUsersRotation value=${Std.string(props.order.id)} color={Primary} />');
			jsx('<div>
					<NativeSelect key=${"select-" + props.order.id} value=${state.userId2Value} onChange=${updateUserId2} input=${cast inputSelect} style=${{fontSize:"0.95rem", height: 45, width: "100%" }} >	
						<option value="0">-</option>
						$options						
					</NativeSelect>
					<FormControlLabel key=${"label-" + props.order.id} control=${ cast checkboxProps } label="Inverser l\'alternance" />					
				</div>');		

		}
		else {

			null;
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
		
		return jsx('<div className="productOrder row">
			<div className=${className1}>
				<Product productInfo=${props.order.product} />
			</div>

			<div className=${className2} style=${{ paddingTop: 15 }} >
				${props.order.product.ref}
			</div>

			<div className=${className3} style=${{ paddingTop: 15 }} >
				${round(props.order.quantity * props.order.product.price)}&nbsp;${props.currency}
			</div>
			
			<div className=${className4} >
				$input			
				${makeInfos()}
			</div>

			${paidInput( props.hasPayments )}				

			${ props.catalogType == 0 ? jsx('<div className="col-md-4">$alternated</div>') : null }
			
		</div>');
	}
	
	function round(f) {

		return Formatting.formatNum(f);
	}

	function paidInput( paymentsEnabled : Bool ) {
		
		if ( paymentsEnabled ) {

			return null;
		}
        
		return jsx('<div className="col-md-1 text-center" >
						<Checkbox checked=${state.paid} onChange=$updatePaid value=${Std.string(props.order.id)} color={Primary} />
					</div>');
	}

	function makeInfos() {

		return if ( isSmartQtInput() ) {

			jsx('
			<div className="infos">
				<b> ${getProductQuantity()} </b> x <b>${props.order.product.qt} ${getProductUnit()} </b> ${props.order.product.name}
			</div>');
		}
		else {

			null;
		}
	}

	function isSmartQtInput() : Bool {

		return props.order.product.hasFloatQt || props.order.product.variablePrice || props.order.product.wholesale;
	}

	function updateQuantity( e: js.html.Event ) {		

		e.preventDefault();		

		var value: String = untyped (e.target.value == "") ? "0" : e.target.value;
		setState( { quantityInputValue : value } );

		var orderQuantity : Float = Formatting.parseFloat(value);
		if ( isSmartQtInput() ) {

			//the value is a smart qt, so we need re-compute the quantity
			orderQuantity = orderQuantity / props.order.product.qt;
		}				
		props.updateOrderQuantity(orderQuantity); 
	}	


	function updateUserId2( e: js.html.Event ) {		

		e.preventDefault();		

		var value : Int = untyped (e.target.value == "") ? null : e.target.value;
		setState( { userId2Value : value } );

		props.updateOrderUserId2(value); 
	}	

	function updatePaid( e: js.html.Event ) {		

		e.preventDefault();

		var value : Bool = untyped (e.target.checked == "") ? false : e.target.checked;
		setState( { paid : value } );

		props.updatePaid(value); 
	}	

	function reverseUsersRotation( e: js.html.Event ) {		

		e.preventDefault();

		var value : Bool = untyped (e.target.checked == "") ? false : e.target.checked;
		setState( { invertSharedOrder : value } );

		props.reverseRotation(value); 
	}	

	function getProductUnit() : String {

		var productUnit : Unit = props.order.product.unitType != null ? props.order.product.unitType : Piece;
		return Formatting.unit( productUnit ); 		
	}

	function getDisplayQuantity() : String {

		if ( isSmartQtInput() ) {

			return Std.string( round( props.order.quantity * props.order.product.qt ) );
		}
		else {

			return Std.string( props.order.quantity );
		}

	}

	function getProductQuantity() : String {

		return Std.string( round(  Formatting.parseFloat(state.quantityInputValue) / props.order.product.qt ) );
	}

	static function mapStateToProps( state : react.order.redux.reducers.OrderBoxReducer.OrderBoxState ) : react.Partial<OrderProps> {	
		
		return { users : Reflect.field(state, "reduxApp").users };
	}

	static function mapDispatchToProps( dispatch: redux.Redux.Dispatch, ownProps: OrderProps ) : react.Partial<OrderProps> {
				
		return { 

			updateOrderQuantity : function( orderQuantity ) {
									dispatch( OrderBoxAction.UpdateOrderQuantity( ownProps.order.id, orderQuantity ) ); 
								},
			reverseRotation : function( reverseRotation : Bool ) {
								dispatch( OrderBoxAction.ReverseOrderRotation( ownProps.order.id, reverseRotation ) ); 
							  },
			updateOrderUserId2 : function( userId2 : Int ) {
									dispatch( OrderBoxAction.UpdateOrderUserId2( ownProps.order.id, userId2 == 0 ? null : userId2 ) );				
								 },
			updatePaid : function( paid : Bool ) {
								dispatch( OrderBoxAction.UpdatePaid( ownProps.order.id, paid ) );
			}
		}
	}

}