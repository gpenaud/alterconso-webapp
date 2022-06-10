package bootstrap;

typedef PopoverOption = {
  ?template: String,
  ?content: String,
  ?title: String,
  ?dismissible: Bool,
  ?trigger: String,
  ?animation: String,
  ?placement: String,
  ?delay: Int,
  ?container: Dynamic,
};

@:jsRequire('bootstrap.native', "Popover")  
extern class Popover {
  public function new (el: js.html.Element, ?option: PopoverOption);
  public function show(): Void;
  public function hide(): Void;
  public function toggle(): Void;
}
