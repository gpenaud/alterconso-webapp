
package react.store;

// it's just easier with this lib
import classnames.ClassNames.fastNull as classNames;
import react.mui.CagetteTheme;
import mui.core.styles.Classes;
import mui.core.styles.Styles;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.types.*;
import mui.core.Button;
import css.JustifyContent;
import css.AlignContent;
import mui.core.Grid;

private typedef Props = {
	> PublicProps,
	var classes:TClasses;
}

private typedef PublicProps = {
    var onChange:Int->Void;
    var value:Int;
}

private typedef TClasses = Classes<[
    quantityInput,
]>


@:acceptsMoreProps
@:publicProps(PublicProps)
@:wrap(Styles.withStyles(styles))
class QuantityInput extends ReactComponentOfProps<Props> {
    
    public static function styles(theme:Theme):ClassesDef<TClasses> {
		return {
            quantityInput : {
                border: '1px solid ${CGColors.Primary}',
                borderRadius: 3,
                display: "flex",
                maxWidth: 104,
                "& div" : {
                    flexGrow: 1,
                },
                "& .quantityMoreLess" : {
                    backgroundColor : CGColors.Primary,
                    padding: 8,
                    color : "#ffffff",
                    fontSize: "2rem",
                    lineHeight: "1rem",
                    cursor: "pointer",
                    textAlign: Center,
                    transition: "all 0.5s ease",
                    "&:hover" : {
                        backgroundColor:CGColors.Primary //untyped color(CGColors.Second).darken(10).hexString(),            
                    },
                },
                "& .quantity" : {
                    fontSize: "1.2rem",
                    lineHeight: "2rem",
                    textAlign: Center,
                    verticalAlign: "middle",
                    color: CGColors.Primary,
                    backgroundColor: "#fff",
                },
            },
		}
	}

    public function new(props) {
        super(props);
    }

    function updateValue(delta:Int) {
        var v = props.value + delta;
        if( v + delta < 0 ) v = 0;
        props.onChange(v);
    }

    override function render() {
        var classes = props.classes;
        return jsx('
            <Grid className=${classes.quantityInput} container={true} direction=${Row}>
                <Grid item={true} xs={4} className="quantityMoreLess noSelect">
                    <div onClick=${updateValue.bind(-1)}>-</div>
                </Grid>
                <Grid item={true} xs={4} className="quantity">
                    <div> ${props.value} </div>
                </Grid>
                <Grid item={true} xs={4} className="quantityMoreLess noSelect">
                    <div onClick=${updateValue.bind(1)}>+</div>
                </Grid>
            </Grid>

        ');
    }
}

