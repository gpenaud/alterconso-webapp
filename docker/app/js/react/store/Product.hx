package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.types.*;
import css.JustifyContent;
import css.AlignContent;
import mui.core.Button;
import mui.core.Card;
import mui.core.CardMedia;
import mui.core.CardContent;
import mui.core.Modal;
import mui.core.CardActionArea;
import mui.core.CardActions;
import mui.core.Typography;
import mui.core.Avatar;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.core.Hidden;
import mui.icon.Icon;
import react.mui.CagetteTheme;
import Common;

private typedef Props = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
    var product : ProductInfo;
    var openModal : ProductInfo->VendorInfos->Void;
    var vendor : VendorInfos;
}

private typedef TClasses = Classes<[
	button,
    card,
    media,
    area,
    cardContent,
    productBuy,
    starProduct,
    farmerAvatar,
    cagAvatarContainer,
    cagProductTitle,
    cagProductDesc,
    cagProductInfoWrap,
    cagProductInfo,
    cagProductLabel,
]>

typedef ProductState = {};

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class Product extends ReactComponentOf<Props, ProductState> {

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
            media: {                
                //XS breakpoint       
                "@media (min-width:0px)" : {
					height: 120,
				},
                //MD breakpoint
                "@media (min-width:960px)" : {
					height: 240,
				},
                padding: 1,
            },
            cardContent: {
                padding: 10,
                paddingBottom: 5,
            },
            productBuy: {
                boxShadow: "none",
            },
            starProduct: {
                width: 30,
                height: 30,
                color: '#F9D800',        
                backgroundColor: '#FFF',
                marginLeft: "auto",
                fontSize: 16,
            },
            farmerAvatar: {       
                color: '#404040',   
                backgroundColor: '#ededed',
                border: "3px solid #FFF",
                width: 70,
                height: 70,
                //marginLeft: "auto",
                //fontSize: 10,
                position:css.Position.Absolute,
                top: 160,
                right: 12
            },
            cagAvatarContainer: {
                margin: "3%",
                height: "43%",
                display: "flex",
            },
            cagProductTitle: {
                fontSize: '1.08rem',
                lineHeight: "normal",
                fontStyle: "normal",
                textTransform: UpperCase,
                marginBottom: 3,
                fontWeight: 400,
                maxHeight: 40,
                overflow: Hidden,
            },
            cagProductLabel : {
                color:CGColors.MediumGrey,                
            },
            cagProductDesc: {
                fontSize: '0.9rem',
                color : CGColors.MediumGrey,
                marginBottom : 0,
                maxHeight: 65,
                overflow: Hidden,
            },
            cagProductInfoWrap : {       
                justifyContent: SpaceBetween,
                padding: "0 10px",
            },
            cagProductInfo : {
                /*fontSize : "1.3rem",

                "& .cagProductUnit" : {
                    marginRight: "2rem",
                },

                "& .cagProductPrice" : {
                    color : CGColors.Third,        
                },*/
            },
		}
	}

    public function new(props) {
        super(props);
        this.state = {};
    }

    function displayProductInfos(_) {
        props.openModal(props.product,props.vendor);
    }

    override public function render() {
        var classes = props.classes;
        var product = props.product;
        var v = props.vendor;
        var portrait = v.images!=null && v.images.portrait!=null ? v.images.portrait : v.image;

        var avatar = portrait==null ? null : jsx('<Hidden xsDown>
            <div className=${classes.cagAvatarContainer}>
                <Avatar src=$portrait className=${classes.farmerAvatar}/>  
            </div>
        </Hidden>');

        return jsx('
            <Card elevation={0} className=${classes.card}> 
                <CardActionArea className=${classes.area} onClick=${displayProductInfos}>
                    <CardMedia  className=${classes.media} image=${product.image}>
                        <!--<div className=${classes.cagAvatarContainer}>
                            <Avatar className=${classes.starProduct}>
                                ${CagetteTheme.getIcon("star")}
                            </Avatar>  
                        </div>-->

                        $avatar
                    </CardMedia>

                    <CardContent className=${classes.cardContent}>

                        <Typography component="h3" className=${classes.cagProductTitle}>
                            ${product.name}
                        </Typography>

                        <Typography component="p" className=${classes.cagProductDesc}>
                            ${product.stock!=null && product.stock<=10 && product.stock>0 ? renderLowStock(product) : renderVendor(props.vendor)} 
                        </Typography>

                        <Typography component="p" className=${classes.cagProductLabel}>
                            <Labels product=$product />
                        </Typography>

                    </CardContent>           
                </CardActionArea>

                <$ProductActions product=$product displayVAT={false}/>
            </Card>
        ');

        // avec icones : 
        /*<$SubCateg label="Label rouge" icon="icon icon-truck" colorClass="cagLabelRouge" />
        <$SubCateg label="Bio" icon="icon icon-bio" colorClass="cagBio"  />*/
    }

    function renderVendor(vendor:VendorInfos){
        return jsx('<span>${vendor.name}</span>');
    }

    function renderLowStock(product:ProductInfo){        
        return jsx('<span style=${{color:CGColors.Third}}>Plus que ${product.stock} en stock</span>');
    }
}
