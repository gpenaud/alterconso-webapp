package payment;

import service.PaymentService;

/**
 * Virtual payment type ( represents all "on the spot" payment types )
 */
class OnTheSpotPayment extends payment.PaymentType
{
	
	public static var TYPE(default, never) = "onthespot";
	public var allowedPaymentTypes : Array<payment.PaymentType>;

	public function new() 
	{
		var t = sugoi.i18n.Locale.texts;
		this.onTheSpot = false;
		this.type = TYPE;
		this.icon = '<i class="icon icon-euro" aria-hidden="true"></i>';
		this.name = t._("On the spot payment");
		this.link = "/transaction/onthespot";
		this.allowedPaymentTypes = [];
	}

	//get payment types wich are "on the spot"
	public static function getPaymentTypes() : Array<String>
	{
		return PaymentService.getPaymentTypes(PCAll).filter(p -> p.onTheSpot).map(p -> p.type);
	}
	
}