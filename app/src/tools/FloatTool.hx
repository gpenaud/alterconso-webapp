package tools;


class FloatTool{

	/**
	Tries to fix buddy float comparison in Neko...
	**/
	public static function isEqual(a:Float,b:Float){
		a = Math.round(a*10000);
		b = Math.round(b*10000);
		return a==b;
	}

	public static function isInt(f:Float){
		return isEqual(f , Math.round(f) );
	}

	//prevent float comparison bug in Neko
	public static function clean(f:Float):Float{
		return Math.round(f*100)/100;
	}

}