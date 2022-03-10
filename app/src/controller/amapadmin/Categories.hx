package controller.amapadmin;

class Categories extends controller.Controller
{
	@tpl("categories/default.mtt")
	public function doDefault() {
		
		view.groups = db.CategoryGroup.manager.search($amap == app.user.getGroup(), false);
		
		checkToken();
		
	}
	
	/**
	 * genere le set par défaut de catégories
	 */
	public function doGenerate() {
		
		if ( db.CategoryGroup.manager.search($amap == app.user.getGroup(), false).length != 0) {
			throw Error("/amapadmin/categories", t._("The category list is not empty.") );
		}
		
		function gen(catGroupName:String,color:Int,cats:Array<String>) {
			
			var cg = new db.CategoryGroup();
			cg.name = catGroupName;
			cg.color = color;
			cg.amap = app.user.getGroup();
			cg.insert();
			
			for (c in cats) {
				var x = new db.Category();
				x.categoryGroup = cg;
				x.name = c;
				x.insert();
			}
			
		}
		var t = sugoi.i18n.Locale.texts;
		gen(t._("Product types"),2, [t._("Vegetables"), t._("Fruits"), t._("Fish"), t._("Red meat"), t._("Breads"), t._("Grocery"), t._("Beverages") ]);
		gen(t._("Labels"),0, [t._("Certified organic agriculture"), t._("Uncertified organic agriculture"), t._("Non organic") ]);
		
		throw Ok("/amapadmin/categories", t._("Default categories have been created") );
		
	}
	
	/**
	 * modifie un groupe de categories
	 */
	@tpl('form.mtt')
	function doEditGroup(g:db.CategoryGroup) {
		
		var form = form.CagetteForm.fromSpod(g);
		
		form.removeElementByName("color");
		form.removeElementByName("groupId");
		form.addElement(new form.ColorRadioGroup("color", t._("Color") , Std.string(g.color) ));		
		
		if (form.isValid()) {
			
			form.toSpod(g);
			g.update();
			throw Ok("/amapadmin/categories", t._("Group modified"));
			
		}
		
		view.title = t._("Modify the group ") + g.name;
		view.form = form;
	}
	
	@tpl('form.mtt')
	function doInsertGroup() {
		var g = new db.CategoryGroup();
		var form = form.CagetteForm.fromSpod(g );
		
		form.removeElementByName("color");
		form.removeElementByName("groupId");
		form.addElement(new form.ColorRadioGroup("color", "Couleur", Std.string(g.color)));		
		
		if (form.isValid()) {
			
			form.toSpod(g);
			g.amap = app.user.getGroup();
			g.insert();
			throw Ok("/amapadmin/categories", t._("Group added"));
			
		}
		
		view.title = t._("Create a group of categories");
		view.form = form;
	}
	
	@tpl('form.mtt')
	function doInsert(g:db.CategoryGroup) {
		var c = new db.Category();
		var form = form.CagetteForm.fromSpod(c);
		
		form.removeElementByName("categoryGroupId");
		
		if (form.isValid()) {
			
			form.toSpod(c);
			c.categoryGroup = g;
			c.insert();
			throw Ok("/amapadmin/categories", t._("Category added"));
			
		}
		
		view.title = t._("Create a category");
		view.form = form;
	}
	
	
	@tpl('form.mtt')
	function doEdit(c:db.Category) {
		
		var form = form.CagetteForm.fromSpod(c);
		
		form.removeElementByName("categoryGroupId");
		
		if (form.isValid()) {
			
			form.toSpod(c);
			c.update();
			throw Ok("/amapadmin/categories","Category modified");			
		}
		
		view.title = t._("Modify the category ") + c.name;
		view.form = form;
	}
	
	
	function doDeleteGroup(g:db.CategoryGroup,args:{token:String}) {
		
		if ( checkToken()) {
			if (g.getCategories().length > 0) throw Error("/amapadmin/categories", t._("All categories must be removed from this group before it can be deleted."));
			
			g.lock();
			g.delete();
			throw Ok("/amapadmin/categories", t._("Group deleted"));
		}else {
			throw Redirect("/amapadmin/categories");
		}
	}
	
	function doDelete(c:db.Category,args:{token:String}) {
		
		if ( checkToken()) {
			c.lock();
			c.delete();
			throw Ok("/amapadmin/categories", t._("Category deleted"));
		}else {
			throw Redirect("/amapadmin/categories");
		}
	}
	
	
	
	
}
