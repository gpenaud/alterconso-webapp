package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

//datepicker broken if called like this //import react.DateTimeField.*;
//@:jsRequire('react-bootstrap-datetimepicker')
//extern class DateTimeField extends react.ReactComponent {}


/**
 * @doc https://github.com/YouCanBookMe/react-datetime
 */
@:jsRequire('react-datetime')
extern class DateTime extends react.ReactComponent {}




/**
 * ...
 * @author fbarbut
 */
class ReportHeader extends react.ReactComponentOfState<OrdersReportOptions>
{

	public function new() 
	{
		super();
		state = {startDate:null, endDate:null, groupBy:null, contracts:[]};
		
		//load fr locale of moment.js
		var moment = js.Lib.require('moment');
		js.Lib.require('moment/locale/fr');
		
	}
	
	override public function render(){
		
		return jsx('<div className="reportHeader">
			<div className="col-md-3">
				<div  className="input-group">
					<span className="input-group-addon">
						<span className="glyphicon glyphicon-calendar"></span>
					</span>
					<DateTime name="startDate_PROUT" onChange={onDateChange} locale="fr" dateFormat="LLLL" />
				</div>
				
			</div>
			
			<div className="col-md-3">
				<DateTime name="endDate" onChange={onDateChange} inputFormat="YYYY-MM-DD HH:mm:ss" />			
			</div>
			
			<div className="col-md-3">
				<select className="form-control" onChange={onGroupByChange}>
					<option value="ByMember">Par adhérent</option>
					<option value="ByProduct">Par Produit</option>
				</select>
			</div>			
			<div className="col-md-3">
				<a className="btn btn-primary">Afficher</a>
			</div>					
		</div>');
		
	}
	
	function onDateChange(e:js.html.Event){
		trace("onDateChange");
		//var name :String = untyped e.target.name;
		//var value :String = untyped e.target.value;
		//trace('$name $value');
		trace(e);
		//e.preventDefault();
	}
	
	/**
	 * @doc https://facebook.github.io/react/docs/forms.html
	 */
	function onGroupByChange(e:js.html.Event){
		e.preventDefault();
		trace("onGRoupByChange");
		var name :String = untyped e.target.name;
		var value :String = untyped e.target.value;
		if (value == "ByMember"){
			state.groupBy = ByMember;
		}else{
			state.groupBy = ByProduct;
		}
		trace(state);
		setState(state);
	}

}