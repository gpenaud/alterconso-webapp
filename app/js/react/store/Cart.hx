package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.Grid;
import mui.core.common.Position;
import mui.core.TextField;
import mui.core.FormControl;
import mui.core.Popover;
import mui.core.popover.AnchorPosition;
import mui.core.form.FormControlVariant;
import mui.core.input.InputType;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.icon.Icon;
import mui.core.Typography;
import Common;
import react.store.redux.action.CartAction;

using Lambda;

typedef CartProps = {
	> PublicProps,
	> ReduxProps,
	var classes:TClasses;
}

private typedef ReduxProps = {
	var order:OrderSimple;
}

private typedef PublicProps = {
	var submitOrder:OrderSimple->Void;
	var place:PlaceInfos;
	var orderByEndDates:Array<OrderByEndDate>;
	var paymentInfos:String;
	var date:Date;
}

private typedef TClasses = Classes<[cartIcon, cartIconFlash, cart, cagMiniBasketContainer, price]>

private typedef CartState = {
	var price:Float;
	var cartOpen:Bool;
	var cartFlash:Bool;
}

@:publicProps(PublicProps)
@:connect
@:wrap(untyped Styles.withStyles(styles))
class Cart extends react.ReactComponentOf<CartProps, CartState> {

	public static function styles(theme:react.mui.CagetteTheme):ClassesDef<TClasses> {
		return {
			cartIcon : {
				width: 50,
				height: 50,
				lineHeight :"55px",
				fontSize: 30,
				backgroundColor: CGColors.Primary,
				borderRadius:"50%",
				color:"white",
				//transitionDuration:"200ms"
			},

			cartIconFlash : {
				//backgroundColor: "#da8cd7",
			},
			cart : {
				width:'100%',
				height:'100%',
				
				borderRadius : 5,
				border : '1px solid '+CGColors.Bg3,
				textAlign: css.TextAlign.Center,
				padding: "0.5em",
				"&:hover" : {
					backgroundColor : CGColors.Bg2, 
				}
			},
			cagMiniBasketContainer : {
				height: '100%',
				fontSize: "1.0rem",
                fontWeight: "bold",//TODO use enum from externs when available
                display: "flex",
                alignItems: Center,
                justifyContent: Center,
				cursor:"pointer",
                "& i": { 
                    verticalAlign: "middle",
					margin:8,
					
                },
                "& span" : {
                    margin:8,
					fontSize:"1.4em",
                },
            },
			price:{
				color : CGColors.Third, 
			}
		}
	}

	static function mapStateToProps(state:react.store.redux.state.State):react.Partial<CartProps> {
		//trace("stateToProps");

		return {
			order: cast state.cart,
		}
	}

	static function mapDispatchToProps(dispatch:redux.Redux.Dispatch):react.Partial<CartProps> {
		//trace("dispatchToProps");
		return { 
		}
	}

	/**
		triggered when component receives new props
	**/
	static function getDerivedStateFromProps(nextProps:CartProps,previousState:CartState):CartState{
		//if order total is bigger than in previous state -> triiger animation
		if( nextProps.order.total > previousState.price ){			
			return {cartFlash:true,price:nextProps.order.total,cartOpen:previousState.cartOpen};
		}else{
			return null;
		}

	}

	var cartRef:Dynamic;//TODO
	public function new(props) {
		super(props);
		this.state = {cartOpen : false, cartFlash : false, price : 0};
		this.cartRef = React.createRef();

	}

	function onCartClicked() {
		trace(state.cartOpen ? "closing" : "opening");
		setState({cartOpen : !state.cartOpen});
	}

	function handleClose(e : Null<js.html.Event>, reason: mui.core.modal.ModalCloseReason) {
		setState({cartOpen: false});
	}

	override public function render() {
		var classes = props.classes;
		var iconBasket = classNames({
			'icon':true,
			'icon-basket':true,
			'${classes.cartIcon}':true,
			'${classes.cartIconFlash}':state.cartFlash,
			'bounce':state.cartFlash,
			'bouncable':true,

		});

		
		//<Typography component="span">(${props.order.count})</Typography>
		return jsx('
			<div className=${classes.cart}>
				<div ref={this.cartRef} className=${classes.cagMiniBasketContainer} onClick=${onCartClicked}>
					<Icon component="i" className=${iconBasket}></Icon>
					
					<Typography className=${classes.price} component="span">${Formatting.formatNum(props.order.total)} €</Typography>
					${CagetteTheme.getIcon("chevron-down")}
				</div>
				<Popover open={state.cartOpen}
						anchorEl={this.cartRef.current}
						onClose={this.handleClose}
						anchorOrigin={{vertical: Bottom, horizontal: Right,}}
						transformOrigin={{vertical: Top,horizontal: Right,}}
					>
					<CartDetails submitOrder=${props.submitOrder} 
						orderByEndDates=${props.orderByEndDates} 
						place=${props.place} 
						paymentInfos=${props.paymentInfos} 
						date=${props.date}/>
				</Popover>
			</div>
		');
	}


	override function componentDidUpdate(_,_){

		//reset animation class after 0.75s
		if(state.cartFlash){
			haxe.Timer.delay(function(){
				this.setState({cartFlash:false});
			},750);
		}

	}
}
