package service;

import service.Mapbox;

class PlaceService{

	/**
	 *  Geocode a place with MapBox Geocode API
	 */
	public static function geocode(p:db.Place):{lat:Float,lng:Float}{
		// var apiKey = App.config.get("google_geocoding_key");
		// if(apiKey==null) return null;

		// var gc = new sugoi.apis.google.GeoCode(apiKey);			
		var address = p.getAddress();
		var res = Mapbox.geocode(address);
		//var comp = "administrative_area:" + p.city + "|postal_code:" + p.zipCode + "|country:FR";
		//Sys.print(address+"<br/>"+comp+"<br/>");
				
		// var geo = gc.geocode( address , null);	
		// var coords = geo[0].geometry.location;
		
		p.lock();
		p.lat = res.geometry.coordinates[1];
		p.lng = res.geometry.coordinates[0];
		p.update();

		return {lat:p.lat,lng:p.lng};

	}

}