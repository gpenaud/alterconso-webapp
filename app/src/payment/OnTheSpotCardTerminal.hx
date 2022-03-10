package payment;

/**
 * On the spot card terminal
 * @author fbarbut
 */
class OnTheSpotCardTerminal extends payment.PaymentType
{
	public static var TYPE(default, never) = "card-terminal";

	public function new() 
	{
        var t = sugoi.i18n.Locale.texts;
        this.onTheSpot = true;
		this.type = TYPE;
		this.icon = '<i class="icon icon-bank-card"></i>';
		this.name = "Carte bancaire sur place";
        this.link = "/transaction/cardTerminal";
        this.adminDesc = "Paiement avec votre terminal de paiement sur place ";
	}
	

	
}