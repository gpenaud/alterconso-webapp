package react.avatareditor;

import react.ReactComponent;

typedef AvatarEditorProps = {
	?scale:Float,
	?width:Int,
	?height:Int,
	?border:Int,
	position:{x:Float,y:Float},
	rotate:Float,
	borderRadius:Int,
    onPositionChange : {x:Float,y:Float}->Void,
	image:js.html.File,
	?className:String,
	?style:Dynamic,

	/*image: string | File;
        width?: number;
        height?: number;
        border?: number;
        borderRadius?: number;
        color?: number[];
        style?: Object;
        scale?: number;
        onDropFile?(event: DragEvent): void;
        onLoadFailure?(event: Event): void;
        onLoadSuccess?(imgInfo: ImageState): void;
        onMouseUp?(): void;
        onMouseMove?(): void;
        onImageChange?(): void;*/
}


@:jsRequire('react-avatar-editor')  
extern class AvatarEditor extends ReactComponentOfProps<AvatarEditorProps> {
	public function getImageScaledToCanvas() : js.html.CanvasElement;
	public function getCroppingRect() : { x : Float, y : Float, width : Float, height : Float };
}

