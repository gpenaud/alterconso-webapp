package react;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

class CustomReactUtil {
	public static macro function getExtraProps(props:Expr):Expr {
		return switch (Context.typeof(props)) {
			case _ => Context.followWithAbstracts(_) => TypeTools.toComplexType(_) => TAnonymous(fields):
				macro {
					var _tmp = js.Object.assign({}, ${props});

					$a{fields.map(function(f) {
						return macro untyped __js__('delete {0}[{1}]', _tmp, $v{f.name});
					})}

					_tmp;
				};

			default:
				Context.fatalError(
					'getExtraProps() expects an anonymous structure as type of argument',
					Context.currentPos()
				);

				macro {};
		};
	}
}
