package sticky;

@:enum
abstract StickyEvent(String) to String 
{
    var CHANGE = 'sticky-change';
    var STUCK = 'sticky-stuck';
    var UNSTUCK = 'sticky-unstuck';
}

@:enum
abstract StickyClassName(String) to String 
{
    var SENTINEL = 'sticky-events--sentinel';
    var SENTINEL_TOP = 'sticky-events--sentinel-top';
    var SENTINEL_BOTTOM = 'sticky-events--sentinel-bottom';
}


typedef StickyEventConfig = {
    @:optional var container: js.html.Node;// default document
    @:optional var enabled: Bool;// default true
    @:optional var stickySelector: String;// default STICKY_SELECTOR
}

@:jsRequire('sticky-events', 'default') 
extern class StickyEvents
{
    public function new(config:StickyEventConfig);

    public var container:js.html.Node;
    public var stickyElements:js.html.NodeList;
    public var stickySelector:String;

    public function enableEvents():Void;
    public function disableEvents(resetStickies:Bool = true):Void;

    inline static var STICKY_SELECTOR = '.sticky-events';
}