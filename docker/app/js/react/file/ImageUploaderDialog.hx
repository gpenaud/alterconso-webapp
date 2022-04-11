package react.file;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.file.ImageUploader;
import react.mui.CagetteTheme;
import mui.core.Button;
import mui.core.Dialog;
import mui.core.DialogActions;
import mui.core.DialogContent;
import mui.core.DialogTitle;

typedef ImageUploaderDialogProps = {
	var uploadURL : String;			//Api endpoint where the image will be posted
	var uploadedImageURL : String;	//URl of the existing image
	var width : Int;		//width constraint
	var height : Int;		//height constraint
	var ?formFieldName: String;
};

typedef ImageUploaderDialogState = {
	var isDialogOpened : Bool;  
};

class ImageUploaderDialog extends ReactComponentOfPropsAndState<ImageUploaderDialogProps, ImageUploaderDialogState> {

	public function new( props : ImageUploaderDialogProps ) {
		super(props);
		state = { isDialogOpened : true };    
  	}

  	function handleClickUpload( value : String ) {
		trace("handleClickUpload : "+value);
		handleClose(null);
  	}

  	override public function render() {
		var thumbnail = /*props.uploadedImageURL != null ? jsx('
			<img alt="thumbnail" src=${props.uploadedImageURL} style=${{ maxWidth: '50px', maxHeight: '50px', verticalAlign: 'middle', marginRight: '5px' }} />
		') :*/ null;
		  
		return jsx('
			<div>
				$thumbnail
				<Dialog open=${state.isDialogOpened} onClose=$handleClose aria-labelledby="form-dialog-title">
					<DialogTitle id="form-dialog-title">
						Ajouter une photo
					</DialogTitle>
					<DialogContent>
						<ImageUploader uploadURL=${props.uploadURL} uploadCallback=$handleClickUpload width=${props.width} height=${props.height} formFieldName=${props.formFieldName} />
					</DialogContent>
				</Dialog>
			</div>'
		);
  	}

  	function handleClose( e : js.html.Event ) {

		setState( { isDialogOpened : false } );
		//js.Browser.location.hash = "/";
		// props.onClose(e,mui.core.modal.ModalCloseReason.BackdropClick);
		//  setState({modalProduct:null, modalVendor:null}, function() {trace("modal closed");});
	}
  
}