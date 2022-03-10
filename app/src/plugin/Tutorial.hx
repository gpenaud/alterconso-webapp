package plugin;
import Common;
import sugoi.plugin.*;

/**
 * Tutorials internal plugin
 * 
 * Its listening to events to know if 
 * the user can go to the next step of his tutorial
 * 
 * User's tutorial state is stored in user.tutoState.
 * The JS widget is triggered in view.init()
 * 
 * 
 */
class Tutorial extends PlugIn implements IPlugIn
{
	public function new() {
		super();	
		App.current.eventDispatcher.add(onEvent);		
	}
	
	/**
	 * catch events
	 */
	public function onEvent(e:Event) {
		//no need to continue if tutos are disabled
		if ( App.current.user==null || App.current.user.tutoState==null ) return;

		switch(e) {
			
			//a page is displayed
			case Page(uri):
				
				var ts = App.current.user.tutoState;
				if (ts == null) return;
				var tuto = TutoDatas.get(ts.name);
				var step = tuto.steps[ts.step];
				if (step == null ) return;
				
				//skip steps if action is "next"
				while (step.action.equals(TANext)) {
					if (ts.step + 1 >= tuto.steps.length) break;
					ts.step++;					
					step = tuto.steps[ts.step];
				}
				
				//trace( "tuto active, listening to step="+ts.step );
				switch(step.action) {
					case TAPage(_uri):
						
						//trace(""+_uri+"="+uri+" ?");
						if (match(_uri, uri)) {
							
							//trace("ok");
							var u = App.current.user;
							u.lock();
							
							if ( ts.step+1 >= tuto.steps.length) {
								//tuto finished
								u.tutoState = null;
							}else {
								//next step
								u.tutoState.step = ts.step+1;	
							}
							
							u.update();
						}
					default:	
					
				}
				
				
			default : 
		}
	}

	/**
	 * to know if the current uri matches with the tuto step uri
	 */
	public static function match(pattern:String, uri:String):Bool {
		
		if (pattern.indexOf("*") > -1) {
			
			//the url contains a wildcard
			
			//  ~/http:\/\/(\w+).com/    match urls like http://anything.com
			var s = pattern;
			s = StringTools.replace(s, "/", "\\/"); //escape antislashes
			s = StringTools.replace(s, "*", "(\\w+)");
			var e = new EReg(s,"");
		
			return e.match(uri);
			
		}else {
			
			return pattern == uri;
		}
		
	}
	
	public static function all() {
		TutoDatas.get("intro");//just to init translation
		return TutoDatas.TUTOS;
	}
	
	
	
}