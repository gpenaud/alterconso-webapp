package bootstrap;

@:jsRequire('bootstrap.native', "Modal")  
extern class Modal {
  public function new (el: js.html.Element);
  public function show(): Void;
  public function hide(): Void;
}
