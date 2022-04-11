package react.map;
import js.Promise;
import react.ReactComponent;
import react.ReactMacro.jsx;
import utils.HttpUtil;
import leaflet.L;
import neo.GeoAutocomplete;
import react.mui.Box;
import Common;
using Lambda;

@:jsRequire('react-places-autocomplete', 'default')  
extern class Autocomplete extends ReactComponent {}

@:jsRequire('react-places-autocomplete')
extern class GeoUtil {
	static function geocodeByAddress(address:Dynamic):Promise<Dynamic>;
}

@:jsRequire('geolib')  
extern class Geolib {
  static function getDistance(start:Dynamic, end:Dynamic):Float;
}

/**
 * Groups Map
 * @author rcrestey
 */

typedef GroupMapRootState = {
	var point:Dynamic;
	var address:String;
	var groups:Array<GroupOnMap>;
	var groupFocusedId:Int;
	var isInit:Bool;
};

typedef GroupMapRootProps = {
	var lat:Float;
	var lng:Float;
	var address:String;
};

class GroupMapRoot extends ReactComponentOf<GroupMapRootProps, GroupMapRootState>{

	static inline var GROUP_MAP_URL = '/api/group/map';

	var distanceMap = new Map<Int,Dynamic>();

	public function new(props) 
	{
		super(props);

		state = { 
			point: L.latLng(props.lat, props.lng),
			address: props.address,
			groups: [],
			groupFocusedId: null,
			isInit: false
		};
	}

	function onChange(address) {
		setState({
			address: address
		});
	}

	function openPopup(group:Dynamic) {
		setState({
			groupFocusedId: group.place.id
		});
	}

	function closePopup() {
		setState({
			groupFocusedId: null
		});
	}

	function geocodeByAddress(address:String):Promise<Dynamic> {
		return GeoUtil.geocodeByAddress(address)
		.then(function(results) {
			var lat = results[0].geometry.location.lat();
			var lng = results[0].geometry.location.lng();

			return {lat: lat, lng: lng};
		});
	}

	/**
	 *  Call API to find groups at $lat and $lng
	 *  @param lat - 
	 *  @param lng - 
	 */
	function fetchGroups(lat:Float, lng:Float) {
		HttpUtil.fetch(GROUP_MAP_URL, GET, {lat: lat, lng: lng}, JSON)
		.then(function(results) {
			setState({
				point: L.latLng(lat, lng),
				groups: results.groups,
				isInit: true
			}, fillDistanceMap);
		})
		.catchError(function(error) {
			trace('Error', error);
		});
	}

	/**
	 *  Call API to look for groups in the defined bounding box
	 */
	var wait : Bool;
	function fetchGroupsInsideBox(newBox) {
		
		switch(wait){
			case null,false : wait = true;
			case true : trace("stop"); return;
		}
		
		HttpUtil.fetch(GROUP_MAP_URL, GET, newBox, JSON)
		.then(function(results) {
			wait = false;
			setState({
				groups: results.groups
			}, fillDistanceMap);
		});
		/*.catchError(function(error) {
			trace('Error', error + " stack:"+haxe.CallStack.toString(haxe.CallStack.exceptionStack())) ;
			wait = false;
		});*/
  	}

	function getGroupDistance(group:GroupOnMap):Float {
			
		if(state.point ==null || group==null || group.place==null || group.place.latitude==null || group.place.longitude==null ){
			return null;
		}
		
		var start = {
			latitude: state.point.lat,
			longitude: state.point.lng
		};
		var end = {
			latitude: group.place.latitude,
			longitude: group.place.longitude
		};

		return Geolib.getDistance(start, end);
	}

	function fillDistanceMap() {
		for (group in state.groups) {
			distanceMap.set(group.place.id, getGroupDistance(group));
		}

		orderGroupsByDistance(state.groups);

		setState({
			groups: state.groups
		});
	}

	function orderGroupsByDistance(groups:Array<GroupOnMap>) {
		groups.sort(function(a, b) {
			return distanceMap.get(a.place.id) - distanceMap.get(b.place.id);
		});
	}

	function convertDistance(distance:Int):String { // to test
		if (distance > 10000)
			return Math.floor(distance / 1000) + ' km';
		if (distance > 1000)
			return Math.floor(distance / 100) / 10 + ' km';
		return distance + ' m';
    }
    
    function onAutocompleteChange(v: Dynamic) {
        trace("onAutocompleteChange", v);
        if (v != null) {
            var coord = v.geometry.coordinates;
            trace("coord", coord);
            fetchGroups(coord[1], coord[0]);
        }
    }

	override public function componentDidMount() {
        trace("componentDidMount", state.point, state.address);
		if (state.point != null)
			fetchGroups(state.point.lat, state.point.lng);
		// else if (state.address != '')
			// handleSelect(state.address);
	}


	override public function render() {
		return jsx('
			<div className="group-map">
				<div className="row">
                    <div id="logo" className="col-md-3">&nbsp;</div>
					<div className="col-md-9">
						<div className="form-group-container">
                        <Box width="50%" bgcolor="#fff" boxShadow={1}>
                            <GeoAutocomplete
                                initialValue={props.address}
                                label="Trouvez un groupe Cagette près de chez vous"
                                noOptionsText="Saisissez votre adresse"
                                mapboxToken="pk.eyJ1IjoiYnViYXIiLCJhIjoiY2loM2lubmZpMDBwcGtxbHlwdmw0bXRkbCJ9.rfgXPakoGnXZ3wIGA3-1kQ"
                                onChange=$onAutocompleteChange />
                        </Box>
						</div>
					</div>
      			</div>
				<div className="row">
					<div className="col-md-3" id="groupsContainer">${renderGroupList()}</div> 
					<div className="col-md-9" id="mapContainer">${renderGroupMap()}</div> 
				</div>
      		</div>');
	}

	function renderGroupMap() {
		if (!state.isInit)
            return null;
		
		return jsx('
			<GroupMap
				addressCoord=${state.point}
				groups=${state.groups}
				fetchGroupsInsideBox=${fetchGroupsInsideBox}
				groupFocusedId=${state.groupFocusedId}
			/>
		');
	}

	function renderGroupList() {
		var groups = state.groups.map(function(group) {
			return renderGroup(group);
		});

		return jsx('
			<div className="groups">
				${groups}
			</div>
		');
	}

	/**
	 * Renders a group in the left list
	 */
	function renderGroup(group:GroupOnMap) {
		var address = [
			group.place.address1,
			group.place.address2,
			[group.place.zipCode, group.place.city].join(" "),
		];

		var addressBlock = Lambda.array(address.mapi(function(index, element) {
			if (element != null){
				return jsx('<div key=${index}>$element</div>');				
			}else{
				return null;
			}
		}));

		var distance = null;
		if (distanceMap.get(group.place.id) != null)
			distance = jsx('<div className="distance">${convertDistance(distanceMap.get(group.place.id))}</div>');

		var classNames = ['clickable groupBlock'];
		if (group.place.id == state.groupFocusedId)
			classNames.push('focused');

		var img = if(group.image==null) {
			null;
		}else{
			jsx('<img src=${group.image} className="img-responsive" />');
		} 

		return jsx('<a target="_blank"
			onMouseEnter=${function() { openPopup(group); }}
			onMouseLeave=${closePopup}
			className=${classNames.join(' ')}
			key=${group.place.id}
			href=${"/group/"+group.id}
			>
				$img					
				<h4>${group.name}</h4>
				<div className="address">${addressBlock}</div>
				${distance}
			</a>');
	}
}
