package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

/**
 * A Error Div
 */
class Error extends react.ReactComponentOfProps<{error:String}>
{

	public function new(props:Dynamic) 
	{
		super(props);
	}
	
	
	override public function render(){
		
		if (props.error == null) return null;
		
		return jsx('<div className="alert alert-danger">
				<i className="icon icon-alert"></i> ${props.error}
			</div>
		');
	}

	
}