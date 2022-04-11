package react.vendor;

import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;
import mui.core.Typography;
import react.mui.CagetteTheme;
import mui.core.Avatar;
import mui.core.Button;
import mui.core.Card;
import mui.core.CardContent;
import mui.core.CardActionArea;
import mui.core.CardActions;
import mui.core.Grid;
import mui.core.GridList;
import mui.core.GridListTile;
import mui.core.GridListTileBar;
import mui.core.Link;
import mui.core.ListSubheader;
using Lambda;
import leaflet.L;
import leaflet.L.LatLngBounds;

/**
 *  Externs for react-leaflet 
 *  @doc https://react-leaflet.js.org/docs/en/intro.html
 */
@:jsRequire('react-leaflet', 'Map')  
extern class LeafMap extends ReactComponent {}
@:jsRequire('react-leaflet', 'TileLayer')  
extern class TileLayer extends ReactComponent {}
@:jsRequire('react-leaflet', 'Marker')  
extern class Marker extends ReactComponent {}
@:jsRequire('react-leaflet', 'Popup')  
extern class Popup extends ReactComponent {}

typedef MarkerInfo = {
	var key: String;
	var latitude: Float;
	var longitude: Float;
	var content: String;	
}

class SimpleMap extends react.ReactComponentOfProps<{markers: Array<MarkerInfo>}> {

	var markerIcon = L.icon({
		iconUrl: '/img/marker.svg',
		iconSize: [40, 40],
		iconAnchor: [20, 40],
		popupAnchor: [0, -30],
		className: 'icon'
	});

	function getLatLngBounds() {
		return Lambda.array(Lambda.map(props.markers,function(marker) return [marker.latitude, marker.longitude]));
	}

	public function new(){
		super(props);
	}
	
	override public function render(){

		return jsx('
			<LeafMap bounds=${getLatLngBounds()}>	
					<TileLayer
					attribution="&amp;copy <a href=&quot;http://osm.org/copyright&quot;>OpenStreetMap</a> contributors"
					url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
					id="bubar.cih3inmqd00tjuxm7oc2532l0"
					/>
					${props.markers.map(function(marker:MarkerInfo) {
						return jsx('
							<Marker key=${marker.key} position=${[marker.latitude, marker.longitude]} icon=${markerIcon}>
								<Popup className="popup">
									<div>
										<div className="groupName">${marker.content}</div>
									</div>
								</Popup>
							</Marker>
						');
					})}
			</LeafMap>			
		');

	}

}