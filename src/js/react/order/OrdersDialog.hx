package react.order;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.order.redux.components.OrderBox;
import react.mui.CagetteTheme;
import mui.core.Button;
import mui.core.Dialog;
import mui.core.DialogActions;
import mui.core.DialogContent;


typedef OrdersDialogProps = {

	var userId : Int;
	var multiDistribId : Int;
	var catalogId : Int;
	var catalogType : Int;
	var date : String;
	var place : String;
	var userName : String;
	var callbackUrl : String;
	var currency : String;
	var hasPayments : Bool;
};

typedef OrdersDialogState = {

	var openDialog : Bool;	
}


/**
 * A dialog for te orders
 * @author web-wizard
 */
class OrdersDialog extends react.ReactComponentOfPropsAndState<OrdersDialogProps, OrdersDialogState>
{
	public function new(props) {

		super(props);
		state = { openDialog : true };		
	}
	
	override public function render() {		

		return jsx('<Dialog onClose=${this.handleClose} fullWidth={true} maxWidth={MD} scroll={Body} open=${state.openDialog} >
				<DialogContent>
					<OrderBox userId=${props.userId} multiDistribId=${props.multiDistribId} catalogId=${props.catalogId} catalogType=${props.catalogType}
					date=${props.date} place=${props.place} userName=${props.userName} callbackUrl=${props.callbackUrl} currency=${props.currency} hasPayments=${props.hasPayments} />
				</DialogContent>
				<DialogActions>
					<Button onClick=${this.handleClose}>
						${CagetteTheme.getIcon("delete")}&nbsp;Fermer
					</Button>
				</DialogActions>	
			</Dialog>');
				
	}

	function handleClose( e : Null<js.html.Event> ) {

		setState( { openDialog : false } );
		js.Browser.location.hash = "/";
	}

}