package sugoi.mail;
import sugoi.mail.IMail;
import sugoi.mail.IMailer;


/**
 * Send an email via custom Smtp micro-service
 * @author gpenaud
 */
class SmtpMailer implements IMailer
{

	var conf : Dynamic;

	public function new() {}

	public function init(?c:Dynamic):IMailer{
		conf = c;
		return this;
	}

	public function send(m:sugoi.mail.IMail,?params:Dynamic,?callback:MailerResult->Void):Void{

		//build an object from headers map
		var headersObj = { };
		var headers = m.getHeaders();
		for(k in headers.keys()) {
			Reflect.setField(headersObj, k, headers.get(k));
		}

		var data = {
			html : m.getHtmlBody(),
			subject : m.getSubject(),
			from_email : m.getSender().email,
			from_name : m.getSender().name,
			to : [],
			headers : headersObj,
			//images : images,
		};

		for (r in m.getRecipients()) {
			data.to.push( { email:r.email, name:r.name, type:"to" } );
		}

    var mailer_host = App.config.get("mailer_host");
    var mailer_port = App.config.get("mailer_port");

    trace("SmtpMailer::send(): " + haxe.Json.stringify(data));
		var raw = curlRequest("POST", "http://" + mailer_host + ":" + mailer_port + "/send", {}, haxe.Json.stringify(data));

    trace("SmtpMailer::send(): " + raw);

		if (callback != null){
      trace("SmtpMailer::send(): " + callback);

			if (raw == null) throw "CURL response is null";
			if (raw == "") throw "CURL response is empty";
			var apiResult : SmtpSendResult = null;
			try {
				apiResult = haxe.Json.parse(raw);
			} catch (e:Dynamic){
				throw "unable to decode : " + raw + ", error is "+Std.string(e);
			}

			var map = new MailerResult();
			for ( r in apiResult){
				var v : tink.core.Outcome<sugoi.mail.IMailer.MailerSuccess,sugoi.mail.IMailer.MailerError> = null;

				switch(r.status){
					case "sent" :
						v = Success(Sent);
					case "queued":
						v = Success(Queued);
					default:
						//"hard-bounce", "soft-bounce", "spam", "unsub", "custom", "invalid-sender", "invalid", "test-mode-limit", "unsigned", or "rule"
						switch(r.reject_reason){
							case "hard-bounce" :
								v = Failure(HardBounce);
							case "soft-bounce":
								v = Failure(SoftBounce);
							case "spam":
								v = Failure(Spam);
							case "unsub":
								v = Failure(Unsub);
							default :
								v = Failure(GenericError(new tink.core.Error(raw)));
						}
				}

				map.set( r.email , v );
			}
			callback(map);
		}
	}


	public function curlRequest( method: String, url : String, ?headers : Dynamic, postData : String ) : Dynamic {
		var cParams = ["-X"+method,"--max-time","60"];
		for( k in Reflect.fields(headers) ){
			cParams.push("-H");
			cParams.push(k+": "+Reflect.field(headers,k));
		}

		cParams.push(url);

    if( postData != null ){
			cParams.push("-d");
			cParams.push(postData);
		}

    trace(postData);

		var p = new sys.io.Process("curl", cParams);

		#if neko
		var str = neko.Lib.stringReference(p.stdout.readAll());
		#else
		var str = p.stdout.readAll().toString();
		#end

		if (str == null || str == "") {
			str = neko.Lib.stringReference(p.stderr.readAll());
		}

		p.exitCode();

		return str;
	}

}

typedef SmtpSendResult = Array <{
	email:String,
	status:String,
	_id:String,
	reject_reason:String,
}>;
