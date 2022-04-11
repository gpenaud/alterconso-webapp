

package test;import utest.Assert;
import db.UserGroup;
import Common;

/**
 * Test user rights to view contracts
 * 
 * @author web-wizard
 */
class TestUser extends utest.Test
{
	
	public function new(){
		super();
	}
	
	function setup(){
		TestSuite.initDB();
		TestSuite.initDatas();
	}
	
	/**
		Check that a user who has admin rights for his/her group can't view a contract from a group
    	he/she doesn't belong to
	 */
	function testViewContract(){        
		db.UserGroup.CACHE.clear();
        var userGroup = db.UserGroup.getOrCreate(TestSuite.FRANCOIS, TestSuite.AMAP_DU_JARDIN);
		userGroup.giveRight(Right.GroupAdmin);
		Assert.isNull( db.UserGroup.get(TestSuite.FRANCOIS , TestSuite.LOCAVORES) );

		var catalog = TestSuite.LOCAVORES.getContracts().first();
        Assert.isFalse( TestSuite.FRANCOIS.canManageContract(catalog) );
	}

}