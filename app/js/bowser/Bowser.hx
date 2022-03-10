package bowser;

/**
    Externs for Bowser, browser detection
    https://github.com/lancedikson/bowser
**/
@:jsRequire("bowser")
extern class Bowser{
    public static function getParser(userAgent:String):Parser;
}

@:jsRequire("bowser","parser")
extern class Parser{
    public function getBrowserName():String;
    public function satisfies(params:Dynamic):Null<Bool>;
    public function getOSName():String;
    public function getBrowserVersion():String;

}