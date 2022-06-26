package controller;
import sugoi.form.Form;
import sugoi.tools.Utils;


class Vendor extends Controller
{

	public function new()
	{
		super();
		
		if (!app.user.isContractManager()) throw t._("Forbidden access");
		
	}
	
	/*@logged
	@tpl('vendor/default.mtt')
	function doDefault() {
		var browse:Int->Int->List<Dynamic>;
		
		//default display
		browse = function(index:Int, limit:Int) {
			return db.Vendor.manager.search($id > index && $amap==app.user.getGroup(), { limit:limit, orderBy:-id }, false);
		}
		
		var count = db.Vendor.manager.count($amap==app.user.getGroup());
		var rb = new sugoi.tools.ResultsBrowser(count, 10, browse);
		view.vendors = rb;
	}*/
	
	
	/*@tpl("vendor/view.mtt")
	function doView(vendor:db.Vendor) {
		view.vendor = vendor;
	}*/
	
	@tpl('form.mtt')
	function doEdit(vendor:db.Vendor) {
		
		/*if(vendor.getGroups().length>1){
			throw Error("/contractAdmin",t._("You can't edit this vendor profile because he's active in more than one group. If you want him to update his profile, please ask him to do so."));
		} */

		if(vendor.email!=null && vendor.email.indexOf("@leportail.org")>-1) throw Error("/contractAdmin","Il est impossible de modifier ce producteur");

		#if plugins
		if(pro.db.CagettePro.getFromVendor(vendor)!=null) throw Error("/contractAdmin","Vous ne pouvez pas modifier la fiche de ce producteur, car il gère lui même sa fiche depuis Cagette Pro");
		#end

		var form = form.CagetteForm.fromSpod(vendor);
		form.removeElementByName("country");
		form.addElement(new sugoi.form.elements.StringSelect('country',t._("Country"),db.Place.getCountries(),vendor.country,true));
		
		if (form.isValid()) {
			form.toSpod(vendor);
			vendor.update();
			throw Ok('/contractAdmin', t._("This supplier has been updated"));
		}
		
		view.form = form;
	}
	
	@tpl('vendor/addimage.mtt')
	function doAddImage(vendor:db.Vendor) {
		
		/*if(vendor.getGroups().length>1){
			throw Error("/contractAdmin",t._("You can't edit this vendor profile because he's active in more than one group. If you want him to update his profile, please ask him to do so."));
		} */

		if(vendor.email != null && vendor.email.indexOf("@leportail.org")>-1) throw Error("/contractAdmin","Il est impossible de modifier ce producteur");

		#if plugins
		if(pro.db.CagettePro.getFromVendor(vendor)!=null) throw Error("/contractAdmin","Vous ne pouvez pas modifier la fiche de ce producteur, car il gère lui même sa fiche depuis Cagette Pro");
		#end

		view.vendor = vendor;
		view.image = vendor.image;		
		var request = sugoi.tools.Utils.getMultipart(1024 * 1024 * 12); //12Mb
		
		if (request.exists("image")) {
			
			//Image
			var image = request.get("image");
			if (image != null && image.length > 0) {
				var img : sugoi.db.File = null;
				if ( Sys.systemName() == "Windows") {
					img = sugoi.db.File.create(request.get("image"), request.get("image_filename"));
				}else {
					img = sugoi.tools.UploadedImage.resizeAndStore(request.get("image"), request.get("image_filename"), 400, 400);	
				}
				
				vendor.lock();				
				if (vendor.image != null) {
					//efface ancienne
					vendor.image.lock();
					vendor.image.delete();
				}				
				vendor.image = img;
				vendor.update();
				throw Ok('/contractAdmin/', t._("Image updated"));
			}
		}
	}	
	
}