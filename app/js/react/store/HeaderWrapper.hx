package react.store;
// it's just easier with this lib
import js.html.ScrollBehavior;
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
import mui.core.Hidden;
import mui.core.InputAdornment;

import Common;

using Lambda;

typedef HeaderWrapperProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
	var submitOrder:OrderSimple->Void;
    var place:PlaceInfos;
	var orderByEndDates:Array<OrderByEndDate>;
    var paymentInfos:String;
    var date : Date;

    var categories:Array<CategoryInfo>;
	var resetFilter:Void->Void;
	var filterByCategory:Int->Void;
	var filterBySubCategory:Int->Int->Void;
	var toggleFilterTag:String->Void;

    var onSearch:String->Void;

    var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
}

private typedef TClasses = Classes<[
    fab,
]>

private typedef HeaderWrapperPropsState = {
    var isSticky:Bool;
}

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class HeaderWrapper extends react.ReactComponentOf<HeaderWrapperProps, HeaderWrapperPropsState> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
            fab: {
                position: Absolute,
                top: "calc(100vh - 80px)",
                right: theme.spacing.unit * 2,
            },
        }
	}

	public function new(props) {
		super(props);
        this.state = {isSticky:false};
	}

    override function componentDidMount() {
        var stickyEvents = new sticky.StickyEvents({stickySelector:'.sticky', enabled:true});
        for( e in stickyEvents.stickyElements ) {
            e.addEventListener(sticky.StickyEvents.StickyEvent.CHANGE, function(e) {
                //trace("We have an element changing sticky status");
                //trace(e.target);

                //need to delay this, otherwise it causes flickering in some cases
                haxe.Timer.delay(function(){
                    setState({isSticky: e.detail.isSticky});                    
                },200);
            });
        }
    }

    function renderFab() {
        if (state.isSticky == false) return null;

        var classes = props.classes;
        return jsx('
            <Fab className=${classes.fab} color={Primary} onClick=${resetScroll}>
               <ArrowUpward />
            </Fab>
        ');
    }

    function resetScroll() {
        
        js.Browser.window.scrollTo({ top: 0, behavior: ScrollBehavior.SMOOTH });
    }

	override public function render() {
        var classes = props.classes;
        
		return jsx('
            <div className="sticky">
                <Header isSticky=${state.isSticky} 
                        submitOrder=${props.submitOrder} 
                        orderByEndDates=${props.orderByEndDates} 
                        place=${props.place} 
                        paymentInfos=${props.paymentInfos} 
                        date=${props.date}
                        onSearch=${props.onSearch}
                        />
					
                <HeaderCategories 
                    isSticky=${state.isSticky} 
                    categories=${props.categories}
                    resetFilter=${props.resetFilter}
                    filterByCategory=${props.filterByCategory}
                    filterBySubCategory=${props.filterBySubCategory}
                    toggleFilterTag=${props.toggleFilterTag}
                    nav=${props.nav}
                />

                ${renderFab()}
            </div>
        ');
    }

}


