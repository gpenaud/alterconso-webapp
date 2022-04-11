package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.types.*;
import css.JustifyContent;
import css.AlignContent;
import react.store.redux.action.CartAction;
import mui.core.Button;
import mui.core.CardActionArea;
import mui.core.CardActions;
import mui.core.Typography;
import mui.core.Grid;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.icon.Icon;
import react.mui.CagetteTheme;
import mui.core.Tooltip;
import Common;

private typedef Props = {
	> PublicProps,
    > ReduxProps,
	var classes:TClasses;
}

private typedef PublicProps = {
    var product:ProductInfo;
    var displayVAT:Bool;
}

private typedef ReduxProps = {
	var updateCart:ProductInfo->Int->Void;
	var addToCart:ProductInfo->Void;
    var quantity:Int;
}

private typedef TClasses = Classes<[
	button,
    card,
    area,
    productBuy,    
    cagProductInfoWrap,
    cagProductInfo,
    cagProductPriceRate,
    cagProductLabel,
]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
@:connect
class ProductActions extends ReactComponentOfProps<Props> {

    //https://cssinjs.org/jss-expand-full?v=v5.3.0
    //https://cssinjs.org/jss-expand-full/?v=v5.3.0#supported-properties
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			button:{
                size: "small",
                textTransform: None,
                color: '#84BD55',
            },
            card: {     
                backgroundColor: '#F8F4E5',
            },
            area: {     
                width: '100%',
            },
            productBuy: {
                boxShadow: "none",
            },
            cagProductLabel : {
                marginLeft : -3,
            },
            cagProductInfoWrap : {       
                justifyContent: SpaceBetween,
                padding: "0 10px",
            },
            cagProductInfo : {
                fontSize : "1.3rem",

                "& .cagProductUnit" : {
                    marginRight: "2rem",
                },

                "& .cagProductPrice" : {
                    color : CGColors.Third,        
                },
            },
            cagProductPriceRate : {        
                fontSize: "0.9rem",
                color : CGColors.MediumGrey,
                //marginTop : -5,
                //marginLeft: 5,
            },
		}
	}

    static function mapStateToProps(st:react.store.redux.state.State, ownProps:PublicProps):react.Partial<Props> {
        var storeProduct = 0;
        for( p in st.cart.products ) { if( p.product == ownProps.product) {storeProduct = p.quantity ; break; }}
		return {
			quantity: storeProduct,
		}
	}

	static function mapDispatchToProps(dispatch:redux.Redux.Dispatch):react.Partial<Props> {
		return {
			updateCart: function(product, quantity) {
				dispatch(CartAction.UpdateQuantity(product, quantity));
			},
			addToCart: function(product) {
				dispatch(CartAction.AddProduct(product));
			},
		}
	}
    
    public function new(props) {
        super(props);
    }

    function updateQuantity(quantity:Int) {
        props.updateCart(props.product, quantity);
    }

    function addToCart() {
        props.addToCart(props.product);
    }

    function renderQuantityAction() {

        var style = {fontSize:20};
        var basketIcon = CagetteTheme.getIcon("basket-add",style);

        return if(props.product.stock!=null && props.product.stock<=0){
            jsx('<span style=${{color:CGColors.Third}}>Rupture<br/>de stock</span>');
            } else if(props.quantity <= 0 ) {
            jsx('<Tooltip title="Ajouter ce produit à mon panier" placement=${mui.core.popper.PopperPlacement.Bottom}>
                    <Button
                        onClick=${addToCart}
                        variant=${Contained}
                        color=${Primary} 
                        className=${props.classes.productBuy} 
                        disableRipple>                        
                        $basketIcon
                    </Button>
                </Tooltip>');
        } else {
            jsx('<QuantityInput onChange=${updateQuantity} value=${props.quantity}/>');
        }
    }

    function renderQtAndUnit(p:ProductInfo){
        if(p.qt==0 || p.qt==null) return null;
        if(p.unitType==null) return null;
        return jsx('<>${Formatting.formatNum(p.qt)} ${Formatting.unit(p.unitType,p.qt)}</>');
    }

    override public function render() {
        var classes = props.classes;
        var product = props.product;

        return jsx('
            <CardActions className=${classes.cagProductInfoWrap} >
                <Grid container>
                    <Grid item md={4} xs={6} style=${{textAlign:css.TextAlign.Left}}>
                        <Typography component="div" className=${classes.cagProductInfo} >                                 
                            <span className="cagProductUnit">
                                ${renderQtAndUnit(product)}
                                <div className=${classes.cagProductPriceRate}>
                                    ${Formatting.pricePerUnit(product.price,product.qt,product.unitType)}
                                </div>
                            </span>
                        </Typography>
                    </Grid>
                    
                    <Grid item md={3} xs={6} style=${{textAlign:css.TextAlign.Center}}>
                        <Typography component="div" className=${classes.cagProductInfo} >
                            <span className="cagProductPrice">
                                ${Formatting.formatNum(product.price)}&nbsp;&euro;
                            </span> 
                        </Typography> 
                        
                        ${renderVAT(product)}

                    </Grid>
                    
                    <Grid item md={5} xs={12} style=${{textAlign:css.TextAlign.Right}}>
                        ${renderQuantityAction()}
                    </Grid>

                </Grid>
           </CardActions>
        ');
    }

    function renderVAT(product:ProductInfo){
        if(props.displayVAT && product.vat!=null && product.vat!=0 ){
            return jsx('<Typography className=${props.classes.cagProductPriceRate}>                        
                ${Formatting.formatNum(product.vat)} % de TVA inclue
            </Typography>');
        }else{
            return null;
        }
    }

}
