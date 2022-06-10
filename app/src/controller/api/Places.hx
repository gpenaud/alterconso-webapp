package controller.api;

import haxe.Json;

class Places extends Controller {
  private var place: db.Place;

  public function new(place: db.Place) {
    super();
    this.place = place;
  }

  public function doDefault() {
    if (sugoi.Web.getMethod() != "GET") throw new tink.core.Error(405, "Method Not Allowed");
    jsonify({
      name: this.place.name,
      address1: this.place.address1,
      address2: this.place.address2,
      city: this.place.city,
      zipCode: this.place.zipCode,
      lat: this.place.lat,
      lng: this.place.lng,
    });
  }

  /**
   * 
   */
   private function jsonify(o: Dynamic) {
    Sys.print(Json.stringify(o));
   }
}