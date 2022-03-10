package react.store;

import Common;
import react.ReactComponent;
import react.ReactMacro.jsx;
import mui.core.Tooltip;
import react.mui.CagetteTheme;

class Labels extends react.ReactComponentOfProps<{product:ProductInfo}> {

    public function new(props) {
		super(props);
	}

    override public function render() {

        var style = {
            fontSize:20,
            color:CGColors.MediumGrey,
            marginRight:8
        };

        var labels = [];

        //bio
        if(props.product.organic){
            labels.push( label("bio","Agriculture biologique",style) );
        }

        //variable-weight
        if(props.product.variablePrice){
            labels.push( label("scale","Prix variable selon pesée",style) );
        }

        //bulk
        if(props.product.bulk){
            labels.push( label("bulk","Vendu en vrac : pensez à prendre un contenant",style) );
        }

        //wholesale
        if(props.product.bulk){
            labels.push( label("wholesale","Ce produit est commandé en gros",style) );
        }
        

        return labels;
    }

    function label(iconId,name,style){
        return jsx('<Tooltip key=$iconId title=$name placement=${mui.core.popper.PopperPlacement.Top}>
            ${CagetteTheme.getIcon(iconId,style)}
        </Tooltip>');
    }
}