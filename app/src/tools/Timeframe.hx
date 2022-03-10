package tools;
import tink.core.Error;

class Timeframe {

    public var from : Date;
    public var to : Date;

    public function new(_from:Date,_to:Date,?webParamsOverride=true){
        
        var params = App.current.params;
        if(webParamsOverride){
            //take web params in priority
            this.from = params.get("_from")==null   ? _from : Date.fromString(params.get("_from")); 
		    this.to = 	params.get("_to")==null     ? _to : Date.fromString(params.get("_to")); 
        }else{
            this.from = _from;
            this.to = _to;
        }
        
        if(from.getTime()>to.getTime()){
            throw new Error('"from" date should be earlier than "to" date. ( $from > $to ) ');
        }
        
    }

    public function next(){
        var time = to.getTime() - from.getTime();
        var from2 = to;
        var to2 = DateTools.delta(from2, time);
        return new Timeframe(from2,to2,false);
    }

    public function previous(){
        var time = to.getTime() - from.getTime();
        var to2 = from;
        var from2 = DateTools.delta(to2, -time);
        return new Timeframe(from2,to2,false);
    }

}