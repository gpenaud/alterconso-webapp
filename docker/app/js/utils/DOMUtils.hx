package utils;

import js.Browser;
import js.html.Window;
import js.html.Element;

class DOMUtils {

  static public function fadeOut(el: Element) {
    if (el == null) return;

    el.style.opacity = "1";

    function fade() {
      var value: Float = Std.parseFloat(el.style.opacity);
      if (value > 0) {
        value -= .1;
        el.style.opacity = Std.string(value);
        Browser.window.requestAnimationFrame((id: Float) -> {
          fade();
        });
      } else {
        el.style.display = "none";
      }
    }

    fade();
  }

  static public function fadeIn(el: Element, display: String = "block") {
    if (el == null) return;

    el.style.opacity = "0";
    el.style.display = display;

    function fade() {
      var value: Float = Std.parseFloat(el.style.opacity);
      if (value < 1) {
        value += .1;
        el.style.opacity = Std.string(value);
        Browser.window.requestAnimationFrame((id: Float) -> {
          fade();
        });
      } 
    }

    fade();
  }

}