package test;
import utest.Assert;
import Common;

/**
 * Test various tools
 * 
 * @author fbarbut
 */
class TestTools extends utest.Test
{
	
	function testDateRanges(){        
        // test last hour range
		var now = Date.fromString("2018-01-01 00:30:12");
		var r = tools.DateTool.getLastHourRange(now);
        Assert.equals("2017-12-31 23:00:00",r.from.toString());
		Assert.equals("2018-01-01 00:00:00",r.to.toString());

		// test last minute
		var now = Date.fromString("2018-01-01 00:30:12");
		var r = tools.DateTool.getLastMinuteRange(now);
        Assert.equals("2018-01-01 00:29:00",r.from.toString());
		Assert.equals("2018-01-01 00:30:00",r.to.toString());
	}


	function testFloatTool(){

		Assert.equals( true , tools.FloatTool.isEqual(10.0,10.000) );
		Assert.equals( true , tools.FloatTool.isEqual(10.0,10) );
		Assert.equals( true , tools.FloatTool.isEqual(10,10) );
		Assert.equals( true , tools.FloatTool.isEqual(10.00000001,10) );
		Assert.equals( false , tools.FloatTool.isEqual(10.02,10) );

		Assert.equals( false , tools.FloatTool.isInt(10.08) );
		Assert.equals( true , tools.FloatTool.isInt(10.00) );
	}

	function testStockDispatch(){
		//base stock 15kg, 3 offers : 10kg, 1kg, 5kg

		var stocks = tools.StockTool.dispatchOffers( 15 , ["10kg"=>10,"1kg"=>1, "5kg"=>5] );

		Assert.equals(stocks["10kg"],0);// 0 x 10kg
		Assert.equals(stocks["1kg"],10);// 10 x 1kg
		Assert.equals(stocks["5kg"],1);// 1 x 5kg

		var stocks = tools.StockTool.dispatchOffers( 30 , ["10kg"=>10, "1kg"=>1, "5kg"=>5] );

		Assert.equals(stocks["10kg"],1);// 1 x 10kg
		Assert.equals(stocks["1kg"],10);// 10 x 1kg
		Assert.equals(stocks["5kg"],2);// 2 x 5kg
	}

	function testListSynchronizer(){

		TestSuite.initDB();
		TestSuite.initDatas();
		db.UserGroup.CACHE.clear();

		//create initial state : francois and seb are member of a group.
		var francois = TestSuite.FRANCOIS;
		var seb = TestSuite.SEB;
		var julie = TestSuite.JULIE;
		var group = TestSuite.AMAP_DU_JARDIN;
		francois.makeMemberOf(group);
		seb.makeMemberOf(group);

		//source datas is an array of INt ( users to assign to this group )
		//destination datas is an array of UserAmap.
		var ls = new tools.ListSynchronizer<Int,db.UserGroup>();

		//we want to remove seb and add Julie
		ls.setSourceDatas( [julie.id,francois.id] );
		ls.setDestinationDatas( Lambda.array(db.UserGroup.manager.search($group==group)) );
		ls.isEqualTo = function(id:Int,ua:db.UserGroup){
			return id==ua.user.id;
		};
		ls.createNewEntity = function(id:Int){
			var u = db.User.manager.get(id,false);
			return u.makeMemberOf(group);
		};
		ls.deleteEntity = function(ua:db.UserGroup){
			ua.delete();
		};
		ls.updateEntity = function(id:Int,ua:db.UserGroup){
			ua.user = db.User.manager.get(id);
			ua.update();
			return ua;
		};
		var newList = ls.sync();

		Assert.isTrue( newList.length==2 );
		Assert.isTrue( Lambda.find(newList,function(ua) return ua.user.id==julie.id )!=null );
		Assert.isTrue( Lambda.find(newList,function(ua) return ua.user.id==francois.id )!=null );

		//reload from DB
		var newList = Lambda.array(db.UserGroup.manager.search($group==group));

		Assert.isTrue( newList.length==2 );
		Assert.isTrue( Lambda.find(newList,function(ua) return ua.user.id==julie.id )!=null );
		Assert.isTrue( Lambda.find(newList,function(ua) return ua.user.id==francois.id )!=null );
	}

	function testDateJSON(){

		//winter time
		var january = Formatting.dateToIso(new Date(2020,0,1,0,0,0));
		Assert.equals("2020-01-01T00:00:00+01:00",january);

		//summer time
		var june = Formatting.dateToIso(new Date(2020,5,1,0,0,0));
		Assert.equals("2020-06-01T00:00:00+02:00",june);
	}

/*
	@admin
	public function doTests() {
		
		var Assert.isTrue = function(val, ?desc="") {
			if (val) {
				Sys.println("OK : <br/>");
			}else {
				Sys.println("ERROR : "+desc+"<br/>");
			}
		}
		
		
		//test les fonctions de cotisation
		
		var amap = db.Group.manager.get(1);
		
		amap.membershipRenewalDate = new Date(2015, 0, 1,0,0,0);
		amap.update();
		
		Assert.isTrue(amap.getMembershipYear(new Date(2015, 3, 3, 0, 0, 0) ) == 2015);
		Assert.isTrue(amap.getPeriodName(new Date(2015, 3, 3, 0, 0, 0)) == "2015");
		
		Assert.isTrue(amap.getMembershipYear(new Date(2014, 8, 8, 0, 0, 0) ) == 2014);
		Assert.isTrue(amap.getPeriodName(new Date(2014, 8, 8, 0, 0, 0) ) == "2014");
		
		Assert.isTrue(amap.getMembershipYear(new Date(2013, 11, 12, 0, 0, 0) ) == 2013);
		Assert.isTrue(amap.getPeriodName(new Date(2013, 11, 12, 0, 0, 0) ) == "2013");
		
		amap.membershipRenewalDate = new Date(2015, 8, 1,0,0,0);
		amap.update();
		
		Assert.isTrue(amap.getMembershipYear(new Date(2015, 3, 3, 0, 0, 0) ) == 2014);
		Assert.isTrue(amap.getPeriodName(new Date(2015, 3, 3, 0, 0, 0)) == "2014-2015");
		
		var d = amap.getMembershipYear(new Date(2015, 8, 8, 0, 0, 0) );
		Assert.isTrue( d == 2015, "le 8 sept 2015, on doit etre en cotis 2015, la c " + d);
		Assert.isTrue(amap.getPeriodName(new Date(2015, 8, 8, 0, 0, 0)) == "2015-2016");
		
		var d = new Date(2013, 11, 12, 0, 0, 0) ;
		Assert.isTrue( amap.getMembershipYear(d) == 2013, "le 12 oct 2013, on doit etre en cotis 2013 , là c " + amap.getMembershipYear(d) );
		Assert.isTrue(amap.getPeriodName(d) == "2013-2014", "le 12 oct 2013, on doit etre en 2013-2014 , là c " + amap.getPeriodName(d) );
		
		
	}*/

}