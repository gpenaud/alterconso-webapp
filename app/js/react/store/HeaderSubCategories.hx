
package react.store;

import Common;
// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.mui.CagetteTheme;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.types.*;
import mui.icon.Icon;
import mui.core.Hidden;
import css.JustifyContent;
import css.AlignContent;
import css.Properties;
//import css.Overflow;

private typedef HeaderSubCategoriesProps = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
    category:CategoryInfo,
    subcategory:Null<CategoryInfo>,
    onClick:CategoryInfo->Void,
}

private typedef TClasses = Classes<[
    subCategs,
    cagWrap,
]>

@:acceptsMoreProps
@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class HeaderSubCategories extends ReactComponentOfProps<HeaderSubCategoriesProps> {
    
    public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
            subCategs : {
                backgroundColor: CGColors.Bg3,
                padding: 5,
                textAlign: Left,
            },
            cagWrap: {
				maxWidth: 1240,
                margin : "auto",
                padding: "0 10px",
			},
		}
	}

    override function render() {
        var classes = props.classes;
        var cat = props.category;
        if(cat == null) return null;
        if(cat.subcategories == null) return null;
        if(cat.subcategories.length == 0) return null;

        var subheaderClasses = classNames({
			'${classes.subCategs}': true,
		});

        var subCategs = [
            for( sub in cat.subcategories )
                jsx('<HeaderSubCategoryButton key=${sub.id} label=${sub.name} onclick=${props.onClick.bind(sub)} active=${props.subcategory == sub}/>')
        ];
        return jsx('<Hidden xsDown>
        <div className=${subheaderClasses}>
            <div className=${classes.cagWrap}>
                ${subCategs}
            </div>
        </div>
        </Hidden>');
    }
}

