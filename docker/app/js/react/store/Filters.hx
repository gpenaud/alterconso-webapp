package react.store;
// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.mui.CagetteTheme;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import Common;

using Lambda;

typedef FiltersProps = {
	> PublicProps,
	var classes:TClasses;
};

private typedef PublicProps = {
	var categories:Array<CategoryInfo>;
	var filters:Array<String>;
	var toggleFilter:String->Void;
}

private typedef TClasses = Classes<[]>

@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class Filters extends react.ReactComponentOfProps<FiltersProps> {
	public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
			button: {
				size: "small",
				textTransform: "none",//TODO use extern enum when available
				color: '#84BD55',
			},
		}
	}

	public function new(props) {
		super(props);
	}

	override public function render() {
		return jsx('
      <div className="filters">
        <h3>Filtres</h3>
        ${renderFilters()}
      </div>
    ');
	}

	function renderFilters() {
		return props.categories.map(function(category) {
			var classNames = ["filter"];
			if (props.filters.has(category.name))
				classNames.push("active");

			return jsx('
        <div
          className=${classNames.join(" ")}
          key=${category.id}
          onClick=${function(){
            props.toggleFilter(category.name);
          }}
        >
          ${category.name}
        </div>
      ');
		});
	}
}
