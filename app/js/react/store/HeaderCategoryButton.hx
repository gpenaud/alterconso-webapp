package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.*;
import mui.core.form.FormControlVariant;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import Common;

using Lambda;

typedef HeaderCategoryButtonProps = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
	var isSticky:Bool;
	var category:CategoryInfo;
	var active:Bool;
	var onClick:Void->Void;
}

private typedef TClasses = Classes<[cagCategoryActive, cagCategory, img, imgFit, gridItem,]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class HeaderCategoryButton extends react.ReactComponentOfProps<HeaderCategoryButtonProps> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			cagCategoryActive: {
				backgroundColor: CGColors.Bg3,
			},
			gridItem : {
				//"@media (min-width:800px)" : {
					height: '100%',
				//}
			},
			cagCategory: {
				height: '100%',
				cursor: "pointer",
				padding: 4,
				"&:hover" : {
                    backgroundColor: CGColors.Bg3,
                },
				"& span" : {
					display: "block",
					/*"@media (max-width:800px)" : {
						display:"none",
					}*/
				}
			},
			img: {
				height: '50%',
			},
			imgFit: {
				objectFit: "contain",
				height: '100%',
			}
		}
	}

	public function new(props) {
		super(props);
	}

	override public function render() {
		var classes = props.classes;

		var categoryClasses = classNames({
			'${classes.cagCategoryActive}': props.active,
			'${classes.cagCategory}':true,
		});

		var imgClasses = classNames({
			'${classes.img}': true,
			'${classes.imgFit}': props.isSticky,
		});
		
		//if(props.active) trace("CategoryButton "+props.category.name+" active?"+props.active);

		var name = (props.isSticky) ? null : jsx('${props.category.name}');
		return jsx('
            <Grid item xs className=${classes.gridItem}>
                <div className=${categoryClasses} onClick=${props.onClick}>
					
					<img src=${props.category.image} alt=${props.category.name} className=${imgClasses} />
					
					<Hidden xsDown><span>${name}</span></Hidden>
                </div>
            </Grid>
        ');
	}
}
