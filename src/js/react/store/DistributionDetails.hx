package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.Grid;
import mui.core.TextField;
import mui.core.Typography;
import mui.core.FormControl;
import mui.icon.Icon;
import mui.core.form.FormControlVariant;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.core.Hidden;
import Common;
import Formatting;
//import css.Overflow;

using Lambda;

typedef DistributionDetailsProps = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
	var isSticky:Bool;
	var displayLinks:Bool;
	var place:PlaceInfos;
	var orderByEndDates:Array<OrderByEndDate>;
	var paymentInfos:String;
	var date : Date;
}

private typedef TClasses = Classes<[cagNavInfo,textSingleLine]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class DistributionDetails extends react.ReactComponentOfPropsAndState<DistributionDetailsProps,{placePopup:PlaceInfos}> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			cagNavInfo : {
                /*fontSize: "0.7rem",
				fontWeight: "lighter",
                color: CGColors.Secondfont,*/
				lineHeight : 1.5,
                padding: "10px 0",
                
                "& p" : {
                    margin: "0 0 0.2rem 0",// !important  hum...
                },

                "& a" : {
                    color : CGColors.DarkGrey, // !important   hum....
                },

                "& i" : {
                    color : CGColors.MediumGrey,
                    fontSize: "1em",
                    verticalAlign: "middle",//TODO replace later with proper externs enum
                    marginRight: "0.2rem",
                },
            },
			textSingleLine : {
				cursor : "pointer",
				/*
				Buddy when displayed in Cart Details
				textOverflow : css.TextOverflow.Ellipsis,
				whiteSpace : css.WhiteSpace.NoWrap,
				overflow : cast "hidden",*/
			}
		}
	}

	public function new(props) {
		super(props);
		this.state = {placePopup:null};
	}

	override public function render() {
		
		if( props.orderByEndDates != null || props.orderByEndDates.length > 0 ) {
			return jsx('<div className=${props.classes.cagNavInfo}> 
				<span className=${props.classes.textSingleLine} onClick=$openMapWindow>
					${renderDistributionDate()} à ${renderLocation()}
				</span>
				<Hidden xsDown>
					${renderClosingDates()}
					${renderPaymentInfos()}
				</Hidden>				
				${state.placePopup!=null?jsx('<OSMWindow place=${state.placePopup} onClose=$onOSMWindowClose  />'):null}
			</div>');
		}else{
			return null;
		}
	}

	function renderLocation() {
		//if( props.isSticky ) return null;
		if(props.place==null) return null;

		return jsx('<span>
				${CagetteTheme.getIcon("map-marker")}
				${props.place.name}				
			</span>');
	}

	function renderDistributionDate() {
		if(props.date==null) return null;
		return jsx('
			<span>
				${CagetteTheme.getIcon("calendar")}
				<span>Distribution le ${Formatting.hDate(props.date)}</span>
			</span>'
		);
	}

	function renderClosingDates() {
		var endDates;
		if (props.orderByEndDates.length == 1) {
			//single closing date
			var orderEndDate = Date.fromString(props.orderByEndDates[0].date);
			endDates = [jsx('<span key=$orderEndDate>La commande ferme ${Formatting.timeToDate(orderEndDate)}</span>')];
		} else {
			//many closing dates
			endDates = props.orderByEndDates.map(function(order) {
				if (order.contracts.length == 1) {
					return jsx('
						<span key=${order.date}>
							La commande ${order.contracts[0]} ferme ${Formatting.timeToDate(Date.fromString(order.date))}.<br/> 
						</span>
					');
				}

				return jsx('
					<span key=${order.date}>
						Les autres commandes ferment ${Formatting.timeToDate(Date.fromString(order.date))}. 
					</span>
				');
			});
		}

		return jsx('
			<Typography component="p">
				${CagetteTheme.getIcon("clock")}
				${endDates}
			</Typography>'
		);
	}

	function renderPaymentInfos() {
		if( props.isSticky ) return null;
		if(props.paymentInfos=="" || props.paymentInfos==null) return null;

		var paymentInfos = jsx('<span>Paiement: ${props.paymentInfos}</span>');
		return jsx('
            <Typography component="p">
				${CagetteTheme.getIcon("euro")}
				${paymentInfos}
			</Typography>');
	}

	function onOSMWindowClose(_,_){
		setState({placePopup:null});
	}

	function openMapWindow(_){
		setState({placePopup:props.place});
	}
}
