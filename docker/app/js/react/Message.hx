package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

/**
 * A message Div
 */
class Message extends react.ReactComponentOfProps<{message:String}>
{

	public function new(props:Dynamic) 
	{
		super(props);
	}
	
	override public function render(){
		
		if (props.message == null) return null;
		
		return jsx('<div className="alert alert-warning">
				<i className="icon icon-alert"></i> ${props.message}
			</div>
		');
	}
}