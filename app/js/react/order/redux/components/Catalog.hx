package react.order.redux.components;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common.ContractInfo;

/**
 * A Catalog
 * @author web-wizard
 */
class Catalog extends react.ReactComponentOfProps<{ catalog : ContractInfo }>
{

	public function new(props) 
	{
		super(props);	
	}

	override public function render() {

		var imgStyle = { width: '64px', height:'64px', 'backgroundImage': 'url("${props.catalog.image}")' };
		
		return jsx('<div className="catalog row">
						<div className="col-md-4">
							<div src="${props.catalog.image}" className="productImg" style=$imgStyle/>
						</div>
						<div className="col-md-8">
							<strong>${props.catalog.name}</strong><br/>							
						</div>
					</div>');
	}

}	