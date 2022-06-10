package react;

import api.react.ReactMacro.jsx;
import js.html.InputElement;
import Common;

typedef ComposerAppState = {
	products:Array<{id:Int,name:String,qt:Float,unit:UnitType}>
}

typedef ComposerAppRefs = {
	pi:ProductInput,
	productContainer:js.html.DivElement,
	qt:InputElement,
	unit:js.html.SelectElement,
}

/**
 * Composite product composer
 * 
 */
class ComposerApp extends ReactComponentOfStateAndRefs<ComposerAppState, ComposerAppRefs>
{
	/*var products:Array<{id:Int,name:String,?qt:Float,?unit:UnitType}>;
	
	
	public function new(props:Dynamic) 
	{
		
		super(props);
		products =  [{id:1,name:"pipo"},{id:2,name:"Loclac"}];
	}
	
	override public function render(){
		return jsx('
			<div className="ComposerApp" style={{margin:"10px"}} >
			
				<div className="form-inline">					
					
					<ProductInput ref="pi"/>
					
					<input ref="qt" onChange="$onChange"  className="form-control" type="text" name="qt" placeholder="Quantité" />
					
					<select ref="unit" className="form-control" name="unit">
						${getUnits()}
					</select>
					
					<a className="btn btn-primary" onClick=$addItem>
						<span className="glyphicon glyphicon-plus"></span> Ajouter
					</a>
						
					
				</div>
				
				<div className="container" ref="productContainer">
					${createChildren()}
				</div>
				
			</div>
		');
		
	}
	
	function onChange(){
		
	}
	
	function getUnits(){
		var out = [];
		for ( c in Unit.createAll()){
			
			out.push(jsx( '<option value="{c.getIndex()}"> {Std.string(c)} </option>'));
			
		}
		
		return out;
	}
	
	function createChildren() 
	{
		
		
		return [for (p in products) jsx('<ProductComp key={p.id} name={p.name} qt={p.qt} unit={p.unit}/>')];
	}
	
	function addItem(){
		var text :String = refs.pi.refs.input.value;
		if (text.length > 0) 
		{
			trace("add " + text);
			trace("qt " + this.refs.qt.value);
			trace("unit " + this.refs.unit.selectedIndex);
			
			var qt = Std.parseFloat(this.refs.qt.value);
			var unit = UnitType.createByIndex(this.refs.unit.selectedIndex);
			var id = Std.random(999);
			products.push( {id:id, name:text,qt:qt,unit:unit});
			
			setState({products:[{id:id,name:text, qt:qt, unit:unit}]});
			//this.forceUpdate();
		}
	}*/
	
}