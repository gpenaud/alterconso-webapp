package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import mui.core.Dialog;
import mui.core.DialogActions;
import mui.core.DialogContent;
import mui.core.DialogContentText;
import mui.core.DialogTitle;
import mui.core.Button;
import mui.core.Tooltip;
import mui.core.modal.ModalCloseReason;
import mui.core.Typography;
import Common;

/**
 * A modal window displaying an OSM map
 */
class OSMWindow extends react.ReactComponentOfProps<{place:PlaceInfos,onClose:js.html.Event->ModalCloseReason->Void}>
{

	public function new(props:Dynamic) 
	{
		super(props);
	}
	

	override public function render(){
		return jsx('
        <Dialog 
            open=${props.place != null} 
            onClose=${props.onClose}
            fullWidth={true}
			maxWidth=${mui.core.common.ShirtSize.ShirtSizeOrFalse.MD} 
            scroll=${mui.core.dialog.DialogScrollContainer.Body}>
            
            <DialogTitle id="alert-dialog-title">
                <i className="icon icon-map-marker"/> ${Formatting.getFullAddress(props.place)}
            </DialogTitle>

            <Tooltip title="Fermer">
                <Button onClick=${close} style={{top:0,position:css.Position.Absolute,right:0}}>
                    <i className="icon icon-delete"/>
                </Button>
            </Tooltip>

            <DialogContent>
                <DialogContentText style=${{height:600}}>                    
                                      
                    <OSMMap place=${props.place} height={550}/>    

                </DialogContentText>
            </DialogContent>
                    
		</Dialog>');
	}

    function close(e){
        props.onClose(e,mui.core.modal.ModalCloseReason.BackdropClick);
    }

	
}