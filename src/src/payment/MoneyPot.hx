package payment;

/**
 * ...
 * @author web-wizard
 */
class MoneyPot extends payment.PaymentType
{
	
	public static var TYPE(default, never) = "moneypot";

	public function new() 
	{
		var t = sugoi.i18n.Locale.texts;
		onTheSpot = false;
		type = TYPE;
		icon = '<i class="icon icon-moneypot"></i>';
		name = t._("Money pot");
		link = "/transaction/moneypot";
		adminDesc = "Le client ne paye pas tout de suite sa commande.<br/>Vous régularisez les paiements manuellement plus tard.";
		docLink = "https://wiki.cagette.net/admin:admin_cagnotte";
	}
	
}