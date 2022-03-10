package react.store;
// it's just easier with this lib
import mui.core.grid.GridSpacing;
import js.html.ScrollBehavior;
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.Grid;
import mui.core.TextField;
import mui.core.FormControl;
import mui.core.form.FormControlVariant;
// import mui.core.input.InputType;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import mui.core.Hidden;

import Common;

using Lambda;

typedef HeaderCategoriesProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
    var isSticky:Bool;
    var categories:Array<CategoryInfo>;
    var nav:{category:Null<CategoryInfo>, subcategory:Null<CategoryInfo>};
	var resetFilter:Void->Void;
	var filterByCategory:Int->Void;
	var filterBySubCategory:Int->Int->Void;
	var toggleFilterTag:String->Void;
}

private typedef TClasses = Classes<[
    cagNavHeaderCategories,
    cagCategoryActive,
    cagWrap,
    shadow,
    cagSticky, 
    cagGridHeight, cagGridHeightSticky, cagGrid,
]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class HeaderCategories extends react.ReactComponentOfProps<HeaderCategoriesProps> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
            cagWrap: {
				maxWidth: 1240,
                margin : "auto",
                padding: "0 10px",
			},
            cagNavHeaderCategories : {
                backgroundColor: CGColors.Bg2,
                textAlign: Center,
                textTransform: UpperCase,
                fontSize: "0.7rem",
                lineHeight: "0.9rem", 
            },
            cagSticky : {
                maxWidth: 1240,
                margin : "auto",
            },
            cagCategoryActive : {
                backgroundColor: CGColors.Bg3,
            },
            shadow : {
                //filter: "drop-shadow(0px 4px 1px #00000055)",
                filter: "drop-shadow(0px 4px 0px #00000022)",
            },
            cagGrid: {
                
            },
            cagGridHeight: {
                height: "9em", 
            },
            cagGridHeightSticky: {
                height: "5em",
            },
        }
    }

    public function new(props) {
		super(props);
	}
    
    function onSubCategoryClicked(subcategory:CategoryInfo) {
        js.Browser.window.scrollTo({ top: 0, behavior: ScrollBehavior.SMOOTH });
        props.filterBySubCategory(props.nav.category.id, subcategory.id);
    }

    function onCategoryClicked(category:CategoryInfo) {
        js.Browser.window.scrollTo({ top: 0, behavior: ScrollBehavior.SMOOTH });
        props.filterByCategory(category.id);

        // pour le bio et le label rouge..
        // Attention : vérifier l'implémentation du filtre qui n'a pas du être faite !
        //toggleFilterTag=${props.toggleFilterTag}
    }

	override public function render() {
        var classes = props.classes;
        var headerClasses = classNames({
			'${classes.cagNavHeaderCategories}': true,
            '${classes.cagSticky}': props.isSticky,
            '${classes.shadow}': props.isSticky,
		});

        var categoryGridClasses = classNames({
            '${classes.cagGrid}': true,
            '${classes.cagGridHeight}': !props.isSticky,
            '${classes.cagGridHeightSticky}': props.isSticky,
        });

        var categories = [
            for(category in props.categories)
                jsx('<HeaderCategoryButton
                        key=${category.id} 
                        isSticky=${props.isSticky}
                        active=${category == props.nav.category}
                        category=${category} 
                        onClick=${onCategoryClicked.bind(category)}
                />')
        ];
        
        return jsx('
        <Hidden xsDown>
            <div className=${headerClasses}>
                <div className=${classes.cagWrap}>
                    <Grid container spacing=${GridSpacing.Spacing_0} className=${categoryGridClasses}>
                        ${categories}
                    </Grid>
                    <HeaderSubCategories category=${props.nav.category} subcategory=${props.nav.subcategory} onClick=${onSubCategoryClicked} />                    
                </div>
            </div>
        </Hidden>
        ');
    }
}
