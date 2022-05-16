package dateFns;

@:jsRequire('date-fns')
extern class DateFns {
  static public function format(date: Dynamic, format: String, ?options: Dynamic): String;
}