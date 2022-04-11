package bootstrap;

@:jsRequire('bootstrap.native', "Collapse")  
extern class Collapse {
  public function new (el: js.html.Element);
  public function show(): Void;
  public function hide(): Void;
}
