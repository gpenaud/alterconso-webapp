package ;
import js.html.InputElement;
import js.Browser;
import Common;

/**
 * 
 * Tag products with categories
 * 
 * @author fbarbut<francois.barbut@gmail.com>
 */
@:keep
class Tagger
{

	var contractId : Int;
	var data:TaggerInfos;
	var pids : Array<Int>; //selected product Ids
	
	public function new(cid:Int) {
		contractId = cid;
		pids = [];
	}
	
	public function init() {
		var req = new haxe.Http("/product/categorizeInit/"+contractId);
		req.onData = function(_data) {			
			data = haxe.Json.parse(_data);	
			render();
		}
		req.request();
	}
	
	function render() {
		var html = new StringBuf();
		html.add("<table class='table'>");
		for (p in data.products) {
			html.add("<tr class='p"+p.product.id+"'>");
			var checked = Lambda.has(pids,p.product.id) ? "checked" : "";
			html.add('<td><input type="checkbox" name="p${p.product.id}" $checked/></td>');
			html.add("<td>" + p.product.name+"</td>");
			var tags = [];
			
			//trace('product tags ${p.categories} from tags ${data.categories}');
			
			for (c in p.categories) {
				//trouve le nom du tag
				var name = "";
				var color = "";
				for (gc in data.categories) {
					for ( t in gc.tags) {
						if (c == t.id) {
							name = t.name;
							color = gc.color;
							break;
						}
					}
				}
				//var bt = App.jq("<a>[X]</a>")
				tags.push("<span class='tag t"+c+"' style='background-color:"+color+";cursor:pointer;'>"+name+"</span>");
			}
			
			html.add("<td class='tags'>"+ tags.join(" ") +"</td>");
			html.add("</tr>");
		}
		html.add("</table>");

		Browser.document.getElementById("tagger").innerHTML = html.toString();
		var tagNdes = Browser.document.querySelectorAll("#tagger .tag");
		for (n in tagNdes) {
			var tag: js.html.Element = cast n;
			tag.onclick = () -> {
				var tid = Std.parseInt(tag.getAttribute('class').split(" ")[1].substr(1));
				var pid = Std.parseInt(tag.parentElement.parentElement.getAttribute('class').substr(1));
				tag.parentNode.removeChild(tag);
				remove(tid,pid);
			};
		}
	}
	
	public function add() {
		var tagEl: InputElement = cast Browser.document.getElementById("tag");
		var tagId = Std.parseInt(tagEl.value);
		
		if (tagId == 0) js.Browser.alert("Impossible de trouver la catégorie selectionnée");
		
		pids = [];

		for (n in Browser.document.querySelectorAll("#tagger input:checked")) {
			var inputEl: js.html.InputElement = cast n;
			pids.push(Std.parseInt(inputEl.getAttribute("name").substr(1)));
		}

		if (pids.length == 0) js.Browser.alert("Sélectionnez un produit afin de pouvoir lui attribuer une catégorie");
		
		for (p in pids) {
			addTag(tagId, p);
		}
		
		render();
	}
	
	public function remove(tagId:Int,productId:Int) {
		//data
		for ( p in data.products) {
			if (p.product.id == productId) {
				for ( t in p.categories) {
					if (t == tagId) p.categories.remove(t);
				}
			}
		}
	}
	
	function addTag(tagId:Int, productId:Int) {
		//check for doubles
		for ( p in data.products) {
			if (p.product.id == productId) {
				for (t in p.categories) {
					if (t == tagId) return;
				}
			}
		}
		
		//data
		for ( p in data.products) {
			if (p.product.id == productId) {
				p.categories.push(tagId);
				break;
			}
		}
	}
	
	public function submit() {
		var req = new haxe.Http("/product/categorizeSubmit/" + contractId);
		req.addParameter("data", haxe.Json.stringify(data));
		req.onData = function(_data) {			
			
			js.Browser.alert(_data);
		}
		req.request(true);
	}
}