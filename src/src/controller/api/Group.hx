package controller.api;
import haxe.Json;
import Common;
import service.Mapbox;

/**
 * Groups API
 * @author fbarbut
 */
class Group extends Controller
{
	/**
	 * 
	 */
	 public function doDefault(group:db.Group) {
		switch (sugoi.Web.getMethod()) {
			case "POST":
				if (!app.user.isAmapManager()) throw Error("/", t._("Access forbidden"));

				var request = sugoi.tools.Utils.getMultipart(1024 * 1024 * 12); //12Mb
				
				// IMAGE
				if (request.exists("file")) {
					var image = request.get("file");

					if (image != null && image.length > 0) {
						var img = sugoi.db.File.createFromDataUrl(request.get("file"), request.get("filename"));
						group.lock();
						if (group.image != null) {
							//efface ancienne
							group.image.lock();
							group.image.delete();
						}				
						group.image = img;
						group.update();
					}
				}
				Sys.print(haxe.Json.stringify(group.infos()));
			default: Sys.print(haxe.Json.stringify({}));
		}
	}	


	/**
	 * JSON map datas
	 * 
	 * Request by zone : http://localhost/api/group/map?minLat=42.8115217450979&maxLat=51.04139389812637=&minLng=-18.369140624999996&maxLng=23.13720703125
	 * Request by location : http://localhost/api/group/map?lat=48.85&lng=2.32
	 * Request by address : http://localhost/api/group/map?address=105%20avenue%20d%27ivry%20Paris
	 */
	public function doMap(args:{?minLat:Float, ?maxLat:Float, ?minLng:Float, ?maxLng:Float, ?lat:Float, ?lng:Float, ?address:String}) {
	
		var out  = new Array<GroupOnMap>();
		var places  =  new List<db.Place>();
		if (args.minLat != null && args.maxLat != null && args.minLng != null && args.maxLng != null){

			if(args.maxLat-args.minLat > 1) {
				//zone is too large
			}else if(args.maxLng-args.minLng > 2) {
				//zone is too large
			}else{
				//Request by zone
				#if plugins
				var sql = "select p.* from Place p, Hosting h where h.id=p.groupId and h.visible=1 and ";
				sql += 'p.lat > ${args.minLat} and p.lat < ${args.maxLat} and p.lng > ${args.minLng} and p.lng < ${args.maxLng} LIMIT 200';			
				#else
				var sql = "select p.* from Place p where ";
				sql += 'p.lat > ${args.minLat} and p.lat < ${args.maxLat} and p.lng > ${args.minLng} and p.lng < ${args.maxLng} LIMIT 200';
				#end
				places = db.Place.manager.unsafeObjects(sql, false);
			}
			
			
			
		}else if (args.lat!=null && args.lng!=null){
			
			//Request by location
			places = findGroupByDist(args.lat, args.lng);
			
		}else{
			//Request by address
			if (args.address == null) throw "Please provide parameters";
			var res = Mapbox.geocode(args.address);
			places = findGroupByDist(res.geometry.coordinates[1], res.geometry.coordinates[0]);
			
			// var geocode = new sugoi.apis.google.GeoCode(App.config.get("google_geocoding_key"));
			// var loc = geocode.geocode(args.address)[0].geometry.location;
			// args.lat = loc.lat;
			// args.lng = loc.lng;
			// places = findGroupByDist(args.lat, args.lng);
		}
		
		for ( p in places){
			out.push({
				id : p.group.id,
				name : p.group.name,
				image : p.group.image==null ? null : view.file(p.group.image),
				place : p.getInfos()
			});
		}

		Sys.print(haxe.Json.stringify({success:true,groups:out}));
	}
	
	/**
	 * ~~ Pythagore rulez ~~
	 */
	function findGroupByDist(lat:Float, lng:Float,?limit=10){
		#if plugins
		var sql = 'select p.*,SQRT( POW(p.lat-$lat,2) + POW(p.lng-$lng,2) ) as dist from Place p, Hosting h ';
		sql += "where h.id=p.groupId and h.visible=1 and p.lat is not null ";		
		sql += 'order by dist asc LIMIT $limit';
		#else
		var sql = 'select p.*,SQRT( POW(p.lat-$lat,2) + POW(p.lng-$lng,2) ) as dist from Place p ';
		sql += "where p.lat is not null ";
		sql += 'order by dist asc LIMIT $limit';
		#end
		return db.Place.manager.unsafeObjects(sql, false);
	}
}