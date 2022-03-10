package react.store;
// it's just easier with this lib
import mui.core.grid.GridSpacing;
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.Color;
import mui.core.Grid;
import mui.core.TextField;
import mui.core.FormControl;
import mui.core.Fab;
import mui.icon.ArrowUpward;
import mui.core.form.FormControlVariant;
import mui.core.input.InputType;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.core.InputAdornment;
import mui.icon.AccountCircle;

import Common;

using Lambda;

typedef HeaderProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
    var isSticky:Bool;
	var submitOrder:OrderSimple->Void;
    var place:PlaceInfos;
	var orderByEndDates:Array<OrderByEndDate>;
    var paymentInfos:String;
    var date : Date;

    var onSearch:String->Void;
}

private typedef TClasses = Classes<[
    cagWrap,
    searchField,
    cagFormContainer,
    cartContainer,
    shadow,
]>
/**
    Shop header
**/
@:build(lib.lodash.Lodash.build())
@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class Header extends react.ReactComponentOfProps<HeaderProps> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
            cagWrap: {
                maxWidth: 1240,
                margin : "auto",
                padding: "0 10px",
                display: "flex",
                alignItems: Center,
                justifyContent: Center,
                backgroundColor: CGColors.White,
			},
            searchField : {
                padding: '0.5em',
            },
            cagFormContainer : {
                fontSize: "1.2rem",
                fontWeight: "bold",//TODO use enum from externs when available
                display: "flex",
                alignItems: Center,
                justifyContent: Center,
                height: 70,
            },
            cartContainer : {
                display: "flex",
                alignItems: Center,
                justifyContent: Center,
                height: 70,
            },
            shadow : {
                filter: "drop-shadow(0px 4px 2px #00000077)",
            },
		}
	}

	public function new(props) {
		super(props);
	}

    //https://css-tricks.com/debouncing-throttling-explained-examples/
    @:debounce(1000, {trailing:true})
    function search(criteria:String) {
        if( criteria.length >= 3 || criteria.length == 0 )
            props.onSearch(criteria);
    }

    function handleChange(event:js.html.Event):Void {
        var target:js.html.InputElement = cast event.target;
        var criteria:String = target.value;
        search(criteria);
    }

	override public function render() {
        var classes = props.classes;
        
        var searchIcon = CagetteTheme.getIcon("search",{color:CGColors.MediumGrey});
        var inputProps = {
            startAdornment: jsx('<InputAdornment position=${mui.core.input.InputAdornmentPosition.Start}>$searchIcon</InputAdornment>')
        };

        var headerClasses = classNames({
			'${classes.cagWrap}':true,
            //'${classes.shadow}': props.isSticky,
		});

		return jsx('
            <Grid container spacing=${GridSpacing.Spacing_2} className=${headerClasses}>
                <Grid item md={6} xs={12}> 
                    <DistributionDetails 
                        isSticky=${props.isSticky} 
                        displayLinks=${true} 
                        orderByEndDates=${props.orderByEndDates} 
                        place=${props.place} 
                        paymentInfos=${props.paymentInfos} 
                        date=${props.date}
                    />
                </Grid>
                <Grid item md={3} xs={6} className=${classes.cagFormContainer}>                  
                        <TextField                            
                            id="search-bar"
                            placeholder="Recherche"
                            variant=${Outlined}
                            type=${Search} 
                            className=${classes.searchField}
                            InputProps=${cast inputProps}
                            onChange=${handleChange}
                        />                                                                                         
                </Grid>
                <Grid item md={3} xs={6} className=${classes.cartContainer}>
                    <Cart submitOrder=${props.submitOrder} orderByEndDates=${props.orderByEndDates} place=${props.place} paymentInfos=${props.paymentInfos} date=${props.date}/>
                </Grid>
            </Grid>
        ');
    }
}


