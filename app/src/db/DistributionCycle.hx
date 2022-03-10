package db;
import tools.Timeframe;
import sys.db.Object;
import sys.db.Types;
using tools.DateTool;

enum CycleType {
	Weekly;	
	Monthly;
	BiWeekly;
	TriWeekly;
}

/**
 * Distribution cycle
 */
class DistributionCycle extends Object
{
	public var id : SId;	
	@hideInForms @:relation(groupId) public var group : db.Group;
	public var cycleType:SEnum<CycleType>;
	public var startDate : SDate; 	//cycle start date
	public var endDate : SDate;		//cycle end date
	public var startHour : SDateTime; 
	public var endHour : SDateTime;	
	public var daysBeforeOrderStart : SNull<STinyInt>;
	public var daysBeforeOrderEnd : SNull<STinyInt>;
	public var openingHour : SNull<SDate>;
	public var closingHour : SNull<SDate>;
	@formPopulate("placePopulate") @:relation(placeId) public var place : Place;
	
	public function new() {
		super();
	}

	public function getDistributions():Array<db.MultiDistrib>{
		return db.MultiDistrib.manager.search($distributionCycle == this,{orderBy:distribStartDate}, false).array();
	}

	/**
		Get cycles who have either startDate or EndDate in the timeframe
	**/
	public static function getFromTimeFrame(group:db.Group, timeframe:Timeframe){
		return db.DistributionCycle.manager.search( 
			$group==group && (
				($startDate > timeframe.from && $startDate < timeframe.to) 
				||
				($endDate > timeframe.from && $endDate < timeframe.to) 
				||
				($startDate < timeframe.from && $endDate > timeframe.to) 
			) , false);
	}
	
	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"cycleType"		=> t._("Frequency"),
			"startDate" 	=> t._("Cycle start date"),
			"endDate"		=> t._("Cycle end date"),
			"daysBeforeOrderStart" 		=> t._("Ouverture de commande (nbre de jours avant distribution)"),			
			"daysBeforeOrderEnd"		=> t._("Fermeture de commande (nbre de jours avant distribution)"),
			"place" 		=> t._("Place"),		
		];
	}
	
	public function placePopulate():Array<{label:String,value:Int}> {
		var out = [];
		if ( App.current.user == null || App.current.user.getGroup() == null ) return out;
		var places = db.Place.manager.search($group == App.current.user.getGroup(), false);
		for (p in places) out.push( { label:p.name,value :p.id } );
		return out;
	}
}