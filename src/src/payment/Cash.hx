package payment;

/**
 * ...
 * @author fbarbut
 */
class Cash extends payment.PaymentType
{
	
	public static var TYPE(default, never)  = "cash";

	public function new() 
	{
		var t = sugoi.i18n.Locale.texts;
		this.onTheSpot = true;
		this.type = TYPE;
		this.icon = '<i class="icon icon-euro"></i>';
		this.name = t._("Cash");
		this.link = "/transaction/cash";
		this.adminDesc = "Paiement en espèces sur place";
	}
	
}