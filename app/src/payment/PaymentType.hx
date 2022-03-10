package payment;

/**
 * ...
 * @author fbarbut
 */
class PaymentType
{

	public var type:String;	// unique string id
	public var icon:String; 
	public var name:String; //translated name
	public var link:String;
	public var onTheSpot:Bool; //is this payment made "on the spot"
	public var publicDesc:String; //public description for customers
	public var adminDesc:String; //description pour the group admin
	public var docLink:String; //link to documentation
	
}