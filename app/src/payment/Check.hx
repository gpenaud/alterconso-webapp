package payment;

/**
 * Check payment type
 * @author fbarbut
 */
class Check extends payment.PaymentType
{
	public static var TYPE(default, never) = "check";

	public function new() 
	{
		var t = sugoi.i18n.Locale.texts;
		this.onTheSpot = true;
		this.type = TYPE;
		this.icon = '<i class="icon icon-cheque"></i>';
		this.name = t._("Check");
		this.link = "/transaction/check";
		this.adminDesc = "Paiement par chèque sur place";
	}
	
	public static function getCode(date:Date,place:db.Place,user:db.User){
		return date.toString().substr(0, 10) + "-" + place.id + "-" + user.id;
	}
	
}