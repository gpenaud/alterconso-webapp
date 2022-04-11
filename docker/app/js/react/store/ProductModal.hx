package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.types.*;
import css.JustifyContent;
import css.AlignContent;

import mui.core.Backdrop;
import mui.core.Button;
import mui.core.Card;
import mui.core.Grid;
import mui.core.GridList;
import mui.core.CardMedia;
import mui.core.CardContent;
import mui.core.CardActionArea;
import mui.core.CardActions;
import mui.core.Dialog;
import mui.core.modal.ModalCloseReason;
import mui.core.Typography;
import mui.core.Avatar;
import mui.core.Paper;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.icon.Icon;
import mui.core.common.ShirtSize;
import mui.core.Tooltip;
import react.store.redux.action.CartAction;
import react.mui.CagetteTheme;
import mui.core.grid.GridSpacing;

import Common;

private typedef Props = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
    var product:ProductInfo;
    var vendor:VendorInfos;
    var onClose:js.html.Event->ModalCloseReason->Void;
}

private typedef TClasses = Classes<[
	gridItem,
	modal, 
	cartFooter,
	products, 
	product, 
	iconStyle, 
	cover,
	cagProductTitle,
    cagProductInfoWrap,
]>


@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class ProductModal extends ReactComponentOfProps<Props> {
    public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			modal : {
                padding:"24px",
            },
			gridItem: {
				overflow: Hidden,
			},
			cartFooter: {
				display: "flex",
				flexDirection: Column,
				fontSize: "1.8rem",
				alignItems:Center,
				justifyContent:SpaceEvenly,
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
                width:"100%",
				//maxWidth: '300px',
				maxHeight: '400px',
				//objectFit: "cover",
			},
		
			cagProductTitle: {
                fontSize: '1.4rem',
                fontStyle: "normal",
                textTransform: UpperCase,
                marginBottom: 3,
				//overflow: Hidden,
				//textOverflow: Ellipsis,
				//lineHeight: "1.0em",
  				//maxHeight: "1.8em",
				//alignSelf: "flex-start",
            },
            cagProductInfoWrap : {       
                justifyContent: SpaceBetween,
                padding: "0 5px",
            },
		}
	}
    
    public function new(props) {
        super(props);
    }

    override public function render() {
        var classes = props.classes;
        var product = props.product;
        var vendor = props.vendor;        
        if(vendor==null || product==null) return null;
        var portrait = vendor.images!=null && vendor.images.portrait!=null ? vendor.images.portrait : vendor.image;
        if( product == null || vendor == null ) return null;


        return jsx('
            <Dialog 
                open={true} 
                onClose=${props.onClose} 
                fullWidth={true}
				maxWidth=${ShirtSizeOrFalse.MD} 
                scroll=${mui.core.dialog.DialogScrollContainer.Body}>
                <div className=${classes.modal}>
                    
                    <Tooltip title="Fermer">
                        <Button onClick=${close} style={{top:0,position:css.Position.Absolute,right:0}}>
                            <i className="icon icon-delete"/>
                        </Button>
                    </Tooltip>
                    
                    <Grid container spacing=${GridSpacing.Spacing_2}>              
                        <Grid item xs={4} className=${classes.gridItem}>
                            <div>
                                <img className=${classes.cover} src=${product.image}/>
                            </div>
                            <div>
                                <Labels product=$product />
                            </div>
                        </Grid>

                        <Grid item xs={8}  className=${classes.gridItem}>

                            <Typography component="h3" className=${classes.cagProductTitle}>
                                ${product.name}
                            </Typography>

                            <Typography component="p" dangerouslySetInnerHTML={{ __html: ${product.desc} }}></Typography>

                            <div style=${{background:CGColors.Bg2,padding:"12px"}}>
                                <$ProductActions product=$product displayVAT={true}/>                            
                            </div>
                        </Grid>
                    </Grid>

                    <div style={{marginTop:18,marginBottom:18}}>
                        <h2>
                        ${vendor.name}
                        </h2>
                    </div>

                    <Grid container spacing=${GridSpacing.Spacing_2}>
                        <Grid item xs={4}>
                            <img className=${classes.cover} src=${portrait} />
                        </Grid>

                        <Grid item xs={8} style=${{color:CGColors.MediumGrey}}>                        
                            <Typography component="p">
                                <i className="icon icon-map-marker"/> ${vendor.city} (${vendor.zipCode})
                            </Typography>

                            <Typography component="p">
                                <i className="icon icon-link"/> <a href=${vendor.linkUrl} target="_blank">${vendor.linkText}</a>
                            </Typography>

                            <div dangerouslySetInnerHTML=${{__html: ${vendor.desc}}}></div>
                        </Grid>
                    </Grid>
                </div>
            </Dialog>
        ');
    }

    function close(e){
        props.onClose(e,mui.core.modal.ModalCloseReason.BackdropClick);
    }  
}
