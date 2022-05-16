package react.mui;

import classnames.ClassNames.fastNull as classNames;
import mui.icon.Icon;
import react.ReactMacro.jsx;
import mui.core.Typography;
import js.Object;
import Common;

@:enum 
abstract CGColors(String) to String {
	var Primary = "#a53fa1"; //purple
	var Secondary = "#84BD55"; //Cagette green	
	var Third = "#E95219";	//orange

	var White = "#FFFFFF";

	var Bg1 = "#E5D3BF"; //light greyed-pink-purple
	var Bg2 = "#F8F4E5"; //same but lighter
	var Bg3 = "#F2EBD9"; //used for active category BG

	var DarkGrey = "#404040";//ex first font
	var MediumGrey = "#7F7F7F";//ex second font
	var LightGrey = "#DDDDDD";
}

// This is not complete but exposes what we are currently using of the theme
typedef Theme = {
	var mixins:Mixins;
	var palette:ColorPalette;
	var spacing:Spacings;
	var zIndex:ZIndexes;

	// TODO: typography
	// TODO: direction
	// TODO: breakpoints
}

typedef Spacings = {
	var unit:Int;
}

typedef Mixins = {
	var appBar:Object;
	var leftPanel:Object;
}

@:enum abstract PaletteType(String) from String to String {
	var Light = "light";
	var Dark = "dark";
}

typedef ColorPalette = {
	var type:PaletteType;
	var contrastThreshold:Int;
	var tonalOffset:Float;
	var getContrastText:haxe.Constraints.Function;
	var augmentColor:haxe.Constraints.Function;

	// TODO: use the real types
	var primary:Dynamic;
	var secondary:Dynamic;
	var error:Dynamic;
	var action:Dynamic;

	//TODO : this is a test at first for cagette
	var cgColors: CGColors;

	var divider:String;

	var background:{
		paper:String,
		// default:String
		// custom values
		dark:String,

		//TODO : this is a test at first for cagette
		cgBg01:CGColors,
		cgBg02:CGColors,
		cgBg03:CGColors,
	};

	/*var grey:{
		// TODO
	};*/

	var text:{
		primary:String,
		secondary:String,
		disabled:String,
		hint:String,
		// custom values
		inverted: String,
		cgFirstfont: CGColors,
		cgSecondfont: CGColors,
	};

	var common:{
		black:String,
		white:String
	};

	// custom values
	var indicator:IndicatorsPalette;
}

typedef IndicatorsPalette = {
	var green:String;
	var yellow:String;
	var orange:String;
	var red:String;
}

typedef ZIndexes = {
	var mobileStepper:Int;
	var appBar:Int;
	var drawer:Int;
	var modal:Int;
	var snackbar:Int;
	var tooltip:Int;
}

class CagetteTheme{

	public static function get(){
		return mui.core.styles.MuiTheme.createMuiTheme({
			palette: {
				primary: 	{main: cast CGColors.Primary},
				secondary: 	{main: cast CGColors.Secondary},
				error: 		{main: cast "#FF0000"},       
			},
			typography: {
				fontFamily:['Cabin', 'icons', '"Helvetica Neue"','Arial','sans-serif',],
				fontSize:16, 
    			//useNextVariants: true,//https://material-ui.com/style/typography/#migration-to-typography-v2
			},
			overrides: {
				MuiButton: { // Name of the component ⚛️ / style sheet
					root: { // Name of the rule
						minHeight: 'initial',
						minWidth: 'initial',
					},
				},
			},
		});
	}

	/**
        Get a mui Icon using Cagette's icon font
    **/
    public static function getIcon(iconId:String,?style:Dynamic){
        var classes = {'icons':true};
        Reflect.setField(classes,"icon-"+iconId,true);
        var iconObj = classNames(classes);
        return jsx('<Icon component="i" className=${iconObj} style=$style></Icon>');
    }

	/**
	return a H2 title
	**/
	public static function h2(text:String){
		return jsx('<Typography variant=${mui.core.typography.TypographyVariant.H2} style=${{fontSize:"2rem",marginTop:22,marginBottom:11}}>
				$text
			</Typography>');
	}

	public static function place(place:PlaceInfos){
		var out = [];
		out.push(jsx('<>${CagetteTheme.getIcon("map-marker")}  ${place.name}<br /></>'));
		if(place.address1!=null) out.push(jsx('<>${place.address1}<br /></>'));
		if(place.address2!=null) out.push(jsx('<>${place.address2}<br /></>'));
		out.push(jsx('<>${place.zipCode} </>'));
		out.push(jsx('<>${place.city}</>'));
		return out;									
	}
}
