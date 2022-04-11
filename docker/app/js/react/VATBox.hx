package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

// I need to store also the "input" because of https://stackoverflow.com/questions/29140354/how-to-handle-decimal-values-in-reacts-onchange-event-for-input
typedef VATBoxState = {ht:Float, ttc:Float, vat:Float, htInput:String, ttcInput:String,lastEdited:String};


/**
 * A box to manage prices with and without VAT
 * @author fbarbut
 */
class VATBox extends react.ReactComponentOfPropsAndState<{ttc:Float,currency:String,vatRates:String,vat:Float,formName:String},VATBoxState>
{

	public function new(props) 
	{
		super(props);
		//trace(props);
		
		this.state = {
			ht : round(props.ttc/(1+props.vat/100)),
			htInput : Std.string(round(props.ttc/(1+props.vat/100))),
			ttc : round(props.ttc),
			ttcInput : Std.string(round(props.ttc)),
			vat:props.vat,
			lastEdited:null
		};
		

	}
	
	override public function render(){
		
		var rates :Array<Float>= props.vatRates.split("|").map(Std.parseFloat);
		
		var options = [for (r in rates) jsx('<option key=$r value=$r>$r %</option>')  ];
		var priceInputName = props.formName+"_price";
		var vatInputName = props.formName+"_vat";
		
		return jsx('<div>
				
				<div className="row">
					<div className="col-md-4 text-center"> Hors taxe </div>
					<div className="col-md-4 text-center"> Taux de TVA </div>
					<div className="col-md-4 text-center"> TTC </div>
				</div>
				
				<div className="row">
					<div className="col-md-4">
						<div className="input-group">
							<input type="text" name="htInput" value=${state.htInput} className="form-control" onChange=$onChange/>
							<div className="input-group-addon">${props.currency}</div>
						</div>
					</div>
				
					<div className="col-md-4">
						<select name="vat" className="form-control" onChange={onChange} defaultValue=${state.vat}>							
							${options}
						</select>
					</div>
					
					<div className="col-md-4">
						<div className="input-group">
							<input type="text" name="ttcInput" value=${state.ttcInput} className="form-control" onChange=$onChange/>
							<div className="input-group-addon">${props.currency}</div>
						</div>
					</div>
				</div>
				
				<input type="hidden" name=$priceInputName 	value=${state.ttc} />
				<input type="hidden" name=$vatInputName 	value=${state.vat} />
		
			</div>
		');
	}
	

	/**
	 * Recompute prices 
	 */
	function onChange(e:js.html.Event){
		
		e.preventDefault();
		var name :String = untyped e.target.name;
		var input : String = Std.string(untyped e.target.value);
		if (input == null || input == "") input = "0";
		input = StringTools.replace(input, ",", ".");
		var value : Float = Std.parseFloat(input);
		if (value == null) value = 0;
		
		var rate = 1 + (state.vat / 100);
		//trace('name:$name - raw:' + untyped e.target.value+' - input:$input - value:$value ');
		
		switch(name){
		case "htInput":
			
			this.setState(cast {ht:value , htInput:input , ttc: round(value * rate), ttcInput:round(value * rate) , lastEdited:"htInput"});	
			
		case "ttcInput":
			this.setState(cast {ht: round(value / rate), htInput : round(value/rate), ttcInput:input  , ttc:value , lastEdited:"ttcInput"});	
			
		case "vat":
			rate = 1 + (value / 100);
			if (state.lastEdited == "htInput"){
				//compute ttc from ht
				this.setState(cast { vat:value, ht:state.ht, htInput:state.ht, ttc:round(state.ht * rate) , ttcInput:round(state.ht * rate)} );	
			}else{
				//compute ht from ttc
				this.setState(cast { vat:value, ht: round( state.ttc/rate ), htInput: round( state.ttc/rate ), ttc:state.ttc , ttcInput:state.ttc} );	
			}
		default:
			
		}
		
		
	}
	
	function round(f:Float):Float{
		return Math.round(f * 100) / 100;
	}

	
}