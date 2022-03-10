package react.store;

import mui.core.grid.GridSpacing;
import css.AlignSelf;
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.*;
import mui.IconColor;
import mui.icon.Icon;

import mui.core.styles.Classes;
import mui.core.styles.Styles;

import react.store.redux.action.CartAction;
import Common;
using Lambda;


typedef CartDetailsProps = {
	> PublicProps,
	> ReduxProps,
	var classes:TClasses;
}

private typedef ReduxProps = {
	var updateCart:ProductInfo->Int->Void;
	var removeProduct:ProductInfo->Void;
	var resetCart:Void->Void;
	var order:OrderSimple;
}

private typedef PublicProps = {
	var submitOrder:OrderSimple->Void;

	var place:PlaceInfos;
	var orderByEndDates:Array<OrderByEndDate>;
	var paymentInfos:String;
	var date:Date;
}

private typedef TClasses = Classes<[
	gridItem,

	cartDetails, 
	cartFooter,
	products, 
	product, 
	iconStyle, 
	subcard, 
	cover,

	cagProductTitle,
    cagProductInfoWrap,
    cagProductInfo,
    cagProductPriceRate,
	
	]>

@:build(lib.lodash.Lodash.build())
@:publicProps(PublicProps)
@:connect
@:wrap(untyped Styles.withStyles(styles))
class CartDetails extends react.ReactComponentOfPropsAndState<CartDetailsProps,{disabled:Bool}> {

    public function new(props) {
		super(props);
        this.state = {disabled: false};
    }
	
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			cartDetails : {
                /*fontSize: "1.2rem",
                fontWeight: "bold",//TODO use enum from externs when available*/
                display: "flex",
				flexDirection: css.FlexDirection.Column,
                width: 400,
				//padding:10,
            },
			subcard: {
				flexDirection: css.FlexDirection.Row,
				display: 'flex',
			},
			gridItem: {
				overflow: Hidden,
			},
			cartFooter: {
				display: "flex",
				flexDirection: Column,
				//fontSize: "1.8rem",
				alignItems:Center,
				//justifyContent:SpaceEvenly,
				//height:120
			},
			products : {
				display: "flex",
				justifyContent: SpaceAround,
				alignItems: Center,
				maxHeight: (4*80),
				overflow: Auto,
			},
			product : {
				height: 80,
				padding: 8,
				marginBottom: 6,
				overflow: Hidden,
				alignItems:Center,
				justifyContent:SpaceEvenly,
			},
			iconStyle:{
				fontSize:12,
			},
			cover: {
				width: '70px',
				height: '70px',
				objectFit: "cover",
			},
			
			cagProductTitle: {
                fontSize: '0.8rem',
                fontStyle: "normal",
                textTransform: UpperCase,
                //marginBottom: 3,
				overflow: Hidden,
				//whiteSpace: NoWrap,
				textOverflow: Ellipsis,
				lineHeight: "1.2em",
  				maxHeight: 80,
				alignSelf: AlignSelf.FlexStart,
            },
            cagProductInfoWrap : {       
                justifyContent: SpaceBetween,
                padding: "0 5px",
            },
            cagProductInfo : {
                fontSize : "1.0rem",
                "& .cagProductUnit" : {
                    marginRight: "2rem",
                },

                "& .cagProductPrice" : {
                    color : CGColors.Third,        
                },
            },
            cagProductPriceRate : {        
               /* fontSize: "0.5rem",
                color : CGColors.Secondfont,
                marginTop : -3,
                marginLeft: 3,*/
            },
		}
	}

	static function mapStateToProps(st:react.store.redux.state.State):react.Partial<CartDetailsProps> {
		return {
			order: cast st.cart,
		}
	}

	static function mapDispatchToProps(dispatch:redux.Redux.Dispatch):react.Partial<CartDetailsProps> {
		return {
			updateCart: function(product, quantity) {
				dispatch(CartAction.UpdateQuantity(product, quantity));
			},
			resetCart: function() {
				dispatch(CartAction.ResetCart);
			},
			removeProduct: function(p:ProductInfo) {
				dispatch(CartAction.RemoveProduct(p));
			}
		}
	}

	override public function render() {
		var classes = props.classes;
		return jsx('
			<Card className=${classes.cartDetails}>
				<CardContent>
					${renderProducts()}
					<Divider variant={Middle} />
					<DistributionDetails 
						isSticky={false}
						displayLinks={false}
						orderByEndDates=${props.orderByEndDates}
						place=${props.place}
						paymentInfos=${props.paymentInfos}
						date=${props.date}/>
				</CardContent>
				<CardActions style=${{height:80}}>
					${renderFooter()}
				</CardActions>
			</Card>
        ');
		//height is 80, because of a rendering bug in IE11 and Safari 9
    }

	function renderQtAndUnit(qt:Float,unit:Unit){
        if(qt==0 || qt==null) return null;
        if(unit==null) return null;
        return jsx('<>${Formatting.formatNum(qt)}${Formatting.unit(unit,qt)}</>');
    }


	function updateQuantity(cartProduct:ProductWithQuantity, newValue:Int) {
		props.updateCart(cartProduct.product, newValue);
	}

	function renderProducts() {

		if( props.order.products == null || props.order.products.length == 0 ) return null;

		var classes = props.classes;
		var cl = classNames({
			'icons':true,
			'icon-delete':true,
		});

        var productsToOrder = props.order.products.map(function(cartProduct:ProductWithQuantity) {
			var quantity = cartProduct.quantity;
			var product = cartProduct.product;

			return jsx('
				<Grid className=${classes.product} container={true} direction=${Row} spacing=${GridSpacing.Spacing_1} key=${product.id}>
					<Grid item xs={2} className=${classes.gridItem}>
						<Card className=${classes.subcard} elevation={0}>
							<CardMedia
								className=${classes.cover}
								image=${product.image}
							/>
						</Card>
					</Grid>
					<Grid item={true} xs={3} className=${classes.gridItem}>
						<Typography component="h3" className=${classes.cagProductTitle}>
                            ${product.name}
                        </Typography>
						
					</Grid>
					<Grid item={true} xs={2} className=${classes.gridItem}>
						<Typography component="p" className=${classes.cagProductInfo}>
							<span className="cagProductUnit">${renderQtAndUnit(quantity*product.qt,product.unitType)}</span>	
						</Typography>
						<Typography component="p" className=${classes.cagProductInfo} >
							<span className="cagProductPrice">${Formatting.formatNum(quantity*product.price)}&nbsp;&euro;</span>
						</Typography>
					</Grid>
					<Grid item={true} xs={3}>
						<QuantityInput onChange=${updateQuantity.bind(cartProduct)} value=${quantity} />
					</Grid>
					<Grid item={true} xs={1}>
						<IconButton onClick=${props.removeProduct.bind(product)} style={{padding:4}}>
							<Icon component="i" className=${cl} color=${Primary}></Icon>
						</IconButton>
					</Grid>
				</Grid>
			');
		});

		//<GridList cellHeight={80} cols={1} className=${classes.products} direction=${Column} spacing={8}>
		//<Grid className=${classes.products} direction=${Column} spacing={8}>
		return jsx('			
			<GridList cellHeight={80} cols={1} className=${classes.products} spacing={8}>
				${productsToOrder}
			</GridList>
		');
    }
    
    @:debounce(5000, {leading:true})
    function submit(){
        trace("submit");
        if (props.order.products.length == 0) return;
        props.submitOrder(props.order);
        setState({disabled:true});

    }

    function renderFooter() {
		var classes = props.classes;
		
		return jsx('
			<Grid className=${classes.cartFooter} container={true} direction=${css.FlexDirection.Column} key="footer">
				<Grid item={true} xs={12}>
					<Button
                        onClick=${submit}
                        variant=${Contained}
                        color=${Primary} 
						disabled=${(props.order.products.length == 0) ? true : state.disabled}
                        >                        
                        COMMANDER
                    </Button>
				</Grid>
			</Grid>
		');
	}
}

