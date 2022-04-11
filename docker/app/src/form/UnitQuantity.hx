package form;
import Common;
/**
 * ...
 * @author fbarbut
 */
class UnitQuantity extends sugoi.form.elements.FloatInput
{

	var unit : Unit;
	
	public function new(name, label, value, ?required=false,unit){
		super(name, label, value, required);
		this.unit = unit;
	}
	
	override function render(){
		
		var r = super.render();
		return '
			<div class="input-group">
				'+r+'
				<div class="input-group-addon">'+Formatting.unit(unit)+'</div>
			</div>';
	}
	
}