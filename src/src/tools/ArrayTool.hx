package tools;

/**
 * Some utility functions for arrays
 */
class ArrayTool
{
	/**
	 * shuffle (randomize) an array
	 */
	//public static function shuffle<T>(arr:Array<T>):Array<T>
	//{
		//if (arr!=null) {
			//for (i in 0...arr.length) {
				//var j = Std.random(arr.length);
				//var a = arr[i];
				//var b = arr[j];
				//arr[i] = b;
				//arr[j] = a;
			//}
		//}
		//return arr;
	//}
	
	/**
	 * Group a list of objects by date
	 * @param	objs			List of objects
	 * @param	dateParamName	Name of the object field which is a date
	 * @return
	 */
	public static function groupByDate<T>(objs:Array<T>,dateFieldName:String):Map<String,Array<T>>{
	
		var out = new Map<String, Array<T> >();
		for ( o in objs){
			var d : Date = Reflect.field(o, dateFieldName);
			var group = out.get(d.toString());
			if (group == null) group = new Array<T>();
			group.push(o);
			out.set(d.toString(), group);			
		}
		return out;
	}
	
	
	public static function mapLength<T>(m:Map<T,Dynamic>):Int{
		var i = 0;
		for (x in m) i++;
		return i;
	}

	public static function deduplicate<T>(array:Array<T>):Array<T> {
        var l = [];
        for (v in array) {
         	if (l.indexOf(v) == -1) { // array has not v
            	l.push(v);
            }
         }
        return l;
    }
	
}