package;
import js.Browser;
import Common;

/**
 * Tutorial javascript widget 
 * @author fbarbut<francois.barbut@gmail.com>
 */
class Tuto
{
	var name:String;
	var step:Int;
	
	static var LAST_ELEMENT :String = null; //last hightlit element
	static var STOP_URL  = "/account?stopTuto=";
	
	public function new(name:String, step:Int){
		this.name = name;
		this.step = step;
		TutoDatas.get(name, init);
	}
	
	/**
	 * asyn init
	 * @param	tuto
	 */
	function init(tuto) 
	{
		var s = tuto.steps[step];
		
		//close previous popovers
		// var p = App.jq(".popover");
		// untyped p.popover('hide');
		
		var t = App.instance.t;
		if (t == null) trace("Gettext translator is null");

		
		if (s == null) {
			/**
			 * tutorial is finished : display a modal window
			 */
			var modalElement = Browser.document.getElementById("myModal");
			var modal = new bootstrap.Modal(modalElement);
			modal.show();

			modalElement.classList.add("help");
			modalElement.querySelector(".modal-header").innerHTML = "<span class='glyphicon glyphicon-hand-right'></span> " + tuto.name;
			modalElement.querySelector(".modal-body").innerHTML = "<span class='glyphicon glyphicon-ok'></span> "+t._("This tutorial is over.");
			modalElement.querySelector(".modal-dialog").classList.remove("modal-lg");

			var btn = Browser.document.createElement("a");
			btn.classList.add("btn");
			btn.classList.add("btn-default");
			btn.innerHTML = "<span class='glyphicon glyphicon-chevron-right'></span> " + t._("Come back to tutorials page");
			btn.onclick = function() {
				modal.hide();
				js.Browser.location.href = STOP_URL + name;
			};
			modalElement.querySelector(".modal-footer").append(btn);			
		} else if (s.element == null) {
			/**
			 * no element, make a modal window (usually its the first step of the tutorial)
			 */
			var modalElement = Browser.document.getElementById("myModal");
			var modal = new bootstrap.Modal(modalElement);
			modal.show();
			
			modalElement.classList.add("help");
			modalElement.querySelector('.modal-body').innerHTML = s.text;
			modalElement.querySelector('.modal-header').innerHTML = "<span class='glyphicon glyphicon-hand-right'></span> "+tuto.name;
			modalElement.querySelector('.modal-dialog').classList.remove("modal-lg");

			var confirmButtonIcon = Browser.document.createElement('i');
			confirmButtonIcon.classList.add("icon");
			confirmButtonIcon.classList.add("icon-chevron-right");
			
			var confirmButton = Browser.document.createElement('a');
			confirmButton.classList.add("btn");
			confirmButton.classList.add("btn-default");
			confirmButton.appendChild(confirmButtonIcon);
			confirmButton.appendChild(Browser.document.createTextNode(" " + t._("OK")));

			modalElement.querySelector(".modal-footer").append(confirmButton);
			
			confirmButton.onclick = function () {
				modal.hide();
				new Tuto(name, step + 1);
			}; 	
		} else {
			
			var elStr: String = cast s.element;
			var el = Browser.document.querySelector(elStr);
			var btn = null;

			var popoverPlacement = switch(s.placement) {
				case TPTop: "top";
				case TPBottom : "bottom";
				case TPLeft : "left";
				case TPRight : "right";
				default : null;
			}

			var popoverFooterId = 'popover-footer-'+ (step+1);
			var popoverFooter = '
				<div id=$popoverFooterId class="footer">
					<div class="pull-left"></div>
					<div class="pull-right"></div>
				</div>
			';

			var popover = new bootstrap.Popover(s.element, {
				trigger: "click",
				container: "body",
				title: tuto.name + ' <div class="pull-right">'+ (step+1) + '/' + tuto.steps.length + '</div>',
				content: ''
				+ '<p>' + s.text + '</p>'
				+ popoverFooter,
				placement: popoverPlacement,
			});
			popover.show();

			switch(s.action) {
				case TANext :
					var nextIcon = Browser.document.createElement('i');
					nextIcon.classList.add("icon");
					nextIcon.classList.add("icon-chevron-right");
					var link = Browser.document.createElement('a');
					link.classList.add("btn");
					link.classList.add("btn-default");
					link.appendChild(nextIcon);
					link.appendChild(Browser.document.createTextNode(" " + t._("Next")));
					btn = Browser.document.createElement('p');
					btn.appendChild(link);

					btn.onclick = function () {
						new Tuto(name, step + 1);
						popover.hide();
						if (LAST_ELEMENT!=null) {
							el.classList.remove("highlight");
						}
					}
				default:
			}	
			
			el.addEventListener("show.bs.popover", function () {
				var footerEl = Browser.document.getElementById(popoverFooterId);
				if (btn != null) footerEl.querySelector(".pull-right").append(btn);
				footerEl.querySelector(".pull-left").append(createCloseButton(t._('Stop')));
			});

			el.classList.add("highlight");
			LAST_ELEMENT = elStr;
		}
	}

	function createCloseButton(?text) {
		var icon = Browser.document.createElement("span");
		icon.classList.add("glyphicon");
		icon.classList.add("glyphicon-remove");

		var btn = Browser.document.createElement("a");
		btn.classList.add("btn");
		btn.classList.add("btn-default");
		btn.classList.add("btn");
		btn.appendChild(icon);
		btn.appendChild(Browser.document.createTextNode(text==null ? "" : text));

		btn.onclick = function() {
			js.Browser.location.href = STOP_URL + name;
		};

		return btn;
	}
}