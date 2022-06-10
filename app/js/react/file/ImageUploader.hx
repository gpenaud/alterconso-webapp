package react.file;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.ReactRef;
import mui.core.Button;
import haxe.Json;
import js.html.XMLHttpRequest;
import react.avatareditor.AvatarEditor;
import react.avatareditor.DropZone;
import mui.core.CircularProgress;
import mui.core.Grid;

typedef ImageUploaderProps = {
	var uploadURL : String;
	// var uploadField : String;
	// var uploadResponseField : String;
	var uploadCallback : String -> Void;
	var width:Int;
	var height:Int;
	var ?formFieldName: String;
};

typedef ImageUploaderState = {
	var image : js.html.File;
	var position : { x : Float, y : Float };
	var scale : Float;
  	var rotate : Int;
	var preview : { img : Dynamic, rect : { x : Float, y : Float, width : Float, height : Float },  scale : Float, width : Int, height : Int, borderRadius : Float };
	var width : Int;
	var height : Int;
	var uploading : Bool;
	var uploadProgress : { state : String, percentage : Float };
	var successfullUploaded : Bool;
};

class ImageUploader extends ReactComponentOfPropsAndState<ImageUploaderProps, ImageUploaderState> {

  	var avatarEditorRef : react.ReactRef<AvatarEditor>;

  	public function new( props : ImageUploaderProps ) {		
		super(props);
		state = { image : null, position : { x: 0.5, y: 0.5 }, scale : 1, rotate : 0, preview : null, width : props.width, height : props.height,
		uploading : false, uploadProgress : { state : "notstarted", percentage : 0}, successfullUploaded : false };
		avatarEditorRef  = React.createRef();
		
		//use this to see if the haxe extern is linked to the js object
		//trace(DropZone);
		//trace(AvatarEditor);
		//js.html.Console.log(AvatarEditor);
  	}
 
 	function updateImage( e : js.html.Event ) {
		e.preventDefault();		
		var newImage : js.html.File = untyped ( e.target.files[0] );
		setState( { image : newImage } );	
	}

  	function updatePreview( e : js.html.Event ) {
		e.preventDefault();		
		var image = avatarEditorRef.current.getImageScaledToCanvas().toDataURL();
		var rect = avatarEditorRef.current.getCroppingRect();
		setState( { preview : { img : image, rect : rect, scale : state.scale, width: state.width, height: state.height, borderRadius: 0 } } );
  	}

	function updateScale( e : js.html.Event ) {
		e.preventDefault();		
		var scale = untyped (e.target.value == "") ? null : e.target.value;
		setState( { scale : Std.parseFloat(scale) } );
	}  

  	function rotateLeft( e : js.html.Event ) {
		e.preventDefault();		
		// Hack: Swap width and height on +/- 90° rotation, because of bug in react-avatar-editor (rotation rotates canvas and image, instead of image only)
		setState( { rotate : state.rotate - 90, width : state.height, height : state.width } );
  	}

  	function rotateRight( e : js.html.Event ) {
		e.preventDefault();		
		// Hack: Swap width and height on +/- 90° rotation, because of bug in react-avatar-editor (rotation rotates canvas and image, instead of image only)
		setState( { rotate : state.rotate + 90, width : state.height, height : state.width } );
  	}

	function logCallback( e : String ) {
		trace("****CALLBACK*****");
		trace(e);
  	}

  	function onPositionChange( position : { x : Float, y : Float } ) {
		setState( { position : position } );
  	}

	function handleDrop( acceptedFiles : Array<js.html.File> ) {
		setState( { image : acceptedFiles[0] } );
  	}  

  	function uploadImage() {

		setState( { uploading: true } );
		var image = avatarEditorRef.current.getImageScaledToCanvas().toDataURL();

		var initRequest = js.Promise.all( [sendRequest(image)] ).then(
			function(data:Dynamic) {
				//trace("Successfull upload");
		  		setState( { successfullUploaded : true, uploading : false } );
				js.Browser.window.location.reload(true);
			}
		).catchError (
			function(error) {
				//trace("Error while uploading:", error);
		  		setState( { successfullUploaded: false, uploading: false } );
		  		throw error;
			}
		);
  	}

  	function sendRequest( image : Dynamic ) {

		return new js.Promise( 
			function( resolve : Dynamic -> Void, reject )
			{
				var request = new XMLHttpRequest();
	  			request.responseType = js.html.XMLHttpRequestResponseType.JSON;
				request.upload.addEventListener("progress", function(event) {
					if ( event.lengthComputable ) {
						setState({ uploadProgress: { state : "pending", percentage : ( event.loaded / event.total ) * 100 } });
						trace(state.uploadProgress);
					}
				});
	  			request.upload.addEventListener("load", function(event) {
		  			setState({ uploadProgress: { state: "done", percentage: 100 } });
					trace(state.uploadProgress);
	  			});     

	  			request.upload.addEventListener("error", function(event) {
					setState( { uploadProgress : { state: "error", percentage: 0 } } );
					reject( request.responseText );
	  			});

	  			request.onreadystatechange = function () {
					if (request.readyState == 4) {
					  	switch (request.status) {
						case 200:
			  				if ( request.responseType != js.html.XMLHttpRequestResponseType.JSON ) {
								trace( "Wrong response type" );
								reject( request.responseText );
			  				} else if ( request.response ) {
								trace( "received response:"+ request.response );
								//var json = Json.parse(request.response);
								var json = request.response;
								resolve( json );
								trace(json);
							} else {						
								trace( "Wrong response content" );
								reject( request.response );
							}
			  			case 204:
							resolve(true);
					  	default:
							trace( "Wrong response status" );
						  	reject( request.responseText );
		  				}
					}
	  			}

	  			var data = new js.html.FormData();
	   			// If we had a real file, we could use `file.name` as third argument
	  			data.append(props.formFieldName != null ? props.formFieldName : "file", image);
	  			request.open("POST", props.uploadURL);
	  			request.send(data);
		});
  	}

	override public function render() {
		/*onLoadFailure=$onLoadFailure
					onLoadSuccess=${logCallback.bind('onLoadSuccess')}
			  		onImageReady=${logCallback.bind('onImageReady')}
							*/
			var ratio = 537 / props.width;
	  	var image = state.image != null ? jsx('
			<div>
				<AvatarEditor 
						ref=$avatarEditorRef
						style={{ width: ${props.width} * ${ratio}, height: ${props.height} * ${ratio} }}
					scale=${state.scale}
					width=${state.width}
					height=${state.height}
			  		position=${state.position}
					onPositionChange=$onPositionChange
					rotate=${state.rotate}		  		
					image=${state.image}
					borderRadius=${0}
					className="editor-canvas" />
			</div>') : null/*jsx('
			<label htmlFor="newImage" className="field-label">
				<div className="dropzone--empty">Déposez une image ici ou cliquez sur Parcourir</div>
			</label>')*/;

		//<Button variant={Contained} onClick=$updatePreview className="preview-button">Preview</Button>
		var buttons = if(state.image != null){
			if(state.uploadProgress.percentage>0){				
				jsx('<CircularProgress />');
			}else{
				jsx('<div>
				<Grid container style=${{margin:"24px 0"}}>
					<Grid item md={2}>
						Zoom 
					</Grid>
					<Grid item md={8}>
						<input name="scale" type="range" onChange=$updateScale min="0.1" max="2" step="0.01" defaultValue="1" />
					</Grid>
					<Grid item md={2}>
						${ Math.round(state.scale * 100) } %
					</Grid>
				</Grid>
                
				<Grid container>
					<Grid item md={4}>
						<Button variant={Contained} onClick=$rotateLeft className="rotate-left-button">↶ Gauche</Button> 
					</Grid>
					<Grid item md={4}>
						<Button variant={Contained} onClick=$rotateRight className="rotate-right-button">↷ Droite</Button>
					</Grid>
					<Grid item md={4}>
						<Button variant={Contained} color={Primary} onClick=$uploadImage className="upload-button">Envoyer</Button>
					</Grid>
                </Grid>
				</div>');
			}
		}else{ null; };

		//var preview = state.preview != null ? jsx('<img src=${state.preview.img} style=${{borderRadius:"0px"}} alt="preview" />') : null;

			
		//cant make dropzone work
		/*return jsx('
		<div className="image-import-edit-upload-component">
			<DropZone className="dropzone" onDrop=$handleDrop multiple={false} style=${{ width: state.width + 50, height: state.height + 50 }} >
				$image         
			</DropZone>
			<br/>
			<label htmlFor="newImage">
				<Button variant={Contained} component="span">Parcourir</Button>
			</label>
			<br/>
			<input id="newImage" name="newImage" type="file" onChange=$updateImage className="input--file" />
			$buttons
			$preview
		</div>');*/
		return jsx('
		<div className="image-import-edit-upload-component">
			$image         			
			<br/>
			<input id="newImage" name="newImage" type="file" onChange=$updateImage className="input--file" />
			$buttons
		</div>');

  	}

}