package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;
import mui.core.Collapse;
import react.mui.CagetteTheme;
import mui.core.Button;
import mui.core.button.ButtonSize;


class ExpandableText extends react.ReactComponentOfPropsAndState<{text:String,height:Float},{open:Bool}>
{

	public function new(props:Dynamic) 
	{
		super(props);
        state = {open:false};
	}
	
	
	override public function render(){
		
        var height = props.height+"px";
        var text = props.text==null ? "" : props.text;

        //don't need expandable block
        if(text.length<1800) return jsx('<span dangerouslySetInnerHTML=${{__html: text}}></span>');
		
		return jsx('<>
        <Collapse in=${state.open} collapsedHeight=$height>
            <span dangerouslySetInnerHTML=${{__html: text}}></span>            
        </Collapse>
        <div style=${{width:"100%",textAlign:css.AlignContent.Center,borderTop:"3px solid "+CGColors.LightGrey}}>
            <Button onClick=$toggle size=$Small style=${{color:CGColors.MediumGrey}}>
                ${state.open ? CagetteTheme.getIcon("chevron-up") : CagetteTheme.getIcon("chevron-down")}
                &nbsp;
                ${state.open ? "Refermer" : "Lire plus"}
            </Button>            
        </div>
        </>');
	}

    function toggle(){
        setState({open:!state.open});
    }

	
}

