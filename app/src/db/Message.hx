package db;
import sys.db.Object;
import sys.db.Types;
import tink.core.Noise;
import tink.core.Outcome;
import sugoi.mail.IMailer;


/**
 * Message sent from the message Section
 */
class Message extends Object
{

	public var id : SId;
	@:relation(amapId) public var amap : SNull<db.Group>;
	@:relation(senderId) public var sender : SNull<User>;
	
	public var recipientListId : SNull<SString<12>>;
	public var recipients : SNull<SData<Array<String>>>;
	
	public var title : SString<128>;
	public var body : SText;	
	public var date : SDateTime;
	
	
	
}