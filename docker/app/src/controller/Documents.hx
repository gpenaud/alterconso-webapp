package controller;

import sugoi.form.elements.StringInput;
import sugoi.form.elements.RadioGroup;

class Documents extends controller.Controller
{
	public function new()
	{
		super();		
	}

	
	//  View the documents for either a catalog or a group
	@tpl("contractadmin/documents.mtt")
	function doDefault( ?catalog : db.Catalog ) {

		var documents : Array<sugoi.db.EntityFile>  = null;
		if( catalog != null ) {

			if ( !app.user.canManageContract( catalog ) ) throw Error( '/', t._('Access forbidden') );
			documents = sugoi.db.EntityFile.getByEntity( 'catalog', catalog.id, 'document' );
			view.catalog = catalog;
			view.c = catalog;
		}
		else { // Documents for a group

			if ( !app.user.isAmapManager() ) throw Error( '/', t._('Access forbidden') );
			documents = sugoi.db.EntityFile.getByEntity( 'group', app.user.getGroup().id, 'document' );
		}
			
		view.nav.push( 'documents' );
		view.documents = documents;

		//generate a token
		checkToken();
	}
	
	@tpl("form.mtt")
	public function doEdit( document : sugoi.db.EntityFile, ?catalog : db.Catalog ) {

		var returnPath : String = null;
		if( catalog != null ) {

			if ( !app.user.canManageContract( catalog ) ) throw Error( '/', t._('Access forbidden') );
			returnPath = '/contractAdmin/documents/' + catalog.id;
		}
		else { // Documents for a group

			if ( !app.user.isAmapManager() ) throw Error( '/', t._('Access forbidden') );
			returnPath = '/amapadmin/documents';
		}
		
		var form = new sugoi.form.Form("documentEdit");
		view.title = "Editer le document ici";		
		view.text = "Vous pouvez changer le nom et la visibilité du document ici.<br/>";
		
		form.addElement( new StringInput( "name","Nom du document", document.file.name, true ) );

		var options = [ { value : "subscribers", label : "Souscripteurs du contrat" },
						  { value : "members", label : "Membres du groupe" },
						  { value : "public", label : "Public" } ];

		//In case of a group or a variable orders catalog
		if ( catalog == null || catalog.type != 0 ) {

			options = [	{ value : "members", label : "Membres du groupe" }, { value : "public", label : "Public" } ];
		}
		form.addElement( new RadioGroup( 'visibility', 'Visibilité', options, document.data != null ? document.data : 'members' ) );
	
		if( form.isValid() ) {
			
			document.lock();
			document.file.lock();
			document.file.name = form.getValueOf("name");
			document.data = form.getValueOf("visibility");
			document.file.update();
			document.update();
				
			throw Ok( returnPath, 'Le document ' + document.file.name + ' a bien été mis à jour.' );
		}
			
		view.form = form;
	}


	public function doDelete( document : sugoi.db.EntityFile, ?catalog : db.Catalog ) {
		
		var returnPath : String = null;
		if( catalog != null ) {

			if ( !app.user.canManageContract( catalog ) ) throw Error( '/', t._('Access forbidden') );
			returnPath = '/contractAdmin/documents/' + catalog.id;
		}
		else { // Documents for a group

			if ( !app.user.isAmapManager() ) throw Error( '/', t._('Access forbidden') );
			returnPath = '/amapadmin/documents';
		}
		
		if ( checkToken() ) {

			document.lock();
			document.file.lock();
			var name = document.file.name;
			document.delete();
			document.file.delete();

			throw Ok( returnPath, 'Le document ' + name + ' a bien été supprimé.' );
			
		}

		throw Error( returnPath, t._("Token error") );
	}


	@tpl("contractadmin/adddocument.mtt")
	public function doInsert( ?catalog : db.Catalog ) {

		var returnPath : String = null;
		var errorPath : String = null;
		if( catalog != null ) {

			if ( !app.user.canManageContract( catalog ) ) throw Error( '/', t._('Access forbidden') );
			view.c = catalog;
			view.catalog = catalog;
			view.type_constorders = db.Catalog.TYPE_CONSTORDERS;
			view.catalog = catalog;
			returnPath = '/contractAdmin/documents/' + catalog.id;
			errorPath = '/contractAdmin/documents/insert/' + catalog.id;
		}
		else { // Documents for a group

			if ( !app.user.isAmapManager() ) throw Error( '/', t._('Access forbidden') );
			returnPath = '/amapadmin/documents';
			errorPath = '/amapadmin/documents/insert';
		}

		view.nav.push( 'documents' );

		var request = new Map();
		try {

			request = sugoi.tools.Utils.getMultipart( 1024 * 1024 * 10 ); //10Mb	
		}
		catch ( e:Dynamic ) {

			throw Error( errorPath, 'Le document importé est trop volumineux. Il ne doit pas dépasser 10 Mo.');
		}
		
		if ( request.exists( 'document' ) ) {
			
			var doc = request.get( 'document' );
			if ( doc != null && doc.length > 0 ) {

				var originalFilename = request.get( 'document_filename' );
				if ( !StringTools.endsWith( originalFilename.toLowerCase(), '.pdf' ) ) {

					throw Error( errorPath, 'Le document n\'est pas au format pdf. Veuillez sélectionner un fichier au format pdf.');
				}
				
				var filename = ( request.get( 'name' ) == null || request.get( 'name' ) == '' ) ? originalFilename : request.get( 'name' );
				var file : sugoi.db.File = sugoi.db.File.create( request.get( 'document' ), filename );					
				var document = new sugoi.db.EntityFile();
				document.entityType = catalog != null ? 'catalog' : 'group';
				document.entityId = catalog != null ? catalog.id : app.user.getGroup().id;
				document.documentType = 'document';
				document.file = file;								
				document.data = request.get( 'visibility' );
				document.insert();
	
				throw Ok( returnPath, 'Le document ' + document.file.name + ' a bien été ajouté.' );
			}
		}
				
	}

}
