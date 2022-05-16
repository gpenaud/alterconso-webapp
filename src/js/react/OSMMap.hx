package react;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;


/**
 * OpenStreetMap Map
 * @author fbarbut
 */
class OSMMap extends react.ReactComponentOfProps<{place:PlaceInfos,height:Int}>
{

	public function new(props) 
	{
		super(props);
	
	}

    override public function render() {
        
        var p = props.place;

        var bbox = (p.longitude-0.02)+","+(p.latitude-0.02)+","+(p.longitude+0.02)+","+(p.latitude+0.02);
        var layer = "mapnik";
        var marker = p.latitude+","+p.longitude;
        var url = StringTools.urlDecode('https://www.openstreetmap.org/export/embed.html?bbox=$bbox&layer=$layer&marker=$marker');

        //"https://www.openstreetmap.org/export/embed.html?bbox=-0.14144897460937503%2C44.558827052887736%2C-0.08480072021484376%2C44.5853325627196&amp;layer=mapnik&amp;marker=44.57208131778757%2C-0.11312484741210938"

        return jsx('<iframe style=${{border:0,width:"100%",height:props.height}} src=$url ></iframe>');
    }    

    /* <br/>
        <small>
            <a href="https://www.openstreetmap.org/?mlat=44.5721&amp;mlon=-0.1131#map=15/44.5721/-0.1131">
                Afficher une carte plus grande
            </a>
        </small>*/
}


