'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

function _interopDefault (ex) { return (ex && (typeof ex === 'object') && 'default' in ex) ? ex['default'] : ex; }

var React = require('react');
var React__default = _interopDefault(React);
var core = require('@material-ui/core');
var Autocomplete = _interopDefault(require('@material-ui/lab/Autocomplete'));
var SvgIcon = _interopDefault(require('@material-ui/core/SvgIcon'));
var ReactDOM = _interopDefault(require('react-dom'));
var lab = require('@material-ui/lab');
var formik = require('formik');
var formikMaterialUi = require('formik-material-ui');
var reactLeaflet = require('react-leaflet');

/*! *****************************************************************************
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at http://www.apache.org/licenses/LICENSE-2.0

THIS CODE IS PROVIDED ON AN *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
MERCHANTABLITY OR NON-INFRINGEMENT.

See the Apache Version 2.0 License for specific language governing permissions
and limitations under the License.
***************************************************************************** */

var __assign = function() {
    __assign = Object.assign || function __assign(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};

function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

function __generator(thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
}

function __spreadArrays() {
    for (var s = 0, i = 0, il = arguments.length; i < il; i++) s += arguments[i].length;
    for (var r = Array(s), k = 0, i = 0; i < il; i++)
        for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
            r[k] = a[j];
    return r;
}

var Colors = {
    purple: '#a53fa1',
    green: '#84BD55',
    orange: '#E95219',
    orangeLight: '#E5D3BF',
    orangeExtraLight: '#F8F4E5',
    withe: '#FFFFFF',
    red: '#FF0000',
};
var theme = core.createMuiTheme({
    palette: {
        primary: {
            main: Colors.purple,
        },
        secondary: { main: Colors.green },
        background: {
            default: Colors.orangeExtraLight,
        },
    },
    typography: {
        fontFamily: 'Cabin',
    },
});

var withNeolithicProvider = function (Wrapped) {
    var Wrapper = function (props) {
        /** */
        return (React__default.createElement(core.ThemeProvider, { theme: theme },
            React__default.createElement(core.CssBaseline, null),
            React__default.createElement(Wrapped, __assign({}, props))));
    };
    return Wrapper;
};

var commonjsGlobal = typeof globalThis !== 'undefined' ? globalThis : typeof window !== 'undefined' ? window : typeof global !== 'undefined' ? global : typeof self !== 'undefined' ? self : {};

function unwrapExports (x) {
	return x && x.__esModule && Object.prototype.hasOwnProperty.call(x, 'default') ? x['default'] : x;
}

function createCommonjsModule(fn, module) {
	return module = { exports: {} }, fn(module, module.exports), module.exports;
}

var interopRequireDefault = createCommonjsModule(function (module) {
function _interopRequireDefault(obj) {
  return obj && obj.__esModule ? obj : {
    "default": obj
  };
}

module.exports = _interopRequireDefault;
});

unwrapExports(interopRequireDefault);

var _extends_1 = createCommonjsModule(function (module) {
function _extends() {
  module.exports = _extends = Object.assign || function (target) {
    for (var i = 1; i < arguments.length; i++) {
      var source = arguments[i];

      for (var key in source) {
        if (Object.prototype.hasOwnProperty.call(source, key)) {
          target[key] = source[key];
        }
      }
    }

    return target;
  };

  return _extends.apply(this, arguments);
}

module.exports = _extends;
});

var createSvgIcon_1 = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = createSvgIcon;

var _extends2 = interopRequireDefault(_extends_1);

var _react = interopRequireDefault(React__default);

var _SvgIcon = interopRequireDefault(SvgIcon);

function createSvgIcon(path, displayName) {
  var Component = _react.default.memo(_react.default.forwardRef(function (props, ref) {
    return _react.default.createElement(_SvgIcon.default, (0, _extends2.default)({
      ref: ref
    }, props), path);
  }));

  if (process.env.NODE_ENV !== 'production') {
    Component.displayName = "".concat(displayName, "Icon");
  }

  Component.muiName = _SvgIcon.default.muiName;
  return Component;
}
});

unwrapExports(createSvgIcon_1);

var LocationOn = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"
}), 'LocationOn');

exports.default = _default;
});

var LocationOnIcon = unwrapExports(LocationOn);

/**
 * Checks if `value` is the
 * [language type](http://www.ecma-international.org/ecma-262/7.0/#sec-ecmascript-language-types)
 * of `Object`. (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an object, else `false`.
 * @example
 *
 * _.isObject({});
 * // => true
 *
 * _.isObject([1, 2, 3]);
 * // => true
 *
 * _.isObject(_.noop);
 * // => true
 *
 * _.isObject(null);
 * // => false
 */
function isObject(value) {
  var type = typeof value;
  return value != null && (type == 'object' || type == 'function');
}

var isObject_1 = isObject;

/** Detect free variable `global` from Node.js. */
var freeGlobal = typeof commonjsGlobal == 'object' && commonjsGlobal && commonjsGlobal.Object === Object && commonjsGlobal;

var _freeGlobal = freeGlobal;

/** Detect free variable `self`. */
var freeSelf = typeof self == 'object' && self && self.Object === Object && self;

/** Used as a reference to the global object. */
var root = _freeGlobal || freeSelf || Function('return this')();

var _root = root;

/**
 * Gets the timestamp of the number of milliseconds that have elapsed since
 * the Unix epoch (1 January 1970 00:00:00 UTC).
 *
 * @static
 * @memberOf _
 * @since 2.4.0
 * @category Date
 * @returns {number} Returns the timestamp.
 * @example
 *
 * _.defer(function(stamp) {
 *   console.log(_.now() - stamp);
 * }, _.now());
 * // => Logs the number of milliseconds it took for the deferred invocation.
 */
var now = function() {
  return _root.Date.now();
};

var now_1 = now;

/** Built-in value references. */
var Symbol$1 = _root.Symbol;

var _Symbol = Symbol$1;

/** Used for built-in method references. */
var objectProto = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty = objectProto.hasOwnProperty;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var nativeObjectToString = objectProto.toString;

/** Built-in value references. */
var symToStringTag = _Symbol ? _Symbol.toStringTag : undefined;

/**
 * A specialized version of `baseGetTag` which ignores `Symbol.toStringTag` values.
 *
 * @private
 * @param {*} value The value to query.
 * @returns {string} Returns the raw `toStringTag`.
 */
function getRawTag(value) {
  var isOwn = hasOwnProperty.call(value, symToStringTag),
      tag = value[symToStringTag];

  try {
    value[symToStringTag] = undefined;
    var unmasked = true;
  } catch (e) {}

  var result = nativeObjectToString.call(value);
  if (unmasked) {
    if (isOwn) {
      value[symToStringTag] = tag;
    } else {
      delete value[symToStringTag];
    }
  }
  return result;
}

var _getRawTag = getRawTag;

/** Used for built-in method references. */
var objectProto$1 = Object.prototype;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var nativeObjectToString$1 = objectProto$1.toString;

/**
 * Converts `value` to a string using `Object.prototype.toString`.
 *
 * @private
 * @param {*} value The value to convert.
 * @returns {string} Returns the converted string.
 */
function objectToString(value) {
  return nativeObjectToString$1.call(value);
}

var _objectToString = objectToString;

/** `Object#toString` result references. */
var nullTag = '[object Null]',
    undefinedTag = '[object Undefined]';

/** Built-in value references. */
var symToStringTag$1 = _Symbol ? _Symbol.toStringTag : undefined;

/**
 * The base implementation of `getTag` without fallbacks for buggy environments.
 *
 * @private
 * @param {*} value The value to query.
 * @returns {string} Returns the `toStringTag`.
 */
function baseGetTag(value) {
  if (value == null) {
    return value === undefined ? undefinedTag : nullTag;
  }
  return (symToStringTag$1 && symToStringTag$1 in Object(value))
    ? _getRawTag(value)
    : _objectToString(value);
}

var _baseGetTag = baseGetTag;

/**
 * Checks if `value` is object-like. A value is object-like if it's not `null`
 * and has a `typeof` result of "object".
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
 * @example
 *
 * _.isObjectLike({});
 * // => true
 *
 * _.isObjectLike([1, 2, 3]);
 * // => true
 *
 * _.isObjectLike(_.noop);
 * // => false
 *
 * _.isObjectLike(null);
 * // => false
 */
function isObjectLike(value) {
  return value != null && typeof value == 'object';
}

var isObjectLike_1 = isObjectLike;

/** `Object#toString` result references. */
var symbolTag = '[object Symbol]';

/**
 * Checks if `value` is classified as a `Symbol` primitive or object.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a symbol, else `false`.
 * @example
 *
 * _.isSymbol(Symbol.iterator);
 * // => true
 *
 * _.isSymbol('abc');
 * // => false
 */
function isSymbol(value) {
  return typeof value == 'symbol' ||
    (isObjectLike_1(value) && _baseGetTag(value) == symbolTag);
}

var isSymbol_1 = isSymbol;

/** Used as references for various `Number` constants. */
var NAN = 0 / 0;

/** Used to match leading and trailing whitespace. */
var reTrim = /^\s+|\s+$/g;

/** Used to detect bad signed hexadecimal string values. */
var reIsBadHex = /^[-+]0x[0-9a-f]+$/i;

/** Used to detect binary string values. */
var reIsBinary = /^0b[01]+$/i;

/** Used to detect octal string values. */
var reIsOctal = /^0o[0-7]+$/i;

/** Built-in method references without a dependency on `root`. */
var freeParseInt = parseInt;

/**
 * Converts `value` to a number.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to process.
 * @returns {number} Returns the number.
 * @example
 *
 * _.toNumber(3.2);
 * // => 3.2
 *
 * _.toNumber(Number.MIN_VALUE);
 * // => 5e-324
 *
 * _.toNumber(Infinity);
 * // => Infinity
 *
 * _.toNumber('3.2');
 * // => 3.2
 */
function toNumber(value) {
  if (typeof value == 'number') {
    return value;
  }
  if (isSymbol_1(value)) {
    return NAN;
  }
  if (isObject_1(value)) {
    var other = typeof value.valueOf == 'function' ? value.valueOf() : value;
    value = isObject_1(other) ? (other + '') : other;
  }
  if (typeof value != 'string') {
    return value === 0 ? value : +value;
  }
  value = value.replace(reTrim, '');
  var isBinary = reIsBinary.test(value);
  return (isBinary || reIsOctal.test(value))
    ? freeParseInt(value.slice(2), isBinary ? 2 : 8)
    : (reIsBadHex.test(value) ? NAN : +value);
}

var toNumber_1 = toNumber;

/** Error message constants. */
var FUNC_ERROR_TEXT = 'Expected a function';

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeMax = Math.max,
    nativeMin = Math.min;

/**
 * Creates a debounced function that delays invoking `func` until after `wait`
 * milliseconds have elapsed since the last time the debounced function was
 * invoked. The debounced function comes with a `cancel` method to cancel
 * delayed `func` invocations and a `flush` method to immediately invoke them.
 * Provide `options` to indicate whether `func` should be invoked on the
 * leading and/or trailing edge of the `wait` timeout. The `func` is invoked
 * with the last arguments provided to the debounced function. Subsequent
 * calls to the debounced function return the result of the last `func`
 * invocation.
 *
 * **Note:** If `leading` and `trailing` options are `true`, `func` is
 * invoked on the trailing edge of the timeout only if the debounced function
 * is invoked more than once during the `wait` timeout.
 *
 * If `wait` is `0` and `leading` is `false`, `func` invocation is deferred
 * until to the next tick, similar to `setTimeout` with a timeout of `0`.
 *
 * See [David Corbacho's article](https://css-tricks.com/debouncing-throttling-explained-examples/)
 * for details over the differences between `_.debounce` and `_.throttle`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to debounce.
 * @param {number} [wait=0] The number of milliseconds to delay.
 * @param {Object} [options={}] The options object.
 * @param {boolean} [options.leading=false]
 *  Specify invoking on the leading edge of the timeout.
 * @param {number} [options.maxWait]
 *  The maximum time `func` is allowed to be delayed before it's invoked.
 * @param {boolean} [options.trailing=true]
 *  Specify invoking on the trailing edge of the timeout.
 * @returns {Function} Returns the new debounced function.
 * @example
 *
 * // Avoid costly calculations while the window size is in flux.
 * jQuery(window).on('resize', _.debounce(calculateLayout, 150));
 *
 * // Invoke `sendMail` when clicked, debouncing subsequent calls.
 * jQuery(element).on('click', _.debounce(sendMail, 300, {
 *   'leading': true,
 *   'trailing': false
 * }));
 *
 * // Ensure `batchLog` is invoked once after 1 second of debounced calls.
 * var debounced = _.debounce(batchLog, 250, { 'maxWait': 1000 });
 * var source = new EventSource('/stream');
 * jQuery(source).on('message', debounced);
 *
 * // Cancel the trailing debounced invocation.
 * jQuery(window).on('popstate', debounced.cancel);
 */
function debounce(func, wait, options) {
  var lastArgs,
      lastThis,
      maxWait,
      result,
      timerId,
      lastCallTime,
      lastInvokeTime = 0,
      leading = false,
      maxing = false,
      trailing = true;

  if (typeof func != 'function') {
    throw new TypeError(FUNC_ERROR_TEXT);
  }
  wait = toNumber_1(wait) || 0;
  if (isObject_1(options)) {
    leading = !!options.leading;
    maxing = 'maxWait' in options;
    maxWait = maxing ? nativeMax(toNumber_1(options.maxWait) || 0, wait) : maxWait;
    trailing = 'trailing' in options ? !!options.trailing : trailing;
  }

  function invokeFunc(time) {
    var args = lastArgs,
        thisArg = lastThis;

    lastArgs = lastThis = undefined;
    lastInvokeTime = time;
    result = func.apply(thisArg, args);
    return result;
  }

  function leadingEdge(time) {
    // Reset any `maxWait` timer.
    lastInvokeTime = time;
    // Start the timer for the trailing edge.
    timerId = setTimeout(timerExpired, wait);
    // Invoke the leading edge.
    return leading ? invokeFunc(time) : result;
  }

  function remainingWait(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime,
        timeWaiting = wait - timeSinceLastCall;

    return maxing
      ? nativeMin(timeWaiting, maxWait - timeSinceLastInvoke)
      : timeWaiting;
  }

  function shouldInvoke(time) {
    var timeSinceLastCall = time - lastCallTime,
        timeSinceLastInvoke = time - lastInvokeTime;

    // Either this is the first call, activity has stopped and we're at the
    // trailing edge, the system time has gone backwards and we're treating
    // it as the trailing edge, or we've hit the `maxWait` limit.
    return (lastCallTime === undefined || (timeSinceLastCall >= wait) ||
      (timeSinceLastCall < 0) || (maxing && timeSinceLastInvoke >= maxWait));
  }

  function timerExpired() {
    var time = now_1();
    if (shouldInvoke(time)) {
      return trailingEdge(time);
    }
    // Restart the timer.
    timerId = setTimeout(timerExpired, remainingWait(time));
  }

  function trailingEdge(time) {
    timerId = undefined;

    // Only invoke if we have `lastArgs` which means `func` has been
    // debounced at least once.
    if (trailing && lastArgs) {
      return invokeFunc(time);
    }
    lastArgs = lastThis = undefined;
    return result;
  }

  function cancel() {
    if (timerId !== undefined) {
      clearTimeout(timerId);
    }
    lastInvokeTime = 0;
    lastArgs = lastCallTime = lastThis = timerId = undefined;
  }

  function flush() {
    return timerId === undefined ? result : trailingEdge(now_1());
  }

  function debounced() {
    var time = now_1(),
        isInvoking = shouldInvoke(time);

    lastArgs = arguments;
    lastThis = this;
    lastCallTime = time;

    if (isInvoking) {
      if (timerId === undefined) {
        return leadingEdge(lastCallTime);
      }
      if (maxing) {
        // Handle invocations in a tight loop.
        clearTimeout(timerId);
        timerId = setTimeout(timerExpired, wait);
        return invokeFunc(lastCallTime);
      }
    }
    if (timerId === undefined) {
      timerId = setTimeout(timerExpired, wait);
    }
    return result;
  }
  debounced.cancel = cancel;
  debounced.flush = flush;
  return debounced;
}

var debounce_1 = debounce;

/** Error message constants. */
var FUNC_ERROR_TEXT$1 = 'Expected a function';

/**
 * Creates a throttled function that only invokes `func` at most once per
 * every `wait` milliseconds. The throttled function comes with a `cancel`
 * method to cancel delayed `func` invocations and a `flush` method to
 * immediately invoke them. Provide `options` to indicate whether `func`
 * should be invoked on the leading and/or trailing edge of the `wait`
 * timeout. The `func` is invoked with the last arguments provided to the
 * throttled function. Subsequent calls to the throttled function return the
 * result of the last `func` invocation.
 *
 * **Note:** If `leading` and `trailing` options are `true`, `func` is
 * invoked on the trailing edge of the timeout only if the throttled function
 * is invoked more than once during the `wait` timeout.
 *
 * If `wait` is `0` and `leading` is `false`, `func` invocation is deferred
 * until to the next tick, similar to `setTimeout` with a timeout of `0`.
 *
 * See [David Corbacho's article](https://css-tricks.com/debouncing-throttling-explained-examples/)
 * for details over the differences between `_.throttle` and `_.debounce`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to throttle.
 * @param {number} [wait=0] The number of milliseconds to throttle invocations to.
 * @param {Object} [options={}] The options object.
 * @param {boolean} [options.leading=true]
 *  Specify invoking on the leading edge of the timeout.
 * @param {boolean} [options.trailing=true]
 *  Specify invoking on the trailing edge of the timeout.
 * @returns {Function} Returns the new throttled function.
 * @example
 *
 * // Avoid excessively updating the position while scrolling.
 * jQuery(window).on('scroll', _.throttle(updatePosition, 100));
 *
 * // Invoke `renewToken` when the click event is fired, but not more than once every 5 minutes.
 * var throttled = _.throttle(renewToken, 300000, { 'trailing': false });
 * jQuery(element).on('click', throttled);
 *
 * // Cancel the trailing throttled invocation.
 * jQuery(window).on('popstate', throttled.cancel);
 */
function throttle(func, wait, options) {
  var leading = true,
      trailing = true;

  if (typeof func != 'function') {
    throw new TypeError(FUNC_ERROR_TEXT$1);
  }
  if (isObject_1(options)) {
    leading = 'leading' in options ? !!options.leading : leading;
    trailing = 'trailing' in options ? !!options.trailing : trailing;
  }
  return debounce_1(func, wait, {
    'leading': leading,
    'maxWait': wait,
    'trailing': trailing
  });
}

var throttle_1 = throttle;

var diacritics = createCommonjsModule(function (module) {
// Diacritics.js
// 
// Started as something to be an equivalent of the Google Java Library diacritics library for JavaScript.
// Found this: http://jsperf.com/diacritics/6 and converted it into a reusable module.
// 
// @author Nijiko Yonskai
// @license MIT
// @copyright Nijikokun 2013 <nijikokun@gmail.com>
(function (name, definition) {
  if ( module.exports) module.exports = definition();
  else this[name] = definition();
})('Diacritics', function () {
  // Create public object
  var output = {
    map: {}
  };

  // Create private reference map.
  var reference = [
    {'base':' ',    'letters':'\u00A0'},
    {'base':'A',    'letters':'\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F'},
    {'base':'AA',   'letters':'\uA732'},
    {'base':'AE',   'letters':'\u00C6\u01FC\u01E2'},
    {'base':'AO',   'letters':'\uA734'},
    {'base':'AU',   'letters':'\uA736'},
    {'base':'AV',   'letters':'\uA738\uA73A'},
    {'base':'AY',   'letters':'\uA73C'},
    {'base':'B',    'letters':'\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181'},
    {'base':'C',    'letters':'\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E'},
    {'base':'D',    'letters':'\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779'},
    {'base':'DZ',   'letters':'\u01F1\u01C4'},
    {'base':'Dz',   'letters':'\u01F2\u01C5'},
    {'base':'E',    'letters':'\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E'},
    {'base':'F',    'letters':'\u0046\u24BB\uFF26\u1E1E\u0191\uA77B'},
    {'base':'G',    'letters':'\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E'},
    {'base':'H',    'letters':'\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D'},
    {'base':'I',    'letters':'\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197'},
    {'base':'J',    'letters':'\u004A\u24BF\uFF2A\u0134\u0248'},
    {'base':'K',    'letters':'\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2'},
    {'base':'L',    'letters':'\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780'},
    {'base':'LJ',   'letters':'\u01C7'},
    {'base':'Lj',   'letters':'\u01C8'},
    {'base':'M',    'letters':'\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C'},
    {'base':'N',    'letters':'\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4'},
    {'base':'NJ',   'letters':'\u01CA'},
    {'base':'Nj',   'letters':'\u01CB'},
    {'base':'O',    'letters':'\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C'},
    {'base':'OI',   'letters':'\u01A2'},
    {'base':'OO',   'letters':'\uA74E'},
    {'base':'OU',   'letters':'\u0222'},
    {'base':'P',    'letters':'\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754'},
    {'base':'Q',    'letters':'\u0051\u24C6\uFF31\uA756\uA758\u024A'},
    {'base':'R',    'letters':'\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782'},
    {'base':'S',    'letters':'\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784'},
    {'base':'T',    'letters':'\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786'},
    {'base':'Th',   'letters':'\u00DE'},
    {'base':'TZ',   'letters':'\uA728'},
    {'base':'U',    'letters':'\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244'},
    {'base':'V',    'letters':'\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245'},
    {'base':'VY',   'letters':'\uA760'},
    {'base':'W',    'letters':'\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72'},
    {'base':'X',    'letters':'\u0058\u24CD\uFF38\u1E8A\u1E8C'},
    {'base':'Y',    'letters':'\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE'},
    {'base':'Z',    'letters':'\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762'},
    {'base':'a',    'letters':'\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250\u0251'},
    {'base':'aa',   'letters':'\uA733'},
    {'base':'ae',   'letters':'\u00E6\u01FD\u01E3'},
    {'base':'ao',   'letters':'\uA735'},
    {'base':'au',   'letters':'\uA737'},
    {'base':'av',   'letters':'\uA739\uA73B'},
    {'base':'ay',   'letters':'\uA73D'},
    {'base':'b',    'letters':'\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253'},
    {'base':'c',    'letters':'\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184'},
    {'base':'d',    'letters':'\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A'},
    {'base':'dz',   'letters':'\u01F3\u01C6'},
    {'base':'e',    'letters':'\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD'},
    {'base':'f',    'letters':'\u0066\u24D5\uFF46\u1E1F\u0192\uA77C'},
    {'base':'ff',   'letters':'\uFB00'},
    {'base':'fi',   'letters':'\uFB01'},
    {'base':'fl',   'letters':'\uFB02'},
    {'base':'ffi',  'letters':'\uFB03'},
    {'base':'ffl',  'letters':'\uFB04'},
    {'base':'g',    'letters':'\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F'},
    {'base':'h',    'letters':'\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265'},
    {'base':'hv',   'letters':'\u0195'},
    {'base':'i',    'letters':'\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131'},
    {'base':'j',    'letters':'\u006A\u24D9\uFF4A\u0135\u01F0\u0249'},
    {'base':'k',    'letters':'\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3'},
    {'base':'l',    'letters':'\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747'},
    {'base':'lj',   'letters':'\u01C9'},
    {'base':'m',    'letters':'\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F'},
    {'base':'n',    'letters':'\x6E\xF1\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5\u043B\u0509'},
    {'base':'nj',   'letters':'\u01CC'},
    {'base':'o',    'letters':'\u07C0\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275'},
    {'base':'oe',   'letters':'\u0152\u0153'},
    {'base':'oi',   'letters':'\u01A3'},
    {'base':'ou',   'letters':'\u0223'},
    {'base':'oo',   'letters':'\uA74F'},
    {'base':'p',    'letters':'\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755'},
    {'base':'q',    'letters':'\u0071\u24E0\uFF51\u024B\uA757\uA759'},
    {'base':'r',    'letters':'\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783'},
    {'base':'s',    'letters':'\u0073\u24E2\uFF53\u00DF\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B'},
    {'base':'ss',   'letters':'\xDF'},
    {'base':'t',    'letters':'\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787'},
    {'base':'th',   'letters':'\u00FE'},
    {'base':'tz',   'letters':'\uA729'},
    {'base':'u',    'letters': '\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289'},
    {'base':'v',    'letters':'\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C'},
    {'base':'vy',   'letters':'\uA761'},
    {'base':'w',    'letters':'\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73'},
    {'base':'x',    'letters':'\u0078\u24E7\uFF58\u1E8B\u1E8D'},
    {'base':'y',    'letters':'\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF'},
    {'base':'z',    'letters':'\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763'}
  ];

  // Generate reference mapping
  for (var i = 0, refLength = reference.length; i < refLength; i++){
    var letters = reference[i].letters.split("");

    for (var j = 0, letLength = letters.length; j < letLength; j++){
      output.map[letters[j]] = reference[i].base;
    }
  }

  /**
   * Clean accents (diacritics) from string.
   * 
   * @param  {String} input String to be cleaned of diacritics.
   * @return {String}
   */
  output.clean = function (input) {
    if (!input || !input.length || input.length < 1) {
      return "";
    }

    var string = "";
    var letters = input.split("");
    var index = 0;
    var length = letters.length;
    var letter;

    for (; index < length; index++) {
      letter = letters[index];
      string += letter in output.map ? output.map[letter] : letter;
    }

    return string;
  };

  return output;
});
});

var removeDiacritics = diacritics.clean;

// https://developer.mozilla.org/en/docs/Web/JavaScript/Guide/Regular_Expressions#Using_special_characters
var specialCharsRegex = /[.*+?^${}()|[\]\\]/g;

// http://www.ecma-international.org/ecma-262/5.1/#sec-15.10.2.6
var wordCharacterRegex = /[a-z0-9_]/i;

var whitespacesRegex = /\s+/;

function escapeRegexCharacters(str) {
  return str.replace(specialCharsRegex, '\\$&');
}

var match = function match(text, query) {
  text = removeDiacritics(text);
  query = removeDiacritics(query);

  return (
    query
      .trim()
      .split(whitespacesRegex)
      // If query is blank, we'll get empty string here, so let's filter it out.
      .filter(function(word) {
        return word.length > 0;
      })
      .reduce(function(result, word) {
        var wordLen = word.length;
        var prefix = wordCharacterRegex.test(word[0]) ? '\\b' : '';
        var regex = new RegExp(prefix + escapeRegexCharacters(word), 'i');
        var index = text.search(regex);

        if (index > -1) {
          result.push([index, index + wordLen]);

          // Replace what we just found with spaces so we don't find it again.
          text =
            text.slice(0, index) +
            new Array(wordLen + 1).join(' ') +
            text.slice(index + wordLen);
        }

        return result;
      }, [])
      .sort(function(match1, match2) {
        return match1[0] - match2[0];
      })
  );
};

var parse = function parse(text, matches) {
  var result = [];

  if (matches.length === 0) {
    result.push({
      text: text,
      highlight: false
    });
  } else {
    if (matches[0][0] > 0) {
      result.push({
        text: text.slice(0, matches[0][0]),
        highlight: false
      });
    }
  }

  matches.forEach(function(match, i) {
    var startIndex = match[0];
    var endIndex = match[1];

    result.push({
      text: text.slice(startIndex, endIndex),
      highlight: true
    });

    if (i === matches.length - 1) {
      if (endIndex < text.length) {
        result.push({
          text: text.slice(endIndex, text.length),
          highlight: false
        });
      }
    } else if (endIndex < matches[i + 1][0]) {
      result.push({
        text: text.slice(endIndex, matches[i + 1][0]),
        highlight: false
      });
    }
  });

  return result;
};

var mapboxApiUrlBuilder = function (service, request, options, mapboxToken) {
    var url = "https://api.mapbox.com/geocoding/v5/" + service + "/" + request + ".json?access_token=" + (mapboxToken || process.env.MAPBOX_KEY) + "&language=fr&proximity=2.213749%2C46.227638";
    if (options) {
        url += '&';
        url += Object.keys(options)
            .map(function (key) { return key + "=" + options.get(key); })
            .join('&');
    }
    return url;
};
var getOptionLabel = function (option) { return option.place_name; };
var useStyles = core.makeStyles(function (theme) { return ({
    optionIcon: {
        marginRight: theme.spacing(2),
        color: theme.palette.text.secondary,
    },
    textfield: function () { return ({}); },
}); });
var GeoAutocomplete = function (_a) {
    var initialValue = _a.initialValue, label = _a.label, noOptionsText = _a.noOptionsText, mapboxToken = _a.mapboxToken, onChange = _a.onChange;
    var _b = React__default.useState([]), options = _b[0], setOptions = _b[1];
    var _c = React__default.useState(initialValue || ''), inputValue = _c[0], setInputValue = _c[1];
    var _d = React__default.useState(initialValue && initialValue !== ''), needChange = _d[0], toggleNeedChange = _d[1];
    var cs = useStyles();
    /** */
    var fetchAddress = React__default.useMemo(function () {
        return throttle_1(function (request, callback) {
            var fetchOptions = new Map();
            fetchOptions.set('autocomplete', true);
            fetch(mapboxApiUrlBuilder('mapbox.places', request, fetchOptions, mapboxToken))
                .then(function (res) {
                if (!res.ok)
                    throw new Error(res.statusText);
                return res.json();
            })
                .then(callback);
        }, 200);
    }, []);
    /** */
    var onInputChange = function (e) {
        setInputValue(e.target.value);
    };
    var onAutocompleteChange = function (_e, value) {
        if (value) {
            setInputValue(getOptionLabel(value));
        }
        onChange(value);
    };
    /** */
    React__default.useEffect(function () {
        var active = true;
        if (inputValue === '') {
            setOptions([]);
            return undefined;
        }
        fetchAddress(inputValue, function (results) {
            if (active && results.features) {
                setOptions(results.features);
                if (needChange && inputValue === initialValue && results.features.length > 0) {
                    toggleNeedChange(false);
                    onChange(results.features[0]);
                }
            }
        });
        return function () {
            active = false;
        };
    }, [inputValue, fetchAddress]);
    /** */
    var renderInput = function (inputProps) { return (React__default.createElement(core.TextField, __assign({ className: cs.textfield }, inputProps, { label: label, variant: "outlined", onChange: onInputChange }))); };
    var renderOption = function (option) {
        var optionValue = option.place_name;
        var parts = parse(optionValue, match(optionValue, inputValue));
        return (React__default.createElement(core.Grid, { container: true },
            React__default.createElement(core.Grid, { item: true },
                React__default.createElement(LocationOnIcon, { className: cs.optionIcon })),
            React__default.createElement(core.Grid, { item: true, xs: true },
                React__default.createElement(core.Typography, null),
                parts.map(function (part, index) { return (React__default.createElement("span", { 
                    // eslint-disable-next-line react/no-array-index-key
                    key: index, style: { fontWeight: part.highlight ? 700 : 400 } }, part.text)); }))));
    };
    /** */
    return (React__default.createElement(Autocomplete, { options: options, inputValue: inputValue, getOptionLabel: getOptionLabel, renderOption: renderOption, renderInput: renderInput, noOptionsText: noOptionsText, onChange: onAutocompleteChange }));
};

var parseUserVo = function (data) { return ({
    id: data.id,
    firstName: data.firstName,
    lastName: data.lastName,
    email: data.email,
    phone: data.phone || undefined,
    address1: data.address1 || undefined,
    address2: data.address2 || undefined,
    zipCode: data.zipCode || undefined,
    city: data.city || undefined,
    nationality: data.nationality || undefined,
    countryOfResidence: data.countryOfResidence || undefined,
    birthDate: data.birthDate || undefined,
    firstName2: data.firstName2 || undefined,
    lastName2: data.lastName2 || undefined,
    email2: data.email2 || undefined,
    phone2: data.phone2 || undefined,
}); };
var formatUserAddress = function (user) {
    var res = '';
    if (!user.city && !user.zipCode)
        return undefined;
    if (user.city)
        res = user.city;
    if (user.zipCode)
        res = res + " (" + user.zipCode + ")";
    if (user.address1)
        res = user.address1 + " - " + res;
    return res;
};

var parseSlotVo = function (data) {
    return {
        id: data.id,
        distribId: data.distribId,
        selectedUserIds: data.selectedUserIds,
        registeredUserIds: data.registeredUserIds,
        start: new Date(data.start),
        end: new Date(data.end),
    };
};
var parseDistribVo = function (data) {
    return {
        id: data.id,
        mode: data.mode,
        start: data.start ? new Date(data.start) : undefined,
        end: data.end ? new Date(data.end) : undefined,
        orderEndDate: data.orderEndDate ? new Date(data.orderEndDate) : undefined,
        slots: data.slots ? data.slots.map(parseSlotVo) : undefined,
        inNeedUsers: data.slots ? data.inNeedUsers.map(parseUserVo) : undefined,
    };
};

var parseGroupPreviewVo = function (data) { return ({
    id: data.id,
    name: data.name,
}); };
var parseGroupVo = function (data) {
    return __assign(__assign({}, parseGroupPreviewVo(data)), { iban: data.iban || undefined, user: data.user ? parseUserVo(data.user) : undefined });
};

var parsePlaceVo = function (data) {
    return {
        id: data.id,
        name: data.name,
        address1: data.address1 ? data.address1 : undefined,
        address2: data.address2 ? data.address2 : undefined,
        city: data.city ? data.city : undefined,
        zipCode: data.zipCode ? data.zipCode : undefined,
        lat: data.lat ? data.lat : undefined,
        lng: data.lng ? data.lng : undefined,
    };
};

// import { TOKEN_STORAGE_KEY } from './constants';
var checkRes = function (res) { return __awaiter(void 0, void 0, void 0, function () {
    var error;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                if (!!res.ok) return [3 /*break*/, 2];
                return [4 /*yield*/, res.json()];
            case 1:
                error = _a.sent();
                throw new Error("" + (error.message || error.error.message));
            case 2: return [2 /*return*/, res.json()];
        }
    });
}); };
var request = function (url, init) { return __awaiter(void 0, void 0, void 0, function () {
    var res;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0: return [4 /*yield*/, fetch(url, __assign(__assign({}, init), { credentials: 'include' }))];
            case 1:
                res = _a.sent();
                return [2 /*return*/, checkRes(res)];
        }
    });
}); };
var get = function (url) {
    return request(url);
};
var post = function (url, data, type) {
    if (type === void 0) { type = 'json'; }
    return request(url, __assign({ method: 'POST', headers: __assign({}, (type === 'json'
            ? {
                Accept: 'application/json',
                'Content-Type': 'application/json',
            }
            : {})) }, (data
        ? {
            body: type === 'json' ? JSON.stringify(data) : data,
        }
        : {})));
};
var api = function () {
    var apiUrl = "http://" + (process.env.API_HOSTNAME || 'localhost') + ":" + (process.env.API_PORT || '3000');
    return {
        setUrl: function (url) {
            apiUrl = url;
        },
        login: function (email, password) {
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, post(apiUrl + "/auth/login", {
                                email: email,
                                password: password,
                            })];
                        case 1:
                            res = _a.sent();
                            if (res) {
                                localStorage.setItem('token', res.token);
                                return [2 /*return*/, parseUserVo(res.user)];
                            }
                            return [2 /*return*/, null];
                    }
                });
            });
        },
        me: function () {
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, get(apiUrl + "/user/me")];
                        case 1:
                            res = _a.sent();
                            if (res)
                                return [2 /*return*/, parseUserVo(res)];
                            return [2 /*return*/, null];
                    }
                });
            });
        },
        updateMe: function (data, type) {
            if (type === void 0) { type = 'json'; }
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, post(apiUrl + "/user/me", data, type)];
                        case 1:
                            res = _a.sent();
                            if (res)
                                return [2 /*return*/, parseUserVo(res)];
                            return [2 /*return*/, null];
                    }
                });
            });
        },
        getGroup: function (id) {
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, get(apiUrl + "/groups/" + id)];
                        case 1:
                            res = _a.sent();
                            return [2 /*return*/, res ? parseGroupVo(res) : null];
                    }
                });
            });
        },
        getUser: function (id) {
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, get(apiUrl + "/users/" + id)];
                        case 1:
                            res = _a.sent();
                            return [2 /*return*/, res ? parseUserVo(res) : null];
                    }
                });
            });
        },
        getGroupUsers: function (id) {
            return __awaiter(this, void 0, void 0, function () {
                var res;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, get(apiUrl + "/groups/" + id + "/users")];
                        case 1:
                            res = _a.sent();
                            return [2 /*return*/, res ? res.map(parseUserVo) : null];
                    }
                });
            });
        },
        place: {
            getPlace: function (id) {
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, get(apiUrl + "/places/" + id)];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res ? parsePlaceVo(res) : null];
                        }
                    });
                });
            },
        },
        distrib: {
            getDistrib: function (id) {
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, get(apiUrl + "/distributions/" + id)];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res ? parseDistribVo(res) : null];
                        }
                    });
                });
            },
            getResolvedDistrib: function (id, parser) {
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, get(apiUrl + "/distributions/" + id + "/resolved")];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res ? parser(res) : null];
                        }
                    });
                });
            },
            activateSlots: function (id, data, type) {
                if (type === void 0) { type = 'json'; }
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, post(apiUrl + "/distributions/" + id + "/activateSlots", data, type)];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res ? parseDistribVo(res) : null];
                        }
                    });
                });
            },
            disableSlots: function (id) {
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, post(apiUrl + "/distributions/" + id + "/desactivateSlots")];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res ? parseDistribVo(res) : null];
                        }
                    });
                });
            },
            registerMe: function (distribId, data, type) {
                if (type === void 0) { type = 'json'; }
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, post(apiUrl + "/distributions/" + distribId + "/slots/registerMe", data, type)];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res];
                        }
                    });
                });
            },
            getStatus: function (distribId) {
                return __awaiter(this, void 0, void 0, function () {
                    var res;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0: return [4 /*yield*/, get(apiUrl + "/distributions/" + distribId + "/slots/me")];
                            case 1:
                                res = _a.sent();
                                return [2 /*return*/, res];
                        }
                    });
                });
            },
        },
    };
};
var api$1 = api();

var Check = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"
}), 'Check');

exports.default = _default;
});

var CheckIcon = unwrapExports(Check);

function _defineProperty(obj, key, value) {
  if (key in obj) {
    Object.defineProperty(obj, key, {
      value: value,
      enumerable: true,
      configurable: true,
      writable: true
    });
  } else {
    obj[key] = value;
  }

  return obj;
}

var defineProperty = _defineProperty;

function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

var classCallCheck = _classCallCheck;

function _defineProperties(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

function _createClass(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties(Constructor, staticProps);
  return Constructor;
}

var createClass = _createClass;

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }
var defaultOptions = {
  bindI18n: 'languageChanged',
  bindI18nStore: '',
  // nsMode: 'fallback' // loop through all namespaces given to hook, HOC, render prop for key lookup
  transEmptyNodeValue: '',
  transSupportBasicHtmlNodes: true,
  transKeepBasicHtmlNodesFor: ['br', 'strong', 'i', 'p'],
  // hashTransKey: key => key // calculate a key for Trans component based on defaultValue
  useSuspense: true
};
var i18nInstance;
var I18nContext = React__default.createContext();
function setDefaults() {
  var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
  defaultOptions = _objectSpread({}, defaultOptions, {}, options);
}
function getDefaults() {
  return defaultOptions;
}
var ReportNamespaces =
/*#__PURE__*/
function () {
  function ReportNamespaces() {
    classCallCheck(this, ReportNamespaces);

    this.usedNamespaces = {};
  }

  createClass(ReportNamespaces, [{
    key: "addUsedNamespaces",
    value: function addUsedNamespaces(namespaces) {
      var _this = this;

      namespaces.forEach(function (ns) {
        if (!_this.usedNamespaces[ns]) _this.usedNamespaces[ns] = true;
      });
    }
  }, {
    key: "getUsedNamespaces",
    value: function getUsedNamespaces() {
      return Object.keys(this.usedNamespaces);
    }
  }]);

  return ReportNamespaces;
}();
function setI18n(instance) {
  i18nInstance = instance;
}
function getI18n() {
  return i18nInstance;
}
var initReactI18next = {
  type: '3rdParty',
  init: function init(instance) {
    setDefaults(instance.options.react);
    setI18n(instance);
  }
};

function warn() {
  if (console && console.warn) {
    var _console;

    for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
      args[_key] = arguments[_key];
    }

    if (typeof args[0] === 'string') args[0] = "react-i18next:: ".concat(args[0]);

    (_console = console).warn.apply(_console, args);
  }
}
var alreadyWarned = {};
function warnOnce() {
  for (var _len2 = arguments.length, args = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
    args[_key2] = arguments[_key2];
  }

  if (typeof args[0] === 'string' && alreadyWarned[args[0]]) return;
  if (typeof args[0] === 'string') alreadyWarned[args[0]] = new Date();
  warn.apply(void 0, args);
} // not needed right now
//
// export function deprecated(...args) {
//   if (process && process.env && (!process.env.NODE_ENV || process.env.NODE_ENV === 'development')) {
//     if (typeof args[0] === 'string') args[0] = `deprecation warning -> ${args[0]}`;
//     warnOnce(...args);
//   }
// }

function loadNamespaces(i18n, ns, cb) {
  i18n.loadNamespaces(ns, function () {
    // delay ready if not yet initialized i18n instance
    if (i18n.isInitialized) {
      cb();
    } else {
      var initialized = function initialized() {
        // due to emitter removing issue in i18next we need to delay remove
        setTimeout(function () {
          i18n.off('initialized', initialized);
        }, 0);
        cb();
      };

      i18n.on('initialized', initialized);
    }
  });
}
function hasLoadedNamespace(ns, i18n) {
  var options = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : {};

  if (!i18n.languages || !i18n.languages.length) {
    warnOnce('i18n.languages were undefined or empty', i18n.languages);
    return true;
  }

  var lng = i18n.languages[0];
  var fallbackLng = i18n.options ? i18n.options.fallbackLng : false;
  var lastLng = i18n.languages[i18n.languages.length - 1]; // we're in cimode so this shall pass

  if (lng.toLowerCase() === 'cimode') return true;

  var loadNotPending = function loadNotPending(l, n) {
    var loadState = i18n.services.backendConnector.state["".concat(l, "|").concat(n)];
    return loadState === -1 || loadState === 2;
  }; // bound to trigger on event languageChanging
  // so set ready to false while we are changing the language
  // and namespace pending (depends on having a backend)


  if (options.bindI18n && options.bindI18n.indexOf('languageChanging') > -1 && i18n.services.backendConnector.backend && i18n.isLanguageChangingTo && !loadNotPending(i18n.isLanguageChangingTo, ns)) return false; // loaded -> SUCCESS

  if (i18n.hasResourceBundle(lng, ns)) return true; // were not loading at all -> SEMI SUCCESS

  if (!i18n.services.backendConnector.backend) return true; // failed loading ns - but at least fallback is not pending -> SEMI SUCCESS

  if (loadNotPending(lng, ns) && (!fallbackLng || loadNotPending(lastLng, ns))) return true;
  return false;
}

function _arrayWithHoles(arr) {
  if (Array.isArray(arr)) return arr;
}

var arrayWithHoles = _arrayWithHoles;

function _iterableToArrayLimit(arr, i) {
  if (typeof Symbol === "undefined" || !(Symbol.iterator in Object(arr))) return;
  var _arr = [];
  var _n = true;
  var _d = false;
  var _e = undefined;

  try {
    for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) {
      _arr.push(_s.value);

      if (i && _arr.length === i) break;
    }
  } catch (err) {
    _d = true;
    _e = err;
  } finally {
    try {
      if (!_n && _i["return"] != null) _i["return"]();
    } finally {
      if (_d) throw _e;
    }
  }

  return _arr;
}

var iterableToArrayLimit = _iterableToArrayLimit;

function _arrayLikeToArray(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
}

var arrayLikeToArray = _arrayLikeToArray;

function _unsupportedIterableToArray(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return arrayLikeToArray(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(n);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return arrayLikeToArray(o, minLen);
}

var unsupportedIterableToArray = _unsupportedIterableToArray;

function _nonIterableRest() {
  throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

var nonIterableRest = _nonIterableRest;

function _slicedToArray(arr, i) {
  return arrayWithHoles(arr) || iterableToArrayLimit(arr, i) || unsupportedIterableToArray(arr, i) || nonIterableRest();
}

var slicedToArray = _slicedToArray;

function ownKeys$1(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread$1(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys$1(source, true).forEach(function (key) { defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys$1(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }
function useTranslation(ns) {
  var props = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
  // assert we have the needed i18nInstance
  var i18nFromProps = props.i18n;
  var ReactI18nContext = React.useContext(I18nContext);

  var _ref =  {},
      i18nFromContext = _ref.i18n,
      defaultNSFromContext = _ref.defaultNS;

  var i18n = i18nFromProps || i18nFromContext || getI18n();
  if (i18n && !i18n.reportNamespaces) i18n.reportNamespaces = new ReportNamespaces();

  if (!i18n) {
    warnOnce('You will need pass in an i18next instance by using initReactI18next');

    var notReadyT = function notReadyT(k) {
      return Array.isArray(k) ? k[k.length - 1] : k;
    };

    var retNotReady = [notReadyT, {}, false];
    retNotReady.t = notReadyT;
    retNotReady.i18n = {};
    retNotReady.ready = false;
    return retNotReady;
  }

  var i18nOptions = _objectSpread$1({}, getDefaults(), {}, i18n.options.react, {}, props);

  var useSuspense = i18nOptions.useSuspense; // prepare having a namespace

  var namespaces = ns || defaultNSFromContext || i18n.options && i18n.options.defaultNS;
  namespaces = typeof namespaces === 'string' ? [namespaces] : namespaces || ['translation']; // report namespaces as used

  if (i18n.reportNamespaces.addUsedNamespaces) i18n.reportNamespaces.addUsedNamespaces(namespaces); // are we ready? yes if all namespaces in first language are loaded already (either with data or empty object on failed load)

  var ready = (i18n.isInitialized || i18n.initializedStoreOnce) && namespaces.every(function (n) {
    return hasLoadedNamespace(n, i18n, i18nOptions);
  }); // binding t function to namespace (acts also as rerender trigger)

  function getT() {
    return {
      t: i18n.getFixedT(null, i18nOptions.nsMode === 'fallback' ? namespaces : namespaces[0])
    };
  }

  var _useState = React.useState(getT()),
      _useState2 = slicedToArray(_useState, 2),
      t = _useState2[0],
      setT = _useState2[1]; // seems we can't have functions as value -> wrap it in obj


  var isMounted = React.useRef(true);
  React.useEffect(function () {
    var bindI18n = i18nOptions.bindI18n,
        bindI18nStore = i18nOptions.bindI18nStore;
    isMounted.current = true; // if not ready and not using suspense load the namespaces
    // in side effect and do not call resetT if unmounted

    if (!ready && !useSuspense) {
      loadNamespaces(i18n, namespaces, function () {
        if (isMounted.current) setT(getT());
      });
    }

    function boundReset() {
      if (isMounted.current) setT(getT());
    } // bind events to trigger change, like languageChanged


    if (bindI18n && i18n) i18n.on(bindI18n, boundReset);
    if (bindI18nStore && i18n) i18n.store.on(bindI18nStore, boundReset); // unbinding on unmount

    return function () {
      isMounted.current = false;
      if (bindI18n && i18n) bindI18n.split(' ').forEach(function (e) {
        return i18n.off(e, boundReset);
      });
      if (bindI18nStore && i18n) bindI18nStore.split(' ').forEach(function (e) {
        return i18n.store.off(e, boundReset);
      });
    };
  }, [namespaces.join()]); // re-run effect whenever list of namespaces changes

  var ret = [t.t, i18n, ready];
  ret.t = t.t;
  ret.i18n = i18n;
  ret.ready = ready; // return hook stuff if ready

  if (ready) return ret; // not yet loaded namespaces -> load them -> and return if useSuspense option set false

  if (!ready && !useSuspense) return ret; // not yet loaded namespaces -> load them -> and trigger suspense

  throw new Promise(function (resolve) {
    loadNamespaces(i18n, namespaces, function () {
      if (isMounted.current) setT(getT());
      resolve();
    });
  });
}

function toInteger(dirtyNumber) {
  if (dirtyNumber === null || dirtyNumber === true || dirtyNumber === false) {
    return NaN;
  }

  var number = Number(dirtyNumber);

  if (isNaN(number)) {
    return number;
  }

  return number < 0 ? Math.ceil(number) : Math.floor(number);
}

function requiredArgs(required, args) {
  if (args.length < required) {
    throw new TypeError(required + ' argument' + (required > 1 ? 's' : '') + ' required, but only ' + args.length + ' present');
  }
}

/**
 * @name toDate
 * @category Common Helpers
 * @summary Convert the given argument to an instance of Date.
 *
 * @description
 * Convert the given argument to an instance of Date.
 *
 * If the argument is an instance of Date, the function returns its clone.
 *
 * If the argument is a number, it is treated as a timestamp.
 *
 * If the argument is none of the above, the function returns Invalid Date.
 *
 * **Note**: *all* Date arguments passed to any *date-fns* function is processed by `toDate`.
 *
 * @param {Date|Number} argument - the value to convert
 * @returns {Date} the parsed date in the local time zone
 * @throws {TypeError} 1 argument required
 *
 * @example
 * // Clone the date:
 * const result = toDate(new Date(2014, 1, 11, 11, 30, 30))
 * //=> Tue Feb 11 2014 11:30:30
 *
 * @example
 * // Convert the timestamp to date:
 * const result = toDate(1392098430000)
 * //=> Tue Feb 11 2014 11:30:30
 */

function toDate(argument) {
  requiredArgs(1, arguments);
  var argStr = Object.prototype.toString.call(argument); // Clone the date

  if (argument instanceof Date || typeof argument === 'object' && argStr === '[object Date]') {
    // Prevent the date to lose the milliseconds when passed to new Date() in IE10
    return new Date(argument.getTime());
  } else if (typeof argument === 'number' || argStr === '[object Number]') {
    return new Date(argument);
  } else {
    if ((typeof argument === 'string' || argStr === '[object String]') && typeof console !== 'undefined') {
      // eslint-disable-next-line no-console
      console.warn("Starting with v2.0.0-beta.1 date-fns doesn't accept strings as arguments. Please use `parseISO` to parse strings. See: https://git.io/fjule"); // eslint-disable-next-line no-console

      console.warn(new Error().stack);
    }

    return new Date(NaN);
  }
}

/**
 * @name addMilliseconds
 * @category Millisecond Helpers
 * @summary Add the specified number of milliseconds to the given date.
 *
 * @description
 * Add the specified number of milliseconds to the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date to be changed
 * @param {Number} amount - the amount of milliseconds to be added. Positive decimals will be rounded using `Math.floor`, decimals less than zero will be rounded using `Math.ceil`.
 * @returns {Date} the new date with the milliseconds added
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Add 750 milliseconds to 10 July 2014 12:45:30.000:
 * var result = addMilliseconds(new Date(2014, 6, 10, 12, 45, 30, 0), 750)
 * //=> Thu Jul 10 2014 12:45:30.750
 */

function addMilliseconds(dirtyDate, dirtyAmount) {
  requiredArgs(2, arguments);
  var timestamp = toDate(dirtyDate).getTime();
  var amount = toInteger(dirtyAmount);
  return new Date(timestamp + amount);
}

var MILLISECONDS_IN_MINUTE = 60000;

function getDateMillisecondsPart(date) {
  return date.getTime() % MILLISECONDS_IN_MINUTE;
}
/**
 * Google Chrome as of 67.0.3396.87 introduced timezones with offset that includes seconds.
 * They usually appear for dates that denote time before the timezones were introduced
 * (e.g. for 'Europe/Prague' timezone the offset is GMT+00:57:44 before 1 October 1891
 * and GMT+01:00:00 after that date)
 *
 * Date#getTimezoneOffset returns the offset in minutes and would return 57 for the example above,
 * which would lead to incorrect calculations.
 *
 * This function returns the timezone offset in milliseconds that takes seconds in account.
 */


function getTimezoneOffsetInMilliseconds(dirtyDate) {
  var date = new Date(dirtyDate.getTime());
  var baseTimezoneOffset = Math.ceil(date.getTimezoneOffset());
  date.setSeconds(0, 0);
  var hasNegativeUTCOffset = baseTimezoneOffset > 0;
  var millisecondsPartOfTimezoneOffset = hasNegativeUTCOffset ? (MILLISECONDS_IN_MINUTE + getDateMillisecondsPart(date)) % MILLISECONDS_IN_MINUTE : getDateMillisecondsPart(date);
  return baseTimezoneOffset * MILLISECONDS_IN_MINUTE + millisecondsPartOfTimezoneOffset;
}

/**
 * @name isValid
 * @category Common Helpers
 * @summary Is the given date valid?
 *
 * @description
 * Returns false if argument is Invalid Date and true otherwise.
 * Argument is converted to Date using `toDate`. See [toDate]{@link https://date-fns.org/docs/toDate}
 * Invalid Date is a Date, whose time value is NaN.
 *
 * Time value of Date: http://es5.github.io/#x15.9.1.1
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * - Now `isValid` doesn't throw an exception
 *   if the first argument is not an instance of Date.
 *   Instead, argument is converted beforehand using `toDate`.
 *
 *   Examples:
 *
 *   | `isValid` argument        | Before v2.0.0 | v2.0.0 onward |
 *   |---------------------------|---------------|---------------|
 *   | `new Date()`              | `true`        | `true`        |
 *   | `new Date('2016-01-01')`  | `true`        | `true`        |
 *   | `new Date('')`            | `false`       | `false`       |
 *   | `new Date(1488370835081)` | `true`        | `true`        |
 *   | `new Date(NaN)`           | `false`       | `false`       |
 *   | `'2016-01-01'`            | `TypeError`   | `false`       |
 *   | `''`                      | `TypeError`   | `false`       |
 *   | `1488370835081`           | `TypeError`   | `true`        |
 *   | `NaN`                     | `TypeError`   | `false`       |
 *
 *   We introduce this change to make *date-fns* consistent with ECMAScript behavior
 *   that try to coerce arguments to the expected type
 *   (which is also the case with other *date-fns* functions).
 *
 * @param {*} date - the date to check
 * @returns {Boolean} the date is valid
 * @throws {TypeError} 1 argument required
 *
 * @example
 * // For the valid date:
 * var result = isValid(new Date(2014, 1, 31))
 * //=> true
 *
 * @example
 * // For the value, convertable into a date:
 * var result = isValid(1393804800000)
 * //=> true
 *
 * @example
 * // For the invalid date:
 * var result = isValid(new Date(''))
 * //=> false
 */

function isValid(dirtyDate) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  return !isNaN(date);
}

var formatDistanceLocale = {
  lessThanXSeconds: {
    one: 'less than a second',
    other: 'less than {{count}} seconds'
  },
  xSeconds: {
    one: '1 second',
    other: '{{count}} seconds'
  },
  halfAMinute: 'half a minute',
  lessThanXMinutes: {
    one: 'less than a minute',
    other: 'less than {{count}} minutes'
  },
  xMinutes: {
    one: '1 minute',
    other: '{{count}} minutes'
  },
  aboutXHours: {
    one: 'about 1 hour',
    other: 'about {{count}} hours'
  },
  xHours: {
    one: '1 hour',
    other: '{{count}} hours'
  },
  xDays: {
    one: '1 day',
    other: '{{count}} days'
  },
  aboutXMonths: {
    one: 'about 1 month',
    other: 'about {{count}} months'
  },
  xMonths: {
    one: '1 month',
    other: '{{count}} months'
  },
  aboutXYears: {
    one: 'about 1 year',
    other: 'about {{count}} years'
  },
  xYears: {
    one: '1 year',
    other: '{{count}} years'
  },
  overXYears: {
    one: 'over 1 year',
    other: 'over {{count}} years'
  },
  almostXYears: {
    one: 'almost 1 year',
    other: 'almost {{count}} years'
  }
};
function formatDistance(token, count, options) {
  options = options || {};
  var result;

  if (typeof formatDistanceLocale[token] === 'string') {
    result = formatDistanceLocale[token];
  } else if (count === 1) {
    result = formatDistanceLocale[token].one;
  } else {
    result = formatDistanceLocale[token].other.replace('{{count}}', count);
  }

  if (options.addSuffix) {
    if (options.comparison > 0) {
      return 'in ' + result;
    } else {
      return result + ' ago';
    }
  }

  return result;
}

function buildFormatLongFn(args) {
  return function (dirtyOptions) {
    var options = dirtyOptions || {};
    var width = options.width ? String(options.width) : args.defaultWidth;
    var format = args.formats[width] || args.formats[args.defaultWidth];
    return format;
  };
}

var dateFormats = {
  full: 'EEEE, MMMM do, y',
  long: 'MMMM do, y',
  medium: 'MMM d, y',
  short: 'MM/dd/yyyy'
};
var timeFormats = {
  full: 'h:mm:ss a zzzz',
  long: 'h:mm:ss a z',
  medium: 'h:mm:ss a',
  short: 'h:mm a'
};
var dateTimeFormats = {
  full: "{{date}} 'at' {{time}}",
  long: "{{date}} 'at' {{time}}",
  medium: '{{date}}, {{time}}',
  short: '{{date}}, {{time}}'
};
var formatLong = {
  date: buildFormatLongFn({
    formats: dateFormats,
    defaultWidth: 'full'
  }),
  time: buildFormatLongFn({
    formats: timeFormats,
    defaultWidth: 'full'
  }),
  dateTime: buildFormatLongFn({
    formats: dateTimeFormats,
    defaultWidth: 'full'
  })
};

var formatRelativeLocale = {
  lastWeek: "'last' eeee 'at' p",
  yesterday: "'yesterday at' p",
  today: "'today at' p",
  tomorrow: "'tomorrow at' p",
  nextWeek: "eeee 'at' p",
  other: 'P'
};
function formatRelative(token, _date, _baseDate, _options) {
  return formatRelativeLocale[token];
}

function buildLocalizeFn(args) {
  return function (dirtyIndex, dirtyOptions) {
    var options = dirtyOptions || {};
    var context = options.context ? String(options.context) : 'standalone';
    var valuesArray;

    if (context === 'formatting' && args.formattingValues) {
      var defaultWidth = args.defaultFormattingWidth || args.defaultWidth;
      var width = options.width ? String(options.width) : defaultWidth;
      valuesArray = args.formattingValues[width] || args.formattingValues[defaultWidth];
    } else {
      var _defaultWidth = args.defaultWidth;

      var _width = options.width ? String(options.width) : args.defaultWidth;

      valuesArray = args.values[_width] || args.values[_defaultWidth];
    }

    var index = args.argumentCallback ? args.argumentCallback(dirtyIndex) : dirtyIndex;
    return valuesArray[index];
  };
}

var eraValues = {
  narrow: ['B', 'A'],
  abbreviated: ['BC', 'AD'],
  wide: ['Before Christ', 'Anno Domini']
};
var quarterValues = {
  narrow: ['1', '2', '3', '4'],
  abbreviated: ['Q1', 'Q2', 'Q3', 'Q4'],
  wide: ['1st quarter', '2nd quarter', '3rd quarter', '4th quarter'] // Note: in English, the names of days of the week and months are capitalized.
  // If you are making a new locale based on this one, check if the same is true for the language you're working on.
  // Generally, formatted dates should look like they are in the middle of a sentence,
  // e.g. in Spanish language the weekdays and months should be in the lowercase.

};
var monthValues = {
  narrow: ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
  abbreviated: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  wide: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
};
var dayValues = {
  narrow: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
  short: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
  abbreviated: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
  wide: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
};
var dayPeriodValues = {
  narrow: {
    am: 'a',
    pm: 'p',
    midnight: 'mi',
    noon: 'n',
    morning: 'morning',
    afternoon: 'afternoon',
    evening: 'evening',
    night: 'night'
  },
  abbreviated: {
    am: 'AM',
    pm: 'PM',
    midnight: 'midnight',
    noon: 'noon',
    morning: 'morning',
    afternoon: 'afternoon',
    evening: 'evening',
    night: 'night'
  },
  wide: {
    am: 'a.m.',
    pm: 'p.m.',
    midnight: 'midnight',
    noon: 'noon',
    morning: 'morning',
    afternoon: 'afternoon',
    evening: 'evening',
    night: 'night'
  }
};
var formattingDayPeriodValues = {
  narrow: {
    am: 'a',
    pm: 'p',
    midnight: 'mi',
    noon: 'n',
    morning: 'in the morning',
    afternoon: 'in the afternoon',
    evening: 'in the evening',
    night: 'at night'
  },
  abbreviated: {
    am: 'AM',
    pm: 'PM',
    midnight: 'midnight',
    noon: 'noon',
    morning: 'in the morning',
    afternoon: 'in the afternoon',
    evening: 'in the evening',
    night: 'at night'
  },
  wide: {
    am: 'a.m.',
    pm: 'p.m.',
    midnight: 'midnight',
    noon: 'noon',
    morning: 'in the morning',
    afternoon: 'in the afternoon',
    evening: 'in the evening',
    night: 'at night'
  }
};

function ordinalNumber(dirtyNumber, _dirtyOptions) {
  var number = Number(dirtyNumber); // If ordinal numbers depend on context, for example,
  // if they are different for different grammatical genders,
  // use `options.unit`:
  //
  //   var options = dirtyOptions || {}
  //   var unit = String(options.unit)
  //
  // where `unit` can be 'year', 'quarter', 'month', 'week', 'date', 'dayOfYear',
  // 'day', 'hour', 'minute', 'second'

  var rem100 = number % 100;

  if (rem100 > 20 || rem100 < 10) {
    switch (rem100 % 10) {
      case 1:
        return number + 'st';

      case 2:
        return number + 'nd';

      case 3:
        return number + 'rd';
    }
  }

  return number + 'th';
}

var localize = {
  ordinalNumber: ordinalNumber,
  era: buildLocalizeFn({
    values: eraValues,
    defaultWidth: 'wide'
  }),
  quarter: buildLocalizeFn({
    values: quarterValues,
    defaultWidth: 'wide',
    argumentCallback: function (quarter) {
      return Number(quarter) - 1;
    }
  }),
  month: buildLocalizeFn({
    values: monthValues,
    defaultWidth: 'wide'
  }),
  day: buildLocalizeFn({
    values: dayValues,
    defaultWidth: 'wide'
  }),
  dayPeriod: buildLocalizeFn({
    values: dayPeriodValues,
    defaultWidth: 'wide',
    formattingValues: formattingDayPeriodValues,
    defaultFormattingWidth: 'wide'
  })
};

function buildMatchPatternFn(args) {
  return function (dirtyString, dirtyOptions) {
    var string = String(dirtyString);
    var options = dirtyOptions || {};
    var matchResult = string.match(args.matchPattern);

    if (!matchResult) {
      return null;
    }

    var matchedString = matchResult[0];
    var parseResult = string.match(args.parsePattern);

    if (!parseResult) {
      return null;
    }

    var value = args.valueCallback ? args.valueCallback(parseResult[0]) : parseResult[0];
    value = options.valueCallback ? options.valueCallback(value) : value;
    return {
      value: value,
      rest: string.slice(matchedString.length)
    };
  };
}

function buildMatchFn(args) {
  return function (dirtyString, dirtyOptions) {
    var string = String(dirtyString);
    var options = dirtyOptions || {};
    var width = options.width;
    var matchPattern = width && args.matchPatterns[width] || args.matchPatterns[args.defaultMatchWidth];
    var matchResult = string.match(matchPattern);

    if (!matchResult) {
      return null;
    }

    var matchedString = matchResult[0];
    var parsePatterns = width && args.parsePatterns[width] || args.parsePatterns[args.defaultParseWidth];
    var value;

    if (Object.prototype.toString.call(parsePatterns) === '[object Array]') {
      value = findIndex(parsePatterns, function (pattern) {
        return pattern.test(matchedString);
      });
    } else {
      value = findKey(parsePatterns, function (pattern) {
        return pattern.test(matchedString);
      });
    }

    value = args.valueCallback ? args.valueCallback(value) : value;
    value = options.valueCallback ? options.valueCallback(value) : value;
    return {
      value: value,
      rest: string.slice(matchedString.length)
    };
  };
}

function findKey(object, predicate) {
  for (var key in object) {
    if (object.hasOwnProperty(key) && predicate(object[key])) {
      return key;
    }
  }
}

function findIndex(array, predicate) {
  for (var key = 0; key < array.length; key++) {
    if (predicate(array[key])) {
      return key;
    }
  }
}

var matchOrdinalNumberPattern = /^(\d+)(th|st|nd|rd)?/i;
var parseOrdinalNumberPattern = /\d+/i;
var matchEraPatterns = {
  narrow: /^(b|a)/i,
  abbreviated: /^(b\.?\s?c\.?|b\.?\s?c\.?\s?e\.?|a\.?\s?d\.?|c\.?\s?e\.?)/i,
  wide: /^(before christ|before common era|anno domini|common era)/i
};
var parseEraPatterns = {
  any: [/^b/i, /^(a|c)/i]
};
var matchQuarterPatterns = {
  narrow: /^[1234]/i,
  abbreviated: /^q[1234]/i,
  wide: /^[1234](th|st|nd|rd)? quarter/i
};
var parseQuarterPatterns = {
  any: [/1/i, /2/i, /3/i, /4/i]
};
var matchMonthPatterns = {
  narrow: /^[jfmasond]/i,
  abbreviated: /^(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)/i,
  wide: /^(january|february|march|april|may|june|july|august|september|october|november|december)/i
};
var parseMonthPatterns = {
  narrow: [/^j/i, /^f/i, /^m/i, /^a/i, /^m/i, /^j/i, /^j/i, /^a/i, /^s/i, /^o/i, /^n/i, /^d/i],
  any: [/^ja/i, /^f/i, /^mar/i, /^ap/i, /^may/i, /^jun/i, /^jul/i, /^au/i, /^s/i, /^o/i, /^n/i, /^d/i]
};
var matchDayPatterns = {
  narrow: /^[smtwf]/i,
  short: /^(su|mo|tu|we|th|fr|sa)/i,
  abbreviated: /^(sun|mon|tue|wed|thu|fri|sat)/i,
  wide: /^(sunday|monday|tuesday|wednesday|thursday|friday|saturday)/i
};
var parseDayPatterns = {
  narrow: [/^s/i, /^m/i, /^t/i, /^w/i, /^t/i, /^f/i, /^s/i],
  any: [/^su/i, /^m/i, /^tu/i, /^w/i, /^th/i, /^f/i, /^sa/i]
};
var matchDayPeriodPatterns = {
  narrow: /^(a|p|mi|n|(in the|at) (morning|afternoon|evening|night))/i,
  any: /^([ap]\.?\s?m\.?|midnight|noon|(in the|at) (morning|afternoon|evening|night))/i
};
var parseDayPeriodPatterns = {
  any: {
    am: /^a/i,
    pm: /^p/i,
    midnight: /^mi/i,
    noon: /^no/i,
    morning: /morning/i,
    afternoon: /afternoon/i,
    evening: /evening/i,
    night: /night/i
  }
};
var match$1 = {
  ordinalNumber: buildMatchPatternFn({
    matchPattern: matchOrdinalNumberPattern,
    parsePattern: parseOrdinalNumberPattern,
    valueCallback: function (value) {
      return parseInt(value, 10);
    }
  }),
  era: buildMatchFn({
    matchPatterns: matchEraPatterns,
    defaultMatchWidth: 'wide',
    parsePatterns: parseEraPatterns,
    defaultParseWidth: 'any'
  }),
  quarter: buildMatchFn({
    matchPatterns: matchQuarterPatterns,
    defaultMatchWidth: 'wide',
    parsePatterns: parseQuarterPatterns,
    defaultParseWidth: 'any',
    valueCallback: function (index) {
      return index + 1;
    }
  }),
  month: buildMatchFn({
    matchPatterns: matchMonthPatterns,
    defaultMatchWidth: 'wide',
    parsePatterns: parseMonthPatterns,
    defaultParseWidth: 'any'
  }),
  day: buildMatchFn({
    matchPatterns: matchDayPatterns,
    defaultMatchWidth: 'wide',
    parsePatterns: parseDayPatterns,
    defaultParseWidth: 'any'
  }),
  dayPeriod: buildMatchFn({
    matchPatterns: matchDayPeriodPatterns,
    defaultMatchWidth: 'any',
    parsePatterns: parseDayPeriodPatterns,
    defaultParseWidth: 'any'
  })
};

/**
 * @type {Locale}
 * @category Locales
 * @summary English locale (United States).
 * @language English
 * @iso-639-2 eng
 * @author Sasha Koss [@kossnocorp]{@link https://github.com/kossnocorp}
 * @author Lesha Koss [@leshakoss]{@link https://github.com/leshakoss}
 */

var locale = {
  code: 'en-US',
  formatDistance: formatDistance,
  formatLong: formatLong,
  formatRelative: formatRelative,
  localize: localize,
  match: match$1,
  options: {
    weekStartsOn: 0
    /* Sunday */
    ,
    firstWeekContainsDate: 1
  }
};

/**
 * @name subMilliseconds
 * @category Millisecond Helpers
 * @summary Subtract the specified number of milliseconds from the given date.
 *
 * @description
 * Subtract the specified number of milliseconds from the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date to be changed
 * @param {Number} amount - the amount of milliseconds to be subtracted. Positive decimals will be rounded using `Math.floor`, decimals less than zero will be rounded using `Math.ceil`.
 * @returns {Date} the new date with the milliseconds subtracted
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Subtract 750 milliseconds from 10 July 2014 12:45:30.000:
 * var result = subMilliseconds(new Date(2014, 6, 10, 12, 45, 30, 0), 750)
 * //=> Thu Jul 10 2014 12:45:29.250
 */

function subMilliseconds(dirtyDate, dirtyAmount) {
  requiredArgs(2, arguments);
  var amount = toInteger(dirtyAmount);
  return addMilliseconds(dirtyDate, -amount);
}

function addLeadingZeros(number, targetLength) {
  var sign = number < 0 ? '-' : '';
  var output = Math.abs(number).toString();

  while (output.length < targetLength) {
    output = '0' + output;
  }

  return sign + output;
}

/*
 * |     | Unit                           |     | Unit                           |
 * |-----|--------------------------------|-----|--------------------------------|
 * |  a  | AM, PM                         |  A* |                                |
 * |  d  | Day of month                   |  D  |                                |
 * |  h  | Hour [1-12]                    |  H  | Hour [0-23]                    |
 * |  m  | Minute                         |  M  | Month                          |
 * |  s  | Second                         |  S  | Fraction of second             |
 * |  y  | Year (abs)                     |  Y  |                                |
 *
 * Letters marked by * are not implemented but reserved by Unicode standard.
 */

var formatters = {
  // Year
  y: function (date, token) {
    // From http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_tokens
    // | Year     |     y | yy |   yyy |  yyyy | yyyyy |
    // |----------|-------|----|-------|-------|-------|
    // | AD 1     |     1 | 01 |   001 |  0001 | 00001 |
    // | AD 12    |    12 | 12 |   012 |  0012 | 00012 |
    // | AD 123   |   123 | 23 |   123 |  0123 | 00123 |
    // | AD 1234  |  1234 | 34 |  1234 |  1234 | 01234 |
    // | AD 12345 | 12345 | 45 | 12345 | 12345 | 12345 |
    var signedYear = date.getUTCFullYear(); // Returns 1 for 1 BC (which is year 0 in JavaScript)

    var year = signedYear > 0 ? signedYear : 1 - signedYear;
    return addLeadingZeros(token === 'yy' ? year % 100 : year, token.length);
  },
  // Month
  M: function (date, token) {
    var month = date.getUTCMonth();
    return token === 'M' ? String(month + 1) : addLeadingZeros(month + 1, 2);
  },
  // Day of the month
  d: function (date, token) {
    return addLeadingZeros(date.getUTCDate(), token.length);
  },
  // AM or PM
  a: function (date, token) {
    var dayPeriodEnumValue = date.getUTCHours() / 12 >= 1 ? 'pm' : 'am';

    switch (token) {
      case 'a':
      case 'aa':
      case 'aaa':
        return dayPeriodEnumValue.toUpperCase();

      case 'aaaaa':
        return dayPeriodEnumValue[0];

      case 'aaaa':
      default:
        return dayPeriodEnumValue === 'am' ? 'a.m.' : 'p.m.';
    }
  },
  // Hour [1-12]
  h: function (date, token) {
    return addLeadingZeros(date.getUTCHours() % 12 || 12, token.length);
  },
  // Hour [0-23]
  H: function (date, token) {
    return addLeadingZeros(date.getUTCHours(), token.length);
  },
  // Minute
  m: function (date, token) {
    return addLeadingZeros(date.getUTCMinutes(), token.length);
  },
  // Second
  s: function (date, token) {
    return addLeadingZeros(date.getUTCSeconds(), token.length);
  },
  // Fraction of second
  S: function (date, token) {
    var numberOfDigits = token.length;
    var milliseconds = date.getUTCMilliseconds();
    var fractionalSeconds = Math.floor(milliseconds * Math.pow(10, numberOfDigits - 3));
    return addLeadingZeros(fractionalSeconds, token.length);
  }
};

var MILLISECONDS_IN_DAY = 86400000; // This function will be a part of public API when UTC function will be implemented.
// See issue: https://github.com/date-fns/date-fns/issues/376

function getUTCDayOfYear(dirtyDate) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  var timestamp = date.getTime();
  date.setUTCMonth(0, 1);
  date.setUTCHours(0, 0, 0, 0);
  var startOfYearTimestamp = date.getTime();
  var difference = timestamp - startOfYearTimestamp;
  return Math.floor(difference / MILLISECONDS_IN_DAY) + 1;
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function startOfUTCISOWeek(dirtyDate) {
  requiredArgs(1, arguments);
  var weekStartsOn = 1;
  var date = toDate(dirtyDate);
  var day = date.getUTCDay();
  var diff = (day < weekStartsOn ? 7 : 0) + day - weekStartsOn;
  date.setUTCDate(date.getUTCDate() - diff);
  date.setUTCHours(0, 0, 0, 0);
  return date;
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function getUTCISOWeekYear(dirtyDate) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  var year = date.getUTCFullYear();
  var fourthOfJanuaryOfNextYear = new Date(0);
  fourthOfJanuaryOfNextYear.setUTCFullYear(year + 1, 0, 4);
  fourthOfJanuaryOfNextYear.setUTCHours(0, 0, 0, 0);
  var startOfNextYear = startOfUTCISOWeek(fourthOfJanuaryOfNextYear);
  var fourthOfJanuaryOfThisYear = new Date(0);
  fourthOfJanuaryOfThisYear.setUTCFullYear(year, 0, 4);
  fourthOfJanuaryOfThisYear.setUTCHours(0, 0, 0, 0);
  var startOfThisYear = startOfUTCISOWeek(fourthOfJanuaryOfThisYear);

  if (date.getTime() >= startOfNextYear.getTime()) {
    return year + 1;
  } else if (date.getTime() >= startOfThisYear.getTime()) {
    return year;
  } else {
    return year - 1;
  }
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function startOfUTCISOWeekYear(dirtyDate) {
  requiredArgs(1, arguments);
  var year = getUTCISOWeekYear(dirtyDate);
  var fourthOfJanuary = new Date(0);
  fourthOfJanuary.setUTCFullYear(year, 0, 4);
  fourthOfJanuary.setUTCHours(0, 0, 0, 0);
  var date = startOfUTCISOWeek(fourthOfJanuary);
  return date;
}

var MILLISECONDS_IN_WEEK = 604800000; // This function will be a part of public API when UTC function will be implemented.
// See issue: https://github.com/date-fns/date-fns/issues/376

function getUTCISOWeek(dirtyDate) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  var diff = startOfUTCISOWeek(date).getTime() - startOfUTCISOWeekYear(date).getTime(); // Round the number of days to the nearest integer
  // because the number of milliseconds in a week is not constant
  // (e.g. it's different in the week of the daylight saving time clock shift)

  return Math.round(diff / MILLISECONDS_IN_WEEK) + 1;
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function startOfUTCWeek(dirtyDate, dirtyOptions) {
  requiredArgs(1, arguments);
  var options = dirtyOptions || {};
  var locale = options.locale;
  var localeWeekStartsOn = locale && locale.options && locale.options.weekStartsOn;
  var defaultWeekStartsOn = localeWeekStartsOn == null ? 0 : toInteger(localeWeekStartsOn);
  var weekStartsOn = options.weekStartsOn == null ? defaultWeekStartsOn : toInteger(options.weekStartsOn); // Test if weekStartsOn is between 0 and 6 _and_ is not NaN

  if (!(weekStartsOn >= 0 && weekStartsOn <= 6)) {
    throw new RangeError('weekStartsOn must be between 0 and 6 inclusively');
  }

  var date = toDate(dirtyDate);
  var day = date.getUTCDay();
  var diff = (day < weekStartsOn ? 7 : 0) + day - weekStartsOn;
  date.setUTCDate(date.getUTCDate() - diff);
  date.setUTCHours(0, 0, 0, 0);
  return date;
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function getUTCWeekYear(dirtyDate, dirtyOptions) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate, dirtyOptions);
  var year = date.getUTCFullYear();
  var options = dirtyOptions || {};
  var locale = options.locale;
  var localeFirstWeekContainsDate = locale && locale.options && locale.options.firstWeekContainsDate;
  var defaultFirstWeekContainsDate = localeFirstWeekContainsDate == null ? 1 : toInteger(localeFirstWeekContainsDate);
  var firstWeekContainsDate = options.firstWeekContainsDate == null ? defaultFirstWeekContainsDate : toInteger(options.firstWeekContainsDate); // Test if weekStartsOn is between 1 and 7 _and_ is not NaN

  if (!(firstWeekContainsDate >= 1 && firstWeekContainsDate <= 7)) {
    throw new RangeError('firstWeekContainsDate must be between 1 and 7 inclusively');
  }

  var firstWeekOfNextYear = new Date(0);
  firstWeekOfNextYear.setUTCFullYear(year + 1, 0, firstWeekContainsDate);
  firstWeekOfNextYear.setUTCHours(0, 0, 0, 0);
  var startOfNextYear = startOfUTCWeek(firstWeekOfNextYear, dirtyOptions);
  var firstWeekOfThisYear = new Date(0);
  firstWeekOfThisYear.setUTCFullYear(year, 0, firstWeekContainsDate);
  firstWeekOfThisYear.setUTCHours(0, 0, 0, 0);
  var startOfThisYear = startOfUTCWeek(firstWeekOfThisYear, dirtyOptions);

  if (date.getTime() >= startOfNextYear.getTime()) {
    return year + 1;
  } else if (date.getTime() >= startOfThisYear.getTime()) {
    return year;
  } else {
    return year - 1;
  }
}

// See issue: https://github.com/date-fns/date-fns/issues/376

function startOfUTCWeekYear(dirtyDate, dirtyOptions) {
  requiredArgs(1, arguments);
  var options = dirtyOptions || {};
  var locale = options.locale;
  var localeFirstWeekContainsDate = locale && locale.options && locale.options.firstWeekContainsDate;
  var defaultFirstWeekContainsDate = localeFirstWeekContainsDate == null ? 1 : toInteger(localeFirstWeekContainsDate);
  var firstWeekContainsDate = options.firstWeekContainsDate == null ? defaultFirstWeekContainsDate : toInteger(options.firstWeekContainsDate);
  var year = getUTCWeekYear(dirtyDate, dirtyOptions);
  var firstWeek = new Date(0);
  firstWeek.setUTCFullYear(year, 0, firstWeekContainsDate);
  firstWeek.setUTCHours(0, 0, 0, 0);
  var date = startOfUTCWeek(firstWeek, dirtyOptions);
  return date;
}

var MILLISECONDS_IN_WEEK$1 = 604800000; // This function will be a part of public API when UTC function will be implemented.
// See issue: https://github.com/date-fns/date-fns/issues/376

function getUTCWeek(dirtyDate, options) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  var diff = startOfUTCWeek(date, options).getTime() - startOfUTCWeekYear(date, options).getTime(); // Round the number of days to the nearest integer
  // because the number of milliseconds in a week is not constant
  // (e.g. it's different in the week of the daylight saving time clock shift)

  return Math.round(diff / MILLISECONDS_IN_WEEK$1) + 1;
}

var dayPeriodEnum = {
  am: 'am',
  pm: 'pm',
  midnight: 'midnight',
  noon: 'noon',
  morning: 'morning',
  afternoon: 'afternoon',
  evening: 'evening',
  night: 'night'
  /*
   * |     | Unit                           |     | Unit                           |
   * |-----|--------------------------------|-----|--------------------------------|
   * |  a  | AM, PM                         |  A* | Milliseconds in day            |
   * |  b  | AM, PM, noon, midnight         |  B  | Flexible day period            |
   * |  c  | Stand-alone local day of week  |  C* | Localized hour w/ day period   |
   * |  d  | Day of month                   |  D  | Day of year                    |
   * |  e  | Local day of week              |  E  | Day of week                    |
   * |  f  |                                |  F* | Day of week in month           |
   * |  g* | Modified Julian day            |  G  | Era                            |
   * |  h  | Hour [1-12]                    |  H  | Hour [0-23]                    |
   * |  i! | ISO day of week                |  I! | ISO week of year               |
   * |  j* | Localized hour w/ day period   |  J* | Localized hour w/o day period  |
   * |  k  | Hour [1-24]                    |  K  | Hour [0-11]                    |
   * |  l* | (deprecated)                   |  L  | Stand-alone month              |
   * |  m  | Minute                         |  M  | Month                          |
   * |  n  |                                |  N  |                                |
   * |  o! | Ordinal number modifier        |  O  | Timezone (GMT)                 |
   * |  p! | Long localized time            |  P! | Long localized date            |
   * |  q  | Stand-alone quarter            |  Q  | Quarter                        |
   * |  r* | Related Gregorian year         |  R! | ISO week-numbering year        |
   * |  s  | Second                         |  S  | Fraction of second             |
   * |  t! | Seconds timestamp              |  T! | Milliseconds timestamp         |
   * |  u  | Extended year                  |  U* | Cyclic year                    |
   * |  v* | Timezone (generic non-locat.)  |  V* | Timezone (location)            |
   * |  w  | Local week of year             |  W* | Week of month                  |
   * |  x  | Timezone (ISO-8601 w/o Z)      |  X  | Timezone (ISO-8601)            |
   * |  y  | Year (abs)                     |  Y  | Local week-numbering year      |
   * |  z  | Timezone (specific non-locat.) |  Z* | Timezone (aliases)             |
   *
   * Letters marked by * are not implemented but reserved by Unicode standard.
   *
   * Letters marked by ! are non-standard, but implemented by date-fns:
   * - `o` modifies the previous token to turn it into an ordinal (see `format` docs)
   * - `i` is ISO day of week. For `i` and `ii` is returns numeric ISO week days,
   *   i.e. 7 for Sunday, 1 for Monday, etc.
   * - `I` is ISO week of year, as opposed to `w` which is local week of year.
   * - `R` is ISO week-numbering year, as opposed to `Y` which is local week-numbering year.
   *   `R` is supposed to be used in conjunction with `I` and `i`
   *   for universal ISO week-numbering date, whereas
   *   `Y` is supposed to be used in conjunction with `w` and `e`
   *   for week-numbering date specific to the locale.
   * - `P` is long localized date format
   * - `p` is long localized time format
   */

};
var formatters$1 = {
  // Era
  G: function (date, token, localize) {
    var era = date.getUTCFullYear() > 0 ? 1 : 0;

    switch (token) {
      // AD, BC
      case 'G':
      case 'GG':
      case 'GGG':
        return localize.era(era, {
          width: 'abbreviated'
        });
      // A, B

      case 'GGGGG':
        return localize.era(era, {
          width: 'narrow'
        });
      // Anno Domini, Before Christ

      case 'GGGG':
      default:
        return localize.era(era, {
          width: 'wide'
        });
    }
  },
  // Year
  y: function (date, token, localize) {
    // Ordinal number
    if (token === 'yo') {
      var signedYear = date.getUTCFullYear(); // Returns 1 for 1 BC (which is year 0 in JavaScript)

      var year = signedYear > 0 ? signedYear : 1 - signedYear;
      return localize.ordinalNumber(year, {
        unit: 'year'
      });
    }

    return formatters.y(date, token);
  },
  // Local week-numbering year
  Y: function (date, token, localize, options) {
    var signedWeekYear = getUTCWeekYear(date, options); // Returns 1 for 1 BC (which is year 0 in JavaScript)

    var weekYear = signedWeekYear > 0 ? signedWeekYear : 1 - signedWeekYear; // Two digit year

    if (token === 'YY') {
      var twoDigitYear = weekYear % 100;
      return addLeadingZeros(twoDigitYear, 2);
    } // Ordinal number


    if (token === 'Yo') {
      return localize.ordinalNumber(weekYear, {
        unit: 'year'
      });
    } // Padding


    return addLeadingZeros(weekYear, token.length);
  },
  // ISO week-numbering year
  R: function (date, token) {
    var isoWeekYear = getUTCISOWeekYear(date); // Padding

    return addLeadingZeros(isoWeekYear, token.length);
  },
  // Extended year. This is a single number designating the year of this calendar system.
  // The main difference between `y` and `u` localizers are B.C. years:
  // | Year | `y` | `u` |
  // |------|-----|-----|
  // | AC 1 |   1 |   1 |
  // | BC 1 |   1 |   0 |
  // | BC 2 |   2 |  -1 |
  // Also `yy` always returns the last two digits of a year,
  // while `uu` pads single digit years to 2 characters and returns other years unchanged.
  u: function (date, token) {
    var year = date.getUTCFullYear();
    return addLeadingZeros(year, token.length);
  },
  // Quarter
  Q: function (date, token, localize) {
    var quarter = Math.ceil((date.getUTCMonth() + 1) / 3);

    switch (token) {
      // 1, 2, 3, 4
      case 'Q':
        return String(quarter);
      // 01, 02, 03, 04

      case 'QQ':
        return addLeadingZeros(quarter, 2);
      // 1st, 2nd, 3rd, 4th

      case 'Qo':
        return localize.ordinalNumber(quarter, {
          unit: 'quarter'
        });
      // Q1, Q2, Q3, Q4

      case 'QQQ':
        return localize.quarter(quarter, {
          width: 'abbreviated',
          context: 'formatting'
        });
      // 1, 2, 3, 4 (narrow quarter; could be not numerical)

      case 'QQQQQ':
        return localize.quarter(quarter, {
          width: 'narrow',
          context: 'formatting'
        });
      // 1st quarter, 2nd quarter, ...

      case 'QQQQ':
      default:
        return localize.quarter(quarter, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // Stand-alone quarter
  q: function (date, token, localize) {
    var quarter = Math.ceil((date.getUTCMonth() + 1) / 3);

    switch (token) {
      // 1, 2, 3, 4
      case 'q':
        return String(quarter);
      // 01, 02, 03, 04

      case 'qq':
        return addLeadingZeros(quarter, 2);
      // 1st, 2nd, 3rd, 4th

      case 'qo':
        return localize.ordinalNumber(quarter, {
          unit: 'quarter'
        });
      // Q1, Q2, Q3, Q4

      case 'qqq':
        return localize.quarter(quarter, {
          width: 'abbreviated',
          context: 'standalone'
        });
      // 1, 2, 3, 4 (narrow quarter; could be not numerical)

      case 'qqqqq':
        return localize.quarter(quarter, {
          width: 'narrow',
          context: 'standalone'
        });
      // 1st quarter, 2nd quarter, ...

      case 'qqqq':
      default:
        return localize.quarter(quarter, {
          width: 'wide',
          context: 'standalone'
        });
    }
  },
  // Month
  M: function (date, token, localize) {
    var month = date.getUTCMonth();

    switch (token) {
      case 'M':
      case 'MM':
        return formatters.M(date, token);
      // 1st, 2nd, ..., 12th

      case 'Mo':
        return localize.ordinalNumber(month + 1, {
          unit: 'month'
        });
      // Jan, Feb, ..., Dec

      case 'MMM':
        return localize.month(month, {
          width: 'abbreviated',
          context: 'formatting'
        });
      // J, F, ..., D

      case 'MMMMM':
        return localize.month(month, {
          width: 'narrow',
          context: 'formatting'
        });
      // January, February, ..., December

      case 'MMMM':
      default:
        return localize.month(month, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // Stand-alone month
  L: function (date, token, localize) {
    var month = date.getUTCMonth();

    switch (token) {
      // 1, 2, ..., 12
      case 'L':
        return String(month + 1);
      // 01, 02, ..., 12

      case 'LL':
        return addLeadingZeros(month + 1, 2);
      // 1st, 2nd, ..., 12th

      case 'Lo':
        return localize.ordinalNumber(month + 1, {
          unit: 'month'
        });
      // Jan, Feb, ..., Dec

      case 'LLL':
        return localize.month(month, {
          width: 'abbreviated',
          context: 'standalone'
        });
      // J, F, ..., D

      case 'LLLLL':
        return localize.month(month, {
          width: 'narrow',
          context: 'standalone'
        });
      // January, February, ..., December

      case 'LLLL':
      default:
        return localize.month(month, {
          width: 'wide',
          context: 'standalone'
        });
    }
  },
  // Local week of year
  w: function (date, token, localize, options) {
    var week = getUTCWeek(date, options);

    if (token === 'wo') {
      return localize.ordinalNumber(week, {
        unit: 'week'
      });
    }

    return addLeadingZeros(week, token.length);
  },
  // ISO week of year
  I: function (date, token, localize) {
    var isoWeek = getUTCISOWeek(date);

    if (token === 'Io') {
      return localize.ordinalNumber(isoWeek, {
        unit: 'week'
      });
    }

    return addLeadingZeros(isoWeek, token.length);
  },
  // Day of the month
  d: function (date, token, localize) {
    if (token === 'do') {
      return localize.ordinalNumber(date.getUTCDate(), {
        unit: 'date'
      });
    }

    return formatters.d(date, token);
  },
  // Day of year
  D: function (date, token, localize) {
    var dayOfYear = getUTCDayOfYear(date);

    if (token === 'Do') {
      return localize.ordinalNumber(dayOfYear, {
        unit: 'dayOfYear'
      });
    }

    return addLeadingZeros(dayOfYear, token.length);
  },
  // Day of week
  E: function (date, token, localize) {
    var dayOfWeek = date.getUTCDay();

    switch (token) {
      // Tue
      case 'E':
      case 'EE':
      case 'EEE':
        return localize.day(dayOfWeek, {
          width: 'abbreviated',
          context: 'formatting'
        });
      // T

      case 'EEEEE':
        return localize.day(dayOfWeek, {
          width: 'narrow',
          context: 'formatting'
        });
      // Tu

      case 'EEEEEE':
        return localize.day(dayOfWeek, {
          width: 'short',
          context: 'formatting'
        });
      // Tuesday

      case 'EEEE':
      default:
        return localize.day(dayOfWeek, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // Local day of week
  e: function (date, token, localize, options) {
    var dayOfWeek = date.getUTCDay();
    var localDayOfWeek = (dayOfWeek - options.weekStartsOn + 8) % 7 || 7;

    switch (token) {
      // Numerical value (Nth day of week with current locale or weekStartsOn)
      case 'e':
        return String(localDayOfWeek);
      // Padded numerical value

      case 'ee':
        return addLeadingZeros(localDayOfWeek, 2);
      // 1st, 2nd, ..., 7th

      case 'eo':
        return localize.ordinalNumber(localDayOfWeek, {
          unit: 'day'
        });

      case 'eee':
        return localize.day(dayOfWeek, {
          width: 'abbreviated',
          context: 'formatting'
        });
      // T

      case 'eeeee':
        return localize.day(dayOfWeek, {
          width: 'narrow',
          context: 'formatting'
        });
      // Tu

      case 'eeeeee':
        return localize.day(dayOfWeek, {
          width: 'short',
          context: 'formatting'
        });
      // Tuesday

      case 'eeee':
      default:
        return localize.day(dayOfWeek, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // Stand-alone local day of week
  c: function (date, token, localize, options) {
    var dayOfWeek = date.getUTCDay();
    var localDayOfWeek = (dayOfWeek - options.weekStartsOn + 8) % 7 || 7;

    switch (token) {
      // Numerical value (same as in `e`)
      case 'c':
        return String(localDayOfWeek);
      // Padded numerical value

      case 'cc':
        return addLeadingZeros(localDayOfWeek, token.length);
      // 1st, 2nd, ..., 7th

      case 'co':
        return localize.ordinalNumber(localDayOfWeek, {
          unit: 'day'
        });

      case 'ccc':
        return localize.day(dayOfWeek, {
          width: 'abbreviated',
          context: 'standalone'
        });
      // T

      case 'ccccc':
        return localize.day(dayOfWeek, {
          width: 'narrow',
          context: 'standalone'
        });
      // Tu

      case 'cccccc':
        return localize.day(dayOfWeek, {
          width: 'short',
          context: 'standalone'
        });
      // Tuesday

      case 'cccc':
      default:
        return localize.day(dayOfWeek, {
          width: 'wide',
          context: 'standalone'
        });
    }
  },
  // ISO day of week
  i: function (date, token, localize) {
    var dayOfWeek = date.getUTCDay();
    var isoDayOfWeek = dayOfWeek === 0 ? 7 : dayOfWeek;

    switch (token) {
      // 2
      case 'i':
        return String(isoDayOfWeek);
      // 02

      case 'ii':
        return addLeadingZeros(isoDayOfWeek, token.length);
      // 2nd

      case 'io':
        return localize.ordinalNumber(isoDayOfWeek, {
          unit: 'day'
        });
      // Tue

      case 'iii':
        return localize.day(dayOfWeek, {
          width: 'abbreviated',
          context: 'formatting'
        });
      // T

      case 'iiiii':
        return localize.day(dayOfWeek, {
          width: 'narrow',
          context: 'formatting'
        });
      // Tu

      case 'iiiiii':
        return localize.day(dayOfWeek, {
          width: 'short',
          context: 'formatting'
        });
      // Tuesday

      case 'iiii':
      default:
        return localize.day(dayOfWeek, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // AM or PM
  a: function (date, token, localize) {
    var hours = date.getUTCHours();
    var dayPeriodEnumValue = hours / 12 >= 1 ? 'pm' : 'am';

    switch (token) {
      case 'a':
      case 'aa':
      case 'aaa':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'abbreviated',
          context: 'formatting'
        });

      case 'aaaaa':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'narrow',
          context: 'formatting'
        });

      case 'aaaa':
      default:
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // AM, PM, midnight, noon
  b: function (date, token, localize) {
    var hours = date.getUTCHours();
    var dayPeriodEnumValue;

    if (hours === 12) {
      dayPeriodEnumValue = dayPeriodEnum.noon;
    } else if (hours === 0) {
      dayPeriodEnumValue = dayPeriodEnum.midnight;
    } else {
      dayPeriodEnumValue = hours / 12 >= 1 ? 'pm' : 'am';
    }

    switch (token) {
      case 'b':
      case 'bb':
      case 'bbb':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'abbreviated',
          context: 'formatting'
        });

      case 'bbbbb':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'narrow',
          context: 'formatting'
        });

      case 'bbbb':
      default:
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // in the morning, in the afternoon, in the evening, at night
  B: function (date, token, localize) {
    var hours = date.getUTCHours();
    var dayPeriodEnumValue;

    if (hours >= 17) {
      dayPeriodEnumValue = dayPeriodEnum.evening;
    } else if (hours >= 12) {
      dayPeriodEnumValue = dayPeriodEnum.afternoon;
    } else if (hours >= 4) {
      dayPeriodEnumValue = dayPeriodEnum.morning;
    } else {
      dayPeriodEnumValue = dayPeriodEnum.night;
    }

    switch (token) {
      case 'B':
      case 'BB':
      case 'BBB':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'abbreviated',
          context: 'formatting'
        });

      case 'BBBBB':
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'narrow',
          context: 'formatting'
        });

      case 'BBBB':
      default:
        return localize.dayPeriod(dayPeriodEnumValue, {
          width: 'wide',
          context: 'formatting'
        });
    }
  },
  // Hour [1-12]
  h: function (date, token, localize) {
    if (token === 'ho') {
      var hours = date.getUTCHours() % 12;
      if (hours === 0) hours = 12;
      return localize.ordinalNumber(hours, {
        unit: 'hour'
      });
    }

    return formatters.h(date, token);
  },
  // Hour [0-23]
  H: function (date, token, localize) {
    if (token === 'Ho') {
      return localize.ordinalNumber(date.getUTCHours(), {
        unit: 'hour'
      });
    }

    return formatters.H(date, token);
  },
  // Hour [0-11]
  K: function (date, token, localize) {
    var hours = date.getUTCHours() % 12;

    if (token === 'Ko') {
      return localize.ordinalNumber(hours, {
        unit: 'hour'
      });
    }

    return addLeadingZeros(hours, token.length);
  },
  // Hour [1-24]
  k: function (date, token, localize) {
    var hours = date.getUTCHours();
    if (hours === 0) hours = 24;

    if (token === 'ko') {
      return localize.ordinalNumber(hours, {
        unit: 'hour'
      });
    }

    return addLeadingZeros(hours, token.length);
  },
  // Minute
  m: function (date, token, localize) {
    if (token === 'mo') {
      return localize.ordinalNumber(date.getUTCMinutes(), {
        unit: 'minute'
      });
    }

    return formatters.m(date, token);
  },
  // Second
  s: function (date, token, localize) {
    if (token === 'so') {
      return localize.ordinalNumber(date.getUTCSeconds(), {
        unit: 'second'
      });
    }

    return formatters.s(date, token);
  },
  // Fraction of second
  S: function (date, token) {
    return formatters.S(date, token);
  },
  // Timezone (ISO-8601. If offset is 0, output is always `'Z'`)
  X: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timezoneOffset = originalDate.getTimezoneOffset();

    if (timezoneOffset === 0) {
      return 'Z';
    }

    switch (token) {
      // Hours and optional minutes
      case 'X':
        return formatTimezoneWithOptionalMinutes(timezoneOffset);
      // Hours, minutes and optional seconds without `:` delimiter
      // Note: neither ISO-8601 nor JavaScript supports seconds in timezone offsets
      // so this token always has the same output as `XX`

      case 'XXXX':
      case 'XX':
        // Hours and minutes without `:` delimiter
        return formatTimezone(timezoneOffset);
      // Hours, minutes and optional seconds with `:` delimiter
      // Note: neither ISO-8601 nor JavaScript supports seconds in timezone offsets
      // so this token always has the same output as `XXX`

      case 'XXXXX':
      case 'XXX': // Hours and minutes with `:` delimiter

      default:
        return formatTimezone(timezoneOffset, ':');
    }
  },
  // Timezone (ISO-8601. If offset is 0, output is `'+00:00'` or equivalent)
  x: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timezoneOffset = originalDate.getTimezoneOffset();

    switch (token) {
      // Hours and optional minutes
      case 'x':
        return formatTimezoneWithOptionalMinutes(timezoneOffset);
      // Hours, minutes and optional seconds without `:` delimiter
      // Note: neither ISO-8601 nor JavaScript supports seconds in timezone offsets
      // so this token always has the same output as `xx`

      case 'xxxx':
      case 'xx':
        // Hours and minutes without `:` delimiter
        return formatTimezone(timezoneOffset);
      // Hours, minutes and optional seconds with `:` delimiter
      // Note: neither ISO-8601 nor JavaScript supports seconds in timezone offsets
      // so this token always has the same output as `xxx`

      case 'xxxxx':
      case 'xxx': // Hours and minutes with `:` delimiter

      default:
        return formatTimezone(timezoneOffset, ':');
    }
  },
  // Timezone (GMT)
  O: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timezoneOffset = originalDate.getTimezoneOffset();

    switch (token) {
      // Short
      case 'O':
      case 'OO':
      case 'OOO':
        return 'GMT' + formatTimezoneShort(timezoneOffset, ':');
      // Long

      case 'OOOO':
      default:
        return 'GMT' + formatTimezone(timezoneOffset, ':');
    }
  },
  // Timezone (specific non-location)
  z: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timezoneOffset = originalDate.getTimezoneOffset();

    switch (token) {
      // Short
      case 'z':
      case 'zz':
      case 'zzz':
        return 'GMT' + formatTimezoneShort(timezoneOffset, ':');
      // Long

      case 'zzzz':
      default:
        return 'GMT' + formatTimezone(timezoneOffset, ':');
    }
  },
  // Seconds timestamp
  t: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timestamp = Math.floor(originalDate.getTime() / 1000);
    return addLeadingZeros(timestamp, token.length);
  },
  // Milliseconds timestamp
  T: function (date, token, _localize, options) {
    var originalDate = options._originalDate || date;
    var timestamp = originalDate.getTime();
    return addLeadingZeros(timestamp, token.length);
  }
};

function formatTimezoneShort(offset, dirtyDelimiter) {
  var sign = offset > 0 ? '-' : '+';
  var absOffset = Math.abs(offset);
  var hours = Math.floor(absOffset / 60);
  var minutes = absOffset % 60;

  if (minutes === 0) {
    return sign + String(hours);
  }

  var delimiter = dirtyDelimiter || '';
  return sign + String(hours) + delimiter + addLeadingZeros(minutes, 2);
}

function formatTimezoneWithOptionalMinutes(offset, dirtyDelimiter) {
  if (offset % 60 === 0) {
    var sign = offset > 0 ? '-' : '+';
    return sign + addLeadingZeros(Math.abs(offset) / 60, 2);
  }

  return formatTimezone(offset, dirtyDelimiter);
}

function formatTimezone(offset, dirtyDelimiter) {
  var delimiter = dirtyDelimiter || '';
  var sign = offset > 0 ? '-' : '+';
  var absOffset = Math.abs(offset);
  var hours = addLeadingZeros(Math.floor(absOffset / 60), 2);
  var minutes = addLeadingZeros(absOffset % 60, 2);
  return sign + hours + delimiter + minutes;
}

function dateLongFormatter(pattern, formatLong) {
  switch (pattern) {
    case 'P':
      return formatLong.date({
        width: 'short'
      });

    case 'PP':
      return formatLong.date({
        width: 'medium'
      });

    case 'PPP':
      return formatLong.date({
        width: 'long'
      });

    case 'PPPP':
    default:
      return formatLong.date({
        width: 'full'
      });
  }
}

function timeLongFormatter(pattern, formatLong) {
  switch (pattern) {
    case 'p':
      return formatLong.time({
        width: 'short'
      });

    case 'pp':
      return formatLong.time({
        width: 'medium'
      });

    case 'ppp':
      return formatLong.time({
        width: 'long'
      });

    case 'pppp':
    default:
      return formatLong.time({
        width: 'full'
      });
  }
}

function dateTimeLongFormatter(pattern, formatLong) {
  var matchResult = pattern.match(/(P+)(p+)?/);
  var datePattern = matchResult[1];
  var timePattern = matchResult[2];

  if (!timePattern) {
    return dateLongFormatter(pattern, formatLong);
  }

  var dateTimeFormat;

  switch (datePattern) {
    case 'P':
      dateTimeFormat = formatLong.dateTime({
        width: 'short'
      });
      break;

    case 'PP':
      dateTimeFormat = formatLong.dateTime({
        width: 'medium'
      });
      break;

    case 'PPP':
      dateTimeFormat = formatLong.dateTime({
        width: 'long'
      });
      break;

    case 'PPPP':
    default:
      dateTimeFormat = formatLong.dateTime({
        width: 'full'
      });
      break;
  }

  return dateTimeFormat.replace('{{date}}', dateLongFormatter(datePattern, formatLong)).replace('{{time}}', timeLongFormatter(timePattern, formatLong));
}

var longFormatters = {
  p: timeLongFormatter,
  P: dateTimeLongFormatter
};

var protectedDayOfYearTokens = ['D', 'DD'];
var protectedWeekYearTokens = ['YY', 'YYYY'];
function isProtectedDayOfYearToken(token) {
  return protectedDayOfYearTokens.indexOf(token) !== -1;
}
function isProtectedWeekYearToken(token) {
  return protectedWeekYearTokens.indexOf(token) !== -1;
}
function throwProtectedError(token) {
  if (token === 'YYYY') {
    throw new RangeError('Use `yyyy` instead of `YYYY` for formatting years; see: https://git.io/fxCyr');
  } else if (token === 'YY') {
    throw new RangeError('Use `yy` instead of `YY` for formatting years; see: https://git.io/fxCyr');
  } else if (token === 'D') {
    throw new RangeError('Use `d` instead of `D` for formatting days of the month; see: https://git.io/fxCyr');
  } else if (token === 'DD') {
    throw new RangeError('Use `dd` instead of `DD` for formatting days of the month; see: https://git.io/fxCyr');
  }
}

// - [yYQqMLwIdDecihHKkms]o matches any available ordinal number token
//   (one of the certain letters followed by `o`)
// - (\w)\1* matches any sequences of the same letter
// - '' matches two quote characters in a row
// - '(''|[^'])+('|$) matches anything surrounded by two quote characters ('),
//   except a single quote symbol, which ends the sequence.
//   Two quote characters do not end the sequence.
//   If there is no matching single quote
//   then the sequence will continue until the end of the string.
// - . matches any single character unmatched by previous parts of the RegExps

var formattingTokensRegExp = /[yYQqMLwIdDecihHKkms]o|(\w)\1*|''|'(''|[^'])+('|$)|./g; // This RegExp catches symbols escaped by quotes, and also
// sequences of symbols P, p, and the combinations like `PPPPPPPppppp`

var longFormattingTokensRegExp = /P+p+|P+|p+|''|'(''|[^'])+('|$)|./g;
var escapedStringRegExp = /^'([^]*?)'?$/;
var doubleQuoteRegExp = /''/g;
var unescapedLatinCharacterRegExp = /[a-zA-Z]/;
/**
 * @name format
 * @category Common Helpers
 * @summary Format the date.
 *
 * @description
 * Return the formatted date string in the given format. The result may vary by locale.
 *
 * > ⚠️ Please note that the `format` tokens differ from Moment.js and other libraries.
 * > See: https://git.io/fxCyr
 *
 * The characters wrapped between two single quotes characters (') are escaped.
 * Two single quotes in a row, whether inside or outside a quoted sequence, represent a 'real' single quote.
 * (see the last example)
 *
 * Format of the string is based on Unicode Technical Standard #35:
 * https://www.unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table
 * with a few additions (see note 7 below the table).
 *
 * Accepted patterns:
 * | Unit                            | Pattern | Result examples                   | Notes |
 * |---------------------------------|---------|-----------------------------------|-------|
 * | Era                             | G..GGG  | AD, BC                            |       |
 * |                                 | GGGG    | Anno Domini, Before Christ        | 2     |
 * |                                 | GGGGG   | A, B                              |       |
 * | Calendar year                   | y       | 44, 1, 1900, 2017                 | 5     |
 * |                                 | yo      | 44th, 1st, 0th, 17th              | 5,7   |
 * |                                 | yy      | 44, 01, 00, 17                    | 5     |
 * |                                 | yyy     | 044, 001, 1900, 2017              | 5     |
 * |                                 | yyyy    | 0044, 0001, 1900, 2017            | 5     |
 * |                                 | yyyyy   | ...                               | 3,5   |
 * | Local week-numbering year       | Y       | 44, 1, 1900, 2017                 | 5     |
 * |                                 | Yo      | 44th, 1st, 1900th, 2017th         | 5,7   |
 * |                                 | YY      | 44, 01, 00, 17                    | 5,8   |
 * |                                 | YYY     | 044, 001, 1900, 2017              | 5     |
 * |                                 | YYYY    | 0044, 0001, 1900, 2017            | 5,8   |
 * |                                 | YYYYY   | ...                               | 3,5   |
 * | ISO week-numbering year         | R       | -43, 0, 1, 1900, 2017             | 5,7   |
 * |                                 | RR      | -43, 00, 01, 1900, 2017           | 5,7   |
 * |                                 | RRR     | -043, 000, 001, 1900, 2017        | 5,7   |
 * |                                 | RRRR    | -0043, 0000, 0001, 1900, 2017     | 5,7   |
 * |                                 | RRRRR   | ...                               | 3,5,7 |
 * | Extended year                   | u       | -43, 0, 1, 1900, 2017             | 5     |
 * |                                 | uu      | -43, 01, 1900, 2017               | 5     |
 * |                                 | uuu     | -043, 001, 1900, 2017             | 5     |
 * |                                 | uuuu    | -0043, 0001, 1900, 2017           | 5     |
 * |                                 | uuuuu   | ...                               | 3,5   |
 * | Quarter (formatting)            | Q       | 1, 2, 3, 4                        |       |
 * |                                 | Qo      | 1st, 2nd, 3rd, 4th                | 7     |
 * |                                 | QQ      | 01, 02, 03, 04                    |       |
 * |                                 | QQQ     | Q1, Q2, Q3, Q4                    |       |
 * |                                 | QQQQ    | 1st quarter, 2nd quarter, ...     | 2     |
 * |                                 | QQQQQ   | 1, 2, 3, 4                        | 4     |
 * | Quarter (stand-alone)           | q       | 1, 2, 3, 4                        |       |
 * |                                 | qo      | 1st, 2nd, 3rd, 4th                | 7     |
 * |                                 | qq      | 01, 02, 03, 04                    |       |
 * |                                 | qqq     | Q1, Q2, Q3, Q4                    |       |
 * |                                 | qqqq    | 1st quarter, 2nd quarter, ...     | 2     |
 * |                                 | qqqqq   | 1, 2, 3, 4                        | 4     |
 * | Month (formatting)              | M       | 1, 2, ..., 12                     |       |
 * |                                 | Mo      | 1st, 2nd, ..., 12th               | 7     |
 * |                                 | MM      | 01, 02, ..., 12                   |       |
 * |                                 | MMM     | Jan, Feb, ..., Dec                |       |
 * |                                 | MMMM    | January, February, ..., December  | 2     |
 * |                                 | MMMMM   | J, F, ..., D                      |       |
 * | Month (stand-alone)             | L       | 1, 2, ..., 12                     |       |
 * |                                 | Lo      | 1st, 2nd, ..., 12th               | 7     |
 * |                                 | LL      | 01, 02, ..., 12                   |       |
 * |                                 | LLL     | Jan, Feb, ..., Dec                |       |
 * |                                 | LLLL    | January, February, ..., December  | 2     |
 * |                                 | LLLLL   | J, F, ..., D                      |       |
 * | Local week of year              | w       | 1, 2, ..., 53                     |       |
 * |                                 | wo      | 1st, 2nd, ..., 53th               | 7     |
 * |                                 | ww      | 01, 02, ..., 53                   |       |
 * | ISO week of year                | I       | 1, 2, ..., 53                     | 7     |
 * |                                 | Io      | 1st, 2nd, ..., 53th               | 7     |
 * |                                 | II      | 01, 02, ..., 53                   | 7     |
 * | Day of month                    | d       | 1, 2, ..., 31                     |       |
 * |                                 | do      | 1st, 2nd, ..., 31st               | 7     |
 * |                                 | dd      | 01, 02, ..., 31                   |       |
 * | Day of year                     | D       | 1, 2, ..., 365, 366               | 9     |
 * |                                 | Do      | 1st, 2nd, ..., 365th, 366th       | 7     |
 * |                                 | DD      | 01, 02, ..., 365, 366             | 9     |
 * |                                 | DDD     | 001, 002, ..., 365, 366           |       |
 * |                                 | DDDD    | ...                               | 3     |
 * | Day of week (formatting)        | E..EEE  | Mon, Tue, Wed, ..., Su            |       |
 * |                                 | EEEE    | Monday, Tuesday, ..., Sunday      | 2     |
 * |                                 | EEEEE   | M, T, W, T, F, S, S               |       |
 * |                                 | EEEEEE  | Mo, Tu, We, Th, Fr, Su, Sa        |       |
 * | ISO day of week (formatting)    | i       | 1, 2, 3, ..., 7                   | 7     |
 * |                                 | io      | 1st, 2nd, ..., 7th                | 7     |
 * |                                 | ii      | 01, 02, ..., 07                   | 7     |
 * |                                 | iii     | Mon, Tue, Wed, ..., Su            | 7     |
 * |                                 | iiii    | Monday, Tuesday, ..., Sunday      | 2,7   |
 * |                                 | iiiii   | M, T, W, T, F, S, S               | 7     |
 * |                                 | iiiiii  | Mo, Tu, We, Th, Fr, Su, Sa        | 7     |
 * | Local day of week (formatting)  | e       | 2, 3, 4, ..., 1                   |       |
 * |                                 | eo      | 2nd, 3rd, ..., 1st                | 7     |
 * |                                 | ee      | 02, 03, ..., 01                   |       |
 * |                                 | eee     | Mon, Tue, Wed, ..., Su            |       |
 * |                                 | eeee    | Monday, Tuesday, ..., Sunday      | 2     |
 * |                                 | eeeee   | M, T, W, T, F, S, S               |       |
 * |                                 | eeeeee  | Mo, Tu, We, Th, Fr, Su, Sa        |       |
 * | Local day of week (stand-alone) | c       | 2, 3, 4, ..., 1                   |       |
 * |                                 | co      | 2nd, 3rd, ..., 1st                | 7     |
 * |                                 | cc      | 02, 03, ..., 01                   |       |
 * |                                 | ccc     | Mon, Tue, Wed, ..., Su            |       |
 * |                                 | cccc    | Monday, Tuesday, ..., Sunday      | 2     |
 * |                                 | ccccc   | M, T, W, T, F, S, S               |       |
 * |                                 | cccccc  | Mo, Tu, We, Th, Fr, Su, Sa        |       |
 * | AM, PM                          | a..aaa  | AM, PM                            |       |
 * |                                 | aaaa    | a.m., p.m.                        | 2     |
 * |                                 | aaaaa   | a, p                              |       |
 * | AM, PM, noon, midnight          | b..bbb  | AM, PM, noon, midnight            |       |
 * |                                 | bbbb    | a.m., p.m., noon, midnight        | 2     |
 * |                                 | bbbbb   | a, p, n, mi                       |       |
 * | Flexible day period             | B..BBB  | at night, in the morning, ...     |       |
 * |                                 | BBBB    | at night, in the morning, ...     | 2     |
 * |                                 | BBBBB   | at night, in the morning, ...     |       |
 * | Hour [1-12]                     | h       | 1, 2, ..., 11, 12                 |       |
 * |                                 | ho      | 1st, 2nd, ..., 11th, 12th         | 7     |
 * |                                 | hh      | 01, 02, ..., 11, 12               |       |
 * | Hour [0-23]                     | H       | 0, 1, 2, ..., 23                  |       |
 * |                                 | Ho      | 0th, 1st, 2nd, ..., 23rd          | 7     |
 * |                                 | HH      | 00, 01, 02, ..., 23               |       |
 * | Hour [0-11]                     | K       | 1, 2, ..., 11, 0                  |       |
 * |                                 | Ko      | 1st, 2nd, ..., 11th, 0th          | 7     |
 * |                                 | KK      | 1, 2, ..., 11, 0                  |       |
 * | Hour [1-24]                     | k       | 24, 1, 2, ..., 23                 |       |
 * |                                 | ko      | 24th, 1st, 2nd, ..., 23rd         | 7     |
 * |                                 | kk      | 24, 01, 02, ..., 23               |       |
 * | Minute                          | m       | 0, 1, ..., 59                     |       |
 * |                                 | mo      | 0th, 1st, ..., 59th               | 7     |
 * |                                 | mm      | 00, 01, ..., 59                   |       |
 * | Second                          | s       | 0, 1, ..., 59                     |       |
 * |                                 | so      | 0th, 1st, ..., 59th               | 7     |
 * |                                 | ss      | 00, 01, ..., 59                   |       |
 * | Fraction of second              | S       | 0, 1, ..., 9                      |       |
 * |                                 | SS      | 00, 01, ..., 99                   |       |
 * |                                 | SSS     | 000, 0001, ..., 999               |       |
 * |                                 | SSSS    | ...                               | 3     |
 * | Timezone (ISO-8601 w/ Z)        | X       | -08, +0530, Z                     |       |
 * |                                 | XX      | -0800, +0530, Z                   |       |
 * |                                 | XXX     | -08:00, +05:30, Z                 |       |
 * |                                 | XXXX    | -0800, +0530, Z, +123456          | 2     |
 * |                                 | XXXXX   | -08:00, +05:30, Z, +12:34:56      |       |
 * | Timezone (ISO-8601 w/o Z)       | x       | -08, +0530, +00                   |       |
 * |                                 | xx      | -0800, +0530, +0000               |       |
 * |                                 | xxx     | -08:00, +05:30, +00:00            | 2     |
 * |                                 | xxxx    | -0800, +0530, +0000, +123456      |       |
 * |                                 | xxxxx   | -08:00, +05:30, +00:00, +12:34:56 |       |
 * | Timezone (GMT)                  | O...OOO | GMT-8, GMT+5:30, GMT+0            |       |
 * |                                 | OOOO    | GMT-08:00, GMT+05:30, GMT+00:00   | 2     |
 * | Timezone (specific non-locat.)  | z...zzz | GMT-8, GMT+5:30, GMT+0            | 6     |
 * |                                 | zzzz    | GMT-08:00, GMT+05:30, GMT+00:00   | 2,6   |
 * | Seconds timestamp               | t       | 512969520                         | 7     |
 * |                                 | tt      | ...                               | 3,7   |
 * | Milliseconds timestamp          | T       | 512969520900                      | 7     |
 * |                                 | TT      | ...                               | 3,7   |
 * | Long localized date             | P       | 05/29/1453                        | 7     |
 * |                                 | PP      | May 29, 1453                      | 7     |
 * |                                 | PPP     | May 29th, 1453                    | 7     |
 * |                                 | PPPP    | Sunday, May 29th, 1453            | 2,7   |
 * | Long localized time             | p       | 12:00 AM                          | 7     |
 * |                                 | pp      | 12:00:00 AM                       | 7     |
 * |                                 | ppp     | 12:00:00 AM GMT+2                 | 7     |
 * |                                 | pppp    | 12:00:00 AM GMT+02:00             | 2,7   |
 * | Combination of date and time    | Pp      | 05/29/1453, 12:00 AM              | 7     |
 * |                                 | PPpp    | May 29, 1453, 12:00:00 AM         | 7     |
 * |                                 | PPPppp  | May 29th, 1453 at ...             | 7     |
 * |                                 | PPPPpppp| Sunday, May 29th, 1453 at ...     | 2,7   |
 * Notes:
 * 1. "Formatting" units (e.g. formatting quarter) in the default en-US locale
 *    are the same as "stand-alone" units, but are different in some languages.
 *    "Formatting" units are declined according to the rules of the language
 *    in the context of a date. "Stand-alone" units are always nominative singular:
 *
 *    `format(new Date(2017, 10, 6), 'do LLLL', {locale: cs}) //=> '6. listopad'`
 *
 *    `format(new Date(2017, 10, 6), 'do MMMM', {locale: cs}) //=> '6. listopadu'`
 *
 * 2. Any sequence of the identical letters is a pattern, unless it is escaped by
 *    the single quote characters (see below).
 *    If the sequence is longer than listed in table (e.g. `EEEEEEEEEEE`)
 *    the output will be the same as default pattern for this unit, usually
 *    the longest one (in case of ISO weekdays, `EEEE`). Default patterns for units
 *    are marked with "2" in the last column of the table.
 *
 *    `format(new Date(2017, 10, 6), 'MMM') //=> 'Nov'`
 *
 *    `format(new Date(2017, 10, 6), 'MMMM') //=> 'November'`
 *
 *    `format(new Date(2017, 10, 6), 'MMMMM') //=> 'N'`
 *
 *    `format(new Date(2017, 10, 6), 'MMMMMM') //=> 'November'`
 *
 *    `format(new Date(2017, 10, 6), 'MMMMMMM') //=> 'November'`
 *
 * 3. Some patterns could be unlimited length (such as `yyyyyyyy`).
 *    The output will be padded with zeros to match the length of the pattern.
 *
 *    `format(new Date(2017, 10, 6), 'yyyyyyyy') //=> '00002017'`
 *
 * 4. `QQQQQ` and `qqqqq` could be not strictly numerical in some locales.
 *    These tokens represent the shortest form of the quarter.
 *
 * 5. The main difference between `y` and `u` patterns are B.C. years:
 *
 *    | Year | `y` | `u` |
 *    |------|-----|-----|
 *    | AC 1 |   1 |   1 |
 *    | BC 1 |   1 |   0 |
 *    | BC 2 |   2 |  -1 |
 *
 *    Also `yy` always returns the last two digits of a year,
 *    while `uu` pads single digit years to 2 characters and returns other years unchanged:
 *
 *    | Year | `yy` | `uu` |
 *    |------|------|------|
 *    | 1    |   01 |   01 |
 *    | 14   |   14 |   14 |
 *    | 376  |   76 |  376 |
 *    | 1453 |   53 | 1453 |
 *
 *    The same difference is true for local and ISO week-numbering years (`Y` and `R`),
 *    except local week-numbering years are dependent on `options.weekStartsOn`
 *    and `options.firstWeekContainsDate` (compare [getISOWeekYear]{@link https://date-fns.org/docs/getISOWeekYear}
 *    and [getWeekYear]{@link https://date-fns.org/docs/getWeekYear}).
 *
 * 6. Specific non-location timezones are currently unavailable in `date-fns`,
 *    so right now these tokens fall back to GMT timezones.
 *
 * 7. These patterns are not in the Unicode Technical Standard #35:
 *    - `i`: ISO day of week
 *    - `I`: ISO week of year
 *    - `R`: ISO week-numbering year
 *    - `t`: seconds timestamp
 *    - `T`: milliseconds timestamp
 *    - `o`: ordinal number modifier
 *    - `P`: long localized date
 *    - `p`: long localized time
 *
 * 8. `YY` and `YYYY` tokens represent week-numbering years but they are often confused with years.
 *    You should enable `options.useAdditionalWeekYearTokens` to use them. See: https://git.io/fxCyr
 *
 * 9. `D` and `DD` tokens represent days of the year but they are ofthen confused with days of the month.
 *    You should enable `options.useAdditionalDayOfYearTokens` to use them. See: https://git.io/fxCyr
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * - The second argument is now required for the sake of explicitness.
 *
 *   ```javascript
 *   // Before v2.0.0
 *   format(new Date(2016, 0, 1))
 *
 *   // v2.0.0 onward
 *   format(new Date(2016, 0, 1), "yyyy-MM-dd'T'HH:mm:ss.SSSxxx")
 *   ```
 *
 * - New format string API for `format` function
 *   which is based on [Unicode Technical Standard #35](https://www.unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table).
 *   See [this post](https://blog.date-fns.org/post/unicode-tokens-in-date-fns-v2-sreatyki91jg) for more details.
 *
 * - Characters are now escaped using single quote symbols (`'`) instead of square brackets.
 *
 * @param {Date|Number} date - the original date
 * @param {String} format - the string of tokens
 * @param {Object} [options] - an object with options.
 * @param {Locale} [options.locale=defaultLocale] - the locale object. See [Locale]{@link https://date-fns.org/docs/Locale}
 * @param {0|1|2|3|4|5|6} [options.weekStartsOn=0] - the index of the first day of the week (0 - Sunday)
 * @param {Number} [options.firstWeekContainsDate=1] - the day of January, which is
 * @param {Boolean} [options.useAdditionalWeekYearTokens=false] - if true, allows usage of the week-numbering year tokens `YY` and `YYYY`;
 *   see: https://git.io/fxCyr
 * @param {Boolean} [options.useAdditionalDayOfYearTokens=false] - if true, allows usage of the day of year tokens `D` and `DD`;
 *   see: https://git.io/fxCyr
 * @returns {String} the formatted date string
 * @throws {TypeError} 2 arguments required
 * @throws {RangeError} `date` must not be Invalid Date
 * @throws {RangeError} `options.locale` must contain `localize` property
 * @throws {RangeError} `options.locale` must contain `formatLong` property
 * @throws {RangeError} `options.weekStartsOn` must be between 0 and 6
 * @throws {RangeError} `options.firstWeekContainsDate` must be between 1 and 7
 * @throws {RangeError} use `yyyy` instead of `YYYY` for formatting years; see: https://git.io/fxCyr
 * @throws {RangeError} use `yy` instead of `YY` for formatting years; see: https://git.io/fxCyr
 * @throws {RangeError} use `d` instead of `D` for formatting days of the month; see: https://git.io/fxCyr
 * @throws {RangeError} use `dd` instead of `DD` for formatting days of the month; see: https://git.io/fxCyr
 * @throws {RangeError} format string contains an unescaped latin alphabet character
 *
 * @example
 * // Represent 11 February 2014 in middle-endian format:
 * var result = format(new Date(2014, 1, 11), 'MM/dd/yyyy')
 * //=> '02/11/2014'
 *
 * @example
 * // Represent 2 July 2014 in Esperanto:
 * import { eoLocale } from 'date-fns/locale/eo'
 * var result = format(new Date(2014, 6, 2), "do 'de' MMMM yyyy", {
 *   locale: eoLocale
 * })
 * //=> '2-a de julio 2014'
 *
 * @example
 * // Escape string by single quote characters:
 * var result = format(new Date(2014, 6, 2, 15), "h 'o''clock'")
 * //=> "3 o'clock"
 */

function format(dirtyDate, dirtyFormatStr, dirtyOptions) {
  requiredArgs(2, arguments);
  var formatStr = String(dirtyFormatStr);
  var options = dirtyOptions || {};
  var locale$1 = options.locale || locale;
  var localeFirstWeekContainsDate = locale$1.options && locale$1.options.firstWeekContainsDate;
  var defaultFirstWeekContainsDate = localeFirstWeekContainsDate == null ? 1 : toInteger(localeFirstWeekContainsDate);
  var firstWeekContainsDate = options.firstWeekContainsDate == null ? defaultFirstWeekContainsDate : toInteger(options.firstWeekContainsDate); // Test if weekStartsOn is between 1 and 7 _and_ is not NaN

  if (!(firstWeekContainsDate >= 1 && firstWeekContainsDate <= 7)) {
    throw new RangeError('firstWeekContainsDate must be between 1 and 7 inclusively');
  }

  var localeWeekStartsOn = locale$1.options && locale$1.options.weekStartsOn;
  var defaultWeekStartsOn = localeWeekStartsOn == null ? 0 : toInteger(localeWeekStartsOn);
  var weekStartsOn = options.weekStartsOn == null ? defaultWeekStartsOn : toInteger(options.weekStartsOn); // Test if weekStartsOn is between 0 and 6 _and_ is not NaN

  if (!(weekStartsOn >= 0 && weekStartsOn <= 6)) {
    throw new RangeError('weekStartsOn must be between 0 and 6 inclusively');
  }

  if (!locale$1.localize) {
    throw new RangeError('locale must contain localize property');
  }

  if (!locale$1.formatLong) {
    throw new RangeError('locale must contain formatLong property');
  }

  var originalDate = toDate(dirtyDate);

  if (!isValid(originalDate)) {
    throw new RangeError('Invalid time value');
  } // Convert the date in system timezone to the same date in UTC+00:00 timezone.
  // This ensures that when UTC functions will be implemented, locales will be compatible with them.
  // See an issue about UTC functions: https://github.com/date-fns/date-fns/issues/376


  var timezoneOffset = getTimezoneOffsetInMilliseconds(originalDate);
  var utcDate = subMilliseconds(originalDate, timezoneOffset);
  var formatterOptions = {
    firstWeekContainsDate: firstWeekContainsDate,
    weekStartsOn: weekStartsOn,
    locale: locale$1,
    _originalDate: originalDate
  };
  var result = formatStr.match(longFormattingTokensRegExp).map(function (substring) {
    var firstCharacter = substring[0];

    if (firstCharacter === 'p' || firstCharacter === 'P') {
      var longFormatter = longFormatters[firstCharacter];
      return longFormatter(substring, locale$1.formatLong, formatterOptions);
    }

    return substring;
  }).join('').match(formattingTokensRegExp).map(function (substring) {
    // Replace two single quote characters with one single quote character
    if (substring === "''") {
      return "'";
    }

    var firstCharacter = substring[0];

    if (firstCharacter === "'") {
      return cleanEscapedString(substring);
    }

    var formatter = formatters$1[firstCharacter];

    if (formatter) {
      if (!options.useAdditionalWeekYearTokens && isProtectedWeekYearToken(substring)) {
        throwProtectedError(substring);
      }

      if (!options.useAdditionalDayOfYearTokens && isProtectedDayOfYearToken(substring)) {
        throwProtectedError(substring);
      }

      return formatter(utcDate, substring, locale$1.localize, formatterOptions);
    }

    if (firstCharacter.match(unescapedLatinCharacterRegExp)) {
      throw new RangeError('Format string contains an unescaped latin alphabet character `' + firstCharacter + '`');
    }

    return substring;
  }).join('');
  return result;
}

function cleanEscapedString(input) {
  return input.match(escapedStringRegExp)[1].replace(doubleQuoteRegExp, "'");
}

/**
 * @name isBefore
 * @category Common Helpers
 * @summary Is the first date before the second one?
 *
 * @description
 * Is the first date before the second one?
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date that should be before the other one to return true
 * @param {Date|Number} dateToCompare - the date to compare with
 * @returns {Boolean} the first date is before the second date
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Is 10 July 1989 before 11 February 1987?
 * var result = isBefore(new Date(1989, 6, 10), new Date(1987, 1, 11))
 * //=> false
 */

function isBefore(dirtyDate, dirtyDateToCompare) {
  requiredArgs(2, arguments);
  var date = toDate(dirtyDate);
  var dateToCompare = toDate(dirtyDateToCompare);
  return date.getTime() < dateToCompare.getTime();
}

var ConfirmDialog = function (_a) {
    var open = _a.open, cancelButtonLabel = _a.cancelButtonLabel, confirmButtonLabel = _a.confirmButtonLabel, title = _a.title, message = _a.message, onCancel = _a.onCancel, onConfirm = _a.onConfirm;
    return (React__default.createElement(core.Dialog, { open: open },
        title && React__default.createElement(core.DialogTitle, null, title),
        message && (React__default.createElement(core.DialogContent, null,
            React__default.createElement(core.Typography, null, message))),
        React__default.createElement(core.DialogActions, null,
            React__default.createElement(core.Button, { onClick: onCancel }, cancelButtonLabel),
            React__default.createElement(core.Button, { autoFocus: true, variant: "outlined", color: "primary", onClick: onConfirm }, confirmButtonLabel))));
};

function withConfirmDialog (Component, dialogProps) {
    var Wrapper = function (props) {
        var _a = React__default.useState(false), open = _a[0], toggleOpen = _a[1];
        /** */
        var close = function () {
            toggleOpen(false);
        };
        /** */
        // eslint-disable-next-line no-underscore-dangle
        var _onClick = function () {
            toggleOpen(true);
        };
        var onConfirm = function () {
            close();
            // @ts-ignore
            if (props.onClick)
                props.onClick();
        };
        /** */
        return (React__default.createElement(React__default.Fragment, null,
            React__default.createElement(Component, __assign({}, props, { onClick: _onClick })),
            React__default.createElement(ConfirmDialog, __assign({}, dialogProps, { open: open, onCancel: close, onConfirm: onConfirm }))));
    };
    return Wrapper;
}

function _typeof(obj) {
  "@babel/helpers - typeof";

  if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") {
    _typeof = function _typeof(obj) {
      return typeof obj;
    };
  } else {
    _typeof = function _typeof(obj) {
      return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
    };
  }

  return _typeof(obj);
}

function _defineProperty$1(obj, key, value) {
  if (key in obj) {
    Object.defineProperty(obj, key, {
      value: value,
      enumerable: true,
      configurable: true,
      writable: true
    });
  } else {
    obj[key] = value;
  }

  return obj;
}

function _objectSpread$2(target) {
  for (var i = 1; i < arguments.length; i++) {
    var source = arguments[i] != null ? Object(arguments[i]) : {};
    var ownKeys = Object.keys(source);

    if (typeof Object.getOwnPropertySymbols === 'function') {
      ownKeys = ownKeys.concat(Object.getOwnPropertySymbols(source).filter(function (sym) {
        return Object.getOwnPropertyDescriptor(source, sym).enumerable;
      }));
    }

    ownKeys.forEach(function (key) {
      _defineProperty$1(target, key, source[key]);
    });
  }

  return target;
}

function _classCallCheck$1(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

function _defineProperties$1(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

function _createClass$1(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties$1(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties$1(Constructor, staticProps);
  return Constructor;
}

function _assertThisInitialized(self) {
  if (self === void 0) {
    throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
  }

  return self;
}

function _possibleConstructorReturn(self, call) {
  if (call && (_typeof(call) === "object" || typeof call === "function")) {
    return call;
  }

  return _assertThisInitialized(self);
}

function _getPrototypeOf(o) {
  _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) {
    return o.__proto__ || Object.getPrototypeOf(o);
  };
  return _getPrototypeOf(o);
}

function _setPrototypeOf(o, p) {
  _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) {
    o.__proto__ = p;
    return o;
  };

  return _setPrototypeOf(o, p);
}

function _inherits(subClass, superClass) {
  if (typeof superClass !== "function" && superClass !== null) {
    throw new TypeError("Super expression must either be null or a function");
  }

  subClass.prototype = Object.create(superClass && superClass.prototype, {
    constructor: {
      value: subClass,
      writable: true,
      configurable: true
    }
  });
  if (superClass) _setPrototypeOf(subClass, superClass);
}

function _arrayLikeToArray$1(arr, len) {
  if (len == null || len > arr.length) len = arr.length;

  for (var i = 0, arr2 = new Array(len); i < len; i++) {
    arr2[i] = arr[i];
  }

  return arr2;
}

function _arrayWithoutHoles(arr) {
  if (Array.isArray(arr)) return _arrayLikeToArray$1(arr);
}

function _iterableToArray(iter) {
  if (typeof Symbol !== "undefined" && Symbol.iterator in Object(iter)) return Array.from(iter);
}

function _unsupportedIterableToArray$1(o, minLen) {
  if (!o) return;
  if (typeof o === "string") return _arrayLikeToArray$1(o, minLen);
  var n = Object.prototype.toString.call(o).slice(8, -1);
  if (n === "Object" && o.constructor) n = o.constructor.name;
  if (n === "Map" || n === "Set") return Array.from(n);
  if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray$1(o, minLen);
}

function _nonIterableSpread() {
  throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _toConsumableArray(arr) {
  return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray$1(arr) || _nonIterableSpread();
}

function _arrayWithHoles$1(arr) {
  if (Array.isArray(arr)) return arr;
}

function _nonIterableRest$1() {
  throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
}

function _toArray(arr) {
  return _arrayWithHoles$1(arr) || _iterableToArray(arr) || _unsupportedIterableToArray$1(arr) || _nonIterableRest$1();
}

function _iterableToArrayLimit$1(arr, i) {
  if (typeof Symbol === "undefined" || !(Symbol.iterator in Object(arr))) return;
  var _arr = [];
  var _n = true;
  var _d = false;
  var _e = undefined;

  try {
    for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) {
      _arr.push(_s.value);

      if (i && _arr.length === i) break;
    }
  } catch (err) {
    _d = true;
    _e = err;
  } finally {
    try {
      if (!_n && _i["return"] != null) _i["return"]();
    } finally {
      if (_d) throw _e;
    }
  }

  return _arr;
}

function _slicedToArray$1(arr, i) {
  return _arrayWithHoles$1(arr) || _iterableToArrayLimit$1(arr, i) || _unsupportedIterableToArray$1(arr, i) || _nonIterableRest$1();
}

var consoleLogger = {
  type: 'logger',
  log: function log(args) {
    this.output('log', args);
  },
  warn: function warn(args) {
    this.output('warn', args);
  },
  error: function error(args) {
    this.output('error', args);
  },
  output: function output(type, args) {
    var _console;

    /* eslint no-console: 0 */
    if (console && console[type]) (_console = console)[type].apply(_console, _toConsumableArray(args));
  }
};

var Logger =
/*#__PURE__*/
function () {
  function Logger(concreteLogger) {
    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck$1(this, Logger);

    this.init(concreteLogger, options);
  }

  _createClass$1(Logger, [{
    key: "init",
    value: function init(concreteLogger) {
      var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
      this.prefix = options.prefix || 'i18next:';
      this.logger = concreteLogger || consoleLogger;
      this.options = options;
      this.debug = options.debug;
    }
  }, {
    key: "setDebug",
    value: function setDebug(bool) {
      this.debug = bool;
    }
  }, {
    key: "log",
    value: function log() {
      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
        args[_key] = arguments[_key];
      }

      return this.forward(args, 'log', '', true);
    }
  }, {
    key: "warn",
    value: function warn() {
      for (var _len2 = arguments.length, args = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
        args[_key2] = arguments[_key2];
      }

      return this.forward(args, 'warn', '', true);
    }
  }, {
    key: "error",
    value: function error() {
      for (var _len3 = arguments.length, args = new Array(_len3), _key3 = 0; _key3 < _len3; _key3++) {
        args[_key3] = arguments[_key3];
      }

      return this.forward(args, 'error', '');
    }
  }, {
    key: "deprecate",
    value: function deprecate() {
      for (var _len4 = arguments.length, args = new Array(_len4), _key4 = 0; _key4 < _len4; _key4++) {
        args[_key4] = arguments[_key4];
      }

      return this.forward(args, 'warn', 'WARNING DEPRECATED: ', true);
    }
  }, {
    key: "forward",
    value: function forward(args, lvl, prefix, debugOnly) {
      if (debugOnly && !this.debug) return null;
      if (typeof args[0] === 'string') args[0] = "".concat(prefix).concat(this.prefix, " ").concat(args[0]);
      return this.logger[lvl](args);
    }
  }, {
    key: "create",
    value: function create(moduleName) {
      return new Logger(this.logger, _objectSpread$2({}, {
        prefix: "".concat(this.prefix, ":").concat(moduleName, ":")
      }, this.options));
    }
  }]);

  return Logger;
}();

var baseLogger = new Logger();

var EventEmitter =
/*#__PURE__*/
function () {
  function EventEmitter() {
    _classCallCheck$1(this, EventEmitter);

    this.observers = {};
  }

  _createClass$1(EventEmitter, [{
    key: "on",
    value: function on(events, listener) {
      var _this = this;

      events.split(' ').forEach(function (event) {
        _this.observers[event] = _this.observers[event] || [];

        _this.observers[event].push(listener);
      });
      return this;
    }
  }, {
    key: "off",
    value: function off(event, listener) {
      if (!this.observers[event]) return;

      if (!listener) {
        delete this.observers[event];
        return;
      }

      this.observers[event] = this.observers[event].filter(function (l) {
        return l !== listener;
      });
    }
  }, {
    key: "emit",
    value: function emit(event) {
      for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
        args[_key - 1] = arguments[_key];
      }

      if (this.observers[event]) {
        var cloned = [].concat(this.observers[event]);
        cloned.forEach(function (observer) {
          observer.apply(void 0, args);
        });
      }

      if (this.observers['*']) {
        var _cloned = [].concat(this.observers['*']);

        _cloned.forEach(function (observer) {
          observer.apply(observer, [event].concat(args));
        });
      }
    }
  }]);

  return EventEmitter;
}();

// http://lea.verou.me/2016/12/resolve-promises-externally-with-this-one-weird-trick/
function defer() {
  var res;
  var rej;
  var promise = new Promise(function (resolve, reject) {
    res = resolve;
    rej = reject;
  });
  promise.resolve = res;
  promise.reject = rej;
  return promise;
}
function makeString(object) {
  if (object == null) return '';
  /* eslint prefer-template: 0 */

  return '' + object;
}
function copy(a, s, t) {
  a.forEach(function (m) {
    if (s[m]) t[m] = s[m];
  });
}

function getLastOfPath(object, path, Empty) {
  function cleanKey(key) {
    return key && key.indexOf('###') > -1 ? key.replace(/###/g, '.') : key;
  }

  function canNotTraverseDeeper() {
    return !object || typeof object === 'string';
  }

  var stack = typeof path !== 'string' ? [].concat(path) : path.split('.');

  while (stack.length > 1) {
    if (canNotTraverseDeeper()) return {};
    var key = cleanKey(stack.shift());
    if (!object[key] && Empty) object[key] = new Empty();
    object = object[key];
  }

  if (canNotTraverseDeeper()) return {};
  return {
    obj: object,
    k: cleanKey(stack.shift())
  };
}

function setPath(object, path, newValue) {
  var _getLastOfPath = getLastOfPath(object, path, Object),
      obj = _getLastOfPath.obj,
      k = _getLastOfPath.k;

  obj[k] = newValue;
}
function pushPath(object, path, newValue, concat) {
  var _getLastOfPath2 = getLastOfPath(object, path, Object),
      obj = _getLastOfPath2.obj,
      k = _getLastOfPath2.k;

  obj[k] = obj[k] || [];
  if (concat) obj[k] = obj[k].concat(newValue);
  if (!concat) obj[k].push(newValue);
}
function getPath(object, path) {
  var _getLastOfPath3 = getLastOfPath(object, path),
      obj = _getLastOfPath3.obj,
      k = _getLastOfPath3.k;

  if (!obj) return undefined;
  return obj[k];
}
function getPathWithDefaults(data, defaultData, key) {
  var value = getPath(data, key);

  if (value !== undefined) {
    return value;
  } // Fallback to default values


  return getPath(defaultData, key);
}
function deepExtend(target, source, overwrite) {
  /* eslint no-restricted-syntax: 0 */
  for (var prop in source) {
    if (prop in target) {
      // If we reached a leaf string in target or source then replace with source or skip depending on the 'overwrite' switch
      if (typeof target[prop] === 'string' || target[prop] instanceof String || typeof source[prop] === 'string' || source[prop] instanceof String) {
        if (overwrite) target[prop] = source[prop];
      } else {
        deepExtend(target[prop], source[prop], overwrite);
      }
    } else {
      target[prop] = source[prop];
    }
  }

  return target;
}
function regexEscape(str) {
  /* eslint no-useless-escape: 0 */
  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, '\\$&');
}
/* eslint-disable */

var _entityMap = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
  "'": '&#39;',
  '/': '&#x2F;'
};
/* eslint-enable */

function escape(data) {
  if (typeof data === 'string') {
    return data.replace(/[&<>"'\/]/g, function (s) {
      return _entityMap[s];
    });
  }

  return data;
}
var isIE10 = typeof window !== 'undefined' && window.navigator && window.navigator.userAgent && window.navigator.userAgent.indexOf('MSIE') > -1;

var ResourceStore =
/*#__PURE__*/
function (_EventEmitter) {
  _inherits(ResourceStore, _EventEmitter);

  function ResourceStore(data) {
    var _this;

    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {
      ns: ['translation'],
      defaultNS: 'translation'
    };

    _classCallCheck$1(this, ResourceStore);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(ResourceStore).call(this));

    if (isIE10) {
      EventEmitter.call(_assertThisInitialized(_this)); // <=IE10 fix (unable to call parent constructor)
    }

    _this.data = data || {};
    _this.options = options;

    if (_this.options.keySeparator === undefined) {
      _this.options.keySeparator = '.';
    }

    return _this;
  }

  _createClass$1(ResourceStore, [{
    key: "addNamespaces",
    value: function addNamespaces(ns) {
      if (this.options.ns.indexOf(ns) < 0) {
        this.options.ns.push(ns);
      }
    }
  }, {
    key: "removeNamespaces",
    value: function removeNamespaces(ns) {
      var index = this.options.ns.indexOf(ns);

      if (index > -1) {
        this.options.ns.splice(index, 1);
      }
    }
  }, {
    key: "getResource",
    value: function getResource(lng, ns, key) {
      var options = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : {};
      var keySeparator = options.keySeparator !== undefined ? options.keySeparator : this.options.keySeparator;
      var path = [lng, ns];
      if (key && typeof key !== 'string') path = path.concat(key);
      if (key && typeof key === 'string') path = path.concat(keySeparator ? key.split(keySeparator) : key);

      if (lng.indexOf('.') > -1) {
        path = lng.split('.');
      }

      return getPath(this.data, path);
    }
  }, {
    key: "addResource",
    value: function addResource(lng, ns, key, value) {
      var options = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : {
        silent: false
      };
      var keySeparator = this.options.keySeparator;
      if (keySeparator === undefined) keySeparator = '.';
      var path = [lng, ns];
      if (key) path = path.concat(keySeparator ? key.split(keySeparator) : key);

      if (lng.indexOf('.') > -1) {
        path = lng.split('.');
        value = ns;
        ns = path[1];
      }

      this.addNamespaces(ns);
      setPath(this.data, path, value);
      if (!options.silent) this.emit('added', lng, ns, key, value);
    }
  }, {
    key: "addResources",
    value: function addResources(lng, ns, resources) {
      var options = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : {
        silent: false
      };

      /* eslint no-restricted-syntax: 0 */
      for (var m in resources) {
        if (typeof resources[m] === 'string' || Object.prototype.toString.apply(resources[m]) === '[object Array]') this.addResource(lng, ns, m, resources[m], {
          silent: true
        });
      }

      if (!options.silent) this.emit('added', lng, ns, resources);
    }
  }, {
    key: "addResourceBundle",
    value: function addResourceBundle(lng, ns, resources, deep, overwrite) {
      var options = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : {
        silent: false
      };
      var path = [lng, ns];

      if (lng.indexOf('.') > -1) {
        path = lng.split('.');
        deep = resources;
        resources = ns;
        ns = path[1];
      }

      this.addNamespaces(ns);
      var pack = getPath(this.data, path) || {};

      if (deep) {
        deepExtend(pack, resources, overwrite);
      } else {
        pack = _objectSpread$2({}, pack, resources);
      }

      setPath(this.data, path, pack);
      if (!options.silent) this.emit('added', lng, ns, resources);
    }
  }, {
    key: "removeResourceBundle",
    value: function removeResourceBundle(lng, ns) {
      if (this.hasResourceBundle(lng, ns)) {
        delete this.data[lng][ns];
      }

      this.removeNamespaces(ns);
      this.emit('removed', lng, ns);
    }
  }, {
    key: "hasResourceBundle",
    value: function hasResourceBundle(lng, ns) {
      return this.getResource(lng, ns) !== undefined;
    }
  }, {
    key: "getResourceBundle",
    value: function getResourceBundle(lng, ns) {
      if (!ns) ns = this.options.defaultNS; // COMPATIBILITY: remove extend in v2.1.0

      if (this.options.compatibilityAPI === 'v1') return _objectSpread$2({}, {}, this.getResource(lng, ns));
      return this.getResource(lng, ns);
    }
  }, {
    key: "getDataByLanguage",
    value: function getDataByLanguage(lng) {
      return this.data[lng];
    }
  }, {
    key: "toJSON",
    value: function toJSON() {
      return this.data;
    }
  }]);

  return ResourceStore;
}(EventEmitter);

var postProcessor = {
  processors: {},
  addPostProcessor: function addPostProcessor(module) {
    this.processors[module.name] = module;
  },
  handle: function handle(processors, value, key, options, translator) {
    var _this = this;

    processors.forEach(function (processor) {
      if (_this.processors[processor]) value = _this.processors[processor].process(value, key, options, translator);
    });
    return value;
  }
};

var checkedLoadedFor = {};

var Translator =
/*#__PURE__*/
function (_EventEmitter) {
  _inherits(Translator, _EventEmitter);

  function Translator(services) {
    var _this;

    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck$1(this, Translator);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(Translator).call(this));

    if (isIE10) {
      EventEmitter.call(_assertThisInitialized(_this)); // <=IE10 fix (unable to call parent constructor)
    }

    copy(['resourceStore', 'languageUtils', 'pluralResolver', 'interpolator', 'backendConnector', 'i18nFormat', 'utils'], services, _assertThisInitialized(_this));
    _this.options = options;

    if (_this.options.keySeparator === undefined) {
      _this.options.keySeparator = '.';
    }

    _this.logger = baseLogger.create('translator');
    return _this;
  }

  _createClass$1(Translator, [{
    key: "changeLanguage",
    value: function changeLanguage(lng) {
      if (lng) this.language = lng;
    }
  }, {
    key: "exists",
    value: function exists(key) {
      var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {
        interpolation: {}
      };
      var resolved = this.resolve(key, options);
      return resolved && resolved.res !== undefined;
    }
  }, {
    key: "extractFromKey",
    value: function extractFromKey(key, options) {
      var nsSeparator = options.nsSeparator || this.options.nsSeparator;
      if (nsSeparator === undefined) nsSeparator = ':';
      var keySeparator = options.keySeparator !== undefined ? options.keySeparator : this.options.keySeparator;
      var namespaces = options.ns || this.options.defaultNS;

      if (nsSeparator && key.indexOf(nsSeparator) > -1) {
        var parts = key.split(nsSeparator);
        if (nsSeparator !== keySeparator || nsSeparator === keySeparator && this.options.ns.indexOf(parts[0]) > -1) namespaces = parts.shift();
        key = parts.join(keySeparator);
      }

      if (typeof namespaces === 'string') namespaces = [namespaces];
      return {
        key: key,
        namespaces: namespaces
      };
    }
  }, {
    key: "translate",
    value: function translate(keys, options) {
      var _this2 = this;

      if (_typeof(options) !== 'object' && this.options.overloadTranslationOptionHandler) {
        /* eslint prefer-rest-params: 0 */
        options = this.options.overloadTranslationOptionHandler(arguments);
      }

      if (!options) options = {}; // non valid keys handling

      if (keys === undefined || keys === null
      /* || keys === ''*/
      ) return '';
      if (!Array.isArray(keys)) keys = [String(keys)]; // separators

      var keySeparator = options.keySeparator !== undefined ? options.keySeparator : this.options.keySeparator; // get namespace(s)

      var _this$extractFromKey = this.extractFromKey(keys[keys.length - 1], options),
          key = _this$extractFromKey.key,
          namespaces = _this$extractFromKey.namespaces;

      var namespace = namespaces[namespaces.length - 1]; // return key on CIMode

      var lng = options.lng || this.language;
      var appendNamespaceToCIMode = options.appendNamespaceToCIMode || this.options.appendNamespaceToCIMode;

      if (lng && lng.toLowerCase() === 'cimode') {
        if (appendNamespaceToCIMode) {
          var nsSeparator = options.nsSeparator || this.options.nsSeparator;
          return namespace + nsSeparator + key;
        }

        return key;
      } // resolve from store


      var resolved = this.resolve(keys, options);
      var res = resolved && resolved.res;
      var resUsedKey = resolved && resolved.usedKey || key;
      var resExactUsedKey = resolved && resolved.exactUsedKey || key;
      var resType = Object.prototype.toString.apply(res);
      var noObject = ['[object Number]', '[object Function]', '[object RegExp]'];
      var joinArrays = options.joinArrays !== undefined ? options.joinArrays : this.options.joinArrays; // object

      var handleAsObjectInI18nFormat = !this.i18nFormat || this.i18nFormat.handleAsObject;
      var handleAsObject = typeof res !== 'string' && typeof res !== 'boolean' && typeof res !== 'number';

      if (handleAsObjectInI18nFormat && res && handleAsObject && noObject.indexOf(resType) < 0 && !(typeof joinArrays === 'string' && resType === '[object Array]')) {
        if (!options.returnObjects && !this.options.returnObjects) {
          this.logger.warn('accessing an object - but returnObjects options is not enabled!');
          return this.options.returnedObjectHandler ? this.options.returnedObjectHandler(resUsedKey, res, options) : "key '".concat(key, " (").concat(this.language, ")' returned an object instead of string.");
        } // if we got a separator we loop over children - else we just return object as is
        // as having it set to false means no hierarchy so no lookup for nested values


        if (keySeparator) {
          var resTypeIsArray = resType === '[object Array]';
          var copy$$1 = resTypeIsArray ? [] : {}; // apply child translation on a copy

          /* eslint no-restricted-syntax: 0 */

          var newKeyToUse = resTypeIsArray ? resExactUsedKey : resUsedKey;

          for (var m in res) {
            if (Object.prototype.hasOwnProperty.call(res, m)) {
              var deepKey = "".concat(newKeyToUse).concat(keySeparator).concat(m);
              copy$$1[m] = this.translate(deepKey, _objectSpread$2({}, options, {
                joinArrays: false,
                ns: namespaces
              }));
              if (copy$$1[m] === deepKey) copy$$1[m] = res[m]; // if nothing found use orginal value as fallback
            }
          }

          res = copy$$1;
        }
      } else if (handleAsObjectInI18nFormat && typeof joinArrays === 'string' && resType === '[object Array]') {
        // array special treatment
        res = res.join(joinArrays);
        if (res) res = this.extendTranslation(res, keys, options);
      } else {
        // string, empty or null
        var usedDefault = false;
        var usedKey = false; // fallback value

        if (!this.isValidLookup(res) && options.defaultValue !== undefined) {
          usedDefault = true;

          if (options.count !== undefined) {
            var suffix = this.pluralResolver.getSuffix(lng, options.count);
            res = options["defaultValue".concat(suffix)];
          }

          if (!res) res = options.defaultValue;
        }

        if (!this.isValidLookup(res)) {
          usedKey = true;
          res = key;
        } // save missing


        var updateMissing = options.defaultValue && options.defaultValue !== res && this.options.updateMissing;

        if (usedKey || usedDefault || updateMissing) {
          this.logger.log(updateMissing ? 'updateKey' : 'missingKey', lng, namespace, key, updateMissing ? options.defaultValue : res);
          var lngs = [];
          var fallbackLngs = this.languageUtils.getFallbackCodes(this.options.fallbackLng, options.lng || this.language);

          if (this.options.saveMissingTo === 'fallback' && fallbackLngs && fallbackLngs[0]) {
            for (var i = 0; i < fallbackLngs.length; i++) {
              lngs.push(fallbackLngs[i]);
            }
          } else if (this.options.saveMissingTo === 'all') {
            lngs = this.languageUtils.toResolveHierarchy(options.lng || this.language);
          } else {
            lngs.push(options.lng || this.language);
          }

          var send = function send(l, k) {
            if (_this2.options.missingKeyHandler) {
              _this2.options.missingKeyHandler(l, namespace, k, updateMissing ? options.defaultValue : res, updateMissing, options);
            } else if (_this2.backendConnector && _this2.backendConnector.saveMissing) {
              _this2.backendConnector.saveMissing(l, namespace, k, updateMissing ? options.defaultValue : res, updateMissing, options);
            }

            _this2.emit('missingKey', l, namespace, k, res);
          };

          if (this.options.saveMissing) {
            var needsPluralHandling = options.count !== undefined && typeof options.count !== 'string';

            if (this.options.saveMissingPlurals && needsPluralHandling) {
              lngs.forEach(function (l) {
                var plurals = _this2.pluralResolver.getPluralFormsOfKey(l, key);

                plurals.forEach(function (p) {
                  return send([l], p);
                });
              });
            } else {
              send(lngs, key);
            }
          }
        } // extend


        res = this.extendTranslation(res, keys, options, resolved); // append namespace if still key

        if (usedKey && res === key && this.options.appendNamespaceToMissingKey) res = "".concat(namespace, ":").concat(key); // parseMissingKeyHandler

        if (usedKey && this.options.parseMissingKeyHandler) res = this.options.parseMissingKeyHandler(res);
      } // return


      return res;
    }
  }, {
    key: "extendTranslation",
    value: function extendTranslation(res, key, options, resolved) {
      var _this3 = this;

      if (this.i18nFormat && this.i18nFormat.parse) {
        res = this.i18nFormat.parse(res, options, resolved.usedLng, resolved.usedNS, resolved.usedKey, {
          resolved: resolved
        });
      } else if (!options.skipInterpolation) {
        // i18next.parsing
        if (options.interpolation) this.interpolator.init(_objectSpread$2({}, options, {
          interpolation: _objectSpread$2({}, this.options.interpolation, options.interpolation)
        })); // interpolate

        var data = options.replace && typeof options.replace !== 'string' ? options.replace : options;
        if (this.options.interpolation.defaultVariables) data = _objectSpread$2({}, this.options.interpolation.defaultVariables, data);
        res = this.interpolator.interpolate(res, data, options.lng || this.language, options); // nesting

        if (options.nest !== false) res = this.interpolator.nest(res, function () {
          return _this3.translate.apply(_this3, arguments);
        }, options);
        if (options.interpolation) this.interpolator.reset();
      } // post process


      var postProcess = options.postProcess || this.options.postProcess;
      var postProcessorNames = typeof postProcess === 'string' ? [postProcess] : postProcess;

      if (res !== undefined && res !== null && postProcessorNames && postProcessorNames.length && options.applyPostProcessor !== false) {
        res = postProcessor.handle(postProcessorNames, res, key, this.options && this.options.postProcessPassResolved ? _objectSpread$2({
          i18nResolved: resolved
        }, options) : options, this);
      }

      return res;
    }
  }, {
    key: "resolve",
    value: function resolve(keys) {
      var _this4 = this;

      var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
      var found;
      var usedKey; // plain key

      var exactUsedKey; // key with context / plural

      var usedLng;
      var usedNS;
      if (typeof keys === 'string') keys = [keys]; // forEach possible key

      keys.forEach(function (k) {
        if (_this4.isValidLookup(found)) return;

        var extracted = _this4.extractFromKey(k, options);

        var key = extracted.key;
        usedKey = key;
        var namespaces = extracted.namespaces;
        if (_this4.options.fallbackNS) namespaces = namespaces.concat(_this4.options.fallbackNS);
        var needsPluralHandling = options.count !== undefined && typeof options.count !== 'string';
        var needsContextHandling = options.context !== undefined && typeof options.context === 'string' && options.context !== '';
        var codes = options.lngs ? options.lngs : _this4.languageUtils.toResolveHierarchy(options.lng || _this4.language, options.fallbackLng);
        namespaces.forEach(function (ns) {
          if (_this4.isValidLookup(found)) return;
          usedNS = ns;

          if (!checkedLoadedFor["".concat(codes[0], "-").concat(ns)] && _this4.utils && _this4.utils.hasLoadedNamespace && !_this4.utils.hasLoadedNamespace(usedNS)) {
            checkedLoadedFor["".concat(codes[0], "-").concat(ns)] = true;

            _this4.logger.warn("key \"".concat(usedKey, "\" for namespace \"").concat(usedNS, "\" for languages \"").concat(codes.join(', '), "\" won't get resolved as namespace was not yet loaded"), 'This means something IS WRONG in your application setup. You access the t function before i18next.init / i18next.loadNamespace / i18next.changeLanguage was done. Wait for the callback or Promise to resolve before accessing it!!!');
          }

          codes.forEach(function (code) {
            if (_this4.isValidLookup(found)) return;
            usedLng = code;
            var finalKey = key;
            var finalKeys = [finalKey];

            if (_this4.i18nFormat && _this4.i18nFormat.addLookupKeys) {
              _this4.i18nFormat.addLookupKeys(finalKeys, key, code, ns, options);
            } else {
              var pluralSuffix;
              if (needsPluralHandling) pluralSuffix = _this4.pluralResolver.getSuffix(code, options.count); // fallback for plural if context not found

              if (needsPluralHandling && needsContextHandling) finalKeys.push(finalKey + pluralSuffix); // get key for context if needed

              if (needsContextHandling) finalKeys.push(finalKey += "".concat(_this4.options.contextSeparator).concat(options.context)); // get key for plural if needed

              if (needsPluralHandling) finalKeys.push(finalKey += pluralSuffix);
            } // iterate over finalKeys starting with most specific pluralkey (-> contextkey only) -> singularkey only


            var possibleKey;
            /* eslint no-cond-assign: 0 */

            while (possibleKey = finalKeys.pop()) {
              if (!_this4.isValidLookup(found)) {
                exactUsedKey = possibleKey;
                found = _this4.getResource(code, ns, possibleKey, options);
              }
            }
          });
        });
      });
      return {
        res: found,
        usedKey: usedKey,
        exactUsedKey: exactUsedKey,
        usedLng: usedLng,
        usedNS: usedNS
      };
    }
  }, {
    key: "isValidLookup",
    value: function isValidLookup(res) {
      return res !== undefined && !(!this.options.returnNull && res === null) && !(!this.options.returnEmptyString && res === '');
    }
  }, {
    key: "getResource",
    value: function getResource(code, ns, key) {
      var options = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : {};
      if (this.i18nFormat && this.i18nFormat.getResource) return this.i18nFormat.getResource(code, ns, key, options);
      return this.resourceStore.getResource(code, ns, key, options);
    }
  }]);

  return Translator;
}(EventEmitter);

function capitalize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

var LanguageUtil =
/*#__PURE__*/
function () {
  function LanguageUtil(options) {
    _classCallCheck$1(this, LanguageUtil);

    this.options = options;
    this.whitelist = this.options.whitelist || false;
    this.logger = baseLogger.create('languageUtils');
  }

  _createClass$1(LanguageUtil, [{
    key: "getScriptPartFromCode",
    value: function getScriptPartFromCode(code) {
      if (!code || code.indexOf('-') < 0) return null;
      var p = code.split('-');
      if (p.length === 2) return null;
      p.pop();
      return this.formatLanguageCode(p.join('-'));
    }
  }, {
    key: "getLanguagePartFromCode",
    value: function getLanguagePartFromCode(code) {
      if (!code || code.indexOf('-') < 0) return code;
      var p = code.split('-');
      return this.formatLanguageCode(p[0]);
    }
  }, {
    key: "formatLanguageCode",
    value: function formatLanguageCode(code) {
      // http://www.iana.org/assignments/language-tags/language-tags.xhtml
      if (typeof code === 'string' && code.indexOf('-') > -1) {
        var specialCases = ['hans', 'hant', 'latn', 'cyrl', 'cans', 'mong', 'arab'];
        var p = code.split('-');

        if (this.options.lowerCaseLng) {
          p = p.map(function (part) {
            return part.toLowerCase();
          });
        } else if (p.length === 2) {
          p[0] = p[0].toLowerCase();
          p[1] = p[1].toUpperCase();
          if (specialCases.indexOf(p[1].toLowerCase()) > -1) p[1] = capitalize(p[1].toLowerCase());
        } else if (p.length === 3) {
          p[0] = p[0].toLowerCase(); // if lenght 2 guess it's a country

          if (p[1].length === 2) p[1] = p[1].toUpperCase();
          if (p[0] !== 'sgn' && p[2].length === 2) p[2] = p[2].toUpperCase();
          if (specialCases.indexOf(p[1].toLowerCase()) > -1) p[1] = capitalize(p[1].toLowerCase());
          if (specialCases.indexOf(p[2].toLowerCase()) > -1) p[2] = capitalize(p[2].toLowerCase());
        }

        return p.join('-');
      }

      return this.options.cleanCode || this.options.lowerCaseLng ? code.toLowerCase() : code;
    }
  }, {
    key: "isWhitelisted",
    value: function isWhitelisted(code) {
      if (this.options.load === 'languageOnly' || this.options.nonExplicitWhitelist) {
        code = this.getLanguagePartFromCode(code);
      }

      return !this.whitelist || !this.whitelist.length || this.whitelist.indexOf(code) > -1;
    }
  }, {
    key: "getFallbackCodes",
    value: function getFallbackCodes(fallbacks, code) {
      if (!fallbacks) return [];
      if (typeof fallbacks === 'string') fallbacks = [fallbacks];
      if (Object.prototype.toString.apply(fallbacks) === '[object Array]') return fallbacks;
      if (!code) return fallbacks["default"] || []; // asume we have an object defining fallbacks

      var found = fallbacks[code];
      if (!found) found = fallbacks[this.getScriptPartFromCode(code)];
      if (!found) found = fallbacks[this.formatLanguageCode(code)];
      if (!found) found = fallbacks[this.getLanguagePartFromCode(code)];
      if (!found) found = fallbacks["default"];
      return found || [];
    }
  }, {
    key: "toResolveHierarchy",
    value: function toResolveHierarchy(code, fallbackCode) {
      var _this = this;

      var fallbackCodes = this.getFallbackCodes(fallbackCode || this.options.fallbackLng || [], code);
      var codes = [];

      var addCode = function addCode(c) {
        if (!c) return;

        if (_this.isWhitelisted(c)) {
          codes.push(c);
        } else {
          _this.logger.warn("rejecting non-whitelisted language code: ".concat(c));
        }
      };

      if (typeof code === 'string' && code.indexOf('-') > -1) {
        if (this.options.load !== 'languageOnly') addCode(this.formatLanguageCode(code));
        if (this.options.load !== 'languageOnly' && this.options.load !== 'currentOnly') addCode(this.getScriptPartFromCode(code));
        if (this.options.load !== 'currentOnly') addCode(this.getLanguagePartFromCode(code));
      } else if (typeof code === 'string') {
        addCode(this.formatLanguageCode(code));
      }

      fallbackCodes.forEach(function (fc) {
        if (codes.indexOf(fc) < 0) addCode(_this.formatLanguageCode(fc));
      });
      return codes;
    }
  }]);

  return LanguageUtil;
}();

/* eslint-disable */

var sets = [{
  lngs: ['ach', 'ak', 'am', 'arn', 'br', 'fil', 'gun', 'ln', 'mfe', 'mg', 'mi', 'oc', 'pt', 'pt-BR', 'tg', 'ti', 'tr', 'uz', 'wa'],
  nr: [1, 2],
  fc: 1
}, {
  lngs: ['af', 'an', 'ast', 'az', 'bg', 'bn', 'ca', 'da', 'de', 'dev', 'el', 'en', 'eo', 'es', 'et', 'eu', 'fi', 'fo', 'fur', 'fy', 'gl', 'gu', 'ha', 'hi', 'hu', 'hy', 'ia', 'it', 'kn', 'ku', 'lb', 'mai', 'ml', 'mn', 'mr', 'nah', 'nap', 'nb', 'ne', 'nl', 'nn', 'no', 'nso', 'pa', 'pap', 'pms', 'ps', 'pt-PT', 'rm', 'sco', 'se', 'si', 'so', 'son', 'sq', 'sv', 'sw', 'ta', 'te', 'tk', 'ur', 'yo'],
  nr: [1, 2],
  fc: 2
}, {
  lngs: ['ay', 'bo', 'cgg', 'fa', 'id', 'ja', 'jbo', 'ka', 'kk', 'km', 'ko', 'ky', 'lo', 'ms', 'sah', 'su', 'th', 'tt', 'ug', 'vi', 'wo', 'zh'],
  nr: [1],
  fc: 3
}, {
  lngs: ['be', 'bs', 'cnr', 'dz', 'hr', 'ru', 'sr', 'uk'],
  nr: [1, 2, 5],
  fc: 4
}, {
  lngs: ['ar'],
  nr: [0, 1, 2, 3, 11, 100],
  fc: 5
}, {
  lngs: ['cs', 'sk'],
  nr: [1, 2, 5],
  fc: 6
}, {
  lngs: ['csb', 'pl'],
  nr: [1, 2, 5],
  fc: 7
}, {
  lngs: ['cy'],
  nr: [1, 2, 3, 8],
  fc: 8
}, {
  lngs: ['fr'],
  nr: [1, 2],
  fc: 9
}, {
  lngs: ['ga'],
  nr: [1, 2, 3, 7, 11],
  fc: 10
}, {
  lngs: ['gd'],
  nr: [1, 2, 3, 20],
  fc: 11
}, {
  lngs: ['is'],
  nr: [1, 2],
  fc: 12
}, {
  lngs: ['jv'],
  nr: [0, 1],
  fc: 13
}, {
  lngs: ['kw'],
  nr: [1, 2, 3, 4],
  fc: 14
}, {
  lngs: ['lt'],
  nr: [1, 2, 10],
  fc: 15
}, {
  lngs: ['lv'],
  nr: [1, 2, 0],
  fc: 16
}, {
  lngs: ['mk'],
  nr: [1, 2],
  fc: 17
}, {
  lngs: ['mnk'],
  nr: [0, 1, 2],
  fc: 18
}, {
  lngs: ['mt'],
  nr: [1, 2, 11, 20],
  fc: 19
}, {
  lngs: ['or'],
  nr: [2, 1],
  fc: 2
}, {
  lngs: ['ro'],
  nr: [1, 2, 20],
  fc: 20
}, {
  lngs: ['sl'],
  nr: [5, 1, 2, 3],
  fc: 21
}, {
  lngs: ['he'],
  nr: [1, 2, 20, 21],
  fc: 22
}];
var _rulesPluralsTypes = {
  1: function _(n) {
    return Number(n > 1);
  },
  2: function _(n) {
    return Number(n != 1);
  },
  3: function _(n) {
    return 0;
  },
  4: function _(n) {
    return Number(n % 10 == 1 && n % 100 != 11 ? 0 : n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20) ? 1 : 2);
  },
  5: function _(n) {
    return Number(n === 0 ? 0 : n == 1 ? 1 : n == 2 ? 2 : n % 100 >= 3 && n % 100 <= 10 ? 3 : n % 100 >= 11 ? 4 : 5);
  },
  6: function _(n) {
    return Number(n == 1 ? 0 : n >= 2 && n <= 4 ? 1 : 2);
  },
  7: function _(n) {
    return Number(n == 1 ? 0 : n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20) ? 1 : 2);
  },
  8: function _(n) {
    return Number(n == 1 ? 0 : n == 2 ? 1 : n != 8 && n != 11 ? 2 : 3);
  },
  9: function _(n) {
    return Number(n >= 2);
  },
  10: function _(n) {
    return Number(n == 1 ? 0 : n == 2 ? 1 : n < 7 ? 2 : n < 11 ? 3 : 4);
  },
  11: function _(n) {
    return Number(n == 1 || n == 11 ? 0 : n == 2 || n == 12 ? 1 : n > 2 && n < 20 ? 2 : 3);
  },
  12: function _(n) {
    return Number(n % 10 != 1 || n % 100 == 11);
  },
  13: function _(n) {
    return Number(n !== 0);
  },
  14: function _(n) {
    return Number(n == 1 ? 0 : n == 2 ? 1 : n == 3 ? 2 : 3);
  },
  15: function _(n) {
    return Number(n % 10 == 1 && n % 100 != 11 ? 0 : n % 10 >= 2 && (n % 100 < 10 || n % 100 >= 20) ? 1 : 2);
  },
  16: function _(n) {
    return Number(n % 10 == 1 && n % 100 != 11 ? 0 : n !== 0 ? 1 : 2);
  },
  17: function _(n) {
    return Number(n == 1 || n % 10 == 1 ? 0 : 1);
  },
  18: function _(n) {
    return Number(n == 0 ? 0 : n == 1 ? 1 : 2);
  },
  19: function _(n) {
    return Number(n == 1 ? 0 : n === 0 || n % 100 > 1 && n % 100 < 11 ? 1 : n % 100 > 10 && n % 100 < 20 ? 2 : 3);
  },
  20: function _(n) {
    return Number(n == 1 ? 0 : n === 0 || n % 100 > 0 && n % 100 < 20 ? 1 : 2);
  },
  21: function _(n) {
    return Number(n % 100 == 1 ? 1 : n % 100 == 2 ? 2 : n % 100 == 3 || n % 100 == 4 ? 3 : 0);
  },
  22: function _(n) {
    return Number(n === 1 ? 0 : n === 2 ? 1 : (n < 0 || n > 10) && n % 10 == 0 ? 2 : 3);
  }
};
/* eslint-enable */

function createRules() {
  var rules = {};
  sets.forEach(function (set) {
    set.lngs.forEach(function (l) {
      rules[l] = {
        numbers: set.nr,
        plurals: _rulesPluralsTypes[set.fc]
      };
    });
  });
  return rules;
}

var PluralResolver =
/*#__PURE__*/
function () {
  function PluralResolver(languageUtils) {
    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck$1(this, PluralResolver);

    this.languageUtils = languageUtils;
    this.options = options;
    this.logger = baseLogger.create('pluralResolver');
    this.rules = createRules();
  }

  _createClass$1(PluralResolver, [{
    key: "addRule",
    value: function addRule(lng, obj) {
      this.rules[lng] = obj;
    }
  }, {
    key: "getRule",
    value: function getRule(code) {
      return this.rules[code] || this.rules[this.languageUtils.getLanguagePartFromCode(code)];
    }
  }, {
    key: "needsPlural",
    value: function needsPlural(code) {
      var rule = this.getRule(code);
      return rule && rule.numbers.length > 1;
    }
  }, {
    key: "getPluralFormsOfKey",
    value: function getPluralFormsOfKey(code, key) {
      var _this = this;

      var ret = [];
      var rule = this.getRule(code);
      if (!rule) return ret;
      rule.numbers.forEach(function (n) {
        var suffix = _this.getSuffix(code, n);

        ret.push("".concat(key).concat(suffix));
      });
      return ret;
    }
  }, {
    key: "getSuffix",
    value: function getSuffix(code, count) {
      var _this2 = this;

      var rule = this.getRule(code);

      if (rule) {
        // if (rule.numbers.length === 1) return ''; // only singular
        var idx = rule.noAbs ? rule.plurals(count) : rule.plurals(Math.abs(count));
        var suffix = rule.numbers[idx]; // special treatment for lngs only having singular and plural

        if (this.options.simplifyPluralSuffix && rule.numbers.length === 2 && rule.numbers[0] === 1) {
          if (suffix === 2) {
            suffix = 'plural';
          } else if (suffix === 1) {
            suffix = '';
          }
        }

        var returnSuffix = function returnSuffix() {
          return _this2.options.prepend && suffix.toString() ? _this2.options.prepend + suffix.toString() : suffix.toString();
        }; // COMPATIBILITY JSON
        // v1


        if (this.options.compatibilityJSON === 'v1') {
          if (suffix === 1) return '';
          if (typeof suffix === 'number') return "_plural_".concat(suffix.toString());
          return returnSuffix();
        } else if (
        /* v2 */
        this.options.compatibilityJSON === 'v2') {
          return returnSuffix();
        } else if (
        /* v3 - gettext index */
        this.options.simplifyPluralSuffix && rule.numbers.length === 2 && rule.numbers[0] === 1) {
          return returnSuffix();
        }

        return this.options.prepend && idx.toString() ? this.options.prepend + idx.toString() : idx.toString();
      }

      this.logger.warn("no plural rule found for: ".concat(code));
      return '';
    }
  }]);

  return PluralResolver;
}();

var Interpolator =
/*#__PURE__*/
function () {
  function Interpolator() {
    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    _classCallCheck$1(this, Interpolator);

    this.logger = baseLogger.create('interpolator');
    this.options = options;

    this.format = options.interpolation && options.interpolation.format || function (value) {
      return value;
    };

    this.init(options);
  }
  /* eslint no-param-reassign: 0 */


  _createClass$1(Interpolator, [{
    key: "init",
    value: function init() {
      var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
      if (!options.interpolation) options.interpolation = {
        escapeValue: true
      };
      var iOpts = options.interpolation;
      this.escape = iOpts.escape !== undefined ? iOpts.escape : escape;
      this.escapeValue = iOpts.escapeValue !== undefined ? iOpts.escapeValue : true;
      this.useRawValueToEscape = iOpts.useRawValueToEscape !== undefined ? iOpts.useRawValueToEscape : false;
      this.prefix = iOpts.prefix ? regexEscape(iOpts.prefix) : iOpts.prefixEscaped || '{{';
      this.suffix = iOpts.suffix ? regexEscape(iOpts.suffix) : iOpts.suffixEscaped || '}}';
      this.formatSeparator = iOpts.formatSeparator ? iOpts.formatSeparator : iOpts.formatSeparator || ',';
      this.unescapePrefix = iOpts.unescapeSuffix ? '' : iOpts.unescapePrefix || '-';
      this.unescapeSuffix = this.unescapePrefix ? '' : iOpts.unescapeSuffix || '';
      this.nestingPrefix = iOpts.nestingPrefix ? regexEscape(iOpts.nestingPrefix) : iOpts.nestingPrefixEscaped || regexEscape('$t(');
      this.nestingSuffix = iOpts.nestingSuffix ? regexEscape(iOpts.nestingSuffix) : iOpts.nestingSuffixEscaped || regexEscape(')');
      this.nestingOptionsSeparator = iOpts.nestingOptionsSeparator ? iOpts.nestingOptionsSeparator : iOpts.nestingOptionsSeparator || ',';
      this.maxReplaces = iOpts.maxReplaces ? iOpts.maxReplaces : 1000;
      this.alwaysFormat = iOpts.alwaysFormat !== undefined ? iOpts.alwaysFormat : false; // the regexp

      this.resetRegExp();
    }
  }, {
    key: "reset",
    value: function reset() {
      if (this.options) this.init(this.options);
    }
  }, {
    key: "resetRegExp",
    value: function resetRegExp() {
      // the regexp
      var regexpStr = "".concat(this.prefix, "(.+?)").concat(this.suffix);
      this.regexp = new RegExp(regexpStr, 'g');
      var regexpUnescapeStr = "".concat(this.prefix).concat(this.unescapePrefix, "(.+?)").concat(this.unescapeSuffix).concat(this.suffix);
      this.regexpUnescape = new RegExp(regexpUnescapeStr, 'g');
      var nestingRegexpStr = "".concat(this.nestingPrefix, "(.+?)").concat(this.nestingSuffix);
      this.nestingRegexp = new RegExp(nestingRegexpStr, 'g');
    }
  }, {
    key: "interpolate",
    value: function interpolate(str, data, lng, options) {
      var _this = this;

      var match;
      var value;
      var replaces;
      var defaultData = this.options && this.options.interpolation && this.options.interpolation.defaultVariables || {};

      function regexSafe(val) {
        return val.replace(/\$/g, '$$$$');
      }

      var handleFormat = function handleFormat(key) {
        if (key.indexOf(_this.formatSeparator) < 0) {
          var path = getPathWithDefaults(data, defaultData, key);
          return _this.alwaysFormat ? _this.format(path, undefined, lng) : path;
        }

        var p = key.split(_this.formatSeparator);
        var k = p.shift().trim();
        var f = p.join(_this.formatSeparator).trim();
        return _this.format(getPathWithDefaults(data, defaultData, k), f, lng, options);
      };

      this.resetRegExp();
      var missingInterpolationHandler = options && options.missingInterpolationHandler || this.options.missingInterpolationHandler;
      replaces = 0; // unescape if has unescapePrefix/Suffix

      /* eslint no-cond-assign: 0 */

      while (match = this.regexpUnescape.exec(str)) {
        value = handleFormat(match[1].trim());

        if (value === undefined) {
          if (typeof missingInterpolationHandler === 'function') {
            var temp = missingInterpolationHandler(str, match, options);
            value = typeof temp === 'string' ? temp : '';
          } else {
            this.logger.warn("missed to pass in variable ".concat(match[1], " for interpolating ").concat(str));
            value = '';
          }
        } else if (typeof value !== 'string' && !this.useRawValueToEscape) {
          value = makeString(value);
        }

        str = str.replace(match[0], regexSafe(value));
        this.regexpUnescape.lastIndex = 0;
        replaces++;

        if (replaces >= this.maxReplaces) {
          break;
        }
      }

      replaces = 0; // regular escape on demand

      while (match = this.regexp.exec(str)) {
        value = handleFormat(match[1].trim());

        if (value === undefined) {
          if (typeof missingInterpolationHandler === 'function') {
            var _temp = missingInterpolationHandler(str, match, options);

            value = typeof _temp === 'string' ? _temp : '';
          } else {
            this.logger.warn("missed to pass in variable ".concat(match[1], " for interpolating ").concat(str));
            value = '';
          }
        } else if (typeof value !== 'string' && !this.useRawValueToEscape) {
          value = makeString(value);
        }

        value = this.escapeValue ? regexSafe(this.escape(value)) : regexSafe(value);
        str = str.replace(match[0], value);
        this.regexp.lastIndex = 0;
        replaces++;

        if (replaces >= this.maxReplaces) {
          break;
        }
      }

      return str;
    }
  }, {
    key: "nest",
    value: function nest(str, fc) {
      var _this2 = this;

      var options = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : {};
      var match;
      var value;

      var clonedOptions = _objectSpread$2({}, options);

      clonedOptions.applyPostProcessor = false; // avoid post processing on nested lookup

      delete clonedOptions.defaultValue; // assert we do not get a endless loop on interpolating defaultValue again and again
      // if value is something like "myKey": "lorem $(anotherKey, { "count": {{aValueInOptions}} })"

      function handleHasOptions(key, inheritedOptions) {
        var sep = this.nestingOptionsSeparator;
        if (key.indexOf(sep) < 0) return key;
        var c = key.split(new RegExp("".concat(sep, "[ ]*{")));
        var optionsString = "{".concat(c[1]);
        key = c[0];
        optionsString = this.interpolate(optionsString, clonedOptions);
        optionsString = optionsString.replace(/'/g, '"');

        try {
          clonedOptions = JSON.parse(optionsString);
          if (inheritedOptions) clonedOptions = _objectSpread$2({}, inheritedOptions, clonedOptions);
        } catch (e) {
          this.logger.warn("failed parsing options string in nesting for key ".concat(key), e);
          return "".concat(key).concat(sep).concat(optionsString);
        } // assert we do not get a endless loop on interpolating defaultValue again and again


        delete clonedOptions.defaultValue;
        return key;
      } // regular escape on demand


      while (match = this.nestingRegexp.exec(str)) {
        var formatters = [];
        /**
         * If there is more than one parameter (contains the format separator). E.g.:
         *   - t(a, b)
         *   - t(a, b, c)
         *
         * And those parameters are not dynamic values (parameters do not include curly braces). E.g.:
         *   - Not t(a, { "key": "{{variable}}" })
         *   - Not t(a, b, {"keyA": "valueA", "keyB": "valueB"})
         */

        var doReduce = false;

        if (match[0].includes(this.formatSeparator) && !/{.*}/.test(match[1])) {
          var _match$1$split$map = match[1].split(this.formatSeparator).map(function (elem) {
            return elem.trim();
          });

          var _match$1$split$map2 = _toArray(_match$1$split$map);

          match[1] = _match$1$split$map2[0];
          formatters = _match$1$split$map2.slice(1);
          doReduce = true;
        }

        value = fc(handleHasOptions.call(this, match[1].trim(), clonedOptions), clonedOptions); // is only the nesting key (key1 = '$(key2)') return the value without stringify

        if (value && match[0] === str && typeof value !== 'string') return value; // no string to include or empty

        if (typeof value !== 'string') value = makeString(value);

        if (!value) {
          this.logger.warn("missed to resolve ".concat(match[1], " for nesting ").concat(str));
          value = '';
        }

        if (doReduce) {
          value = formatters.reduce(function (v, f) {
            return _this2.format(v, f, options.lng, options);
          }, value.trim());
        } // Nested keys should not be escaped by default #854
        // value = this.escapeValue ? regexSafe(utils.escape(value)) : regexSafe(value);


        str = str.replace(match[0], value);
        this.regexp.lastIndex = 0;
      }

      return str;
    }
  }]);

  return Interpolator;
}();

function remove(arr, what) {
  var found = arr.indexOf(what);

  while (found !== -1) {
    arr.splice(found, 1);
    found = arr.indexOf(what);
  }
}

var Connector =
/*#__PURE__*/
function (_EventEmitter) {
  _inherits(Connector, _EventEmitter);

  function Connector(backend, store, services) {
    var _this;

    var options = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : {};

    _classCallCheck$1(this, Connector);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(Connector).call(this));

    if (isIE10) {
      EventEmitter.call(_assertThisInitialized(_this)); // <=IE10 fix (unable to call parent constructor)
    }

    _this.backend = backend;
    _this.store = store;
    _this.services = services;
    _this.languageUtils = services.languageUtils;
    _this.options = options;
    _this.logger = baseLogger.create('backendConnector');
    _this.state = {};
    _this.queue = [];

    if (_this.backend && _this.backend.init) {
      _this.backend.init(services, options.backend, options);
    }

    return _this;
  }

  _createClass$1(Connector, [{
    key: "queueLoad",
    value: function queueLoad(languages, namespaces, options, callback) {
      var _this2 = this;

      // find what needs to be loaded
      var toLoad = [];
      var pending = [];
      var toLoadLanguages = [];
      var toLoadNamespaces = [];
      languages.forEach(function (lng) {
        var hasAllNamespaces = true;
        namespaces.forEach(function (ns) {
          var name = "".concat(lng, "|").concat(ns);

          if (!options.reload && _this2.store.hasResourceBundle(lng, ns)) {
            _this2.state[name] = 2; // loaded
          } else if (_this2.state[name] < 0) ; else if (_this2.state[name] === 1) {
            if (pending.indexOf(name) < 0) pending.push(name);
          } else {
            _this2.state[name] = 1; // pending

            hasAllNamespaces = false;
            if (pending.indexOf(name) < 0) pending.push(name);
            if (toLoad.indexOf(name) < 0) toLoad.push(name);
            if (toLoadNamespaces.indexOf(ns) < 0) toLoadNamespaces.push(ns);
          }
        });
        if (!hasAllNamespaces) toLoadLanguages.push(lng);
      });

      if (toLoad.length || pending.length) {
        this.queue.push({
          pending: pending,
          loaded: {},
          errors: [],
          callback: callback
        });
      }

      return {
        toLoad: toLoad,
        pending: pending,
        toLoadLanguages: toLoadLanguages,
        toLoadNamespaces: toLoadNamespaces
      };
    }
  }, {
    key: "loaded",
    value: function loaded(name, err, data) {
      var _name$split = name.split('|'),
          _name$split2 = _slicedToArray$1(_name$split, 2),
          lng = _name$split2[0],
          ns = _name$split2[1];

      if (err) this.emit('failedLoading', lng, ns, err);

      if (data) {
        this.store.addResourceBundle(lng, ns, data);
      } // set loaded


      this.state[name] = err ? -1 : 2; // consolidated loading done in this run - only emit once for a loaded namespace

      var loaded = {}; // callback if ready

      this.queue.forEach(function (q) {
        pushPath(q.loaded, [lng], ns);
        remove(q.pending, name);
        if (err) q.errors.push(err);

        if (q.pending.length === 0 && !q.done) {
          // only do once per loaded -> this.emit('loaded', q.loaded);
          Object.keys(q.loaded).forEach(function (l) {
            if (!loaded[l]) loaded[l] = [];

            if (q.loaded[l].length) {
              q.loaded[l].forEach(function (ns) {
                if (loaded[l].indexOf(ns) < 0) loaded[l].push(ns);
              });
            }
          });
          /* eslint no-param-reassign: 0 */

          q.done = true;

          if (q.errors.length) {
            q.callback(q.errors);
          } else {
            q.callback();
          }
        }
      }); // emit consolidated loaded event

      this.emit('loaded', loaded); // remove done load requests

      this.queue = this.queue.filter(function (q) {
        return !q.done;
      });
    }
  }, {
    key: "read",
    value: function read(lng, ns, fcName) {
      var _this3 = this;

      var tried = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : 0;
      var wait = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : 350;
      var callback = arguments.length > 5 ? arguments[5] : undefined;
      if (!lng.length) return callback(null, {}); // noting to load

      return this.backend[fcName](lng, ns, function (err, data) {
        if (err && data
        /* = retryFlag */
        && tried < 5) {
          setTimeout(function () {
            _this3.read.call(_this3, lng, ns, fcName, tried + 1, wait * 2, callback);
          }, wait);
          return;
        }

        callback(err, data);
      });
    }
    /* eslint consistent-return: 0 */

  }, {
    key: "prepareLoading",
    value: function prepareLoading(languages, namespaces) {
      var _this4 = this;

      var options = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : {};
      var callback = arguments.length > 3 ? arguments[3] : undefined;

      if (!this.backend) {
        this.logger.warn('No backend was added via i18next.use. Will not load resources.');
        return callback && callback();
      }

      if (typeof languages === 'string') languages = this.languageUtils.toResolveHierarchy(languages);
      if (typeof namespaces === 'string') namespaces = [namespaces];
      var toLoad = this.queueLoad(languages, namespaces, options, callback);

      if (!toLoad.toLoad.length) {
        if (!toLoad.pending.length) callback(); // nothing to load and no pendings...callback now

        return null; // pendings will trigger callback
      }

      toLoad.toLoad.forEach(function (name) {
        _this4.loadOne(name);
      });
    }
  }, {
    key: "load",
    value: function load(languages, namespaces, callback) {
      this.prepareLoading(languages, namespaces, {}, callback);
    }
  }, {
    key: "reload",
    value: function reload(languages, namespaces, callback) {
      this.prepareLoading(languages, namespaces, {
        reload: true
      }, callback);
    }
  }, {
    key: "loadOne",
    value: function loadOne(name) {
      var _this5 = this;

      var prefix = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : '';

      var _name$split3 = name.split('|'),
          _name$split4 = _slicedToArray$1(_name$split3, 2),
          lng = _name$split4[0],
          ns = _name$split4[1];

      this.read(lng, ns, 'read', undefined, undefined, function (err, data) {
        if (err) _this5.logger.warn("".concat(prefix, "loading namespace ").concat(ns, " for language ").concat(lng, " failed"), err);
        if (!err && data) _this5.logger.log("".concat(prefix, "loaded namespace ").concat(ns, " for language ").concat(lng), data);

        _this5.loaded(name, err, data);
      });
    }
  }, {
    key: "saveMissing",
    value: function saveMissing(languages, namespace, key, fallbackValue, isUpdate) {
      var options = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : {};

      if (this.services.utils && this.services.utils.hasLoadedNamespace && !this.services.utils.hasLoadedNamespace(namespace)) {
        this.logger.warn("did not save key \"".concat(key, "\" for namespace \"").concat(namespace, "\" as the namespace was not yet loaded"), 'This means something IS WRONG in your application setup. You access the t function before i18next.init / i18next.loadNamespace / i18next.changeLanguage was done. Wait for the callback or Promise to resolve before accessing it!!!');
        return;
      } // ignore non valid keys


      if (key === undefined || key === null || key === '') return;

      if (this.backend && this.backend.create) {
        this.backend.create(languages, namespace, key, fallbackValue, null
        /* unused callback */
        , _objectSpread$2({}, options, {
          isUpdate: isUpdate
        }));
      } // write to store to avoid resending


      if (!languages || !languages[0]) return;
      this.store.addResource(languages[0], namespace, key, fallbackValue);
    }
  }]);

  return Connector;
}(EventEmitter);

function get$1() {
  return {
    debug: false,
    initImmediate: true,
    ns: ['translation'],
    defaultNS: ['translation'],
    fallbackLng: ['dev'],
    fallbackNS: false,
    // string or array of namespaces
    whitelist: false,
    // array with whitelisted languages
    nonExplicitWhitelist: false,
    load: 'all',
    // | currentOnly | languageOnly
    preload: false,
    // array with preload languages
    simplifyPluralSuffix: true,
    keySeparator: '.',
    nsSeparator: ':',
    pluralSeparator: '_',
    contextSeparator: '_',
    partialBundledLanguages: false,
    // allow bundling certain languages that are not remotely fetched
    saveMissing: false,
    // enable to send missing values
    updateMissing: false,
    // enable to update default values if different from translated value (only useful on initial development, or when keeping code as source of truth)
    saveMissingTo: 'fallback',
    // 'current' || 'all'
    saveMissingPlurals: true,
    // will save all forms not only singular key
    missingKeyHandler: false,
    // function(lng, ns, key, fallbackValue) -> override if prefer on handling
    missingInterpolationHandler: false,
    // function(str, match)
    postProcess: false,
    // string or array of postProcessor names
    postProcessPassResolved: false,
    // pass resolved object into 'options.i18nResolved' for postprocessor
    returnNull: true,
    // allows null value as valid translation
    returnEmptyString: true,
    // allows empty string value as valid translation
    returnObjects: false,
    joinArrays: false,
    // or string to join array
    returnedObjectHandler: false,
    // function(key, value, options) triggered if key returns object but returnObjects is set to false
    parseMissingKeyHandler: false,
    // function(key) parsed a key that was not found in t() before returning
    appendNamespaceToMissingKey: false,
    appendNamespaceToCIMode: false,
    overloadTranslationOptionHandler: function handle(args) {
      var ret = {};
      if (_typeof(args[1]) === 'object') ret = args[1];
      if (typeof args[1] === 'string') ret.defaultValue = args[1];
      if (typeof args[2] === 'string') ret.tDescription = args[2];

      if (_typeof(args[2]) === 'object' || _typeof(args[3]) === 'object') {
        var options = args[3] || args[2];
        Object.keys(options).forEach(function (key) {
          ret[key] = options[key];
        });
      }

      return ret;
    },
    interpolation: {
      escapeValue: true,
      format: function format(value, _format, lng, options) {
        return value;
      },
      prefix: '{{',
      suffix: '}}',
      formatSeparator: ',',
      // prefixEscaped: '{{',
      // suffixEscaped: '}}',
      // unescapeSuffix: '',
      unescapePrefix: '-',
      nestingPrefix: '$t(',
      nestingSuffix: ')',
      nestingOptionsSeparator: ',',
      // nestingPrefixEscaped: '$t(',
      // nestingSuffixEscaped: ')',
      // defaultVariables: undefined // object that can have values to interpolate on - extends passed in interpolation data
      maxReplaces: 1000 // max replaces to prevent endless loop

    }
  };
}
/* eslint no-param-reassign: 0 */

function transformOptions(options) {
  // create namespace object if namespace is passed in as string
  if (typeof options.ns === 'string') options.ns = [options.ns];
  if (typeof options.fallbackLng === 'string') options.fallbackLng = [options.fallbackLng];
  if (typeof options.fallbackNS === 'string') options.fallbackNS = [options.fallbackNS]; // extend whitelist with cimode

  if (options.whitelist && options.whitelist.indexOf('cimode') < 0) {
    options.whitelist = options.whitelist.concat(['cimode']);
  }

  return options;
}

function noop() {}

var I18n =
/*#__PURE__*/
function (_EventEmitter) {
  _inherits(I18n, _EventEmitter);

  function I18n() {
    var _this;

    var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
    var callback = arguments.length > 1 ? arguments[1] : undefined;

    _classCallCheck$1(this, I18n);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(I18n).call(this));

    if (isIE10) {
      EventEmitter.call(_assertThisInitialized(_this)); // <=IE10 fix (unable to call parent constructor)
    }

    _this.options = transformOptions(options);
    _this.services = {};
    _this.logger = baseLogger;
    _this.modules = {
      external: []
    };

    if (callback && !_this.isInitialized && !options.isClone) {
      // https://github.com/i18next/i18next/issues/879
      if (!_this.options.initImmediate) {
        _this.init(options, callback);

        return _possibleConstructorReturn(_this, _assertThisInitialized(_this));
      }

      setTimeout(function () {
        _this.init(options, callback);
      }, 0);
    }

    return _this;
  }

  _createClass$1(I18n, [{
    key: "init",
    value: function init() {
      var _this2 = this;

      var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
      var callback = arguments.length > 1 ? arguments[1] : undefined;

      if (typeof options === 'function') {
        callback = options;
        options = {};
      }

      this.options = _objectSpread$2({}, get$1(), this.options, transformOptions(options));
      this.format = this.options.interpolation.format;
      if (!callback) callback = noop;

      function createClassOnDemand(ClassOrObject) {
        if (!ClassOrObject) return null;
        if (typeof ClassOrObject === 'function') return new ClassOrObject();
        return ClassOrObject;
      } // init services


      if (!this.options.isClone) {
        if (this.modules.logger) {
          baseLogger.init(createClassOnDemand(this.modules.logger), this.options);
        } else {
          baseLogger.init(null, this.options);
        }

        var lu = new LanguageUtil(this.options);
        this.store = new ResourceStore(this.options.resources, this.options);
        var s = this.services;
        s.logger = baseLogger;
        s.resourceStore = this.store;
        s.languageUtils = lu;
        s.pluralResolver = new PluralResolver(lu, {
          prepend: this.options.pluralSeparator,
          compatibilityJSON: this.options.compatibilityJSON,
          simplifyPluralSuffix: this.options.simplifyPluralSuffix
        });
        s.interpolator = new Interpolator(this.options);
        s.utils = {
          hasLoadedNamespace: this.hasLoadedNamespace.bind(this)
        };
        s.backendConnector = new Connector(createClassOnDemand(this.modules.backend), s.resourceStore, s, this.options); // pipe events from backendConnector

        s.backendConnector.on('*', function (event) {
          for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
            args[_key - 1] = arguments[_key];
          }

          _this2.emit.apply(_this2, [event].concat(args));
        });

        if (this.modules.languageDetector) {
          s.languageDetector = createClassOnDemand(this.modules.languageDetector);
          s.languageDetector.init(s, this.options.detection, this.options);
        }

        if (this.modules.i18nFormat) {
          s.i18nFormat = createClassOnDemand(this.modules.i18nFormat);
          if (s.i18nFormat.init) s.i18nFormat.init(this);
        }

        this.translator = new Translator(this.services, this.options); // pipe events from translator

        this.translator.on('*', function (event) {
          for (var _len2 = arguments.length, args = new Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
            args[_key2 - 1] = arguments[_key2];
          }

          _this2.emit.apply(_this2, [event].concat(args));
        });
        this.modules.external.forEach(function (m) {
          if (m.init) m.init(_this2);
        });
      }

      if (!this.modules.languageDetector && !this.options.lng) {
        this.logger.warn('init: no languageDetector is used and no lng is defined');
      } // append api


      var storeApi = ['getResource', 'addResource', 'addResources', 'addResourceBundle', 'removeResourceBundle', 'hasResourceBundle', 'getResourceBundle', 'getDataByLanguage'];
      storeApi.forEach(function (fcName) {
        _this2[fcName] = function () {
          var _this2$store;

          return (_this2$store = _this2.store)[fcName].apply(_this2$store, arguments);
        };
      });
      var deferred = defer();

      var load = function load() {
        _this2.changeLanguage(_this2.options.lng, function (err, t) {
          _this2.isInitialized = true;

          _this2.logger.log('initialized', _this2.options);

          _this2.emit('initialized', _this2.options);

          deferred.resolve(t); // not rejecting on err (as err is only a loading translation failed warning)

          callback(err, t);
        });
      };

      if (this.options.resources || !this.options.initImmediate) {
        load();
      } else {
        setTimeout(load, 0);
      }

      return deferred;
    }
    /* eslint consistent-return: 0 */

  }, {
    key: "loadResources",
    value: function loadResources(language) {
      var _this3 = this;

      var callback = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : noop;
      var usedCallback = callback;
      var usedLng = typeof language === 'string' ? language : this.language;
      if (typeof language === 'function') usedCallback = language;

      if (!this.options.resources || this.options.partialBundledLanguages) {
        if (usedLng && usedLng.toLowerCase() === 'cimode') return usedCallback(); // avoid loading resources for cimode

        var toLoad = [];

        var append = function append(lng) {
          if (!lng) return;

          var lngs = _this3.services.languageUtils.toResolveHierarchy(lng);

          lngs.forEach(function (l) {
            if (toLoad.indexOf(l) < 0) toLoad.push(l);
          });
        };

        if (!usedLng) {
          // at least load fallbacks in this case
          var fallbacks = this.services.languageUtils.getFallbackCodes(this.options.fallbackLng);
          fallbacks.forEach(function (l) {
            return append(l);
          });
        } else {
          append(usedLng);
        }

        if (this.options.preload) {
          this.options.preload.forEach(function (l) {
            return append(l);
          });
        }

        this.services.backendConnector.load(toLoad, this.options.ns, usedCallback);
      } else {
        usedCallback(null);
      }
    }
  }, {
    key: "reloadResources",
    value: function reloadResources(lngs, ns, callback) {
      var deferred = defer();
      if (!lngs) lngs = this.languages;
      if (!ns) ns = this.options.ns;
      if (!callback) callback = noop;
      this.services.backendConnector.reload(lngs, ns, function (err) {
        deferred.resolve(); // not rejecting on err (as err is only a loading translation failed warning)

        callback(err);
      });
      return deferred;
    }
  }, {
    key: "use",
    value: function use(module) {
      if (!module) throw new Error('You are passing an undefined module! Please check the object you are passing to i18next.use()');
      if (!module.type) throw new Error('You are passing a wrong module! Please check the object you are passing to i18next.use()');

      if (module.type === 'backend') {
        this.modules.backend = module;
      }

      if (module.type === 'logger' || module.log && module.warn && module.error) {
        this.modules.logger = module;
      }

      if (module.type === 'languageDetector') {
        this.modules.languageDetector = module;
      }

      if (module.type === 'i18nFormat') {
        this.modules.i18nFormat = module;
      }

      if (module.type === 'postProcessor') {
        postProcessor.addPostProcessor(module);
      }

      if (module.type === '3rdParty') {
        this.modules.external.push(module);
      }

      return this;
    }
  }, {
    key: "changeLanguage",
    value: function changeLanguage(lng, callback) {
      var _this4 = this;

      this.isLanguageChangingTo = lng;
      var deferred = defer();
      this.emit('languageChanging', lng);

      var done = function done(err, l) {
        if (l) {
          _this4.language = l;
          _this4.languages = _this4.services.languageUtils.toResolveHierarchy(l);

          _this4.translator.changeLanguage(l);

          _this4.isLanguageChangingTo = undefined;

          _this4.emit('languageChanged', l);

          _this4.logger.log('languageChanged', l);
        } else {
          _this4.isLanguageChangingTo = undefined;
        }

        deferred.resolve(function () {
          return _this4.t.apply(_this4, arguments);
        });
        if (callback) callback(err, function () {
          return _this4.t.apply(_this4, arguments);
        });
      };

      var setLng = function setLng(l) {
        if (l) {
          if (!_this4.language) {
            _this4.language = l;
            _this4.languages = _this4.services.languageUtils.toResolveHierarchy(l);
          }

          if (!_this4.translator.language) _this4.translator.changeLanguage(l);
          if (_this4.services.languageDetector) _this4.services.languageDetector.cacheUserLanguage(l);
        }

        _this4.loadResources(l, function (err) {
          done(err, l);
        });
      };

      if (!lng && this.services.languageDetector && !this.services.languageDetector.async) {
        setLng(this.services.languageDetector.detect());
      } else if (!lng && this.services.languageDetector && this.services.languageDetector.async) {
        this.services.languageDetector.detect(setLng);
      } else {
        setLng(lng);
      }

      return deferred;
    }
  }, {
    key: "getFixedT",
    value: function getFixedT(lng, ns) {
      var _this5 = this;

      var fixedT = function fixedT(key, opts) {
        var options;

        if (_typeof(opts) !== 'object') {
          for (var _len3 = arguments.length, rest = new Array(_len3 > 2 ? _len3 - 2 : 0), _key3 = 2; _key3 < _len3; _key3++) {
            rest[_key3 - 2] = arguments[_key3];
          }

          options = _this5.options.overloadTranslationOptionHandler([key, opts].concat(rest));
        } else {
          options = _objectSpread$2({}, opts);
        }

        options.lng = options.lng || fixedT.lng;
        options.lngs = options.lngs || fixedT.lngs;
        options.ns = options.ns || fixedT.ns;
        return _this5.t(key, options);
      };

      if (typeof lng === 'string') {
        fixedT.lng = lng;
      } else {
        fixedT.lngs = lng;
      }

      fixedT.ns = ns;
      return fixedT;
    }
  }, {
    key: "t",
    value: function t() {
      var _this$translator;

      return this.translator && (_this$translator = this.translator).translate.apply(_this$translator, arguments);
    }
  }, {
    key: "exists",
    value: function exists() {
      var _this$translator2;

      return this.translator && (_this$translator2 = this.translator).exists.apply(_this$translator2, arguments);
    }
  }, {
    key: "setDefaultNamespace",
    value: function setDefaultNamespace(ns) {
      this.options.defaultNS = ns;
    }
  }, {
    key: "hasLoadedNamespace",
    value: function hasLoadedNamespace(ns) {
      var _this6 = this;

      if (!this.isInitialized) {
        this.logger.warn('hasLoadedNamespace: i18next was not initialized', this.languages);
        return false;
      }

      if (!this.languages || !this.languages.length) {
        this.logger.warn('hasLoadedNamespace: i18n.languages were undefined or empty', this.languages);
        return false;
      }

      var lng = this.languages[0];
      var fallbackLng = this.options ? this.options.fallbackLng : false;
      var lastLng = this.languages[this.languages.length - 1]; // we're in cimode so this shall pass

      if (lng.toLowerCase() === 'cimode') return true;

      var loadNotPending = function loadNotPending(l, n) {
        var loadState = _this6.services.backendConnector.state["".concat(l, "|").concat(n)];

        return loadState === -1 || loadState === 2;
      }; // loaded -> SUCCESS


      if (this.hasResourceBundle(lng, ns)) return true; // were not loading at all -> SEMI SUCCESS

      if (!this.services.backendConnector.backend) return true; // failed loading ns - but at least fallback is not pending -> SEMI SUCCESS

      if (loadNotPending(lng, ns) && (!fallbackLng || loadNotPending(lastLng, ns))) return true;
      return false;
    }
  }, {
    key: "loadNamespaces",
    value: function loadNamespaces(ns, callback) {
      var _this7 = this;

      var deferred = defer();

      if (!this.options.ns) {
        callback && callback();
        return Promise.resolve();
      }

      if (typeof ns === 'string') ns = [ns];
      ns.forEach(function (n) {
        if (_this7.options.ns.indexOf(n) < 0) _this7.options.ns.push(n);
      });
      this.loadResources(function (err) {
        deferred.resolve();
        if (callback) callback(err);
      });
      return deferred;
    }
  }, {
    key: "loadLanguages",
    value: function loadLanguages(lngs, callback) {
      var deferred = defer();
      if (typeof lngs === 'string') lngs = [lngs];
      var preloaded = this.options.preload || [];
      var newLngs = lngs.filter(function (lng) {
        return preloaded.indexOf(lng) < 0;
      }); // Exit early if all given languages are already preloaded

      if (!newLngs.length) {
        if (callback) callback();
        return Promise.resolve();
      }

      this.options.preload = preloaded.concat(newLngs);
      this.loadResources(function (err) {
        deferred.resolve();
        if (callback) callback(err);
      });
      return deferred;
    }
  }, {
    key: "dir",
    value: function dir(lng) {
      if (!lng) lng = this.languages && this.languages.length > 0 ? this.languages[0] : this.language;
      if (!lng) return 'rtl';
      var rtlLngs = ['ar', 'shu', 'sqr', 'ssh', 'xaa', 'yhd', 'yud', 'aao', 'abh', 'abv', 'acm', 'acq', 'acw', 'acx', 'acy', 'adf', 'ads', 'aeb', 'aec', 'afb', 'ajp', 'apc', 'apd', 'arb', 'arq', 'ars', 'ary', 'arz', 'auz', 'avl', 'ayh', 'ayl', 'ayn', 'ayp', 'bbz', 'pga', 'he', 'iw', 'ps', 'pbt', 'pbu', 'pst', 'prp', 'prd', 'ur', 'ydd', 'yds', 'yih', 'ji', 'yi', 'hbo', 'men', 'xmn', 'fa', 'jpr', 'peo', 'pes', 'prs', 'dv', 'sam'];
      return rtlLngs.indexOf(this.services.languageUtils.getLanguagePartFromCode(lng)) >= 0 ? 'rtl' : 'ltr';
    }
    /* eslint class-methods-use-this: 0 */

  }, {
    key: "createInstance",
    value: function createInstance() {
      var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
      var callback = arguments.length > 1 ? arguments[1] : undefined;
      return new I18n(options, callback);
    }
  }, {
    key: "cloneInstance",
    value: function cloneInstance() {
      var _this8 = this;

      var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
      var callback = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : noop;

      var mergedOptions = _objectSpread$2({}, this.options, options, {
        isClone: true
      });

      var clone = new I18n(mergedOptions);
      var membersToCopy = ['store', 'services', 'language'];
      membersToCopy.forEach(function (m) {
        clone[m] = _this8[m];
      });
      clone.services = _objectSpread$2({}, this.services);
      clone.services.utils = {
        hasLoadedNamespace: clone.hasLoadedNamespace.bind(clone)
      };
      clone.translator = new Translator(clone.services, clone.options);
      clone.translator.on('*', function (event) {
        for (var _len4 = arguments.length, args = new Array(_len4 > 1 ? _len4 - 1 : 0), _key4 = 1; _key4 < _len4; _key4++) {
          args[_key4 - 1] = arguments[_key4];
        }

        clone.emit.apply(clone, [event].concat(args));
      });
      clone.init(mergedOptions, callback);
      clone.translator.options = clone.options; // sync options

      clone.translator.backendConnector.services.utils = {
        hasLoadedNamespace: clone.hasLoadedNamespace.bind(clone)
      };
      return clone;
    }
  }]);

  return I18n;
}(EventEmitter);

var i18next = new I18n();

var arr = [];
var each = arr.forEach;
var slice = arr.slice;
function defaults(obj) {
  each.call(slice.call(arguments, 1), function (source) {
    if (source) {
      for (var prop in source) {
        if (obj[prop] === undefined) obj[prop] = source[prop];
      }
    }
  });
  return obj;
}

function addQueryString(url, params) {
  if (params && _typeof(params) === 'object') {
    var queryString = '',
        e = encodeURIComponent; // Must encode data

    for (var paramName in params) {
      queryString += '&' + e(paramName) + '=' + e(params[paramName]);
    }

    if (!queryString) {
      return url;
    }

    url = url + (url.indexOf('?') !== -1 ? '&' : '?') + queryString.slice(1);
  }

  return url;
} // https://gist.github.com/Xeoncross/7663273


function ajax(url, options, callback, data, cache) {
  if (data && _typeof(data) === 'object') {
    if (!cache) {
      data['_t'] = new Date();
    } // URL encoded form data must be in querystring format


    data = addQueryString('', data).slice(1);
  }

  if (options.queryStringParams) {
    url = addQueryString(url, options.queryStringParams);
  }

  try {
    var x;

    if (XMLHttpRequest) {
      x = new XMLHttpRequest();
    } else {
      x = new ActiveXObject('MSXML2.XMLHTTP.3.0');
    }

    x.open(data ? 'POST' : 'GET', url, 1);

    if (!options.crossDomain) {
      x.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    }

    x.withCredentials = !!options.withCredentials;

    if (data) {
      x.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    }

    if (x.overrideMimeType) {
      x.overrideMimeType("application/json");
    }

    var h = options.customHeaders;
    h = typeof h === 'function' ? h() : h;

    if (h) {
      for (var i in h) {
        x.setRequestHeader(i, h[i]);
      }
    }

    x.onreadystatechange = function () {
      x.readyState > 3 && callback && callback(x.responseText, x);
    };

    x.send(data);
  } catch (e) {
    console && console.log(e);
  }
}

function getDefaults$1() {
  return {
    loadPath: '/locales/{{lng}}/{{ns}}.json',
    addPath: '/locales/add/{{lng}}/{{ns}}',
    allowMultiLoading: false,
    parse: JSON.parse,
    parsePayload: function parsePayload(namespace, key, fallbackValue) {
      return _defineProperty$1({}, key, fallbackValue || '');
    },
    crossDomain: false,
    ajax: ajax
  };
}

var Backend =
/*#__PURE__*/
function () {
  function Backend(services) {
    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck$1(this, Backend);

    this.init(services, options);
    this.type = 'backend';
  }

  _createClass$1(Backend, [{
    key: "init",
    value: function init(services) {
      var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
      this.services = services;
      this.options = defaults(options, this.options || {}, getDefaults$1());
    }
  }, {
    key: "readMulti",
    value: function readMulti(languages, namespaces, callback) {
      var loadPath = this.options.loadPath;

      if (typeof this.options.loadPath === 'function') {
        loadPath = this.options.loadPath(languages, namespaces);
      }

      var url = this.services.interpolator.interpolate(loadPath, {
        lng: languages.join('+'),
        ns: namespaces.join('+')
      });
      this.loadUrl(url, callback);
    }
  }, {
    key: "read",
    value: function read(language, namespace, callback) {
      var loadPath = this.options.loadPath;

      if (typeof this.options.loadPath === 'function') {
        loadPath = this.options.loadPath([language], [namespace]);
      }

      var url = this.services.interpolator.interpolate(loadPath, {
        lng: language,
        ns: namespace
      });
      this.loadUrl(url, callback);
    }
  }, {
    key: "loadUrl",
    value: function loadUrl(url, callback) {
      var _this = this;

      this.options.ajax(url, this.options, function (data, xhr) {
        if (xhr.status >= 500 && xhr.status < 600) return callback('failed loading ' + url, true
        /* retry */
        );
        if (xhr.status >= 400 && xhr.status < 500) return callback('failed loading ' + url, false
        /* no retry */
        );
        var ret, err;

        try {
          ret = _this.options.parse(data, url);
        } catch (e) {
          err = 'failed parsing ' + url + ' to json';
        }

        if (err) return callback(err, false);
        callback(null, ret);
      });
    }
  }, {
    key: "create",
    value: function create(languages, namespace, key, fallbackValue) {
      var _this2 = this;

      if (typeof languages === 'string') languages = [languages];
      var payload = this.options.parsePayload(namespace, key, fallbackValue);
      languages.forEach(function (lng) {
        var url = _this2.services.interpolator.interpolate(_this2.options.addPath, {
          lng: lng,
          ns: namespace
        });

        _this2.options.ajax(url, _this2.options, function (data, xhr) {//const statusCode = xhr.status.toString();
          // TODO: if statusCode === 4xx do log
        }, payload);
      });
    }
  }]);

  return Backend;
}();

Backend.type = 'backend';

var i18nPromise = i18next
    .use(Backend)
    .use(initReactI18next)
    .init({
    lng: 'fr',
    fallbackLng: 'fr',
    debug: process.env.NODE_ENV !== 'production' && false,
    interpolation: {
        escapeValue: false,
    },
});

var withi18n = function (Wrapped) {
    var Wrapper = function (props) {
        /** */
        return (React__default.createElement(React__default.Suspense, { fallback: React__default.createElement(core.Box, { p: 2 },
                React__default.createElement(core.CircularProgress, null)) },
            React__default.createElement(Wrapped, __assign({}, props))));
    };
    return Wrapper;
};

var formatDistanceLocale$1 = {
  lessThanXSeconds: {
    one: 'moins d’une seconde',
    other: 'moins de {{count}} secondes'
  },
  xSeconds: {
    one: '1 seconde',
    other: '{{count}} secondes'
  },
  halfAMinute: '30 secondes',
  lessThanXMinutes: {
    one: 'moins d’une minute',
    other: 'moins de {{count}} minutes'
  },
  xMinutes: {
    one: '1 minute',
    other: '{{count}} minutes'
  },
  aboutXHours: {
    one: 'environ 1 heure',
    other: 'environ {{count}} heures'
  },
  xHours: {
    one: '1 heure',
    other: '{{count}} heures'
  },
  xDays: {
    one: '1 jour',
    other: '{{count}} jours'
  },
  aboutXMonths: {
    one: 'environ 1 mois',
    other: 'environ {{count}} mois'
  },
  xMonths: {
    one: '1 mois',
    other: '{{count}} mois'
  },
  aboutXYears: {
    one: 'environ 1 an',
    other: 'environ {{count}} ans'
  },
  xYears: {
    one: '1 an',
    other: '{{count}} ans'
  },
  overXYears: {
    one: 'plus d’un an',
    other: 'plus de {{count}} ans'
  },
  almostXYears: {
    one: 'presqu’un an',
    other: 'presque {{count}} ans'
  }
};
function formatDistance$1(token, count, options) {
  options = options || {};
  var result;

  if (typeof formatDistanceLocale$1[token] === 'string') {
    result = formatDistanceLocale$1[token];
  } else if (count === 1) {
    result = formatDistanceLocale$1[token].one;
  } else {
    result = formatDistanceLocale$1[token].other.replace('{{count}}', count);
  }

  if (options.addSuffix) {
    if (options.comparison > 0) {
      return 'dans ' + result;
    } else {
      return 'il y a ' + result;
    }
  }

  return result;
}

var dateFormats$1 = {
  full: 'EEEE d MMMM y',
  long: 'd MMMM y',
  medium: 'd MMM y',
  short: 'dd/MM/y'
};
var timeFormats$1 = {
  full: 'HH:mm:ss zzzz',
  long: 'HH:mm:ss z',
  medium: 'HH:mm:ss',
  short: 'HH:mm'
};
var dateTimeFormats$1 = {
  full: "{{date}} 'à' {{time}}",
  long: "{{date}} 'à' {{time}}",
  medium: '{{date}}, {{time}}',
  short: '{{date}}, {{time}}'
};
var formatLong$1 = {
  date: buildFormatLongFn({
    formats: dateFormats$1,
    defaultWidth: 'full'
  }),
  time: buildFormatLongFn({
    formats: timeFormats$1,
    defaultWidth: 'full'
  }),
  dateTime: buildFormatLongFn({
    formats: dateTimeFormats$1,
    defaultWidth: 'full'
  })
};

var formatRelativeLocale$1 = {
  lastWeek: "eeee 'dernier à' p",
  yesterday: "'hier à' p",
  today: "'aujourd’hui à' p",
  tomorrow: "'demain à' p'",
  nextWeek: "eeee 'prochain à' p",
  other: 'P'
};
function formatRelative$1(token, _date, _baseDate, _options) {
  return formatRelativeLocale$1[token];
}

var eraValues$1 = {
  narrow: ['av. J.-C', 'ap. J.-C'],
  abbreviated: ['av. J.-C', 'ap. J.-C'],
  wide: ['avant Jésus-Christ', 'après Jésus-Christ']
};
var quarterValues$1 = {
  narrow: ['T1', 'T2', 'T3', 'T4'],
  abbreviated: ['1er trim.', '2ème trim.', '3ème trim.', '4ème trim.'],
  wide: ['1er trimestre', '2ème trimestre', '3ème trimestre', '4ème trimestre']
};
var monthValues$1 = {
  narrow: ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
  abbreviated: ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'],
  wide: ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
};
var dayValues$1 = {
  narrow: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
  short: ['di', 'lu', 'ma', 'me', 'je', 've', 'sa'],
  abbreviated: ['dim.', 'lun.', 'mar.', 'mer.', 'jeu.', 'ven.', 'sam.'],
  wide: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi']
};
var dayPeriodValues$1 = {
  narrow: {
    am: 'AM',
    pm: 'PM',
    midnight: 'minuit',
    noon: 'midi',
    morning: 'mat.',
    afternoon: 'ap.m.',
    evening: 'soir',
    night: 'mat.'
  },
  abbreviated: {
    am: 'AM',
    pm: 'PM',
    midnight: 'minuit',
    noon: 'midi',
    morning: 'matin',
    afternoon: 'après-midi',
    evening: 'soir',
    night: 'matin'
  },
  wide: {
    am: 'AM',
    pm: 'PM',
    midnight: 'minuit',
    noon: 'midi',
    morning: 'du matin',
    afternoon: 'de l’après-midi',
    evening: 'du soir',
    night: 'du matin'
  }
};

function ordinalNumber$1(dirtyNumber, dirtyOptions) {
  var number = Number(dirtyNumber);
  var options = dirtyOptions || {};
  var unit = String(options.unit);
  var suffix;

  if (number === 0) {
    return number;
  }

  if (unit === 'year' || unit === 'hour' || unit === 'week') {
    if (number === 1) {
      suffix = 'ère';
    } else {
      suffix = 'ème';
    }
  } else {
    if (number === 1) {
      suffix = 'er';
    } else {
      suffix = 'ème';
    }
  }

  return number + suffix;
}

var localize$1 = {
  ordinalNumber: ordinalNumber$1,
  era: buildLocalizeFn({
    values: eraValues$1,
    defaultWidth: 'wide'
  }),
  quarter: buildLocalizeFn({
    values: quarterValues$1,
    defaultWidth: 'wide',
    argumentCallback: function (quarter) {
      return Number(quarter) - 1;
    }
  }),
  month: buildLocalizeFn({
    values: monthValues$1,
    defaultWidth: 'wide'
  }),
  day: buildLocalizeFn({
    values: dayValues$1,
    defaultWidth: 'wide'
  }),
  dayPeriod: buildLocalizeFn({
    values: dayPeriodValues$1,
    defaultWidth: 'wide'
  })
};

var matchOrdinalNumberPattern$1 = /^(\d+)(ième|ère|ème|er|e)?/i;
var parseOrdinalNumberPattern$1 = /\d+/i;
var matchEraPatterns$1 = {
  narrow: /^(av\.J\.C|ap\.J\.C|ap\.J\.-C)/i,
  abbreviated: /^(av\.J\.-C|av\.J-C|apr\.J\.-C|apr\.J-C|ap\.J-C)/i,
  wide: /^(avant Jésus-Christ|après Jésus-Christ)/i
};
var parseEraPatterns$1 = {
  any: [/^av/i, /^ap/i]
};
var matchQuarterPatterns$1 = {
  narrow: /^[1234]/i,
  abbreviated: /^t[1234]/i,
  wide: /^[1234](er|ème|e)? trimestre/i
};
var parseQuarterPatterns$1 = {
  any: [/1/i, /2/i, /3/i, /4/i]
};
var matchMonthPatterns$1 = {
  narrow: /^[jfmasond]/i,
  abbreviated: /^(janv|févr|mars|avr|mai|juin|juill|juil|août|sept|oct|nov|déc)\.?/i,
  wide: /^(janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre)/i
};
var parseMonthPatterns$1 = {
  narrow: [/^j/i, /^f/i, /^m/i, /^a/i, /^m/i, /^j/i, /^j/i, /^a/i, /^s/i, /^o/i, /^n/i, /^d/i],
  any: [/^ja/i, /^f/i, /^mar/i, /^av/i, /^ma/i, /^juin/i, /^juil/i, /^ao/i, /^s/i, /^o/i, /^n/i, /^d/i]
};
var matchDayPatterns$1 = {
  narrow: /^[lmjvsd]/i,
  short: /^(di|lu|ma|me|je|ve|sa)/i,
  abbreviated: /^(dim|lun|mar|mer|jeu|ven|sam)\.?/i,
  wide: /^(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi)/i
};
var parseDayPatterns$1 = {
  narrow: [/^d/i, /^l/i, /^m/i, /^m/i, /^j/i, /^v/i, /^s/i],
  any: [/^di/i, /^lu/i, /^ma/i, /^me/i, /^je/i, /^ve/i, /^sa/i]
};
var matchDayPeriodPatterns$1 = {
  narrow: /^(a|p|minuit|midi|mat\.?|ap\.?m\.?|soir|nuit)/i,
  any: /^([ap]\.?\s?m\.?|du matin|de l'après[-\s]midi|du soir|de la nuit)/i
};
var parseDayPeriodPatterns$1 = {
  any: {
    am: /^a/i,
    pm: /^p/i,
    midnight: /^min/i,
    noon: /^mid/i,
    morning: /mat/i,
    afternoon: /ap/i,
    evening: /soir/i,
    night: /nuit/i
  }
};
var match$2 = {
  ordinalNumber: buildMatchPatternFn({
    matchPattern: matchOrdinalNumberPattern$1,
    parsePattern: parseOrdinalNumberPattern$1,
    valueCallback: function (value) {
      return parseInt(value, 10);
    }
  }),
  era: buildMatchFn({
    matchPatterns: matchEraPatterns$1,
    defaultMatchWidth: 'wide',
    parsePatterns: parseEraPatterns$1,
    defaultParseWidth: 'any'
  }),
  quarter: buildMatchFn({
    matchPatterns: matchQuarterPatterns$1,
    defaultMatchWidth: 'wide',
    parsePatterns: parseQuarterPatterns$1,
    defaultParseWidth: 'any',
    valueCallback: function (index) {
      return index + 1;
    }
  }),
  month: buildMatchFn({
    matchPatterns: matchMonthPatterns$1,
    defaultMatchWidth: 'wide',
    parsePatterns: parseMonthPatterns$1,
    defaultParseWidth: 'any'
  }),
  day: buildMatchFn({
    matchPatterns: matchDayPatterns$1,
    defaultMatchWidth: 'wide',
    parsePatterns: parseDayPatterns$1,
    defaultParseWidth: 'any'
  }),
  dayPeriod: buildMatchFn({
    matchPatterns: matchDayPeriodPatterns$1,
    defaultMatchWidth: 'any',
    parsePatterns: parseDayPeriodPatterns$1,
    defaultParseWidth: 'any'
  })
};

/**
 * @type {Locale}
 * @category Locales
 * @summary French locale.
 * @language French
 * @iso-639-2 fra
 * @author Jean Dupouy [@izeau]{@link https://github.com/izeau}
 * @author François B [@fbonzon]{@link https://github.com/fbonzon}
 */

var locale$1 = {
  code: 'fr',
  formatDistance: formatDistance$1,
  formatLong: formatLong$1,
  formatRelative: formatRelative$1,
  localize: localize$1,
  match: match$2,
  options: {
    weekStartsOn: 1
    /* Monday */
    ,
    firstWeekContainsDate: 1
  }
};

// eslint-disable-next-line import/prefer-default-export
var firstLetterUppercase = function (str) { return "" + str.charAt(0).toUpperCase() + str.slice(1).toLowerCase(); };

var computeStrOptions = function (str, options) {
    var res = str;
    if (options) {
        if (options.firstLetterUppercase)
            res = firstLetterUppercase(res);
    }
    return res;
};
var format$1 = function (date, f, strOptions) {
    return computeStrOptions(format(date, f, { locale: locale$1 }), strOptions);
};

var useStyles$1 = core.makeStyles(function (theme) { return ({
    btn: function (_a) {
        var hasActivated = _a.hasActivated;
        return (__assign({ padding: '5px 10px', lineHeight: '21px', textTransform: 'none', border: '1px solid #ccc', borderRadius: 3, boxShadow: 'none', backgroundColor: theme.palette.common.white }, (hasActivated ? { color: 'green' } : {})));
    },
}); });
var ActivateDistribSlotsView = function (_a) {
    var distribId = _a.distribId, slotDuration = _a.slotDuration;
    var t = useTranslation(['translation', 'neo/distrib-slots']).t;
    var _b = React__default.useState(false), opened = _b[0], toggleOpened = _b[1];
    var _c = React__default.useState(), distrib = _c[0], setDistrib = _c[1];
    var _d = React__default.useState(false), submitting = _d[0], toggleSubmitting = _d[1];
    var _e = React__default.useState(), error = _e[0], setError = _e[1];
    var _f = React__default.useState(false), hasActivated = _f[0], toggleHasActivated = _f[1];
    var _g = React__default.useState('solo-only'), mode = _g[0], setMode = _g[1];
    var cs = useStyles$1({ hasActivated: hasActivated });
    var nbSlots = distrib && distrib.end && distrib.start
        ? Math.floor((distrib.end.getTime() - distrib.start.getTime()) / slotDuration)
        : 0;
    /** */
    var closeDialog = function () {
        if (submitting)
            return;
        toggleOpened(false);
    };
    /** */
    var onModeChange = function (e) {
        setMode(e.target.value);
    };
    var onButtonClick = function () {
        toggleOpened(true);
    };
    var onConfirmClick = function () { return __awaiter(void 0, void 0, void 0, function () {
        var formData, res, err_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    setError(undefined);
                    toggleSubmitting(true);
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, , 4]);
                    formData = new FormData();
                    formData.append('mode', mode);
                    return [4 /*yield*/, api$1.distrib.activateSlots(distribId, formData, 'data')];
                case 2:
                    res = _a.sent();
                    if (res) {
                        setDistrib(res);
                        toggleSubmitting(false);
                        toggleOpened(false);
                        toggleHasActivated(true);
                    }
                    return [3 /*break*/, 4];
                case 3:
                    err_1 = _a.sent();
                    setError(t('error', { error: err_1 }));
                    toggleSubmitting(false);
                    return [3 /*break*/, 4];
                case 4: return [2 /*return*/];
            }
        });
    }); };
    var onDisableSlotsClick = function () { return __awaiter(void 0, void 0, void 0, function () {
        var formData, res, err_2;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    setError(undefined);
                    toggleSubmitting(true);
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, , 4]);
                    formData = new FormData();
                    formData.append('mode', mode);
                    return [4 /*yield*/, api$1.distrib.disableSlots(distribId)];
                case 2:
                    res = _a.sent();
                    if (res) {
                        setDistrib(res);
                        toggleSubmitting(false);
                        toggleOpened(false);
                    }
                    return [3 /*break*/, 4];
                case 3:
                    err_2 = _a.sent();
                    setError(t('error', { error: err_2 }));
                    toggleSubmitting(false);
                    return [3 /*break*/, 4];
                case 4: return [2 /*return*/];
            }
        });
    }); };
    /** */
    React__default.useEffect(function () {
        var active = true;
        var load = function () { return __awaiter(void 0, void 0, void 0, function () {
            var res, err_3;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        _a.trys.push([0, 2, , 3]);
                        return [4 /*yield*/, api$1.distrib.getDistrib(distribId)];
                    case 1:
                        res = _a.sent();
                        if (active && res) {
                            setDistrib(__assign({}, res));
                        }
                        return [3 /*break*/, 3];
                    case 2:
                        err_3 = _a.sent();
                        setError(t('error', { error: err_3 }));
                        return [3 /*break*/, 3];
                    case 3: return [2 /*return*/];
                }
            });
        }); };
        load();
        return function () {
            active = false;
        };
    }, []);
    /** */
    if (!distrib || !distrib.start || !distrib.end)
        return (React__default.createElement(core.Box, { p: 2 }, error ? (React__default.createElement(core.Box, { p: 2 },
            React__default.createElement(lab.Alert, { severity: "error" }, error))) : (React__default.createElement(core.CircularProgress, { size: 20 }))));
    if (distrib.orderEndDate && !isBefore(new Date(), distrib.orderEndDate)) {
        if (!distrib.slots)
            return React__default.createElement(React__default.Fragment, null);
        var goTo = function () {
            document.location.href = "/distribution/timeSlots/" + distrib.id;
        };
        return (React__default.createElement(core.Button, { className: cs.btn, variant: "contained", onClick: goTo },
            React__default.createElement("img", { width: 14, height: 14, src: "/img/virus.svg", alt: "" }),
            React__default.createElement(core.Box, { mr: 1 }),
            t("neo/distrib-slots:activeDistrib.activatedBtn")));
    }
    var ButtonWithConfirmDialog = withConfirmDialog(core.Button, {
        title: t('neo/distrib-slots:activeDistrib.disableSlotsAlertTitle'),
        cancelButtonLabel: t('cancel'),
        confirmButtonLabel: t('confirm'),
    });
    return (React__default.createElement(React__default.Fragment, null,
        React__default.createElement(core.Button, { className: cs.btn, variant: "contained", onClick: onButtonClick },
            hasActivated ? React__default.createElement(CheckIcon, { fontSize: "small" }) : React__default.createElement("img", { width: 14, height: 14, src: "/img/virus.svg", alt: "" }),
            React__default.createElement(core.Box, { mr: 1 }),
            distrib.slots
                ? t("neo/distrib-slots:activeDistrib." + (hasActivated ? 'hasActivatedBtn' : 'activatedBtn'))
                : t("neo/distrib-slots:activeDistrib." + 'activateBtn')),
        React__default.createElement(core.Dialog, { open: opened, onClose: closeDialog },
            React__default.createElement(core.DialogTitle, null,
                React__default.createElement(core.Box, { display: "flex", alignItems: "center" },
                    React__default.createElement(core.Box, { mr: 2 },
                        React__default.createElement("img", { height: 36, src: "/img/virus.svg", alt: "" })),
                    React__default.createElement(core.Typography, { variant: "h4" }, t('neo/distrib-slots:activeDistrib.dialogTitle', {
                        date: format$1(distrib.start, 'EEEE dd MMMM yyyy'),
                    })))),
            React__default.createElement(core.DialogContent, null,
                React__default.createElement(core.Box, { p: 2 },
                    React__default.createElement(lab.Alert, { severity: "error" }, t('neo/distrib-slots:activeDistrib.alert'))),
                React__default.createElement(core.Box, { p: 2 },
                    React__default.createElement(core.Typography, null, t('neo/distrib-slots:activeDistrib.slot-description'))),
                error && (React__default.createElement(core.Box, { p: 2 },
                    React__default.createElement(lab.Alert, { severity: "error" }, error))),
                submitting ? (React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                    React__default.createElement(core.CircularProgress, null))) : (React__default.createElement(React__default.Fragment, null,
                    React__default.createElement(core.Box, { display: "flex", justifyContent: "center" },
                        React__default.createElement(core.List, null, __spreadArrays(Array(nbSlots)).map(function (_v, i) { return i; })
                            .map(function (s) { return (React__default.createElement(core.ListItem, { key: s, alignItems: "center" },
                            React__default.createElement(core.ListItemText, { primary: format$1(addMilliseconds(distrib.start, s * slotDuration), "HH'h'mm") + " - " + format$1(s === nbSlots - 1 ? distrib.end : addMilliseconds(distrib.start, (s + 1) * slotDuration), "HH'h'mm"), secondary: React__default.createElement(core.Box, { display: "flex", justifyContent: "center", component: "span" },
                                    React__default.createElement(core.Typography, { component: "span", variant: "body2" }, t('neo/distrib-slots:activeDistrib.slot-id', {
                                        id: s + 1,
                                    }))) }))); }))),
                    !distrib.slots ? (React__default.createElement(core.Box, { p: 2 },
                        React__default.createElement(core.Typography, null, t('neo/distrib-slots:activeDistrib.modeLabel')),
                        React__default.createElement(core.Typography, { variant: "body2", color: "textSecondary" }, t('neo/distrib-slots:activeDistrib.modeSubLabel')),
                        React__default.createElement(core.FormControl, { component: "fieldset" },
                            React__default.createElement(core.RadioGroup, { "aria-label": "mode-selector", name: "mode", value: mode, onChange: onModeChange },
                                React__default.createElement(core.FormControlLabel, { value: "default", control: React__default.createElement(core.Radio, null), label: t('yes') }),
                                React__default.createElement(core.FormControlLabel, { value: "solo-only", control: React__default.createElement(core.Radio, null), label: t('no') }))))) : (React__default.createElement(React__default.Fragment, null, distrib.mode === 'default' && (React__default.createElement(core.Box, { p: 2 },
                        React__default.createElement(core.Typography, { align: "center" }, t('neo/distrib-slots:activeDistrib.modeDefaultActivated')))))),
                    React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                        distrib.slots && (React__default.createElement(core.Box, { mx: 1, color: "error.main" },
                            React__default.createElement(ButtonWithConfirmDialog, { variant: "outlined", color: "inherit", onClick: onDisableSlotsClick }, t('neo/distrib-slots:activeDistrib.disableSlotsButtonLabel')))),
                        React__default.createElement(core.Box, { mx: 1 },
                            React__default.createElement(core.Button, { variant: "outlined", onClick: closeDialog }, t(distrib.slots ? 'close' : 'cancel'))),
                        !distrib.slots && (React__default.createElement(React__default.Fragment, null,
                            React__default.createElement(core.Box, { mx: 1 },
                                React__default.createElement(core.Button, { variant: "contained", color: "primary", onClick: onConfirmClick }, t('neo/distrib-slots:activeDistrib.confirmBtnLabel'))))))))))));
};
var ActivateDistribSlotsView$1 = withNeolithicProvider(withi18n(ActivateDistribSlotsView));

var ViewCtx = React__default.createContext({
    currentStep: 'loading',
    open: true,
    loading: true,
    slots: [],
    inNeedUsers: [],
    closeDialog: function () { },
    back: function () { },
    selectMode: function () { },
    selectPermissions: function () { },
    selectSlots: function () { },
    selectInNeedUsers: function () { },
    changeSlots: function () { },
    addInNeeds: function () { },
});
var ViewCtxProvider = function (_a) {
    var distribId = _a.distribId, children = _a.children, onRegister = _a.onRegister, onCancel = _a.onCancel;
    var t = useTranslation(['translation']).t;
    var _b = React__default.useState(true), open = _b[0], toggleOpen = _b[1];
    var _c = React__default.useState(false), loading = _c[0], toggleLoading = _c[1];
    var _d = React__default.useState(), error = _d[0], setError = _d[1];
    var _e = React__default.useState('loading'), currentStep = _e[0], setStep = _e[1];
    var _f = React__default.useState(), distrib = _f[0], setDistrib = _f[1];
    var _g = React__default.useState(), status = _g[0], setStatus = _g[1];
    var _h = React__default.useState(), workingStatus = _h[0], setWorkingStatus = _h[1];
    var _j = React__default.useState(false), needReload = _j[0], toggleNeedReload = _j[1];
    /** */
    var updateStatus = function (newStatus, newDistrib) {
        if (!distrib && !newDistrib)
            throw new Error('?');
        var d = newDistrib || distrib;
        var s = d.mode === 'solo-only' ? __assign(__assign({}, newStatus), { has: 'solo' }) : newStatus;
        setStatus(s);
        setWorkingStatus(s);
        if (s.isResolved) {
            setStep('resolved');
        }
        else if (s.registered) {
            setStep('summary');
        }
        else if (s.has === 'solo') {
            setStep('select-slots');
        }
        else {
            setStep('select-mode');
        }
    };
    var registerUser = function (s) { return __awaiter(void 0, void 0, void 0, function () {
        var formData, res, err_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    if (!s.has)
                        return [2 /*return*/];
                    setError(undefined);
                    toggleLoading(true);
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, , 4]);
                    formData = new FormData();
                    formData.append('has', s.has);
                    if (s.allowed) {
                        formData.append('allowed', s.allowed.join(','));
                    }
                    if (s.registeredSlotIds) {
                        formData.append('slotIds', s.registeredSlotIds.join(','));
                    }
                    if (s.voluntaryForIds) {
                        formData.append('userIds', s.voluntaryForIds.join(','));
                    }
                    return [4 /*yield*/, api$1.distrib.registerMe(distribId, formData, 'data')];
                case 2:
                    res = _a.sent();
                    updateStatus(res);
                    toggleLoading(false);
                    toggleNeedReload(true);
                    return [3 /*break*/, 4];
                case 3:
                    err_1 = _a.sent();
                    setError(t('error', { error: err_1 }));
                    toggleLoading(false);
                    return [3 /*break*/, 4];
                case 4: return [2 /*return*/];
            }
        });
    }); };
    var closeDialog = function () {
        if (loading)
            return;
        if (needReload)
            onRegister();
        else
            onCancel();
        toggleOpen(false);
    };
    var back = function () {
        if (status && status.registered) {
            setStep('summary');
        }
        else if (currentStep === 'select-permissions' || currentStep === 'select-slots') {
            setStep('select-mode');
            setWorkingStatus(__assign(__assign({}, workingStatus), { has: null }));
        }
        else if (currentStep === 'select-inNeed') {
            setStep('select-slots');
            setWorkingStatus(__assign(__assign({}, workingStatus), { registeredSlotIds: null }));
        }
    };
    var selectMode = function (mode) {
        var newStatus = __assign(__assign({}, workingStatus), { has: mode });
        setWorkingStatus(newStatus);
        if (mode === 'inNeed') {
            setStep('select-permissions');
        }
        else {
            setStep('select-slots');
        }
    };
    var selectPermissions = function (permissions) {
        var newStatus = __assign(__assign({}, workingStatus), { allowed: permissions });
        setWorkingStatus(newStatus);
        registerUser(newStatus);
    };
    var selectSlots = function (slotIds) {
        var newStatus = __assign(__assign({}, workingStatus), { registeredSlotIds: slotIds });
        setWorkingStatus(newStatus);
        if (newStatus.has === 'solo' ||
            !distrib.inNeedUsers ||
            distrib.inNeedUsers.length === 0 ||
            (status && status.registered)) {
            registerUser(newStatus);
        }
        else {
            setStep('select-inNeed');
        }
    };
    var selectInNeedUsers = function (userIds) {
        var newStatus = __assign(__assign({}, workingStatus), { voluntaryForIds: userIds });
        registerUser(newStatus);
        setWorkingStatus(newStatus);
    };
    var changeSlots = function () {
        var newStatus = __assign(__assign({}, workingStatus), { registeredSlotIds: null });
        setWorkingStatus(newStatus);
        setStep('select-slots');
    };
    var addInNeeds = function () {
        var newStatus = __assign({}, workingStatus);
        setWorkingStatus(newStatus);
        setStep('select-inNeed');
    };
    /** */
    React__default.useEffect(function () {
        var active = true;
        var load = function () { return __awaiter(void 0, void 0, void 0, function () {
            var resDistrib, resStatus, err_2;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        toggleLoading(true);
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 4, , 5]);
                        return [4 /*yield*/, api$1.distrib.getDistrib(distribId)];
                    case 2:
                        resDistrib = _a.sent();
                        return [4 /*yield*/, api$1.distrib.getStatus(distribId)];
                    case 3:
                        resStatus = _a.sent();
                        if (active && resDistrib && resStatus) {
                            setDistrib(resDistrib);
                            updateStatus(resStatus, resDistrib);
                            toggleLoading(false);
                        }
                        return [3 /*break*/, 5];
                    case 4:
                        err_2 = _a.sent();
                        setError(t('error', { error: err_2 }));
                        toggleLoading(false);
                        return [3 /*break*/, 5];
                    case 5: return [2 /*return*/];
                }
            });
        }); };
        load();
        return function () {
            active = false;
        };
    }, []);
    /** */
    return (React__default.createElement(ViewCtx.Provider, { value: {
            currentStep: currentStep,
            open: open,
            loading: loading,
            error: error,
            distribMode: (distrib === null || distrib === void 0 ? void 0 : distrib.mode) || 'default',
            mode: (workingStatus === null || workingStatus === void 0 ? void 0 : workingStatus.has) || undefined,
            slots: (distrib === null || distrib === void 0 ? void 0 : distrib.slots) || [],
            inNeedUsers: (distrib === null || distrib === void 0 ? void 0 : distrib.inNeedUsers) || [],
            registeredSlotIds: (status === null || status === void 0 ? void 0 : status.registeredSlotIds) || undefined,
            voluntaryFor: (status === null || status === void 0 ? void 0 : status.voluntaryFor) || undefined,
            closeDialog: closeDialog,
            back: back,
            selectMode: selectMode,
            selectPermissions: selectPermissions,
            selectSlots: selectSlots,
            selectInNeedUsers: selectInNeedUsers,
            changeSlots: changeSlots,
            addInNeeds: addInNeeds,
        } }, children));
};
var useViewCtx = function () {
    var ctx = React__default.useContext(ViewCtx);
    if (!ctx)
        throw new Error('useViewCtx must be used within a ViewCtxProvider');
    return ctx;
};

var Close = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"
}), 'Close');

exports.default = _default;
});

var CloseIcon = unwrapExports(Close);

var tFile = 'neo/distrib-slots';
var shortTKey = tFile + ":userSlotsSelector";
var MasterDialog = function (_a) {
    var open = _a.open, canClose = _a.canClose, children = _a.children, onClose = _a.onClose;
    var t = useTranslation(['translation', tFile]).t;
    /** */
    return (React__default.createElement(core.Dialog, { open: open, onClose: onClose },
        React__default.createElement(core.DialogTitle, null,
            React__default.createElement(core.Box, { flex: 1, display: "flex", alignItems: "center" },
                React__default.createElement(core.Box, { flex: 1, display: "flex", alignItems: "center" },
                    React__default.createElement(core.Box, { mr: 2, display: "flex", alignItems: "center" },
                        React__default.createElement("img", { height: 36, src: "/img/virus.svg", alt: "" })),
                    React__default.createElement(core.Typography, { variant: "h4" }, t(shortTKey + ".cardTitle"))),
                !canClose && (React__default.createElement(core.Box, { ml: 2, display: "flex", alignItems: "center" },
                    React__default.createElement(core.IconButton, { onClick: onClose },
                        React__default.createElement(CloseIcon, null)))))),
        React__default.createElement(core.DialogContent, null, children)));
};

var tFile$1 = 'neo/distrib-slots';
var shortTKey$1 = tFile$1 + ":userSlotsSelector";
var ModeStep = function (_a) {
    var onSelect = _a.onSelect;
    var t = useTranslation(['translation', tFile$1]).t;
    var _b = React__default.useState(), mode = _b[0], setMode = _b[1];
    /** */
    var onModeChange = function (e) {
        setMode(e.target.value);
    };
    var onClick = function () {
        onSelect(mode);
    };
    /** */
    return (React__default.createElement(core.Box, null,
        React__default.createElement(core.Box, { py: 2 },
            React__default.createElement(lab.Alert, { severity: "error" },
                t(shortTKey$1 + ".alert.p1"),
                React__default.createElement("br", null),
                t(shortTKey$1 + ".alert.p2"))),
        React__default.createElement(core.FormControl, { component: "fieldset" },
            React__default.createElement(core.RadioGroup, { "aria-label": "slots-mode-selector", name: "slots-mode", value: mode || '', onChange: onModeChange },
                React__default.createElement(core.FormControlLabel, { value: "inNeed", control: React__default.createElement(core.Radio, null), label: t(shortTKey$1 + ".modeSelector.inNeed") }),
                React__default.createElement(core.FormControlLabel, { value: "voluntary", control: React__default.createElement(core.Radio, null), label: t(shortTKey$1 + ".modeSelector.voluntary") }),
                React__default.createElement(core.FormControlLabel, { value: "solo", control: React__default.createElement(core.Radio, null), label: t(shortTKey$1 + ".modeSelector.solo") }))),
        React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
            React__default.createElement(core.Button, { variant: "outlined", color: "primary", style: { textTransform: 'none' }, disabled: !mode, onClick: onClick }, t('continue')))));
};

var Edit = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 00-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"
}), 'Edit');

exports.default = _default;
});

var EditIcon = unwrapExports(Edit);

var ExpandMore = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M16.59 8.59L12 13.17 7.41 8.59 6 10l6 6 6-6z"
}), 'ExpandMore');

exports.default = _default;
});

var ExpandMoreIcon = unwrapExports(ExpandMore);

function _extends() {
  _extends = Object.assign || function (target) {
    for (var i = 1; i < arguments.length; i++) {
      var source = arguments[i];

      for (var key in source) {
        if (Object.prototype.hasOwnProperty.call(source, key)) {
          target[key] = source[key];
        }
      }
    }

    return target;
  };

  return _extends.apply(this, arguments);
}

/** Used for built-in method references. */
var objectProto$2 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$1 = objectProto$2.hasOwnProperty;

/**
 * The base implementation of `_.has` without support for deep paths.
 *
 * @private
 * @param {Object} [object] The object to query.
 * @param {Array|string} key The key to check.
 * @returns {boolean} Returns `true` if `key` exists, else `false`.
 */
function baseHas(object, key) {
  return object != null && hasOwnProperty$1.call(object, key);
}

/**
 * Checks if `value` is classified as an `Array` object.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an array, else `false`.
 * @example
 *
 * _.isArray([1, 2, 3]);
 * // => true
 *
 * _.isArray(document.body.children);
 * // => false
 *
 * _.isArray('abc');
 * // => false
 *
 * _.isArray(_.noop);
 * // => false
 */
var isArray = Array.isArray;

/** Detect free variable `global` from Node.js. */
var freeGlobal$1 = typeof global == 'object' && global && global.Object === Object && global;

/** Detect free variable `self`. */
var freeSelf$1 = typeof self == 'object' && self && self.Object === Object && self;

/** Used as a reference to the global object. */
var root$1 = freeGlobal$1 || freeSelf$1 || Function('return this')();

/** Built-in value references. */
var Symbol$2 = root$1.Symbol;

/** Used for built-in method references. */
var objectProto$3 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$2 = objectProto$3.hasOwnProperty;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var nativeObjectToString$2 = objectProto$3.toString;

/** Built-in value references. */
var symToStringTag$2 = Symbol$2 ? Symbol$2.toStringTag : undefined;

/**
 * A specialized version of `baseGetTag` which ignores `Symbol.toStringTag` values.
 *
 * @private
 * @param {*} value The value to query.
 * @returns {string} Returns the raw `toStringTag`.
 */
function getRawTag$1(value) {
  var isOwn = hasOwnProperty$2.call(value, symToStringTag$2),
      tag = value[symToStringTag$2];

  try {
    value[symToStringTag$2] = undefined;
    var unmasked = true;
  } catch (e) {}

  var result = nativeObjectToString$2.call(value);
  if (unmasked) {
    if (isOwn) {
      value[symToStringTag$2] = tag;
    } else {
      delete value[symToStringTag$2];
    }
  }
  return result;
}

/** Used for built-in method references. */
var objectProto$4 = Object.prototype;

/**
 * Used to resolve the
 * [`toStringTag`](http://ecma-international.org/ecma-262/7.0/#sec-object.prototype.tostring)
 * of values.
 */
var nativeObjectToString$3 = objectProto$4.toString;

/**
 * Converts `value` to a string using `Object.prototype.toString`.
 *
 * @private
 * @param {*} value The value to convert.
 * @returns {string} Returns the converted string.
 */
function objectToString$1(value) {
  return nativeObjectToString$3.call(value);
}

/** `Object#toString` result references. */
var nullTag$1 = '[object Null]',
    undefinedTag$1 = '[object Undefined]';

/** Built-in value references. */
var symToStringTag$3 = Symbol$2 ? Symbol$2.toStringTag : undefined;

/**
 * The base implementation of `getTag` without fallbacks for buggy environments.
 *
 * @private
 * @param {*} value The value to query.
 * @returns {string} Returns the `toStringTag`.
 */
function baseGetTag$1(value) {
  if (value == null) {
    return value === undefined ? undefinedTag$1 : nullTag$1;
  }
  return (symToStringTag$3 && symToStringTag$3 in Object(value))
    ? getRawTag$1(value)
    : objectToString$1(value);
}

/**
 * Checks if `value` is object-like. A value is object-like if it's not `null`
 * and has a `typeof` result of "object".
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
 * @example
 *
 * _.isObjectLike({});
 * // => true
 *
 * _.isObjectLike([1, 2, 3]);
 * // => true
 *
 * _.isObjectLike(_.noop);
 * // => false
 *
 * _.isObjectLike(null);
 * // => false
 */
function isObjectLike$1(value) {
  return value != null && typeof value == 'object';
}

/** `Object#toString` result references. */
var symbolTag$1 = '[object Symbol]';

/**
 * Checks if `value` is classified as a `Symbol` primitive or object.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a symbol, else `false`.
 * @example
 *
 * _.isSymbol(Symbol.iterator);
 * // => true
 *
 * _.isSymbol('abc');
 * // => false
 */
function isSymbol$1(value) {
  return typeof value == 'symbol' ||
    (isObjectLike$1(value) && baseGetTag$1(value) == symbolTag$1);
}

/** Used to match property names within property paths. */
var reIsDeepProp = /\.|\[(?:[^[\]]*|(["'])(?:(?!\1)[^\\]|\\.)*?\1)\]/,
    reIsPlainProp = /^\w*$/;

/**
 * Checks if `value` is a property name and not a property path.
 *
 * @private
 * @param {*} value The value to check.
 * @param {Object} [object] The object to query keys on.
 * @returns {boolean} Returns `true` if `value` is a property name, else `false`.
 */
function isKey(value, object) {
  if (isArray(value)) {
    return false;
  }
  var type = typeof value;
  if (type == 'number' || type == 'symbol' || type == 'boolean' ||
      value == null || isSymbol$1(value)) {
    return true;
  }
  return reIsPlainProp.test(value) || !reIsDeepProp.test(value) ||
    (object != null && value in Object(object));
}

/**
 * Checks if `value` is the
 * [language type](http://www.ecma-international.org/ecma-262/7.0/#sec-ecmascript-language-types)
 * of `Object`. (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an object, else `false`.
 * @example
 *
 * _.isObject({});
 * // => true
 *
 * _.isObject([1, 2, 3]);
 * // => true
 *
 * _.isObject(_.noop);
 * // => true
 *
 * _.isObject(null);
 * // => false
 */
function isObject$1(value) {
  var type = typeof value;
  return value != null && (type == 'object' || type == 'function');
}

/** `Object#toString` result references. */
var asyncTag = '[object AsyncFunction]',
    funcTag = '[object Function]',
    genTag = '[object GeneratorFunction]',
    proxyTag = '[object Proxy]';

/**
 * Checks if `value` is classified as a `Function` object.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a function, else `false`.
 * @example
 *
 * _.isFunction(_);
 * // => true
 *
 * _.isFunction(/abc/);
 * // => false
 */
function isFunction(value) {
  if (!isObject$1(value)) {
    return false;
  }
  // The use of `Object#toString` avoids issues with the `typeof` operator
  // in Safari 9 which returns 'object' for typed arrays and other constructors.
  var tag = baseGetTag$1(value);
  return tag == funcTag || tag == genTag || tag == asyncTag || tag == proxyTag;
}

/** Used to detect overreaching core-js shims. */
var coreJsData = root$1['__core-js_shared__'];

/** Used to detect methods masquerading as native. */
var maskSrcKey = (function() {
  var uid = /[^.]+$/.exec(coreJsData && coreJsData.keys && coreJsData.keys.IE_PROTO || '');
  return uid ? ('Symbol(src)_1.' + uid) : '';
}());

/**
 * Checks if `func` has its source masked.
 *
 * @private
 * @param {Function} func The function to check.
 * @returns {boolean} Returns `true` if `func` is masked, else `false`.
 */
function isMasked(func) {
  return !!maskSrcKey && (maskSrcKey in func);
}

/** Used for built-in method references. */
var funcProto = Function.prototype;

/** Used to resolve the decompiled source of functions. */
var funcToString = funcProto.toString;

/**
 * Converts `func` to its source code.
 *
 * @private
 * @param {Function} func The function to convert.
 * @returns {string} Returns the source code.
 */
function toSource(func) {
  if (func != null) {
    try {
      return funcToString.call(func);
    } catch (e) {}
    try {
      return (func + '');
    } catch (e) {}
  }
  return '';
}

/**
 * Used to match `RegExp`
 * [syntax characters](http://ecma-international.org/ecma-262/7.0/#sec-patterns).
 */
var reRegExpChar = /[\\^$.*+?()[\]{}|]/g;

/** Used to detect host constructors (Safari). */
var reIsHostCtor = /^\[object .+?Constructor\]$/;

/** Used for built-in method references. */
var funcProto$1 = Function.prototype,
    objectProto$5 = Object.prototype;

/** Used to resolve the decompiled source of functions. */
var funcToString$1 = funcProto$1.toString;

/** Used to check objects for own properties. */
var hasOwnProperty$3 = objectProto$5.hasOwnProperty;

/** Used to detect if a method is native. */
var reIsNative = RegExp('^' +
  funcToString$1.call(hasOwnProperty$3).replace(reRegExpChar, '\\$&')
  .replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g, '$1.*?') + '$'
);

/**
 * The base implementation of `_.isNative` without bad shim checks.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a native function,
 *  else `false`.
 */
function baseIsNative(value) {
  if (!isObject$1(value) || isMasked(value)) {
    return false;
  }
  var pattern = isFunction(value) ? reIsNative : reIsHostCtor;
  return pattern.test(toSource(value));
}

/**
 * Gets the value at `key` of `object`.
 *
 * @private
 * @param {Object} [object] The object to query.
 * @param {string} key The key of the property to get.
 * @returns {*} Returns the property value.
 */
function getValue(object, key) {
  return object == null ? undefined : object[key];
}

/**
 * Gets the native function at `key` of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @param {string} key The key of the method to get.
 * @returns {*} Returns the function if it's native, else `undefined`.
 */
function getNative(object, key) {
  var value = getValue(object, key);
  return baseIsNative(value) ? value : undefined;
}

/* Built-in method references that are verified to be native. */
var nativeCreate = getNative(Object, 'create');

/**
 * Removes all key-value entries from the hash.
 *
 * @private
 * @name clear
 * @memberOf Hash
 */
function hashClear() {
  this.__data__ = nativeCreate ? nativeCreate(null) : {};
  this.size = 0;
}

/**
 * Removes `key` and its value from the hash.
 *
 * @private
 * @name delete
 * @memberOf Hash
 * @param {Object} hash The hash to modify.
 * @param {string} key The key of the value to remove.
 * @returns {boolean} Returns `true` if the entry was removed, else `false`.
 */
function hashDelete(key) {
  var result = this.has(key) && delete this.__data__[key];
  this.size -= result ? 1 : 0;
  return result;
}

/** Used to stand-in for `undefined` hash values. */
var HASH_UNDEFINED = '__lodash_hash_undefined__';

/** Used for built-in method references. */
var objectProto$6 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$4 = objectProto$6.hasOwnProperty;

/**
 * Gets the hash value for `key`.
 *
 * @private
 * @name get
 * @memberOf Hash
 * @param {string} key The key of the value to get.
 * @returns {*} Returns the entry value.
 */
function hashGet(key) {
  var data = this.__data__;
  if (nativeCreate) {
    var result = data[key];
    return result === HASH_UNDEFINED ? undefined : result;
  }
  return hasOwnProperty$4.call(data, key) ? data[key] : undefined;
}

/** Used for built-in method references. */
var objectProto$7 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$5 = objectProto$7.hasOwnProperty;

/**
 * Checks if a hash value for `key` exists.
 *
 * @private
 * @name has
 * @memberOf Hash
 * @param {string} key The key of the entry to check.
 * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
 */
function hashHas(key) {
  var data = this.__data__;
  return nativeCreate ? (data[key] !== undefined) : hasOwnProperty$5.call(data, key);
}

/** Used to stand-in for `undefined` hash values. */
var HASH_UNDEFINED$1 = '__lodash_hash_undefined__';

/**
 * Sets the hash `key` to `value`.
 *
 * @private
 * @name set
 * @memberOf Hash
 * @param {string} key The key of the value to set.
 * @param {*} value The value to set.
 * @returns {Object} Returns the hash instance.
 */
function hashSet(key, value) {
  var data = this.__data__;
  this.size += this.has(key) ? 0 : 1;
  data[key] = (nativeCreate && value === undefined) ? HASH_UNDEFINED$1 : value;
  return this;
}

/**
 * Creates a hash object.
 *
 * @private
 * @constructor
 * @param {Array} [entries] The key-value pairs to cache.
 */
function Hash(entries) {
  var index = -1,
      length = entries == null ? 0 : entries.length;

  this.clear();
  while (++index < length) {
    var entry = entries[index];
    this.set(entry[0], entry[1]);
  }
}

// Add methods to `Hash`.
Hash.prototype.clear = hashClear;
Hash.prototype['delete'] = hashDelete;
Hash.prototype.get = hashGet;
Hash.prototype.has = hashHas;
Hash.prototype.set = hashSet;

/**
 * Removes all key-value entries from the list cache.
 *
 * @private
 * @name clear
 * @memberOf ListCache
 */
function listCacheClear() {
  this.__data__ = [];
  this.size = 0;
}

/**
 * Performs a
 * [`SameValueZero`](http://ecma-international.org/ecma-262/7.0/#sec-samevaluezero)
 * comparison between two values to determine if they are equivalent.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to compare.
 * @param {*} other The other value to compare.
 * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
 * @example
 *
 * var object = { 'a': 1 };
 * var other = { 'a': 1 };
 *
 * _.eq(object, object);
 * // => true
 *
 * _.eq(object, other);
 * // => false
 *
 * _.eq('a', 'a');
 * // => true
 *
 * _.eq('a', Object('a'));
 * // => false
 *
 * _.eq(NaN, NaN);
 * // => true
 */
function eq(value, other) {
  return value === other || (value !== value && other !== other);
}

/**
 * Gets the index at which the `key` is found in `array` of key-value pairs.
 *
 * @private
 * @param {Array} array The array to inspect.
 * @param {*} key The key to search for.
 * @returns {number} Returns the index of the matched value, else `-1`.
 */
function assocIndexOf(array, key) {
  var length = array.length;
  while (length--) {
    if (eq(array[length][0], key)) {
      return length;
    }
  }
  return -1;
}

/** Used for built-in method references. */
var arrayProto = Array.prototype;

/** Built-in value references. */
var splice = arrayProto.splice;

/**
 * Removes `key` and its value from the list cache.
 *
 * @private
 * @name delete
 * @memberOf ListCache
 * @param {string} key The key of the value to remove.
 * @returns {boolean} Returns `true` if the entry was removed, else `false`.
 */
function listCacheDelete(key) {
  var data = this.__data__,
      index = assocIndexOf(data, key);

  if (index < 0) {
    return false;
  }
  var lastIndex = data.length - 1;
  if (index == lastIndex) {
    data.pop();
  } else {
    splice.call(data, index, 1);
  }
  --this.size;
  return true;
}

/**
 * Gets the list cache value for `key`.
 *
 * @private
 * @name get
 * @memberOf ListCache
 * @param {string} key The key of the value to get.
 * @returns {*} Returns the entry value.
 */
function listCacheGet(key) {
  var data = this.__data__,
      index = assocIndexOf(data, key);

  return index < 0 ? undefined : data[index][1];
}

/**
 * Checks if a list cache value for `key` exists.
 *
 * @private
 * @name has
 * @memberOf ListCache
 * @param {string} key The key of the entry to check.
 * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
 */
function listCacheHas(key) {
  return assocIndexOf(this.__data__, key) > -1;
}

/**
 * Sets the list cache `key` to `value`.
 *
 * @private
 * @name set
 * @memberOf ListCache
 * @param {string} key The key of the value to set.
 * @param {*} value The value to set.
 * @returns {Object} Returns the list cache instance.
 */
function listCacheSet(key, value) {
  var data = this.__data__,
      index = assocIndexOf(data, key);

  if (index < 0) {
    ++this.size;
    data.push([key, value]);
  } else {
    data[index][1] = value;
  }
  return this;
}

/**
 * Creates an list cache object.
 *
 * @private
 * @constructor
 * @param {Array} [entries] The key-value pairs to cache.
 */
function ListCache(entries) {
  var index = -1,
      length = entries == null ? 0 : entries.length;

  this.clear();
  while (++index < length) {
    var entry = entries[index];
    this.set(entry[0], entry[1]);
  }
}

// Add methods to `ListCache`.
ListCache.prototype.clear = listCacheClear;
ListCache.prototype['delete'] = listCacheDelete;
ListCache.prototype.get = listCacheGet;
ListCache.prototype.has = listCacheHas;
ListCache.prototype.set = listCacheSet;

/* Built-in method references that are verified to be native. */
var Map$1 = getNative(root$1, 'Map');

/**
 * Removes all key-value entries from the map.
 *
 * @private
 * @name clear
 * @memberOf MapCache
 */
function mapCacheClear() {
  this.size = 0;
  this.__data__ = {
    'hash': new Hash,
    'map': new (Map$1 || ListCache),
    'string': new Hash
  };
}

/**
 * Checks if `value` is suitable for use as unique object key.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is suitable, else `false`.
 */
function isKeyable(value) {
  var type = typeof value;
  return (type == 'string' || type == 'number' || type == 'symbol' || type == 'boolean')
    ? (value !== '__proto__')
    : (value === null);
}

/**
 * Gets the data for `map`.
 *
 * @private
 * @param {Object} map The map to query.
 * @param {string} key The reference key.
 * @returns {*} Returns the map data.
 */
function getMapData(map, key) {
  var data = map.__data__;
  return isKeyable(key)
    ? data[typeof key == 'string' ? 'string' : 'hash']
    : data.map;
}

/**
 * Removes `key` and its value from the map.
 *
 * @private
 * @name delete
 * @memberOf MapCache
 * @param {string} key The key of the value to remove.
 * @returns {boolean} Returns `true` if the entry was removed, else `false`.
 */
function mapCacheDelete(key) {
  var result = getMapData(this, key)['delete'](key);
  this.size -= result ? 1 : 0;
  return result;
}

/**
 * Gets the map value for `key`.
 *
 * @private
 * @name get
 * @memberOf MapCache
 * @param {string} key The key of the value to get.
 * @returns {*} Returns the entry value.
 */
function mapCacheGet(key) {
  return getMapData(this, key).get(key);
}

/**
 * Checks if a map value for `key` exists.
 *
 * @private
 * @name has
 * @memberOf MapCache
 * @param {string} key The key of the entry to check.
 * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
 */
function mapCacheHas(key) {
  return getMapData(this, key).has(key);
}

/**
 * Sets the map `key` to `value`.
 *
 * @private
 * @name set
 * @memberOf MapCache
 * @param {string} key The key of the value to set.
 * @param {*} value The value to set.
 * @returns {Object} Returns the map cache instance.
 */
function mapCacheSet(key, value) {
  var data = getMapData(this, key),
      size = data.size;

  data.set(key, value);
  this.size += data.size == size ? 0 : 1;
  return this;
}

/**
 * Creates a map cache object to store key-value pairs.
 *
 * @private
 * @constructor
 * @param {Array} [entries] The key-value pairs to cache.
 */
function MapCache(entries) {
  var index = -1,
      length = entries == null ? 0 : entries.length;

  this.clear();
  while (++index < length) {
    var entry = entries[index];
    this.set(entry[0], entry[1]);
  }
}

// Add methods to `MapCache`.
MapCache.prototype.clear = mapCacheClear;
MapCache.prototype['delete'] = mapCacheDelete;
MapCache.prototype.get = mapCacheGet;
MapCache.prototype.has = mapCacheHas;
MapCache.prototype.set = mapCacheSet;

/** Error message constants. */
var FUNC_ERROR_TEXT$2 = 'Expected a function';

/**
 * Creates a function that memoizes the result of `func`. If `resolver` is
 * provided, it determines the cache key for storing the result based on the
 * arguments provided to the memoized function. By default, the first argument
 * provided to the memoized function is used as the map cache key. The `func`
 * is invoked with the `this` binding of the memoized function.
 *
 * **Note:** The cache is exposed as the `cache` property on the memoized
 * function. Its creation may be customized by replacing the `_.memoize.Cache`
 * constructor with one whose instances implement the
 * [`Map`](http://ecma-international.org/ecma-262/7.0/#sec-properties-of-the-map-prototype-object)
 * method interface of `clear`, `delete`, `get`, `has`, and `set`.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Function
 * @param {Function} func The function to have its output memoized.
 * @param {Function} [resolver] The function to resolve the cache key.
 * @returns {Function} Returns the new memoized function.
 * @example
 *
 * var object = { 'a': 1, 'b': 2 };
 * var other = { 'c': 3, 'd': 4 };
 *
 * var values = _.memoize(_.values);
 * values(object);
 * // => [1, 2]
 *
 * values(other);
 * // => [3, 4]
 *
 * object.a = 2;
 * values(object);
 * // => [1, 2]
 *
 * // Modify the result cache.
 * values.cache.set(object, ['a', 'b']);
 * values(object);
 * // => ['a', 'b']
 *
 * // Replace `_.memoize.Cache`.
 * _.memoize.Cache = WeakMap;
 */
function memoize(func, resolver) {
  if (typeof func != 'function' || (resolver != null && typeof resolver != 'function')) {
    throw new TypeError(FUNC_ERROR_TEXT$2);
  }
  var memoized = function() {
    var args = arguments,
        key = resolver ? resolver.apply(this, args) : args[0],
        cache = memoized.cache;

    if (cache.has(key)) {
      return cache.get(key);
    }
    var result = func.apply(this, args);
    memoized.cache = cache.set(key, result) || cache;
    return result;
  };
  memoized.cache = new (memoize.Cache || MapCache);
  return memoized;
}

// Expose `MapCache`.
memoize.Cache = MapCache;

/** Used as the maximum memoize cache size. */
var MAX_MEMOIZE_SIZE = 500;

/**
 * A specialized version of `_.memoize` which clears the memoized function's
 * cache when it exceeds `MAX_MEMOIZE_SIZE`.
 *
 * @private
 * @param {Function} func The function to have its output memoized.
 * @returns {Function} Returns the new memoized function.
 */
function memoizeCapped(func) {
  var result = memoize(func, function(key) {
    if (cache.size === MAX_MEMOIZE_SIZE) {
      cache.clear();
    }
    return key;
  });

  var cache = result.cache;
  return result;
}

/** Used to match property names within property paths. */
var rePropName = /[^.[\]]+|\[(?:(-?\d+(?:\.\d+)?)|(["'])((?:(?!\2)[^\\]|\\.)*?)\2)\]|(?=(?:\.|\[\])(?:\.|\[\]|$))/g;

/** Used to match backslashes in property paths. */
var reEscapeChar = /\\(\\)?/g;

/**
 * Converts `string` to a property path array.
 *
 * @private
 * @param {string} string The string to convert.
 * @returns {Array} Returns the property path array.
 */
var stringToPath = memoizeCapped(function(string) {
  var result = [];
  if (string.charCodeAt(0) === 46 /* . */) {
    result.push('');
  }
  string.replace(rePropName, function(match, number, quote, subString) {
    result.push(quote ? subString.replace(reEscapeChar, '$1') : (number || match));
  });
  return result;
});

/**
 * A specialized version of `_.map` for arrays without support for iteratee
 * shorthands.
 *
 * @private
 * @param {Array} [array] The array to iterate over.
 * @param {Function} iteratee The function invoked per iteration.
 * @returns {Array} Returns the new mapped array.
 */
function arrayMap(array, iteratee) {
  var index = -1,
      length = array == null ? 0 : array.length,
      result = Array(length);

  while (++index < length) {
    result[index] = iteratee(array[index], index, array);
  }
  return result;
}

/** Used as references for various `Number` constants. */
var INFINITY = 1 / 0;

/** Used to convert symbols to primitives and strings. */
var symbolProto = Symbol$2 ? Symbol$2.prototype : undefined,
    symbolToString = symbolProto ? symbolProto.toString : undefined;

/**
 * The base implementation of `_.toString` which doesn't convert nullish
 * values to empty strings.
 *
 * @private
 * @param {*} value The value to process.
 * @returns {string} Returns the string.
 */
function baseToString(value) {
  // Exit early for strings to avoid a performance hit in some environments.
  if (typeof value == 'string') {
    return value;
  }
  if (isArray(value)) {
    // Recursively convert values (susceptible to call stack limits).
    return arrayMap(value, baseToString) + '';
  }
  if (isSymbol$1(value)) {
    return symbolToString ? symbolToString.call(value) : '';
  }
  var result = (value + '');
  return (result == '0' && (1 / value) == -INFINITY) ? '-0' : result;
}

/**
 * Converts `value` to a string. An empty string is returned for `null`
 * and `undefined` values. The sign of `-0` is preserved.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to convert.
 * @returns {string} Returns the converted string.
 * @example
 *
 * _.toString(null);
 * // => ''
 *
 * _.toString(-0);
 * // => '-0'
 *
 * _.toString([1, 2, 3]);
 * // => '1,2,3'
 */
function toString(value) {
  return value == null ? '' : baseToString(value);
}

/**
 * Casts `value` to a path array if it's not one.
 *
 * @private
 * @param {*} value The value to inspect.
 * @param {Object} [object] The object to query keys on.
 * @returns {Array} Returns the cast property path array.
 */
function castPath(value, object) {
  if (isArray(value)) {
    return value;
  }
  return isKey(value, object) ? [value] : stringToPath(toString(value));
}

/** `Object#toString` result references. */
var argsTag = '[object Arguments]';

/**
 * The base implementation of `_.isArguments`.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an `arguments` object,
 */
function baseIsArguments(value) {
  return isObjectLike$1(value) && baseGetTag$1(value) == argsTag;
}

/** Used for built-in method references. */
var objectProto$8 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$6 = objectProto$8.hasOwnProperty;

/** Built-in value references. */
var propertyIsEnumerable = objectProto$8.propertyIsEnumerable;

/**
 * Checks if `value` is likely an `arguments` object.
 *
 * @static
 * @memberOf _
 * @since 0.1.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is an `arguments` object,
 *  else `false`.
 * @example
 *
 * _.isArguments(function() { return arguments; }());
 * // => true
 *
 * _.isArguments([1, 2, 3]);
 * // => false
 */
var isArguments = baseIsArguments(function() { return arguments; }()) ? baseIsArguments : function(value) {
  return isObjectLike$1(value) && hasOwnProperty$6.call(value, 'callee') &&
    !propertyIsEnumerable.call(value, 'callee');
};

/** Used as references for various `Number` constants. */
var MAX_SAFE_INTEGER = 9007199254740991;

/** Used to detect unsigned integer values. */
var reIsUint = /^(?:0|[1-9]\d*)$/;

/**
 * Checks if `value` is a valid array-like index.
 *
 * @private
 * @param {*} value The value to check.
 * @param {number} [length=MAX_SAFE_INTEGER] The upper bounds of a valid index.
 * @returns {boolean} Returns `true` if `value` is a valid index, else `false`.
 */
function isIndex(value, length) {
  var type = typeof value;
  length = length == null ? MAX_SAFE_INTEGER : length;

  return !!length &&
    (type == 'number' ||
      (type != 'symbol' && reIsUint.test(value))) &&
        (value > -1 && value % 1 == 0 && value < length);
}

/** Used as references for various `Number` constants. */
var MAX_SAFE_INTEGER$1 = 9007199254740991;

/**
 * Checks if `value` is a valid array-like length.
 *
 * **Note:** This method is loosely based on
 * [`ToLength`](http://ecma-international.org/ecma-262/7.0/#sec-tolength).
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a valid length, else `false`.
 * @example
 *
 * _.isLength(3);
 * // => true
 *
 * _.isLength(Number.MIN_VALUE);
 * // => false
 *
 * _.isLength(Infinity);
 * // => false
 *
 * _.isLength('3');
 * // => false
 */
function isLength(value) {
  return typeof value == 'number' &&
    value > -1 && value % 1 == 0 && value <= MAX_SAFE_INTEGER$1;
}

/** Used as references for various `Number` constants. */
var INFINITY$1 = 1 / 0;

/**
 * Converts `value` to a string key if it's not a string or symbol.
 *
 * @private
 * @param {*} value The value to inspect.
 * @returns {string|symbol} Returns the key.
 */
function toKey(value) {
  if (typeof value == 'string' || isSymbol$1(value)) {
    return value;
  }
  var result = (value + '');
  return (result == '0' && (1 / value) == -INFINITY$1) ? '-0' : result;
}

/**
 * Checks if `path` exists on `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @param {Array|string} path The path to check.
 * @param {Function} hasFunc The function to check properties.
 * @returns {boolean} Returns `true` if `path` exists, else `false`.
 */
function hasPath(object, path, hasFunc) {
  path = castPath(path, object);

  var index = -1,
      length = path.length,
      result = false;

  while (++index < length) {
    var key = toKey(path[index]);
    if (!(result = object != null && hasFunc(object, key))) {
      break;
    }
    object = object[key];
  }
  if (result || ++index != length) {
    return result;
  }
  length = object == null ? 0 : object.length;
  return !!length && isLength(length) && isIndex(key, length) &&
    (isArray(object) || isArguments(object));
}

/**
 * Checks if `path` is a direct property of `object`.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Object
 * @param {Object} object The object to query.
 * @param {Array|string} path The path to check.
 * @returns {boolean} Returns `true` if `path` exists, else `false`.
 * @example
 *
 * var object = { 'a': { 'b': 2 } };
 * var other = _.create({ 'a': _.create({ 'b': 2 }) });
 *
 * _.has(object, 'a');
 * // => true
 *
 * _.has(object, 'a.b');
 * // => true
 *
 * _.has(object, ['a', 'b']);
 * // => true
 *
 * _.has(other, 'a');
 * // => false
 */
function has(object, path) {
  return object != null && hasPath(object, path, baseHas);
}

/**
 * Removes all key-value entries from the stack.
 *
 * @private
 * @name clear
 * @memberOf Stack
 */
function stackClear() {
  this.__data__ = new ListCache;
  this.size = 0;
}

/**
 * Removes `key` and its value from the stack.
 *
 * @private
 * @name delete
 * @memberOf Stack
 * @param {string} key The key of the value to remove.
 * @returns {boolean} Returns `true` if the entry was removed, else `false`.
 */
function stackDelete(key) {
  var data = this.__data__,
      result = data['delete'](key);

  this.size = data.size;
  return result;
}

/**
 * Gets the stack value for `key`.
 *
 * @private
 * @name get
 * @memberOf Stack
 * @param {string} key The key of the value to get.
 * @returns {*} Returns the entry value.
 */
function stackGet(key) {
  return this.__data__.get(key);
}

/**
 * Checks if a stack value for `key` exists.
 *
 * @private
 * @name has
 * @memberOf Stack
 * @param {string} key The key of the entry to check.
 * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
 */
function stackHas(key) {
  return this.__data__.has(key);
}

/** Used as the size to enable large array optimizations. */
var LARGE_ARRAY_SIZE = 200;

/**
 * Sets the stack `key` to `value`.
 *
 * @private
 * @name set
 * @memberOf Stack
 * @param {string} key The key of the value to set.
 * @param {*} value The value to set.
 * @returns {Object} Returns the stack cache instance.
 */
function stackSet(key, value) {
  var data = this.__data__;
  if (data instanceof ListCache) {
    var pairs = data.__data__;
    if (!Map$1 || (pairs.length < LARGE_ARRAY_SIZE - 1)) {
      pairs.push([key, value]);
      this.size = ++data.size;
      return this;
    }
    data = this.__data__ = new MapCache(pairs);
  }
  data.set(key, value);
  this.size = data.size;
  return this;
}

/**
 * Creates a stack cache object to store key-value pairs.
 *
 * @private
 * @constructor
 * @param {Array} [entries] The key-value pairs to cache.
 */
function Stack(entries) {
  var data = this.__data__ = new ListCache(entries);
  this.size = data.size;
}

// Add methods to `Stack`.
Stack.prototype.clear = stackClear;
Stack.prototype['delete'] = stackDelete;
Stack.prototype.get = stackGet;
Stack.prototype.has = stackHas;
Stack.prototype.set = stackSet;

/**
 * A specialized version of `_.forEach` for arrays without support for
 * iteratee shorthands.
 *
 * @private
 * @param {Array} [array] The array to iterate over.
 * @param {Function} iteratee The function invoked per iteration.
 * @returns {Array} Returns `array`.
 */
function arrayEach(array, iteratee) {
  var index = -1,
      length = array == null ? 0 : array.length;

  while (++index < length) {
    if (iteratee(array[index], index, array) === false) {
      break;
    }
  }
  return array;
}

var defineProperty$1 = (function() {
  try {
    var func = getNative(Object, 'defineProperty');
    func({}, '', {});
    return func;
  } catch (e) {}
}());

/**
 * The base implementation of `assignValue` and `assignMergeValue` without
 * value checks.
 *
 * @private
 * @param {Object} object The object to modify.
 * @param {string} key The key of the property to assign.
 * @param {*} value The value to assign.
 */
function baseAssignValue(object, key, value) {
  if (key == '__proto__' && defineProperty$1) {
    defineProperty$1(object, key, {
      'configurable': true,
      'enumerable': true,
      'value': value,
      'writable': true
    });
  } else {
    object[key] = value;
  }
}

/** Used for built-in method references. */
var objectProto$9 = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$7 = objectProto$9.hasOwnProperty;

/**
 * Assigns `value` to `key` of `object` if the existing value is not equivalent
 * using [`SameValueZero`](http://ecma-international.org/ecma-262/7.0/#sec-samevaluezero)
 * for equality comparisons.
 *
 * @private
 * @param {Object} object The object to modify.
 * @param {string} key The key of the property to assign.
 * @param {*} value The value to assign.
 */
function assignValue(object, key, value) {
  var objValue = object[key];
  if (!(hasOwnProperty$7.call(object, key) && eq(objValue, value)) ||
      (value === undefined && !(key in object))) {
    baseAssignValue(object, key, value);
  }
}

/**
 * Copies properties of `source` to `object`.
 *
 * @private
 * @param {Object} source The object to copy properties from.
 * @param {Array} props The property identifiers to copy.
 * @param {Object} [object={}] The object to copy properties to.
 * @param {Function} [customizer] The function to customize copied values.
 * @returns {Object} Returns `object`.
 */
function copyObject(source, props, object, customizer) {
  var isNew = !object;
  object || (object = {});

  var index = -1,
      length = props.length;

  while (++index < length) {
    var key = props[index];

    var newValue = customizer
      ? customizer(object[key], source[key], key, object, source)
      : undefined;

    if (newValue === undefined) {
      newValue = source[key];
    }
    if (isNew) {
      baseAssignValue(object, key, newValue);
    } else {
      assignValue(object, key, newValue);
    }
  }
  return object;
}

/**
 * The base implementation of `_.times` without support for iteratee shorthands
 * or max array length checks.
 *
 * @private
 * @param {number} n The number of times to invoke `iteratee`.
 * @param {Function} iteratee The function invoked per iteration.
 * @returns {Array} Returns the array of results.
 */
function baseTimes(n, iteratee) {
  var index = -1,
      result = Array(n);

  while (++index < n) {
    result[index] = iteratee(index);
  }
  return result;
}

/**
 * This method returns `false`.
 *
 * @static
 * @memberOf _
 * @since 4.13.0
 * @category Util
 * @returns {boolean} Returns `false`.
 * @example
 *
 * _.times(2, _.stubFalse);
 * // => [false, false]
 */
function stubFalse() {
  return false;
}

/** Detect free variable `exports`. */
var freeExports = typeof exports == 'object' && exports && !exports.nodeType && exports;

/** Detect free variable `module`. */
var freeModule = freeExports && typeof module == 'object' && module && !module.nodeType && module;

/** Detect the popular CommonJS extension `module.exports`. */
var moduleExports = freeModule && freeModule.exports === freeExports;

/** Built-in value references. */
var Buffer = moduleExports ? root$1.Buffer : undefined;

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeIsBuffer = Buffer ? Buffer.isBuffer : undefined;

/**
 * Checks if `value` is a buffer.
 *
 * @static
 * @memberOf _
 * @since 4.3.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a buffer, else `false`.
 * @example
 *
 * _.isBuffer(new Buffer(2));
 * // => true
 *
 * _.isBuffer(new Uint8Array(2));
 * // => false
 */
var isBuffer = nativeIsBuffer || stubFalse;

/** `Object#toString` result references. */
var argsTag$1 = '[object Arguments]',
    arrayTag = '[object Array]',
    boolTag = '[object Boolean]',
    dateTag = '[object Date]',
    errorTag = '[object Error]',
    funcTag$1 = '[object Function]',
    mapTag = '[object Map]',
    numberTag = '[object Number]',
    objectTag = '[object Object]',
    regexpTag = '[object RegExp]',
    setTag = '[object Set]',
    stringTag = '[object String]',
    weakMapTag = '[object WeakMap]';

var arrayBufferTag = '[object ArrayBuffer]',
    dataViewTag = '[object DataView]',
    float32Tag = '[object Float32Array]',
    float64Tag = '[object Float64Array]',
    int8Tag = '[object Int8Array]',
    int16Tag = '[object Int16Array]',
    int32Tag = '[object Int32Array]',
    uint8Tag = '[object Uint8Array]',
    uint8ClampedTag = '[object Uint8ClampedArray]',
    uint16Tag = '[object Uint16Array]',
    uint32Tag = '[object Uint32Array]';

/** Used to identify `toStringTag` values of typed arrays. */
var typedArrayTags = {};
typedArrayTags[float32Tag] = typedArrayTags[float64Tag] =
typedArrayTags[int8Tag] = typedArrayTags[int16Tag] =
typedArrayTags[int32Tag] = typedArrayTags[uint8Tag] =
typedArrayTags[uint8ClampedTag] = typedArrayTags[uint16Tag] =
typedArrayTags[uint32Tag] = true;
typedArrayTags[argsTag$1] = typedArrayTags[arrayTag] =
typedArrayTags[arrayBufferTag] = typedArrayTags[boolTag] =
typedArrayTags[dataViewTag] = typedArrayTags[dateTag] =
typedArrayTags[errorTag] = typedArrayTags[funcTag$1] =
typedArrayTags[mapTag] = typedArrayTags[numberTag] =
typedArrayTags[objectTag] = typedArrayTags[regexpTag] =
typedArrayTags[setTag] = typedArrayTags[stringTag] =
typedArrayTags[weakMapTag] = false;

/**
 * The base implementation of `_.isTypedArray` without Node.js optimizations.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a typed array, else `false`.
 */
function baseIsTypedArray(value) {
  return isObjectLike$1(value) &&
    isLength(value.length) && !!typedArrayTags[baseGetTag$1(value)];
}

/**
 * The base implementation of `_.unary` without support for storing metadata.
 *
 * @private
 * @param {Function} func The function to cap arguments for.
 * @returns {Function} Returns the new capped function.
 */
function baseUnary(func) {
  return function(value) {
    return func(value);
  };
}

/** Detect free variable `exports`. */
var freeExports$1 = typeof exports == 'object' && exports && !exports.nodeType && exports;

/** Detect free variable `module`. */
var freeModule$1 = freeExports$1 && typeof module == 'object' && module && !module.nodeType && module;

/** Detect the popular CommonJS extension `module.exports`. */
var moduleExports$1 = freeModule$1 && freeModule$1.exports === freeExports$1;

/** Detect free variable `process` from Node.js. */
var freeProcess = moduleExports$1 && freeGlobal$1.process;

/** Used to access faster Node.js helpers. */
var nodeUtil = (function() {
  try {
    // Use `util.types` for Node.js 10+.
    var types = freeModule$1 && freeModule$1.require && freeModule$1.require('util').types;

    if (types) {
      return types;
    }

    // Legacy `process.binding('util')` for Node.js < 10.
    return freeProcess && freeProcess.binding && freeProcess.binding('util');
  } catch (e) {}
}());

/* Node.js helper references. */
var nodeIsTypedArray = nodeUtil && nodeUtil.isTypedArray;

/**
 * Checks if `value` is classified as a typed array.
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a typed array, else `false`.
 * @example
 *
 * _.isTypedArray(new Uint8Array);
 * // => true
 *
 * _.isTypedArray([]);
 * // => false
 */
var isTypedArray = nodeIsTypedArray ? baseUnary(nodeIsTypedArray) : baseIsTypedArray;

/** Used for built-in method references. */
var objectProto$a = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$8 = objectProto$a.hasOwnProperty;

/**
 * Creates an array of the enumerable property names of the array-like `value`.
 *
 * @private
 * @param {*} value The value to query.
 * @param {boolean} inherited Specify returning inherited property names.
 * @returns {Array} Returns the array of property names.
 */
function arrayLikeKeys(value, inherited) {
  var isArr = isArray(value),
      isArg = !isArr && isArguments(value),
      isBuff = !isArr && !isArg && isBuffer(value),
      isType = !isArr && !isArg && !isBuff && isTypedArray(value),
      skipIndexes = isArr || isArg || isBuff || isType,
      result = skipIndexes ? baseTimes(value.length, String) : [],
      length = result.length;

  for (var key in value) {
    if ((inherited || hasOwnProperty$8.call(value, key)) &&
        !(skipIndexes && (
           // Safari 9 has enumerable `arguments.length` in strict mode.
           key == 'length' ||
           // Node.js 0.10 has enumerable non-index properties on buffers.
           (isBuff && (key == 'offset' || key == 'parent')) ||
           // PhantomJS 2 has enumerable non-index properties on typed arrays.
           (isType && (key == 'buffer' || key == 'byteLength' || key == 'byteOffset')) ||
           // Skip index properties.
           isIndex(key, length)
        ))) {
      result.push(key);
    }
  }
  return result;
}

/** Used for built-in method references. */
var objectProto$b = Object.prototype;

/**
 * Checks if `value` is likely a prototype object.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a prototype, else `false`.
 */
function isPrototype(value) {
  var Ctor = value && value.constructor,
      proto = (typeof Ctor == 'function' && Ctor.prototype) || objectProto$b;

  return value === proto;
}

/**
 * Creates a unary function that invokes `func` with its argument transformed.
 *
 * @private
 * @param {Function} func The function to wrap.
 * @param {Function} transform The argument transform.
 * @returns {Function} Returns the new function.
 */
function overArg(func, transform) {
  return function(arg) {
    return func(transform(arg));
  };
}

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeKeys = overArg(Object.keys, Object);

/** Used for built-in method references. */
var objectProto$c = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$9 = objectProto$c.hasOwnProperty;

/**
 * The base implementation of `_.keys` which doesn't treat sparse arrays as dense.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names.
 */
function baseKeys(object) {
  if (!isPrototype(object)) {
    return nativeKeys(object);
  }
  var result = [];
  for (var key in Object(object)) {
    if (hasOwnProperty$9.call(object, key) && key != 'constructor') {
      result.push(key);
    }
  }
  return result;
}

/**
 * Checks if `value` is array-like. A value is considered array-like if it's
 * not a function and has a `value.length` that's an integer greater than or
 * equal to `0` and less than or equal to `Number.MAX_SAFE_INTEGER`.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is array-like, else `false`.
 * @example
 *
 * _.isArrayLike([1, 2, 3]);
 * // => true
 *
 * _.isArrayLike(document.body.children);
 * // => true
 *
 * _.isArrayLike('abc');
 * // => true
 *
 * _.isArrayLike(_.noop);
 * // => false
 */
function isArrayLike(value) {
  return value != null && isLength(value.length) && !isFunction(value);
}

/**
 * Creates an array of the own enumerable property names of `object`.
 *
 * **Note:** Non-object values are coerced to objects. See the
 * [ES spec](http://ecma-international.org/ecma-262/7.0/#sec-object.keys)
 * for more details.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Object
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names.
 * @example
 *
 * function Foo() {
 *   this.a = 1;
 *   this.b = 2;
 * }
 *
 * Foo.prototype.c = 3;
 *
 * _.keys(new Foo);
 * // => ['a', 'b'] (iteration order is not guaranteed)
 *
 * _.keys('hi');
 * // => ['0', '1']
 */
function keys(object) {
  return isArrayLike(object) ? arrayLikeKeys(object) : baseKeys(object);
}

/**
 * The base implementation of `_.assign` without support for multiple sources
 * or `customizer` functions.
 *
 * @private
 * @param {Object} object The destination object.
 * @param {Object} source The source object.
 * @returns {Object} Returns `object`.
 */
function baseAssign(object, source) {
  return object && copyObject(source, keys(source), object);
}

/**
 * This function is like
 * [`Object.keys`](http://ecma-international.org/ecma-262/7.0/#sec-object.keys)
 * except that it includes inherited enumerable properties.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names.
 */
function nativeKeysIn(object) {
  var result = [];
  if (object != null) {
    for (var key in Object(object)) {
      result.push(key);
    }
  }
  return result;
}

/** Used for built-in method references. */
var objectProto$d = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$a = objectProto$d.hasOwnProperty;

/**
 * The base implementation of `_.keysIn` which doesn't treat sparse arrays as dense.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names.
 */
function baseKeysIn(object) {
  if (!isObject$1(object)) {
    return nativeKeysIn(object);
  }
  var isProto = isPrototype(object),
      result = [];

  for (var key in object) {
    if (!(key == 'constructor' && (isProto || !hasOwnProperty$a.call(object, key)))) {
      result.push(key);
    }
  }
  return result;
}

/**
 * Creates an array of the own and inherited enumerable property names of `object`.
 *
 * **Note:** Non-object values are coerced to objects.
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category Object
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names.
 * @example
 *
 * function Foo() {
 *   this.a = 1;
 *   this.b = 2;
 * }
 *
 * Foo.prototype.c = 3;
 *
 * _.keysIn(new Foo);
 * // => ['a', 'b', 'c'] (iteration order is not guaranteed)
 */
function keysIn$1(object) {
  return isArrayLike(object) ? arrayLikeKeys(object, true) : baseKeysIn(object);
}

/**
 * The base implementation of `_.assignIn` without support for multiple sources
 * or `customizer` functions.
 *
 * @private
 * @param {Object} object The destination object.
 * @param {Object} source The source object.
 * @returns {Object} Returns `object`.
 */
function baseAssignIn(object, source) {
  return object && copyObject(source, keysIn$1(source), object);
}

/** Detect free variable `exports`. */
var freeExports$2 = typeof exports == 'object' && exports && !exports.nodeType && exports;

/** Detect free variable `module`. */
var freeModule$2 = freeExports$2 && typeof module == 'object' && module && !module.nodeType && module;

/** Detect the popular CommonJS extension `module.exports`. */
var moduleExports$2 = freeModule$2 && freeModule$2.exports === freeExports$2;

/** Built-in value references. */
var Buffer$1 = moduleExports$2 ? root$1.Buffer : undefined,
    allocUnsafe = Buffer$1 ? Buffer$1.allocUnsafe : undefined;

/**
 * Creates a clone of  `buffer`.
 *
 * @private
 * @param {Buffer} buffer The buffer to clone.
 * @param {boolean} [isDeep] Specify a deep clone.
 * @returns {Buffer} Returns the cloned buffer.
 */
function cloneBuffer(buffer, isDeep) {
  if (isDeep) {
    return buffer.slice();
  }
  var length = buffer.length,
      result = allocUnsafe ? allocUnsafe(length) : new buffer.constructor(length);

  buffer.copy(result);
  return result;
}

/**
 * Copies the values of `source` to `array`.
 *
 * @private
 * @param {Array} source The array to copy values from.
 * @param {Array} [array=[]] The array to copy values to.
 * @returns {Array} Returns `array`.
 */
function copyArray(source, array) {
  var index = -1,
      length = source.length;

  array || (array = Array(length));
  while (++index < length) {
    array[index] = source[index];
  }
  return array;
}

/**
 * A specialized version of `_.filter` for arrays without support for
 * iteratee shorthands.
 *
 * @private
 * @param {Array} [array] The array to iterate over.
 * @param {Function} predicate The function invoked per iteration.
 * @returns {Array} Returns the new filtered array.
 */
function arrayFilter(array, predicate) {
  var index = -1,
      length = array == null ? 0 : array.length,
      resIndex = 0,
      result = [];

  while (++index < length) {
    var value = array[index];
    if (predicate(value, index, array)) {
      result[resIndex++] = value;
    }
  }
  return result;
}

/**
 * This method returns a new empty array.
 *
 * @static
 * @memberOf _
 * @since 4.13.0
 * @category Util
 * @returns {Array} Returns the new empty array.
 * @example
 *
 * var arrays = _.times(2, _.stubArray);
 *
 * console.log(arrays);
 * // => [[], []]
 *
 * console.log(arrays[0] === arrays[1]);
 * // => false
 */
function stubArray() {
  return [];
}

/** Used for built-in method references. */
var objectProto$e = Object.prototype;

/** Built-in value references. */
var propertyIsEnumerable$1 = objectProto$e.propertyIsEnumerable;

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeGetSymbols = Object.getOwnPropertySymbols;

/**
 * Creates an array of the own enumerable symbols of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of symbols.
 */
var getSymbols = !nativeGetSymbols ? stubArray : function(object) {
  if (object == null) {
    return [];
  }
  object = Object(object);
  return arrayFilter(nativeGetSymbols(object), function(symbol) {
    return propertyIsEnumerable$1.call(object, symbol);
  });
};

/**
 * Copies own symbols of `source` to `object`.
 *
 * @private
 * @param {Object} source The object to copy symbols from.
 * @param {Object} [object={}] The object to copy symbols to.
 * @returns {Object} Returns `object`.
 */
function copySymbols(source, object) {
  return copyObject(source, getSymbols(source), object);
}

/**
 * Appends the elements of `values` to `array`.
 *
 * @private
 * @param {Array} array The array to modify.
 * @param {Array} values The values to append.
 * @returns {Array} Returns `array`.
 */
function arrayPush(array, values) {
  var index = -1,
      length = values.length,
      offset = array.length;

  while (++index < length) {
    array[offset + index] = values[index];
  }
  return array;
}

/** Built-in value references. */
var getPrototype = overArg(Object.getPrototypeOf, Object);

/* Built-in method references for those with the same name as other `lodash` methods. */
var nativeGetSymbols$1 = Object.getOwnPropertySymbols;

/**
 * Creates an array of the own and inherited enumerable symbols of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of symbols.
 */
var getSymbolsIn = !nativeGetSymbols$1 ? stubArray : function(object) {
  var result = [];
  while (object) {
    arrayPush(result, getSymbols(object));
    object = getPrototype(object);
  }
  return result;
};

/**
 * Copies own and inherited symbols of `source` to `object`.
 *
 * @private
 * @param {Object} source The object to copy symbols from.
 * @param {Object} [object={}] The object to copy symbols to.
 * @returns {Object} Returns `object`.
 */
function copySymbolsIn(source, object) {
  return copyObject(source, getSymbolsIn(source), object);
}

/**
 * The base implementation of `getAllKeys` and `getAllKeysIn` which uses
 * `keysFunc` and `symbolsFunc` to get the enumerable property names and
 * symbols of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @param {Function} keysFunc The function to get the keys of `object`.
 * @param {Function} symbolsFunc The function to get the symbols of `object`.
 * @returns {Array} Returns the array of property names and symbols.
 */
function baseGetAllKeys(object, keysFunc, symbolsFunc) {
  var result = keysFunc(object);
  return isArray(object) ? result : arrayPush(result, symbolsFunc(object));
}

/**
 * Creates an array of own enumerable property names and symbols of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names and symbols.
 */
function getAllKeys(object) {
  return baseGetAllKeys(object, keys, getSymbols);
}

/**
 * Creates an array of own and inherited enumerable property names and
 * symbols of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property names and symbols.
 */
function getAllKeysIn(object) {
  return baseGetAllKeys(object, keysIn$1, getSymbolsIn);
}

/* Built-in method references that are verified to be native. */
var DataView = getNative(root$1, 'DataView');

/* Built-in method references that are verified to be native. */
var Promise$1 = getNative(root$1, 'Promise');

/* Built-in method references that are verified to be native. */
var Set$1 = getNative(root$1, 'Set');

/* Built-in method references that are verified to be native. */
var WeakMap = getNative(root$1, 'WeakMap');

/** `Object#toString` result references. */
var mapTag$1 = '[object Map]',
    objectTag$1 = '[object Object]',
    promiseTag = '[object Promise]',
    setTag$1 = '[object Set]',
    weakMapTag$1 = '[object WeakMap]';

var dataViewTag$1 = '[object DataView]';

/** Used to detect maps, sets, and weakmaps. */
var dataViewCtorString = toSource(DataView),
    mapCtorString = toSource(Map$1),
    promiseCtorString = toSource(Promise$1),
    setCtorString = toSource(Set$1),
    weakMapCtorString = toSource(WeakMap);

/**
 * Gets the `toStringTag` of `value`.
 *
 * @private
 * @param {*} value The value to query.
 * @returns {string} Returns the `toStringTag`.
 */
var getTag = baseGetTag$1;

// Fallback for data views, maps, sets, and weak maps in IE 11 and promises in Node.js < 6.
if ((DataView && getTag(new DataView(new ArrayBuffer(1))) != dataViewTag$1) ||
    (Map$1 && getTag(new Map$1) != mapTag$1) ||
    (Promise$1 && getTag(Promise$1.resolve()) != promiseTag) ||
    (Set$1 && getTag(new Set$1) != setTag$1) ||
    (WeakMap && getTag(new WeakMap) != weakMapTag$1)) {
  getTag = function(value) {
    var result = baseGetTag$1(value),
        Ctor = result == objectTag$1 ? value.constructor : undefined,
        ctorString = Ctor ? toSource(Ctor) : '';

    if (ctorString) {
      switch (ctorString) {
        case dataViewCtorString: return dataViewTag$1;
        case mapCtorString: return mapTag$1;
        case promiseCtorString: return promiseTag;
        case setCtorString: return setTag$1;
        case weakMapCtorString: return weakMapTag$1;
      }
    }
    return result;
  };
}

var getTag$1 = getTag;

/** Used for built-in method references. */
var objectProto$f = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$b = objectProto$f.hasOwnProperty;

/**
 * Initializes an array clone.
 *
 * @private
 * @param {Array} array The array to clone.
 * @returns {Array} Returns the initialized clone.
 */
function initCloneArray(array) {
  var length = array.length,
      result = new array.constructor(length);

  // Add properties assigned by `RegExp#exec`.
  if (length && typeof array[0] == 'string' && hasOwnProperty$b.call(array, 'index')) {
    result.index = array.index;
    result.input = array.input;
  }
  return result;
}

/** Built-in value references. */
var Uint8Array = root$1.Uint8Array;

/**
 * Creates a clone of `arrayBuffer`.
 *
 * @private
 * @param {ArrayBuffer} arrayBuffer The array buffer to clone.
 * @returns {ArrayBuffer} Returns the cloned array buffer.
 */
function cloneArrayBuffer(arrayBuffer) {
  var result = new arrayBuffer.constructor(arrayBuffer.byteLength);
  new Uint8Array(result).set(new Uint8Array(arrayBuffer));
  return result;
}

/**
 * Creates a clone of `dataView`.
 *
 * @private
 * @param {Object} dataView The data view to clone.
 * @param {boolean} [isDeep] Specify a deep clone.
 * @returns {Object} Returns the cloned data view.
 */
function cloneDataView(dataView, isDeep) {
  var buffer = isDeep ? cloneArrayBuffer(dataView.buffer) : dataView.buffer;
  return new dataView.constructor(buffer, dataView.byteOffset, dataView.byteLength);
}

/** Used to match `RegExp` flags from their coerced string values. */
var reFlags = /\w*$/;

/**
 * Creates a clone of `regexp`.
 *
 * @private
 * @param {Object} regexp The regexp to clone.
 * @returns {Object} Returns the cloned regexp.
 */
function cloneRegExp(regexp) {
  var result = new regexp.constructor(regexp.source, reFlags.exec(regexp));
  result.lastIndex = regexp.lastIndex;
  return result;
}

/** Used to convert symbols to primitives and strings. */
var symbolProto$1 = Symbol$2 ? Symbol$2.prototype : undefined,
    symbolValueOf = symbolProto$1 ? symbolProto$1.valueOf : undefined;

/**
 * Creates a clone of the `symbol` object.
 *
 * @private
 * @param {Object} symbol The symbol object to clone.
 * @returns {Object} Returns the cloned symbol object.
 */
function cloneSymbol(symbol) {
  return symbolValueOf ? Object(symbolValueOf.call(symbol)) : {};
}

/**
 * Creates a clone of `typedArray`.
 *
 * @private
 * @param {Object} typedArray The typed array to clone.
 * @param {boolean} [isDeep] Specify a deep clone.
 * @returns {Object} Returns the cloned typed array.
 */
function cloneTypedArray(typedArray, isDeep) {
  var buffer = isDeep ? cloneArrayBuffer(typedArray.buffer) : typedArray.buffer;
  return new typedArray.constructor(buffer, typedArray.byteOffset, typedArray.length);
}

/** `Object#toString` result references. */
var boolTag$1 = '[object Boolean]',
    dateTag$1 = '[object Date]',
    mapTag$2 = '[object Map]',
    numberTag$1 = '[object Number]',
    regexpTag$1 = '[object RegExp]',
    setTag$2 = '[object Set]',
    stringTag$1 = '[object String]',
    symbolTag$2 = '[object Symbol]';

var arrayBufferTag$1 = '[object ArrayBuffer]',
    dataViewTag$2 = '[object DataView]',
    float32Tag$1 = '[object Float32Array]',
    float64Tag$1 = '[object Float64Array]',
    int8Tag$1 = '[object Int8Array]',
    int16Tag$1 = '[object Int16Array]',
    int32Tag$1 = '[object Int32Array]',
    uint8Tag$1 = '[object Uint8Array]',
    uint8ClampedTag$1 = '[object Uint8ClampedArray]',
    uint16Tag$1 = '[object Uint16Array]',
    uint32Tag$1 = '[object Uint32Array]';

/**
 * Initializes an object clone based on its `toStringTag`.
 *
 * **Note:** This function only supports cloning values with tags of
 * `Boolean`, `Date`, `Error`, `Map`, `Number`, `RegExp`, `Set`, or `String`.
 *
 * @private
 * @param {Object} object The object to clone.
 * @param {string} tag The `toStringTag` of the object to clone.
 * @param {boolean} [isDeep] Specify a deep clone.
 * @returns {Object} Returns the initialized clone.
 */
function initCloneByTag(object, tag, isDeep) {
  var Ctor = object.constructor;
  switch (tag) {
    case arrayBufferTag$1:
      return cloneArrayBuffer(object);

    case boolTag$1:
    case dateTag$1:
      return new Ctor(+object);

    case dataViewTag$2:
      return cloneDataView(object, isDeep);

    case float32Tag$1: case float64Tag$1:
    case int8Tag$1: case int16Tag$1: case int32Tag$1:
    case uint8Tag$1: case uint8ClampedTag$1: case uint16Tag$1: case uint32Tag$1:
      return cloneTypedArray(object, isDeep);

    case mapTag$2:
      return new Ctor;

    case numberTag$1:
    case stringTag$1:
      return new Ctor(object);

    case regexpTag$1:
      return cloneRegExp(object);

    case setTag$2:
      return new Ctor;

    case symbolTag$2:
      return cloneSymbol(object);
  }
}

/** Built-in value references. */
var objectCreate = Object.create;

/**
 * The base implementation of `_.create` without support for assigning
 * properties to the created object.
 *
 * @private
 * @param {Object} proto The object to inherit from.
 * @returns {Object} Returns the new object.
 */
var baseCreate = (function() {
  function object() {}
  return function(proto) {
    if (!isObject$1(proto)) {
      return {};
    }
    if (objectCreate) {
      return objectCreate(proto);
    }
    object.prototype = proto;
    var result = new object;
    object.prototype = undefined;
    return result;
  };
}());

/**
 * Initializes an object clone.
 *
 * @private
 * @param {Object} object The object to clone.
 * @returns {Object} Returns the initialized clone.
 */
function initCloneObject(object) {
  return (typeof object.constructor == 'function' && !isPrototype(object))
    ? baseCreate(getPrototype(object))
    : {};
}

/** `Object#toString` result references. */
var mapTag$3 = '[object Map]';

/**
 * The base implementation of `_.isMap` without Node.js optimizations.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a map, else `false`.
 */
function baseIsMap(value) {
  return isObjectLike$1(value) && getTag$1(value) == mapTag$3;
}

/* Node.js helper references. */
var nodeIsMap = nodeUtil && nodeUtil.isMap;

/**
 * Checks if `value` is classified as a `Map` object.
 *
 * @static
 * @memberOf _
 * @since 4.3.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a map, else `false`.
 * @example
 *
 * _.isMap(new Map);
 * // => true
 *
 * _.isMap(new WeakMap);
 * // => false
 */
var isMap = nodeIsMap ? baseUnary(nodeIsMap) : baseIsMap;

/** `Object#toString` result references. */
var setTag$3 = '[object Set]';

/**
 * The base implementation of `_.isSet` without Node.js optimizations.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a set, else `false`.
 */
function baseIsSet(value) {
  return isObjectLike$1(value) && getTag$1(value) == setTag$3;
}

/* Node.js helper references. */
var nodeIsSet = nodeUtil && nodeUtil.isSet;

/**
 * Checks if `value` is classified as a `Set` object.
 *
 * @static
 * @memberOf _
 * @since 4.3.0
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a set, else `false`.
 * @example
 *
 * _.isSet(new Set);
 * // => true
 *
 * _.isSet(new WeakSet);
 * // => false
 */
var isSet = nodeIsSet ? baseUnary(nodeIsSet) : baseIsSet;

/** Used to compose bitmasks for cloning. */
var CLONE_DEEP_FLAG = 1,
    CLONE_FLAT_FLAG = 2,
    CLONE_SYMBOLS_FLAG = 4;

/** `Object#toString` result references. */
var argsTag$2 = '[object Arguments]',
    arrayTag$1 = '[object Array]',
    boolTag$2 = '[object Boolean]',
    dateTag$2 = '[object Date]',
    errorTag$1 = '[object Error]',
    funcTag$2 = '[object Function]',
    genTag$1 = '[object GeneratorFunction]',
    mapTag$4 = '[object Map]',
    numberTag$2 = '[object Number]',
    objectTag$2 = '[object Object]',
    regexpTag$2 = '[object RegExp]',
    setTag$4 = '[object Set]',
    stringTag$2 = '[object String]',
    symbolTag$3 = '[object Symbol]',
    weakMapTag$2 = '[object WeakMap]';

var arrayBufferTag$2 = '[object ArrayBuffer]',
    dataViewTag$3 = '[object DataView]',
    float32Tag$2 = '[object Float32Array]',
    float64Tag$2 = '[object Float64Array]',
    int8Tag$2 = '[object Int8Array]',
    int16Tag$2 = '[object Int16Array]',
    int32Tag$2 = '[object Int32Array]',
    uint8Tag$2 = '[object Uint8Array]',
    uint8ClampedTag$2 = '[object Uint8ClampedArray]',
    uint16Tag$2 = '[object Uint16Array]',
    uint32Tag$2 = '[object Uint32Array]';

/** Used to identify `toStringTag` values supported by `_.clone`. */
var cloneableTags = {};
cloneableTags[argsTag$2] = cloneableTags[arrayTag$1] =
cloneableTags[arrayBufferTag$2] = cloneableTags[dataViewTag$3] =
cloneableTags[boolTag$2] = cloneableTags[dateTag$2] =
cloneableTags[float32Tag$2] = cloneableTags[float64Tag$2] =
cloneableTags[int8Tag$2] = cloneableTags[int16Tag$2] =
cloneableTags[int32Tag$2] = cloneableTags[mapTag$4] =
cloneableTags[numberTag$2] = cloneableTags[objectTag$2] =
cloneableTags[regexpTag$2] = cloneableTags[setTag$4] =
cloneableTags[stringTag$2] = cloneableTags[symbolTag$3] =
cloneableTags[uint8Tag$2] = cloneableTags[uint8ClampedTag$2] =
cloneableTags[uint16Tag$2] = cloneableTags[uint32Tag$2] = true;
cloneableTags[errorTag$1] = cloneableTags[funcTag$2] =
cloneableTags[weakMapTag$2] = false;

/**
 * The base implementation of `_.clone` and `_.cloneDeep` which tracks
 * traversed objects.
 *
 * @private
 * @param {*} value The value to clone.
 * @param {boolean} bitmask The bitmask flags.
 *  1 - Deep clone
 *  2 - Flatten inherited properties
 *  4 - Clone symbols
 * @param {Function} [customizer] The function to customize cloning.
 * @param {string} [key] The key of `value`.
 * @param {Object} [object] The parent object of `value`.
 * @param {Object} [stack] Tracks traversed objects and their clone counterparts.
 * @returns {*} Returns the cloned value.
 */
function baseClone(value, bitmask, customizer, key, object, stack) {
  var result,
      isDeep = bitmask & CLONE_DEEP_FLAG,
      isFlat = bitmask & CLONE_FLAT_FLAG,
      isFull = bitmask & CLONE_SYMBOLS_FLAG;

  if (customizer) {
    result = object ? customizer(value, key, object, stack) : customizer(value);
  }
  if (result !== undefined) {
    return result;
  }
  if (!isObject$1(value)) {
    return value;
  }
  var isArr = isArray(value);
  if (isArr) {
    result = initCloneArray(value);
    if (!isDeep) {
      return copyArray(value, result);
    }
  } else {
    var tag = getTag$1(value),
        isFunc = tag == funcTag$2 || tag == genTag$1;

    if (isBuffer(value)) {
      return cloneBuffer(value, isDeep);
    }
    if (tag == objectTag$2 || tag == argsTag$2 || (isFunc && !object)) {
      result = (isFlat || isFunc) ? {} : initCloneObject(value);
      if (!isDeep) {
        return isFlat
          ? copySymbolsIn(value, baseAssignIn(result, value))
          : copySymbols(value, baseAssign(result, value));
      }
    } else {
      if (!cloneableTags[tag]) {
        return object ? value : {};
      }
      result = initCloneByTag(value, tag, isDeep);
    }
  }
  // Check for circular references and return its corresponding clone.
  stack || (stack = new Stack);
  var stacked = stack.get(value);
  if (stacked) {
    return stacked;
  }
  stack.set(value, result);

  if (isSet(value)) {
    value.forEach(function(subValue) {
      result.add(baseClone(subValue, bitmask, customizer, subValue, value, stack));
    });
  } else if (isMap(value)) {
    value.forEach(function(subValue, key) {
      result.set(key, baseClone(subValue, bitmask, customizer, key, value, stack));
    });
  }

  var keysFunc = isFull
    ? (isFlat ? getAllKeysIn : getAllKeys)
    : (isFlat ? keysIn : keys);

  var props = isArr ? undefined : keysFunc(value);
  arrayEach(props || value, function(subValue, key) {
    if (props) {
      key = subValue;
      subValue = value[key];
    }
    // Recursively populate clone (susceptible to call stack limits).
    assignValue(result, key, baseClone(subValue, bitmask, customizer, key, value, stack));
  });
  return result;
}

/** Used to compose bitmasks for cloning. */
var CLONE_DEEP_FLAG$1 = 1,
    CLONE_SYMBOLS_FLAG$1 = 4;

/**
 * This method is like `_.cloneWith` except that it recursively clones `value`.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Lang
 * @param {*} value The value to recursively clone.
 * @param {Function} [customizer] The function to customize cloning.
 * @returns {*} Returns the deep cloned value.
 * @see _.cloneWith
 * @example
 *
 * function customizer(value) {
 *   if (_.isElement(value)) {
 *     return value.cloneNode(true);
 *   }
 * }
 *
 * var el = _.cloneDeepWith(document.body, customizer);
 *
 * console.log(el === document.body);
 * // => false
 * console.log(el.nodeName);
 * // => 'BODY'
 * console.log(el.childNodes.length);
 * // => 20
 */
function cloneDeepWith(value, customizer) {
  customizer = typeof customizer == 'function' ? customizer : undefined;
  return baseClone(value, CLONE_DEEP_FLAG$1 | CLONE_SYMBOLS_FLAG$1, customizer);
}

/** `Object#toString` result references. */
var stringTag$3 = '[object String]';

/**
 * Checks if `value` is classified as a `String` primitive or object.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Lang
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` is a string, else `false`.
 * @example
 *
 * _.isString('abc');
 * // => true
 *
 * _.isString(1);
 * // => false
 */
function isString(value) {
  return typeof value == 'string' ||
    (!isArray(value) && isObjectLike$1(value) && baseGetTag$1(value) == stringTag$3);
}

/**
 * Converts `iterator` to an array.
 *
 * @private
 * @param {Object} iterator The iterator to convert.
 * @returns {Array} Returns the converted array.
 */
function iteratorToArray(iterator) {
  var data,
      result = [];

  while (!(data = iterator.next()).done) {
    result.push(data.value);
  }
  return result;
}

/**
 * Converts `map` to its key-value pairs.
 *
 * @private
 * @param {Object} map The map to convert.
 * @returns {Array} Returns the key-value pairs.
 */
function mapToArray(map) {
  var index = -1,
      result = Array(map.size);

  map.forEach(function(value, key) {
    result[++index] = [key, value];
  });
  return result;
}

/**
 * Converts `set` to an array of its values.
 *
 * @private
 * @param {Object} set The set to convert.
 * @returns {Array} Returns the values.
 */
function setToArray(set) {
  var index = -1,
      result = Array(set.size);

  set.forEach(function(value) {
    result[++index] = value;
  });
  return result;
}

/**
 * Converts an ASCII `string` to an array.
 *
 * @private
 * @param {string} string The string to convert.
 * @returns {Array} Returns the converted array.
 */
function asciiToArray(string) {
  return string.split('');
}

/** Used to compose unicode character classes. */
var rsAstralRange = '\\ud800-\\udfff',
    rsComboMarksRange = '\\u0300-\\u036f',
    reComboHalfMarksRange = '\\ufe20-\\ufe2f',
    rsComboSymbolsRange = '\\u20d0-\\u20ff',
    rsComboRange = rsComboMarksRange + reComboHalfMarksRange + rsComboSymbolsRange,
    rsVarRange = '\\ufe0e\\ufe0f';

/** Used to compose unicode capture groups. */
var rsZWJ = '\\u200d';

/** Used to detect strings with [zero-width joiners or code points from the astral planes](http://eev.ee/blog/2015/09/12/dark-corners-of-unicode/). */
var reHasUnicode = RegExp('[' + rsZWJ + rsAstralRange  + rsComboRange + rsVarRange + ']');

/**
 * Checks if `string` contains Unicode symbols.
 *
 * @private
 * @param {string} string The string to inspect.
 * @returns {boolean} Returns `true` if a symbol is found, else `false`.
 */
function hasUnicode(string) {
  return reHasUnicode.test(string);
}

/** Used to compose unicode character classes. */
var rsAstralRange$1 = '\\ud800-\\udfff',
    rsComboMarksRange$1 = '\\u0300-\\u036f',
    reComboHalfMarksRange$1 = '\\ufe20-\\ufe2f',
    rsComboSymbolsRange$1 = '\\u20d0-\\u20ff',
    rsComboRange$1 = rsComboMarksRange$1 + reComboHalfMarksRange$1 + rsComboSymbolsRange$1,
    rsVarRange$1 = '\\ufe0e\\ufe0f';

/** Used to compose unicode capture groups. */
var rsAstral = '[' + rsAstralRange$1 + ']',
    rsCombo = '[' + rsComboRange$1 + ']',
    rsFitz = '\\ud83c[\\udffb-\\udfff]',
    rsModifier = '(?:' + rsCombo + '|' + rsFitz + ')',
    rsNonAstral = '[^' + rsAstralRange$1 + ']',
    rsRegional = '(?:\\ud83c[\\udde6-\\uddff]){2}',
    rsSurrPair = '[\\ud800-\\udbff][\\udc00-\\udfff]',
    rsZWJ$1 = '\\u200d';

/** Used to compose unicode regexes. */
var reOptMod = rsModifier + '?',
    rsOptVar = '[' + rsVarRange$1 + ']?',
    rsOptJoin = '(?:' + rsZWJ$1 + '(?:' + [rsNonAstral, rsRegional, rsSurrPair].join('|') + ')' + rsOptVar + reOptMod + ')*',
    rsSeq = rsOptVar + reOptMod + rsOptJoin,
    rsSymbol = '(?:' + [rsNonAstral + rsCombo + '?', rsCombo, rsRegional, rsSurrPair, rsAstral].join('|') + ')';

/** Used to match [string symbols](https://mathiasbynens.be/notes/javascript-unicode). */
var reUnicode = RegExp(rsFitz + '(?=' + rsFitz + ')|' + rsSymbol + rsSeq, 'g');

/**
 * Converts a Unicode `string` to an array.
 *
 * @private
 * @param {string} string The string to convert.
 * @returns {Array} Returns the converted array.
 */
function unicodeToArray(string) {
  return string.match(reUnicode) || [];
}

/**
 * Converts `string` to an array.
 *
 * @private
 * @param {string} string The string to convert.
 * @returns {Array} Returns the converted array.
 */
function stringToArray(string) {
  return hasUnicode(string)
    ? unicodeToArray(string)
    : asciiToArray(string);
}

/**
 * The base implementation of `_.values` and `_.valuesIn` which creates an
 * array of `object` property values corresponding to the property names
 * of `props`.
 *
 * @private
 * @param {Object} object The object to query.
 * @param {Array} props The property names to get values for.
 * @returns {Object} Returns the array of property values.
 */
function baseValues(object, props) {
  return arrayMap(props, function(key) {
    return object[key];
  });
}

/**
 * Creates an array of the own enumerable string keyed property values of `object`.
 *
 * **Note:** Non-object values are coerced to objects.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Object
 * @param {Object} object The object to query.
 * @returns {Array} Returns the array of property values.
 * @example
 *
 * function Foo() {
 *   this.a = 1;
 *   this.b = 2;
 * }
 *
 * Foo.prototype.c = 3;
 *
 * _.values(new Foo);
 * // => [1, 2] (iteration order is not guaranteed)
 *
 * _.values('hi');
 * // => ['h', 'i']
 */
function values(object) {
  return object == null ? [] : baseValues(object, keys(object));
}

/** `Object#toString` result references. */
var mapTag$5 = '[object Map]',
    setTag$5 = '[object Set]';

/** Built-in value references. */
var symIterator = Symbol$2 ? Symbol$2.iterator : undefined;

/**
 * Converts `value` to an array.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Lang
 * @param {*} value The value to convert.
 * @returns {Array} Returns the converted array.
 * @example
 *
 * _.toArray({ 'a': 1, 'b': 2 });
 * // => [1, 2]
 *
 * _.toArray('abc');
 * // => ['a', 'b', 'c']
 *
 * _.toArray(1);
 * // => []
 *
 * _.toArray(null);
 * // => []
 */
function toArray(value) {
  if (!value) {
    return [];
  }
  if (isArrayLike(value)) {
    return isString(value) ? stringToArray(value) : copyArray(value);
  }
  if (symIterator && value[symIterator]) {
    return iteratorToArray(value[symIterator]());
  }
  var tag = getTag$1(value),
      func = tag == mapTag$5 ? mapToArray : (tag == setTag$5 ? setToArray : values);

  return func(value);
}

var toString$1 = Object.prototype.toString;
var errorToString = Error.prototype.toString;
var regExpToString = RegExp.prototype.toString;
var symbolToString$1 = typeof Symbol !== 'undefined' ? Symbol.prototype.toString : function () {
  return '';
};
var SYMBOL_REGEXP = /^Symbol\((.*)\)(.*)$/;

function printNumber(val) {
  if (val != +val) return 'NaN';
  var isNegativeZero = val === 0 && 1 / val < 0;
  return isNegativeZero ? '-0' : '' + val;
}

function printSimpleValue(val, quoteStrings) {
  if (quoteStrings === void 0) {
    quoteStrings = false;
  }

  if (val == null || val === true || val === false) return '' + val;
  var typeOf = typeof val;
  if (typeOf === 'number') return printNumber(val);
  if (typeOf === 'string') return quoteStrings ? "\"" + val + "\"" : val;
  if (typeOf === 'function') return '[Function ' + (val.name || 'anonymous') + ']';
  if (typeOf === 'symbol') return symbolToString$1.call(val).replace(SYMBOL_REGEXP, 'Symbol($1)');
  var tag = toString$1.call(val).slice(8, -1);
  if (tag === 'Date') return isNaN(val.getTime()) ? '' + val : val.toISOString(val);
  if (tag === 'Error' || val instanceof Error) return '[' + errorToString.call(val) + ']';
  if (tag === 'RegExp') return regExpToString.call(val);
  return null;
}

function printValue(value, quoteStrings) {
  var result = printSimpleValue(value, quoteStrings);
  if (result !== null) return result;
  return JSON.stringify(value, function (key, value) {
    var result = printSimpleValue(this[key], quoteStrings);
    if (result !== null) return result;
    return value;
  }, 2);
}

var mixed = {
  default: '${path} is invalid',
  required: '${path} is a required field',
  oneOf: '${path} must be one of the following values: ${values}',
  notOneOf: '${path} must not be one of the following values: ${values}',
  notType: function notType(_ref) {
    var path = _ref.path,
        type = _ref.type,
        value = _ref.value,
        originalValue = _ref.originalValue;
    var isCast = originalValue != null && originalValue !== value;
    var msg = path + " must be a `" + type + "` type, " + ("but the final value was: `" + printValue(value, true) + "`") + (isCast ? " (cast from the value `" + printValue(originalValue, true) + "`)." : '.');

    if (value === null) {
      msg += "\n If \"null\" is intended as an empty value be sure to mark the schema as `.nullable()`";
    }

    return msg;
  },
  defined: '${path} must be defined'
};
var string = {
  length: '${path} must be exactly ${length} characters',
  min: '${path} must be at least ${min} characters',
  max: '${path} must be at most ${max} characters',
  matches: '${path} must match the following: "${regex}"',
  email: '${path} must be a valid email',
  url: '${path} must be a valid URL',
  trim: '${path} must be a trimmed string',
  lowercase: '${path} must be a lowercase string',
  uppercase: '${path} must be a upper case string'
};
var number = {
  min: '${path} must be greater than or equal to ${min}',
  max: '${path} must be less than or equal to ${max}',
  lessThan: '${path} must be less than ${less}',
  moreThan: '${path} must be greater than ${more}',
  notEqual: '${path} must be not equal to ${notEqual}',
  positive: '${path} must be a positive number',
  negative: '${path} must be a negative number',
  integer: '${path} must be an integer'
};
var date = {
  min: '${path} field must be later than ${min}',
  max: '${path} field must be at earlier than ${max}'
};
var boolean = {};
var object = {
  noUnknown: '${path} field has unspecified keys: ${unknown}'
};
var array = {
  min: '${path} field must have at least ${min} items',
  max: '${path} field must have less than or equal to ${max} items'
};
var locale$2 = {
  mixed: mixed,
  string: string,
  number: number,
  date: date,
  object: object,
  array: array,
  boolean: boolean
};

var isSchema = (function (obj) {
  return obj && obj.__isYupSchema__;
});

var Condition = /*#__PURE__*/function () {
  function Condition(refs, options) {
    this.refs = refs;

    if (typeof options === 'function') {
      this.fn = options;
      return;
    }

    if (!has(options, 'is')) throw new TypeError('`is:` is required for `when()` conditions');
    if (!options.then && !options.otherwise) throw new TypeError('either `then:` or `otherwise:` is required for `when()` conditions');
    var is = options.is,
        then = options.then,
        otherwise = options.otherwise;
    var check = typeof is === 'function' ? is : function () {
      for (var _len = arguments.length, values = new Array(_len), _key = 0; _key < _len; _key++) {
        values[_key] = arguments[_key];
      }

      return values.every(function (value) {
        return value === is;
      });
    };

    this.fn = function () {
      for (var _len2 = arguments.length, args = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
        args[_key2] = arguments[_key2];
      }

      var options = args.pop();
      var schema = args.pop();
      var branch = check.apply(void 0, args) ? then : otherwise;
      if (!branch) return undefined;
      if (typeof branch === 'function') return branch(schema);
      return schema.concat(branch.resolve(options));
    };
  }

  var _proto = Condition.prototype;

  _proto.resolve = function resolve(base, options) {
    var values = this.refs.map(function (ref) {
      return ref.getValue(options);
    });
    var schema = this.fn.apply(base, values.concat(base, options));
    if (schema === undefined || schema === base) return base;
    if (!isSchema(schema)) throw new TypeError('conditions must return a schema object');
    return schema.resolve(options);
  };

  return Condition;
}();

function _objectWithoutPropertiesLoose(source, excluded) {
  if (source == null) return {};
  var target = {};
  var sourceKeys = Object.keys(source);
  var key, i;

  for (i = 0; i < sourceKeys.length; i++) {
    key = sourceKeys[i];
    if (excluded.indexOf(key) >= 0) continue;
    target[key] = source[key];
  }

  return target;
}

/* jshint node: true */
function makeArrayFrom(obj) {
  return Array.prototype.slice.apply(obj);
}
var
  PENDING = "pending",
  RESOLVED = "resolved",
  REJECTED = "rejected";

function SynchronousPromise(handler) {
  this.status = PENDING;
  this._continuations = [];
  this._parent = null;
  this._paused = false;
  if (handler) {
    handler.call(
      this,
      this._continueWith.bind(this),
      this._failWith.bind(this)
    );
  }
}

function looksLikeAPromise(obj) {
  return obj && typeof (obj.then) === "function";
}

SynchronousPromise.prototype = {
  then: function (nextFn, catchFn) {
    var next = SynchronousPromise.unresolved()._setParent(this);
    if (this._isRejected()) {
      if (this._paused) {
        this._continuations.push({
          promise: next,
          nextFn: nextFn,
          catchFn: catchFn
        });
        return next;
      }
      if (catchFn) {
        try {
          var catchResult = catchFn(this._error);
          if (looksLikeAPromise(catchResult)) {
            this._chainPromiseData(catchResult, next);
            return next;
          } else {
            return SynchronousPromise.resolve(catchResult)._setParent(this);
          }
        } catch (e) {
          return SynchronousPromise.reject(e)._setParent(this);
        }
      }
      return SynchronousPromise.reject(this._error)._setParent(this);
    }
    this._continuations.push({
      promise: next,
      nextFn: nextFn,
      catchFn: catchFn
    });
    this._runResolutions();
    return next;
  },
  catch: function (handler) {
    if (this._isResolved()) {
      return SynchronousPromise.resolve(this._data)._setParent(this);
    }
    var next = SynchronousPromise.unresolved()._setParent(this);
    this._continuations.push({
      promise: next,
      catchFn: handler
    });
    this._runRejections();
    return next;
  },
  finally: function(callback) {
    var ran = false;
    function runFinally() {
      if (!ran) {
        ran = true;
        return callback();
      }
    }
    return this.then(runFinally)
      .catch(runFinally);
  },
  pause: function () {
    this._paused = true;
    return this;
  },
  resume: function () {
    var firstPaused = this._findFirstPaused();
    if (firstPaused) {
      firstPaused._paused = false;
      firstPaused._runResolutions();
      firstPaused._runRejections();
    }
    return this;
  },
  _findAncestry: function () {
    return this._continuations.reduce(function (acc, cur) {
      if (cur.promise) {
        var node = {
          promise: cur.promise,
          children: cur.promise._findAncestry()
        };
        acc.push(node);
      }
      return acc;
    }, []);
  },
  _setParent: function (parent) {
    if (this._parent) {
      throw new Error("parent already set");
    }
    this._parent = parent;
    return this;
  },
  _continueWith: function (data) {
    var firstPending = this._findFirstPending();
    if (firstPending) {
      firstPending._data = data;
      firstPending._setResolved();
    }
  },
  _findFirstPending: function () {
    return this._findFirstAncestor(function (test) {
      return test._isPending && test._isPending();
    });
  },
  _findFirstPaused: function () {
    return this._findFirstAncestor(function (test) {
      return test._paused;
    });
  },
  _findFirstAncestor: function (matching) {
    var test = this;
    var result;
    while (test) {
      if (matching(test)) {
        result = test;
      }
      test = test._parent;
    }
    return result;
  },
  _failWith: function (error) {
    var firstRejected = this._findFirstPending();
    if (firstRejected) {
      firstRejected._error = error;
      firstRejected._setRejected();
    }
  },
  _takeContinuations: function () {
    return this._continuations.splice(0, this._continuations.length);
  },
  _runRejections: function () {
    if (this._paused || !this._isRejected()) {
      return;
    }
    var
      error = this._error,
      continuations = this._takeContinuations(),
      self = this;
    continuations.forEach(function (cont) {
      if (cont.catchFn) {
        try {
          var catchResult = cont.catchFn(error);
          self._handleUserFunctionResult(catchResult, cont.promise);
        } catch (e) {
          var message = e.message;
          cont.promise.reject(e);
        }
      } else {
        cont.promise.reject(error);
      }
    });
  },
  _runResolutions: function () {
    if (this._paused || !this._isResolved() || this._isPending()) {
      return;
    }
    var continuations = this._takeContinuations();
    if (looksLikeAPromise(this._data)) {
      return this._handleWhenResolvedDataIsPromise(this._data);
    }
    var data = this._data;
    var self = this;
    continuations.forEach(function (cont) {
      if (cont.nextFn) {
        try {
          var result = cont.nextFn(data);
          self._handleUserFunctionResult(result, cont.promise);
        } catch (e) {
          self._handleResolutionError(e, cont);
        }
      } else if (cont.promise) {
        cont.promise.resolve(data);
      }
    });
  },
  _handleResolutionError: function (e, continuation) {
    this._setRejected();
    if (continuation.catchFn) {
      try {
        continuation.catchFn(e);
        return;
      } catch (e2) {
        e = e2;
      }
    }
    if (continuation.promise) {
      continuation.promise.reject(e);
    }
  },
  _handleWhenResolvedDataIsPromise: function (data) {
    var self = this;
    return data.then(function (result) {
      self._data = result;
      self._runResolutions();
    }).catch(function (error) {
      self._error = error;
      self._setRejected();
      self._runRejections();
    });
  },
  _handleUserFunctionResult: function (data, nextSynchronousPromise) {
    if (looksLikeAPromise(data)) {
      this._chainPromiseData(data, nextSynchronousPromise);
    } else {
      nextSynchronousPromise.resolve(data);
    }
  },
  _chainPromiseData: function (promiseData, nextSynchronousPromise) {
    promiseData.then(function (newData) {
      nextSynchronousPromise.resolve(newData);
    }).catch(function (newError) {
      nextSynchronousPromise.reject(newError);
    });
  },
  _setResolved: function () {
    this.status = RESOLVED;
    if (!this._paused) {
      this._runResolutions();
    }
  },
  _setRejected: function () {
    this.status = REJECTED;
    if (!this._paused) {
      this._runRejections();
    }
  },
  _isPending: function () {
    return this.status === PENDING;
  },
  _isResolved: function () {
    return this.status === RESOLVED;
  },
  _isRejected: function () {
    return this.status === REJECTED;
  }
};

SynchronousPromise.resolve = function (result) {
  return new SynchronousPromise(function (resolve, reject) {
    if (looksLikeAPromise(result)) {
      result.then(function (newResult) {
        resolve(newResult);
      }).catch(function (error) {
        reject(error);
      });
    } else {
      resolve(result);
    }
  });
};

SynchronousPromise.reject = function (result) {
  return new SynchronousPromise(function (resolve, reject) {
    reject(result);
  });
};

SynchronousPromise.unresolved = function () {
  return new SynchronousPromise(function (resolve, reject) {
    this.resolve = resolve;
    this.reject = reject;
  });
};

SynchronousPromise.all = function () {
  var args = makeArrayFrom(arguments);
  if (Array.isArray(args[0])) {
    args = args[0];
  }
  if (!args.length) {
    return SynchronousPromise.resolve([]);
  }
  return new SynchronousPromise(function (resolve, reject) {
    var
      allData = [],
      numResolved = 0,
      doResolve = function () {
        if (numResolved === args.length) {
          resolve(allData);
        }
      },
      rejected = false,
      doReject = function (err) {
        if (rejected) {
          return;
        }
        rejected = true;
        reject(err);
      };
    args.forEach(function (arg, idx) {
      SynchronousPromise.resolve(arg).then(function (thisResult) {
        allData[idx] = thisResult;
        numResolved += 1;
        doResolve();
      }).catch(function (err) {
        doReject(err);
      });
    });
  });
};

/* jshint ignore:start */
if (Promise === SynchronousPromise) {
  throw new Error("Please use SynchronousPromise.installGlobally() to install globally");
}
var RealPromise = Promise;
SynchronousPromise.installGlobally = function(__awaiter) {
  if (Promise === SynchronousPromise) {
    return __awaiter;
  }
  var result = patchAwaiterIfRequired(__awaiter);
  Promise = SynchronousPromise;
  return result;
};

SynchronousPromise.uninstallGlobally = function() {
  if (Promise === SynchronousPromise) {
    Promise = RealPromise;
  }
};

function patchAwaiterIfRequired(__awaiter) {
  if (typeof(__awaiter) === "undefined" || __awaiter.__patched) {
    return __awaiter;
  }
  var originalAwaiter = __awaiter;
  __awaiter = function() {
    originalAwaiter.apply(this, makeArrayFrom(arguments));
  };
  __awaiter.__patched = true;
  return __awaiter;
}
/* jshint ignore:end */

var synchronousPromise = {
  SynchronousPromise: SynchronousPromise
};
var synchronousPromise_1 = synchronousPromise.SynchronousPromise;

var strReg = /\$\{\s*(\w+)\s*\}/g;

var replace = function replace(str) {
  return function (params) {
    return str.replace(strReg, function (_, key) {
      return printValue(params[key]);
    });
  };
};

function ValidationError(errors, value, field, type) {
  var _this = this;

  this.name = 'ValidationError';
  this.value = value;
  this.path = field;
  this.type = type;
  this.errors = [];
  this.inner = [];
  if (errors) [].concat(errors).forEach(function (err) {
    _this.errors = _this.errors.concat(err.errors || err);
    if (err.inner) _this.inner = _this.inner.concat(err.inner.length ? err.inner : err);
  });
  this.message = this.errors.length > 1 ? this.errors.length + " errors occurred" : this.errors[0];
  if (Error.captureStackTrace) Error.captureStackTrace(this, ValidationError);
}
ValidationError.prototype = Object.create(Error.prototype);
ValidationError.prototype.constructor = ValidationError;

ValidationError.isError = function (err) {
  return err && err.name === 'ValidationError';
};

ValidationError.formatError = function (message, params) {
  if (typeof message === 'string') message = replace(message);

  var fn = function fn(params) {
    params.path = params.label || params.path || 'this';
    return typeof message === 'function' ? message(params) : message;
  };

  return arguments.length === 1 ? fn : fn(params);
};

var promise = function promise(sync) {
  return sync ? synchronousPromise_1 : Promise;
};

var unwrapError = function unwrapError(errors) {
  if (errors === void 0) {
    errors = [];
  }

  return errors.inner && errors.inner.length ? errors.inner : [].concat(errors);
};

function scopeToValue(promises, value, sync) {
  //console.log('scopeToValue', promises, value)
  var p = promise(sync).all(promises); //console.log('scopeToValue B', p)

  var b = p.catch(function (err) {
    if (err.name === 'ValidationError') err.value = value;
    throw err;
  }); //console.log('scopeToValue c', b)

  var c = b.then(function () {
    return value;
  }); //console.log('scopeToValue d', c)

  return c;
}
/**
 * If not failing on the first error, catch the errors
 * and collect them in an array
 */


function propagateErrors(endEarly, errors) {
  return endEarly ? null : function (err) {
    errors.push(err);
    return err.value;
  };
}
function settled(promises, sync) {
  var Promise = promise(sync);
  return Promise.all(promises.map(function (p) {
    return Promise.resolve(p).then(function (value) {
      return {
        fulfilled: true,
        value: value
      };
    }, function (value) {
      return {
        fulfilled: false,
        value: value
      };
    });
  }));
}
function collectErrors(_ref) {
  var validations = _ref.validations,
      value = _ref.value,
      path = _ref.path,
      sync = _ref.sync,
      errors = _ref.errors,
      sort = _ref.sort;
  errors = unwrapError(errors);
  return settled(validations, sync).then(function (results) {
    var nestedErrors = results.filter(function (r) {
      return !r.fulfilled;
    }).reduce(function (arr, _ref2) {
      var error = _ref2.value;

      // we are only collecting validation errors
      if (!ValidationError.isError(error)) {
        throw error;
      }

      return arr.concat(error);
    }, []);
    if (sort) nestedErrors.sort(sort); //show parent errors after the nested ones: name.first, name

    errors = nestedErrors.concat(errors);
    if (errors.length) throw new ValidationError(errors, value, path);
    return value;
  });
}
function runValidations(_ref3) {
  var endEarly = _ref3.endEarly,
      options = _objectWithoutPropertiesLoose(_ref3, ["endEarly"]);

  if (endEarly) return scopeToValue(options.validations, options.value, options.sync);
  return collectErrors(options);
}

var isObject$2 = function isObject(obj) {
  return Object.prototype.toString.call(obj) === '[object Object]';
};

function prependDeep(target, source) {
  for (var key in source) {
    if (has(source, key)) {
      var sourceVal = source[key],
          targetVal = target[key];

      if (targetVal === undefined) {
        target[key] = sourceVal;
      } else if (targetVal === sourceVal) {
        continue;
      } else if (isSchema(targetVal)) {
        if (isSchema(sourceVal)) target[key] = sourceVal.concat(targetVal);
      } else if (isObject$2(targetVal)) {
        if (isObject$2(sourceVal)) target[key] = prependDeep(targetVal, sourceVal);
      } else if (Array.isArray(targetVal)) {
        if (Array.isArray(sourceVal)) target[key] = sourceVal.concat(targetVal);
      }
    }
  }

  return target;
}

/**
 * Creates a base function for methods like `_.forIn` and `_.forOwn`.
 *
 * @private
 * @param {boolean} [fromRight] Specify iterating from right to left.
 * @returns {Function} Returns the new base function.
 */
function createBaseFor(fromRight) {
  return function(object, iteratee, keysFunc) {
    var index = -1,
        iterable = Object(object),
        props = keysFunc(object),
        length = props.length;

    while (length--) {
      var key = props[fromRight ? length : ++index];
      if (iteratee(iterable[key], key, iterable) === false) {
        break;
      }
    }
    return object;
  };
}

/**
 * The base implementation of `baseForOwn` which iterates over `object`
 * properties returned by `keysFunc` and invokes `iteratee` for each property.
 * Iteratee functions may exit iteration early by explicitly returning `false`.
 *
 * @private
 * @param {Object} object The object to iterate over.
 * @param {Function} iteratee The function invoked per iteration.
 * @param {Function} keysFunc The function to get the keys of `object`.
 * @returns {Object} Returns `object`.
 */
var baseFor = createBaseFor();

/**
 * The base implementation of `_.forOwn` without support for iteratee shorthands.
 *
 * @private
 * @param {Object} object The object to iterate over.
 * @param {Function} iteratee The function invoked per iteration.
 * @returns {Object} Returns `object`.
 */
function baseForOwn(object, iteratee) {
  return object && baseFor(object, iteratee, keys);
}

/** Used to stand-in for `undefined` hash values. */
var HASH_UNDEFINED$2 = '__lodash_hash_undefined__';

/**
 * Adds `value` to the array cache.
 *
 * @private
 * @name add
 * @memberOf SetCache
 * @alias push
 * @param {*} value The value to cache.
 * @returns {Object} Returns the cache instance.
 */
function setCacheAdd(value) {
  this.__data__.set(value, HASH_UNDEFINED$2);
  return this;
}

/**
 * Checks if `value` is in the array cache.
 *
 * @private
 * @name has
 * @memberOf SetCache
 * @param {*} value The value to search for.
 * @returns {number} Returns `true` if `value` is found, else `false`.
 */
function setCacheHas(value) {
  return this.__data__.has(value);
}

/**
 *
 * Creates an array cache object to store unique values.
 *
 * @private
 * @constructor
 * @param {Array} [values] The values to cache.
 */
function SetCache(values) {
  var index = -1,
      length = values == null ? 0 : values.length;

  this.__data__ = new MapCache;
  while (++index < length) {
    this.add(values[index]);
  }
}

// Add methods to `SetCache`.
SetCache.prototype.add = SetCache.prototype.push = setCacheAdd;
SetCache.prototype.has = setCacheHas;

/**
 * A specialized version of `_.some` for arrays without support for iteratee
 * shorthands.
 *
 * @private
 * @param {Array} [array] The array to iterate over.
 * @param {Function} predicate The function invoked per iteration.
 * @returns {boolean} Returns `true` if any element passes the predicate check,
 *  else `false`.
 */
function arraySome(array, predicate) {
  var index = -1,
      length = array == null ? 0 : array.length;

  while (++index < length) {
    if (predicate(array[index], index, array)) {
      return true;
    }
  }
  return false;
}

/**
 * Checks if a `cache` value for `key` exists.
 *
 * @private
 * @param {Object} cache The cache to query.
 * @param {string} key The key of the entry to check.
 * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
 */
function cacheHas(cache, key) {
  return cache.has(key);
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG = 1,
    COMPARE_UNORDERED_FLAG = 2;

/**
 * A specialized version of `baseIsEqualDeep` for arrays with support for
 * partial deep comparisons.
 *
 * @private
 * @param {Array} array The array to compare.
 * @param {Array} other The other array to compare.
 * @param {number} bitmask The bitmask flags. See `baseIsEqual` for more details.
 * @param {Function} customizer The function to customize comparisons.
 * @param {Function} equalFunc The function to determine equivalents of values.
 * @param {Object} stack Tracks traversed `array` and `other` objects.
 * @returns {boolean} Returns `true` if the arrays are equivalent, else `false`.
 */
function equalArrays(array, other, bitmask, customizer, equalFunc, stack) {
  var isPartial = bitmask & COMPARE_PARTIAL_FLAG,
      arrLength = array.length,
      othLength = other.length;

  if (arrLength != othLength && !(isPartial && othLength > arrLength)) {
    return false;
  }
  // Assume cyclic values are equal.
  var stacked = stack.get(array);
  if (stacked && stack.get(other)) {
    return stacked == other;
  }
  var index = -1,
      result = true,
      seen = (bitmask & COMPARE_UNORDERED_FLAG) ? new SetCache : undefined;

  stack.set(array, other);
  stack.set(other, array);

  // Ignore non-index properties.
  while (++index < arrLength) {
    var arrValue = array[index],
        othValue = other[index];

    if (customizer) {
      var compared = isPartial
        ? customizer(othValue, arrValue, index, other, array, stack)
        : customizer(arrValue, othValue, index, array, other, stack);
    }
    if (compared !== undefined) {
      if (compared) {
        continue;
      }
      result = false;
      break;
    }
    // Recursively compare arrays (susceptible to call stack limits).
    if (seen) {
      if (!arraySome(other, function(othValue, othIndex) {
            if (!cacheHas(seen, othIndex) &&
                (arrValue === othValue || equalFunc(arrValue, othValue, bitmask, customizer, stack))) {
              return seen.push(othIndex);
            }
          })) {
        result = false;
        break;
      }
    } else if (!(
          arrValue === othValue ||
            equalFunc(arrValue, othValue, bitmask, customizer, stack)
        )) {
      result = false;
      break;
    }
  }
  stack['delete'](array);
  stack['delete'](other);
  return result;
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG$1 = 1,
    COMPARE_UNORDERED_FLAG$1 = 2;

/** `Object#toString` result references. */
var boolTag$3 = '[object Boolean]',
    dateTag$3 = '[object Date]',
    errorTag$2 = '[object Error]',
    mapTag$6 = '[object Map]',
    numberTag$3 = '[object Number]',
    regexpTag$3 = '[object RegExp]',
    setTag$6 = '[object Set]',
    stringTag$4 = '[object String]',
    symbolTag$4 = '[object Symbol]';

var arrayBufferTag$3 = '[object ArrayBuffer]',
    dataViewTag$4 = '[object DataView]';

/** Used to convert symbols to primitives and strings. */
var symbolProto$2 = Symbol$2 ? Symbol$2.prototype : undefined,
    symbolValueOf$1 = symbolProto$2 ? symbolProto$2.valueOf : undefined;

/**
 * A specialized version of `baseIsEqualDeep` for comparing objects of
 * the same `toStringTag`.
 *
 * **Note:** This function only supports comparing values with tags of
 * `Boolean`, `Date`, `Error`, `Number`, `RegExp`, or `String`.
 *
 * @private
 * @param {Object} object The object to compare.
 * @param {Object} other The other object to compare.
 * @param {string} tag The `toStringTag` of the objects to compare.
 * @param {number} bitmask The bitmask flags. See `baseIsEqual` for more details.
 * @param {Function} customizer The function to customize comparisons.
 * @param {Function} equalFunc The function to determine equivalents of values.
 * @param {Object} stack Tracks traversed `object` and `other` objects.
 * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
 */
function equalByTag(object, other, tag, bitmask, customizer, equalFunc, stack) {
  switch (tag) {
    case dataViewTag$4:
      if ((object.byteLength != other.byteLength) ||
          (object.byteOffset != other.byteOffset)) {
        return false;
      }
      object = object.buffer;
      other = other.buffer;

    case arrayBufferTag$3:
      if ((object.byteLength != other.byteLength) ||
          !equalFunc(new Uint8Array(object), new Uint8Array(other))) {
        return false;
      }
      return true;

    case boolTag$3:
    case dateTag$3:
    case numberTag$3:
      // Coerce booleans to `1` or `0` and dates to milliseconds.
      // Invalid dates are coerced to `NaN`.
      return eq(+object, +other);

    case errorTag$2:
      return object.name == other.name && object.message == other.message;

    case regexpTag$3:
    case stringTag$4:
      // Coerce regexes to strings and treat strings, primitives and objects,
      // as equal. See http://www.ecma-international.org/ecma-262/7.0/#sec-regexp.prototype.tostring
      // for more details.
      return object == (other + '');

    case mapTag$6:
      var convert = mapToArray;

    case setTag$6:
      var isPartial = bitmask & COMPARE_PARTIAL_FLAG$1;
      convert || (convert = setToArray);

      if (object.size != other.size && !isPartial) {
        return false;
      }
      // Assume cyclic values are equal.
      var stacked = stack.get(object);
      if (stacked) {
        return stacked == other;
      }
      bitmask |= COMPARE_UNORDERED_FLAG$1;

      // Recursively compare objects (susceptible to call stack limits).
      stack.set(object, other);
      var result = equalArrays(convert(object), convert(other), bitmask, customizer, equalFunc, stack);
      stack['delete'](object);
      return result;

    case symbolTag$4:
      if (symbolValueOf$1) {
        return symbolValueOf$1.call(object) == symbolValueOf$1.call(other);
      }
  }
  return false;
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG$2 = 1;

/** Used for built-in method references. */
var objectProto$g = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$c = objectProto$g.hasOwnProperty;

/**
 * A specialized version of `baseIsEqualDeep` for objects with support for
 * partial deep comparisons.
 *
 * @private
 * @param {Object} object The object to compare.
 * @param {Object} other The other object to compare.
 * @param {number} bitmask The bitmask flags. See `baseIsEqual` for more details.
 * @param {Function} customizer The function to customize comparisons.
 * @param {Function} equalFunc The function to determine equivalents of values.
 * @param {Object} stack Tracks traversed `object` and `other` objects.
 * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
 */
function equalObjects(object, other, bitmask, customizer, equalFunc, stack) {
  var isPartial = bitmask & COMPARE_PARTIAL_FLAG$2,
      objProps = getAllKeys(object),
      objLength = objProps.length,
      othProps = getAllKeys(other),
      othLength = othProps.length;

  if (objLength != othLength && !isPartial) {
    return false;
  }
  var index = objLength;
  while (index--) {
    var key = objProps[index];
    if (!(isPartial ? key in other : hasOwnProperty$c.call(other, key))) {
      return false;
    }
  }
  // Assume cyclic values are equal.
  var stacked = stack.get(object);
  if (stacked && stack.get(other)) {
    return stacked == other;
  }
  var result = true;
  stack.set(object, other);
  stack.set(other, object);

  var skipCtor = isPartial;
  while (++index < objLength) {
    key = objProps[index];
    var objValue = object[key],
        othValue = other[key];

    if (customizer) {
      var compared = isPartial
        ? customizer(othValue, objValue, key, other, object, stack)
        : customizer(objValue, othValue, key, object, other, stack);
    }
    // Recursively compare objects (susceptible to call stack limits).
    if (!(compared === undefined
          ? (objValue === othValue || equalFunc(objValue, othValue, bitmask, customizer, stack))
          : compared
        )) {
      result = false;
      break;
    }
    skipCtor || (skipCtor = key == 'constructor');
  }
  if (result && !skipCtor) {
    var objCtor = object.constructor,
        othCtor = other.constructor;

    // Non `Object` object instances with different constructors are not equal.
    if (objCtor != othCtor &&
        ('constructor' in object && 'constructor' in other) &&
        !(typeof objCtor == 'function' && objCtor instanceof objCtor &&
          typeof othCtor == 'function' && othCtor instanceof othCtor)) {
      result = false;
    }
  }
  stack['delete'](object);
  stack['delete'](other);
  return result;
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG$3 = 1;

/** `Object#toString` result references. */
var argsTag$3 = '[object Arguments]',
    arrayTag$2 = '[object Array]',
    objectTag$3 = '[object Object]';

/** Used for built-in method references. */
var objectProto$h = Object.prototype;

/** Used to check objects for own properties. */
var hasOwnProperty$d = objectProto$h.hasOwnProperty;

/**
 * A specialized version of `baseIsEqual` for arrays and objects which performs
 * deep comparisons and tracks traversed objects enabling objects with circular
 * references to be compared.
 *
 * @private
 * @param {Object} object The object to compare.
 * @param {Object} other The other object to compare.
 * @param {number} bitmask The bitmask flags. See `baseIsEqual` for more details.
 * @param {Function} customizer The function to customize comparisons.
 * @param {Function} equalFunc The function to determine equivalents of values.
 * @param {Object} [stack] Tracks traversed `object` and `other` objects.
 * @returns {boolean} Returns `true` if the objects are equivalent, else `false`.
 */
function baseIsEqualDeep(object, other, bitmask, customizer, equalFunc, stack) {
  var objIsArr = isArray(object),
      othIsArr = isArray(other),
      objTag = objIsArr ? arrayTag$2 : getTag$1(object),
      othTag = othIsArr ? arrayTag$2 : getTag$1(other);

  objTag = objTag == argsTag$3 ? objectTag$3 : objTag;
  othTag = othTag == argsTag$3 ? objectTag$3 : othTag;

  var objIsObj = objTag == objectTag$3,
      othIsObj = othTag == objectTag$3,
      isSameTag = objTag == othTag;

  if (isSameTag && isBuffer(object)) {
    if (!isBuffer(other)) {
      return false;
    }
    objIsArr = true;
    objIsObj = false;
  }
  if (isSameTag && !objIsObj) {
    stack || (stack = new Stack);
    return (objIsArr || isTypedArray(object))
      ? equalArrays(object, other, bitmask, customizer, equalFunc, stack)
      : equalByTag(object, other, objTag, bitmask, customizer, equalFunc, stack);
  }
  if (!(bitmask & COMPARE_PARTIAL_FLAG$3)) {
    var objIsWrapped = objIsObj && hasOwnProperty$d.call(object, '__wrapped__'),
        othIsWrapped = othIsObj && hasOwnProperty$d.call(other, '__wrapped__');

    if (objIsWrapped || othIsWrapped) {
      var objUnwrapped = objIsWrapped ? object.value() : object,
          othUnwrapped = othIsWrapped ? other.value() : other;

      stack || (stack = new Stack);
      return equalFunc(objUnwrapped, othUnwrapped, bitmask, customizer, stack);
    }
  }
  if (!isSameTag) {
    return false;
  }
  stack || (stack = new Stack);
  return equalObjects(object, other, bitmask, customizer, equalFunc, stack);
}

/**
 * The base implementation of `_.isEqual` which supports partial comparisons
 * and tracks traversed objects.
 *
 * @private
 * @param {*} value The value to compare.
 * @param {*} other The other value to compare.
 * @param {boolean} bitmask The bitmask flags.
 *  1 - Unordered comparison
 *  2 - Partial comparison
 * @param {Function} [customizer] The function to customize comparisons.
 * @param {Object} [stack] Tracks traversed `value` and `other` objects.
 * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
 */
function baseIsEqual(value, other, bitmask, customizer, stack) {
  if (value === other) {
    return true;
  }
  if (value == null || other == null || (!isObjectLike$1(value) && !isObjectLike$1(other))) {
    return value !== value && other !== other;
  }
  return baseIsEqualDeep(value, other, bitmask, customizer, baseIsEqual, stack);
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG$4 = 1,
    COMPARE_UNORDERED_FLAG$2 = 2;

/**
 * The base implementation of `_.isMatch` without support for iteratee shorthands.
 *
 * @private
 * @param {Object} object The object to inspect.
 * @param {Object} source The object of property values to match.
 * @param {Array} matchData The property names, values, and compare flags to match.
 * @param {Function} [customizer] The function to customize comparisons.
 * @returns {boolean} Returns `true` if `object` is a match, else `false`.
 */
function baseIsMatch(object, source, matchData, customizer) {
  var index = matchData.length,
      length = index,
      noCustomizer = !customizer;

  if (object == null) {
    return !length;
  }
  object = Object(object);
  while (index--) {
    var data = matchData[index];
    if ((noCustomizer && data[2])
          ? data[1] !== object[data[0]]
          : !(data[0] in object)
        ) {
      return false;
    }
  }
  while (++index < length) {
    data = matchData[index];
    var key = data[0],
        objValue = object[key],
        srcValue = data[1];

    if (noCustomizer && data[2]) {
      if (objValue === undefined && !(key in object)) {
        return false;
      }
    } else {
      var stack = new Stack;
      if (customizer) {
        var result = customizer(objValue, srcValue, key, object, source, stack);
      }
      if (!(result === undefined
            ? baseIsEqual(srcValue, objValue, COMPARE_PARTIAL_FLAG$4 | COMPARE_UNORDERED_FLAG$2, customizer, stack)
            : result
          )) {
        return false;
      }
    }
  }
  return true;
}

/**
 * Checks if `value` is suitable for strict equality comparisons, i.e. `===`.
 *
 * @private
 * @param {*} value The value to check.
 * @returns {boolean} Returns `true` if `value` if suitable for strict
 *  equality comparisons, else `false`.
 */
function isStrictComparable(value) {
  return value === value && !isObject$1(value);
}

/**
 * Gets the property names, values, and compare flags of `object`.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Array} Returns the match data of `object`.
 */
function getMatchData(object) {
  var result = keys(object),
      length = result.length;

  while (length--) {
    var key = result[length],
        value = object[key];

    result[length] = [key, value, isStrictComparable(value)];
  }
  return result;
}

/**
 * A specialized version of `matchesProperty` for source values suitable
 * for strict equality comparisons, i.e. `===`.
 *
 * @private
 * @param {string} key The key of the property to get.
 * @param {*} srcValue The value to match.
 * @returns {Function} Returns the new spec function.
 */
function matchesStrictComparable(key, srcValue) {
  return function(object) {
    if (object == null) {
      return false;
    }
    return object[key] === srcValue &&
      (srcValue !== undefined || (key in Object(object)));
  };
}

/**
 * The base implementation of `_.matches` which doesn't clone `source`.
 *
 * @private
 * @param {Object} source The object of property values to match.
 * @returns {Function} Returns the new spec function.
 */
function baseMatches(source) {
  var matchData = getMatchData(source);
  if (matchData.length == 1 && matchData[0][2]) {
    return matchesStrictComparable(matchData[0][0], matchData[0][1]);
  }
  return function(object) {
    return object === source || baseIsMatch(object, source, matchData);
  };
}

/**
 * The base implementation of `_.get` without support for default values.
 *
 * @private
 * @param {Object} object The object to query.
 * @param {Array|string} path The path of the property to get.
 * @returns {*} Returns the resolved value.
 */
function baseGet(object, path) {
  path = castPath(path, object);

  var index = 0,
      length = path.length;

  while (object != null && index < length) {
    object = object[toKey(path[index++])];
  }
  return (index && index == length) ? object : undefined;
}

/**
 * Gets the value at `path` of `object`. If the resolved value is
 * `undefined`, the `defaultValue` is returned in its place.
 *
 * @static
 * @memberOf _
 * @since 3.7.0
 * @category Object
 * @param {Object} object The object to query.
 * @param {Array|string} path The path of the property to get.
 * @param {*} [defaultValue] The value returned for `undefined` resolved values.
 * @returns {*} Returns the resolved value.
 * @example
 *
 * var object = { 'a': [{ 'b': { 'c': 3 } }] };
 *
 * _.get(object, 'a[0].b.c');
 * // => 3
 *
 * _.get(object, ['a', '0', 'b', 'c']);
 * // => 3
 *
 * _.get(object, 'a.b.c', 'default');
 * // => 'default'
 */
function get$2(object, path, defaultValue) {
  var result = object == null ? undefined : baseGet(object, path);
  return result === undefined ? defaultValue : result;
}

/**
 * The base implementation of `_.hasIn` without support for deep paths.
 *
 * @private
 * @param {Object} [object] The object to query.
 * @param {Array|string} key The key to check.
 * @returns {boolean} Returns `true` if `key` exists, else `false`.
 */
function baseHasIn(object, key) {
  return object != null && key in Object(object);
}

/**
 * Checks if `path` is a direct or inherited property of `object`.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category Object
 * @param {Object} object The object to query.
 * @param {Array|string} path The path to check.
 * @returns {boolean} Returns `true` if `path` exists, else `false`.
 * @example
 *
 * var object = _.create({ 'a': _.create({ 'b': 2 }) });
 *
 * _.hasIn(object, 'a');
 * // => true
 *
 * _.hasIn(object, 'a.b');
 * // => true
 *
 * _.hasIn(object, ['a', 'b']);
 * // => true
 *
 * _.hasIn(object, 'b');
 * // => false
 */
function hasIn(object, path) {
  return object != null && hasPath(object, path, baseHasIn);
}

/** Used to compose bitmasks for value comparisons. */
var COMPARE_PARTIAL_FLAG$5 = 1,
    COMPARE_UNORDERED_FLAG$3 = 2;

/**
 * The base implementation of `_.matchesProperty` which doesn't clone `srcValue`.
 *
 * @private
 * @param {string} path The path of the property to get.
 * @param {*} srcValue The value to match.
 * @returns {Function} Returns the new spec function.
 */
function baseMatchesProperty(path, srcValue) {
  if (isKey(path) && isStrictComparable(srcValue)) {
    return matchesStrictComparable(toKey(path), srcValue);
  }
  return function(object) {
    var objValue = get$2(object, path);
    return (objValue === undefined && objValue === srcValue)
      ? hasIn(object, path)
      : baseIsEqual(srcValue, objValue, COMPARE_PARTIAL_FLAG$5 | COMPARE_UNORDERED_FLAG$3);
  };
}

/**
 * This method returns the first argument it receives.
 *
 * @static
 * @since 0.1.0
 * @memberOf _
 * @category Util
 * @param {*} value Any value.
 * @returns {*} Returns `value`.
 * @example
 *
 * var object = { 'a': 1 };
 *
 * console.log(_.identity(object) === object);
 * // => true
 */
function identity(value) {
  return value;
}

/**
 * The base implementation of `_.property` without support for deep paths.
 *
 * @private
 * @param {string} key The key of the property to get.
 * @returns {Function} Returns the new accessor function.
 */
function baseProperty(key) {
  return function(object) {
    return object == null ? undefined : object[key];
  };
}

/**
 * A specialized version of `baseProperty` which supports deep paths.
 *
 * @private
 * @param {Array|string} path The path of the property to get.
 * @returns {Function} Returns the new accessor function.
 */
function basePropertyDeep(path) {
  return function(object) {
    return baseGet(object, path);
  };
}

/**
 * Creates a function that returns the value at `path` of a given object.
 *
 * @static
 * @memberOf _
 * @since 2.4.0
 * @category Util
 * @param {Array|string} path The path of the property to get.
 * @returns {Function} Returns the new accessor function.
 * @example
 *
 * var objects = [
 *   { 'a': { 'b': 2 } },
 *   { 'a': { 'b': 1 } }
 * ];
 *
 * _.map(objects, _.property('a.b'));
 * // => [2, 1]
 *
 * _.map(_.sortBy(objects, _.property(['a', 'b'])), 'a.b');
 * // => [1, 2]
 */
function property(path) {
  return isKey(path) ? baseProperty(toKey(path)) : basePropertyDeep(path);
}

/**
 * The base implementation of `_.iteratee`.
 *
 * @private
 * @param {*} [value=_.identity] The value to convert to an iteratee.
 * @returns {Function} Returns the iteratee.
 */
function baseIteratee(value) {
  // Don't store the `typeof` result in a variable to avoid a JIT bug in Safari 9.
  // See https://bugs.webkit.org/show_bug.cgi?id=156034 for more details.
  if (typeof value == 'function') {
    return value;
  }
  if (value == null) {
    return identity;
  }
  if (typeof value == 'object') {
    return isArray(value)
      ? baseMatchesProperty(value[0], value[1])
      : baseMatches(value);
  }
  return property(value);
}

/**
 * Creates an object with the same keys as `object` and values generated
 * by running each own enumerable string keyed property of `object` thru
 * `iteratee`. The iteratee is invoked with three arguments:
 * (value, key, object).
 *
 * @static
 * @memberOf _
 * @since 2.4.0
 * @category Object
 * @param {Object} object The object to iterate over.
 * @param {Function} [iteratee=_.identity] The function invoked per iteration.
 * @returns {Object} Returns the new mapped object.
 * @see _.mapKeys
 * @example
 *
 * var users = {
 *   'fred':    { 'user': 'fred',    'age': 40 },
 *   'pebbles': { 'user': 'pebbles', 'age': 1 }
 * };
 *
 * _.mapValues(users, function(o) { return o.age; });
 * // => { 'fred': 40, 'pebbles': 1 } (iteration order is not guaranteed)
 *
 * // The `_.property` iteratee shorthand.
 * _.mapValues(users, 'age');
 * // => { 'fred': 40, 'pebbles': 1 } (iteration order is not guaranteed)
 */
function mapValues(object, iteratee) {
  var result = {};
  iteratee = baseIteratee(iteratee);

  baseForOwn(object, function(value, key, object) {
    baseAssignValue(result, key, iteratee(value, key, object));
  });
  return result;
}

/**
 * Based on Kendo UI Core expression code <https://github.com/telerik/kendo-ui-core#license-information>
 */

function Cache(maxSize) {
  this._maxSize = maxSize;
  this.clear();
}
Cache.prototype.clear = function() {
  this._size = 0;
  this._values = Object.create(null);
};
Cache.prototype.get = function(key) {
  return this._values[key]
};
Cache.prototype.set = function(key, value) {
  this._size >= this._maxSize && this.clear();
  if (!(key in this._values)) this._size++;

  return (this._values[key] = value)
};

var SPLIT_REGEX = /[^.^\]^[]+|(?=\[\]|\.\.)/g,
  DIGIT_REGEX = /^\d+$/,
  LEAD_DIGIT_REGEX = /^\d/,
  SPEC_CHAR_REGEX = /[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g,
  CLEAN_QUOTES_REGEX = /^\s*(['"]?)(.*?)(\1)\s*$/,
  MAX_CACHE_SIZE = 512;

var pathCache = new Cache(MAX_CACHE_SIZE),
  setCache = new Cache(MAX_CACHE_SIZE),
  getCache = new Cache(MAX_CACHE_SIZE);

var propertyExpr = {
  Cache: Cache,

  split: split,

  normalizePath: normalizePath,

  setter: function(path) {
    var parts = normalizePath(path);

    return (
      setCache.get(path) ||
      setCache.set(path, function setter(data, value) {
        var index = 0,
          len = parts.length;
        while (index < len - 1) {
          data = data[parts[index++]];
        }
        data[parts[index]] = value;
      })
    )
  },

  getter: function(path, safe) {
    var parts = normalizePath(path);
    return (
      getCache.get(path) ||
      getCache.set(path, function getter(data) {
        var index = 0,
          len = parts.length;
        while (index < len) {
          if (data != null || !safe) data = data[parts[index++]];
          else return
        }
        return data
      })
    )
  },

  join: function(segments) {
    return segments.reduce(function(path, part) {
      return (
        path +
        (isQuoted(part) || DIGIT_REGEX.test(part)
          ? '[' + part + ']'
          : (path ? '.' : '') + part)
      )
    }, '')
  },

  forEach: function(path, cb, thisArg) {
    forEach(Array.isArray(path) ? path : split(path), cb, thisArg);
  }
};

function normalizePath(path) {
  return (
    pathCache.get(path) ||
    pathCache.set(
      path,
      split(path).map(function(part) {
        return part.replace(CLEAN_QUOTES_REGEX, '$2')
      })
    )
  )
}

function split(path) {
  return path.match(SPLIT_REGEX)
}

function forEach(parts, iter, thisArg) {
  var len = parts.length,
    part,
    idx,
    isArray,
    isBracket;

  for (idx = 0; idx < len; idx++) {
    part = parts[idx];

    if (part) {
      if (shouldBeQuoted(part)) {
        part = '"' + part + '"';
      }

      isBracket = isQuoted(part);
      isArray = !isBracket && /^\d+$/.test(part);

      iter.call(thisArg, part, isBracket, isArray, idx, parts);
    }
  }
}

function isQuoted(str) {
  return (
    typeof str === 'string' && str && ["'", '"'].indexOf(str.charAt(0)) !== -1
  )
}

function hasLeadingNumber(part) {
  return part.match(LEAD_DIGIT_REGEX) && !part.match(DIGIT_REGEX)
}

function hasSpecialChars(part) {
  return SPEC_CHAR_REGEX.test(part)
}

function shouldBeQuoted(part) {
  return !isQuoted(part) && (hasLeadingNumber(part) || hasSpecialChars(part))
}
var propertyExpr_2 = propertyExpr.split;
var propertyExpr_5 = propertyExpr.getter;
var propertyExpr_7 = propertyExpr.forEach;

var prefixes = {
  context: '$',
  value: '.'
};

var Reference = /*#__PURE__*/function () {
  function Reference(key, options) {
    if (options === void 0) {
      options = {};
    }

    if (typeof key !== 'string') throw new TypeError('ref must be a string, got: ' + key);
    this.key = key.trim();
    if (key === '') throw new TypeError('ref must be a non-empty string');
    this.isContext = this.key[0] === prefixes.context;
    this.isValue = this.key[0] === prefixes.value;
    this.isSibling = !this.isContext && !this.isValue;
    var prefix = this.isContext ? prefixes.context : this.isValue ? prefixes.value : '';
    this.path = this.key.slice(prefix.length);
    this.getter = this.path && propertyExpr_5(this.path, true);
    this.map = options.map;
  }

  var _proto = Reference.prototype;

  _proto.getValue = function getValue(options) {
    var result = this.isContext ? options.context : this.isValue ? options.value : options.parent;
    if (this.getter) result = this.getter(result || {});
    if (this.map) result = this.map(result);
    return result;
  };

  _proto.cast = function cast(value, options) {
    return this.getValue(_extends({}, options, {
      value: value
    }));
  };

  _proto.resolve = function resolve() {
    return this;
  };

  _proto.describe = function describe() {
    return {
      type: 'ref',
      key: this.key
    };
  };

  _proto.toString = function toString() {
    return "Ref(" + this.key + ")";
  };

  Reference.isRef = function isRef(value) {
    return value && value.__isYupRef;
  };

  return Reference;
}();
Reference.prototype.__isYupRef = true;

var formatError = ValidationError.formatError;

var thenable = function thenable(p) {
  return p && typeof p.then === 'function' && typeof p.catch === 'function';
};

function runTest(testFn, ctx, value, sync) {
  var result = testFn.call(ctx, value);
  if (!sync) return Promise.resolve(result);

  if (thenable(result)) {
    throw new Error("Validation test of type: \"" + ctx.type + "\" returned a Promise during a synchronous validate. " + "This test will finish after the validate call has returned");
  }

  return synchronousPromise_1.resolve(result);
}

function resolveParams(oldParams, newParams, resolve) {
  return mapValues(_extends({}, oldParams, {}, newParams), resolve);
}

function createErrorFactory(_ref) {
  var value = _ref.value,
      label = _ref.label,
      resolve = _ref.resolve,
      originalValue = _ref.originalValue,
      opts = _objectWithoutPropertiesLoose(_ref, ["value", "label", "resolve", "originalValue"]);

  return function createError(_temp) {
    var _ref2 = _temp === void 0 ? {} : _temp,
        _ref2$path = _ref2.path,
        path = _ref2$path === void 0 ? opts.path : _ref2$path,
        _ref2$message = _ref2.message,
        message = _ref2$message === void 0 ? opts.message : _ref2$message,
        _ref2$type = _ref2.type,
        type = _ref2$type === void 0 ? opts.name : _ref2$type,
        params = _ref2.params;

    params = _extends({
      path: path,
      value: value,
      originalValue: originalValue,
      label: label
    }, resolveParams(opts.params, params, resolve));
    return _extends(new ValidationError(formatError(message, params), value, path, type), {
      params: params
    });
  };
}
function createValidation(options) {
  var name = options.name,
      message = options.message,
      test = options.test,
      params = options.params;

  function validate(_ref3) {
    var value = _ref3.value,
        path = _ref3.path,
        label = _ref3.label,
        options = _ref3.options,
        originalValue = _ref3.originalValue,
        sync = _ref3.sync,
        rest = _objectWithoutPropertiesLoose(_ref3, ["value", "path", "label", "options", "originalValue", "sync"]);

    var parent = options.parent;

    var resolve = function resolve(item) {
      return Reference.isRef(item) ? item.getValue({
        value: value,
        parent: parent,
        context: options.context
      }) : item;
    };

    var createError = createErrorFactory({
      message: message,
      path: path,
      value: value,
      originalValue: originalValue,
      params: params,
      label: label,
      resolve: resolve,
      name: name
    });

    var ctx = _extends({
      path: path,
      parent: parent,
      type: name,
      createError: createError,
      resolve: resolve,
      options: options
    }, rest);

    return runTest(test, ctx, value, sync).then(function (validOrError) {
      if (ValidationError.isError(validOrError)) throw validOrError;else if (!validOrError) throw createError();
    });
  }

  validate.OPTIONS = options;
  return validate;
}

var trim = function trim(part) {
  return part.substr(0, part.length - 1).substr(1);
};

function getIn(schema, path, value, context) {
  if (context === void 0) {
    context = value;
  }

  var parent, lastPart, lastPartDebug; // root path: ''

  if (!path) return {
    parent: parent,
    parentPath: path,
    schema: schema
  };
  propertyExpr_7(path, function (_part, isBracket, isArray) {
    var part = isBracket ? trim(_part) : _part;
    schema = schema.resolve({
      context: context,
      parent: parent,
      value: value
    });

    if (schema.innerType) {
      var idx = isArray ? parseInt(part, 10) : 0;

      if (value && idx >= value.length) {
        throw new Error("Yup.reach cannot resolve an array item at index: " + _part + ", in the path: " + path + ". " + "because there is no value at that index. ");
      }

      parent = value;
      value = value && value[idx];
      schema = schema.innerType;
    } // sometimes the array index part of a path doesn't exist: "nested.arr.child"
    // in these cases the current part is the next schema and should be processed
    // in this iteration. For cases where the index signature is included this
    // check will fail and we'll handle the `child` part on the next iteration like normal


    if (!isArray) {
      if (!schema.fields || !schema.fields[part]) throw new Error("The schema does not contain the path: " + path + ". " + ("(failed at: " + lastPartDebug + " which is a type: \"" + schema._type + "\")"));
      parent = value;
      value = value && value[part];
      schema = schema.fields[part];
    }

    lastPart = part;
    lastPartDebug = isBracket ? '[' + _part + ']' : '.' + _part;
  });
  return {
    schema: schema,
    parent: parent,
    parentPath: lastPart
  };
}

var reach = function reach(obj, path, value, context) {
  return getIn(obj, path, value, context).schema;
};

var RefSet = /*#__PURE__*/function () {
  function RefSet() {
    this.list = new Set();
    this.refs = new Map();
  }

  var _proto = RefSet.prototype;

  _proto.toArray = function toArray$1() {
    return toArray(this.list).concat(toArray(this.refs.values()));
  };

  _proto.add = function add(value) {
    Reference.isRef(value) ? this.refs.set(value.key, value) : this.list.add(value);
  };

  _proto.delete = function _delete(value) {
    Reference.isRef(value) ? this.refs.delete(value.key) : this.list.delete(value);
  };

  _proto.has = function has(value, resolve) {
    if (this.list.has(value)) return true;
    var item,
        values = this.refs.values();

    while (item = values.next(), !item.done) {
      if (resolve(item.value) === value) return true;
    }

    return false;
  };

  _proto.clone = function clone() {
    var next = new RefSet();
    next.list = new Set(this.list);
    next.refs = new Map(this.refs);
    return next;
  };

  _proto.merge = function merge(newItems, removeItems) {
    var next = this.clone();
    newItems.list.forEach(function (value) {
      return next.add(value);
    });
    newItems.refs.forEach(function (value) {
      return next.add(value);
    });
    removeItems.list.forEach(function (value) {
      return next.delete(value);
    });
    removeItems.refs.forEach(function (value) {
      return next.delete(value);
    });
    return next;
  };

  return RefSet;
}();

function SchemaType(options) {
  var _this = this;

  if (options === void 0) {
    options = {};
  }

  if (!(this instanceof SchemaType)) return new SchemaType();
  this._deps = [];
  this._conditions = [];
  this._options = {
    abortEarly: true,
    recursive: true
  };
  this._exclusive = Object.create(null);
  this._whitelist = new RefSet();
  this._blacklist = new RefSet();
  this.tests = [];
  this.transforms = [];
  this.withMutation(function () {
    _this.typeError(mixed.notType);
  });
  if (has(options, 'default')) this._defaultDefault = options.default;
  this.type = options.type || 'mixed'; // TODO: remove

  this._type = options.type || 'mixed';
}
var proto = SchemaType.prototype = {
  __isYupSchema__: true,
  constructor: SchemaType,
  clone: function clone() {
    var _this2 = this;

    if (this._mutate) return this; // if the nested value is a schema we can skip cloning, since
    // they are already immutable

    return cloneDeepWith(this, function (value) {
      if (isSchema(value) && value !== _this2) return value;
    });
  },
  label: function label(_label) {
    var next = this.clone();
    next._label = _label;
    return next;
  },
  meta: function meta(obj) {
    if (arguments.length === 0) return this._meta;
    var next = this.clone();
    next._meta = _extends(next._meta || {}, obj);
    return next;
  },
  withMutation: function withMutation(fn) {
    var before = this._mutate;
    this._mutate = true;
    var result = fn(this);
    this._mutate = before;
    return result;
  },
  concat: function concat(schema) {
    if (!schema || schema === this) return this;
    if (schema._type !== this._type && this._type !== 'mixed') throw new TypeError("You cannot `concat()` schema's of different types: " + this._type + " and " + schema._type);
    var next = prependDeep(schema.clone(), this); // new undefined default is overridden by old non-undefined one, revert

    if (has(schema, '_default')) next._default = schema._default;
    next.tests = this.tests;
    next._exclusive = this._exclusive; // manually merge the blacklist/whitelist (the other `schema` takes
    // precedence in case of conflicts)

    next._whitelist = this._whitelist.merge(schema._whitelist, schema._blacklist);
    next._blacklist = this._blacklist.merge(schema._blacklist, schema._whitelist); // manually add the new tests to ensure
    // the deduping logic is consistent

    next.withMutation(function (next) {
      schema.tests.forEach(function (fn) {
        next.test(fn.OPTIONS);
      });
    });
    return next;
  },
  isType: function isType(v) {
    if (this._nullable && v === null) return true;
    return !this._typeCheck || this._typeCheck(v);
  },
  resolve: function resolve(options) {
    var schema = this;

    if (schema._conditions.length) {
      var conditions = schema._conditions;
      schema = schema.clone();
      schema._conditions = [];
      schema = conditions.reduce(function (schema, condition) {
        return condition.resolve(schema, options);
      }, schema);
      schema = schema.resolve(options);
    }

    return schema;
  },
  cast: function cast(value, options) {
    if (options === void 0) {
      options = {};
    }

    var resolvedSchema = this.resolve(_extends({}, options, {
      value: value
    }));

    var result = resolvedSchema._cast(value, options);

    if (value !== undefined && options.assert !== false && resolvedSchema.isType(result) !== true) {
      var formattedValue = printValue(value);
      var formattedResult = printValue(result);
      throw new TypeError("The value of " + (options.path || 'field') + " could not be cast to a value " + ("that satisfies the schema type: \"" + resolvedSchema._type + "\". \n\n") + ("attempted value: " + formattedValue + " \n") + (formattedResult !== formattedValue ? "result of cast: " + formattedResult : ''));
    }

    return result;
  },
  _cast: function _cast(rawValue) {
    var _this3 = this;

    var value = rawValue === undefined ? rawValue : this.transforms.reduce(function (value, fn) {
      return fn.call(_this3, value, rawValue);
    }, rawValue);

    if (value === undefined && has(this, '_default')) {
      value = this.default();
    }

    return value;
  },
  _validate: function _validate(_value, options) {
    var _this4 = this;

    if (options === void 0) {
      options = {};
    }

    var value = _value;
    var originalValue = options.originalValue != null ? options.originalValue : _value;

    var isStrict = this._option('strict', options);

    var endEarly = this._option('abortEarly', options);

    var sync = options.sync;
    var path = options.path;
    var label = this._label;

    if (!isStrict) {
      value = this._cast(value, _extends({
        assert: false
      }, options));
    } // value is cast, we can check if it meets type requirements


    var validationParams = {
      value: value,
      path: path,
      schema: this,
      options: options,
      label: label,
      originalValue: originalValue,
      sync: sync
    };
    var initialTests = [];
    if (this._typeError) initialTests.push(this._typeError(validationParams));
    if (this._whitelistError) initialTests.push(this._whitelistError(validationParams));
    if (this._blacklistError) initialTests.push(this._blacklistError(validationParams));
    return runValidations({
      validations: initialTests,
      endEarly: endEarly,
      value: value,
      path: path,
      sync: sync
    }).then(function (value) {
      return runValidations({
        path: path,
        sync: sync,
        value: value,
        endEarly: endEarly,
        validations: _this4.tests.map(function (fn) {
          return fn(validationParams);
        })
      });
    });
  },
  validate: function validate(value, options) {
    if (options === void 0) {
      options = {};
    }

    var schema = this.resolve(_extends({}, options, {
      value: value
    }));
    return schema._validate(value, options);
  },
  validateSync: function validateSync(value, options) {
    if (options === void 0) {
      options = {};
    }

    var schema = this.resolve(_extends({}, options, {
      value: value
    }));
    var result, err;

    schema._validate(value, _extends({}, options, {
      sync: true
    })).then(function (r) {
      return result = r;
    }).catch(function (e) {
      return err = e;
    });

    if (err) throw err;
    return result;
  },
  isValid: function isValid(value, options) {
    return this.validate(value, options).then(function () {
      return true;
    }).catch(function (err) {
      if (err.name === 'ValidationError') return false;
      throw err;
    });
  },
  isValidSync: function isValidSync(value, options) {
    try {
      this.validateSync(value, options);
      return true;
    } catch (err) {
      if (err.name === 'ValidationError') return false;
      throw err;
    }
  },
  getDefault: function getDefault(options) {
    if (options === void 0) {
      options = {};
    }

    var schema = this.resolve(options);
    return schema.default();
  },
  default: function _default(def) {
    if (arguments.length === 0) {
      var defaultValue = has(this, '_default') ? this._default : this._defaultDefault;
      return typeof defaultValue === 'function' ? defaultValue.call(this) : cloneDeepWith(defaultValue);
    }

    var next = this.clone();
    next._default = def;
    return next;
  },
  strict: function strict(isStrict) {
    if (isStrict === void 0) {
      isStrict = true;
    }

    var next = this.clone();
    next._options.strict = isStrict;
    return next;
  },
  _isPresent: function _isPresent(value) {
    return value != null;
  },
  required: function required(message) {
    if (message === void 0) {
      message = mixed.required;
    }

    return this.test({
      message: message,
      name: 'required',
      exclusive: true,
      test: function test(value) {
        return this.schema._isPresent(value);
      }
    });
  },
  notRequired: function notRequired() {
    var next = this.clone();
    next.tests = next.tests.filter(function (test) {
      return test.OPTIONS.name !== 'required';
    });
    return next;
  },
  nullable: function nullable(isNullable) {
    if (isNullable === void 0) {
      isNullable = true;
    }

    var next = this.clone();
    next._nullable = isNullable;
    return next;
  },
  transform: function transform(fn) {
    var next = this.clone();
    next.transforms.push(fn);
    return next;
  },

  /**
   * Adds a test function to the schema's queue of tests.
   * tests can be exclusive or non-exclusive.
   *
   * - exclusive tests, will replace any existing tests of the same name.
   * - non-exclusive: can be stacked
   *
   * If a non-exclusive test is added to a schema with an exclusive test of the same name
   * the exclusive test is removed and further tests of the same name will be stacked.
   *
   * If an exclusive test is added to a schema with non-exclusive tests of the same name
   * the previous tests are removed and further tests of the same name will replace each other.
   */
  test: function test() {
    var opts;

    if (arguments.length === 1) {
      if (typeof (arguments.length <= 0 ? undefined : arguments[0]) === 'function') {
        opts = {
          test: arguments.length <= 0 ? undefined : arguments[0]
        };
      } else {
        opts = arguments.length <= 0 ? undefined : arguments[0];
      }
    } else if (arguments.length === 2) {
      opts = {
        name: arguments.length <= 0 ? undefined : arguments[0],
        test: arguments.length <= 1 ? undefined : arguments[1]
      };
    } else {
      opts = {
        name: arguments.length <= 0 ? undefined : arguments[0],
        message: arguments.length <= 1 ? undefined : arguments[1],
        test: arguments.length <= 2 ? undefined : arguments[2]
      };
    }

    if (opts.message === undefined) opts.message = mixed.default;
    if (typeof opts.test !== 'function') throw new TypeError('`test` is a required parameters');
    var next = this.clone();
    var validate = createValidation(opts);
    var isExclusive = opts.exclusive || opts.name && next._exclusive[opts.name] === true;

    if (opts.exclusive && !opts.name) {
      throw new TypeError('Exclusive tests must provide a unique `name` identifying the test');
    }

    next._exclusive[opts.name] = !!opts.exclusive;
    next.tests = next.tests.filter(function (fn) {
      if (fn.OPTIONS.name === opts.name) {
        if (isExclusive) return false;
        if (fn.OPTIONS.test === validate.OPTIONS.test) return false;
      }

      return true;
    });
    next.tests.push(validate);
    return next;
  },
  when: function when(keys, options) {
    if (arguments.length === 1) {
      options = keys;
      keys = '.';
    }

    var next = this.clone(),
        deps = [].concat(keys).map(function (key) {
      return new Reference(key);
    });
    deps.forEach(function (dep) {
      if (dep.isSibling) next._deps.push(dep.key);
    });

    next._conditions.push(new Condition(deps, options));

    return next;
  },
  typeError: function typeError(message) {
    var next = this.clone();
    next._typeError = createValidation({
      message: message,
      name: 'typeError',
      test: function test(value) {
        if (value !== undefined && !this.schema.isType(value)) return this.createError({
          params: {
            type: this.schema._type
          }
        });
        return true;
      }
    });
    return next;
  },
  oneOf: function oneOf(enums, message) {
    if (message === void 0) {
      message = mixed.oneOf;
    }

    var next = this.clone();
    enums.forEach(function (val) {
      next._whitelist.add(val);

      next._blacklist.delete(val);
    });
    next._whitelistError = createValidation({
      message: message,
      name: 'oneOf',
      test: function test(value) {
        if (value === undefined) return true;
        var valids = this.schema._whitelist;
        return valids.has(value, this.resolve) ? true : this.createError({
          params: {
            values: valids.toArray().join(', ')
          }
        });
      }
    });
    return next;
  },
  notOneOf: function notOneOf(enums, message) {
    if (message === void 0) {
      message = mixed.notOneOf;
    }

    var next = this.clone();
    enums.forEach(function (val) {
      next._blacklist.add(val);

      next._whitelist.delete(val);
    });
    next._blacklistError = createValidation({
      message: message,
      name: 'notOneOf',
      test: function test(value) {
        var invalids = this.schema._blacklist;
        if (invalids.has(value, this.resolve)) return this.createError({
          params: {
            values: invalids.toArray().join(', ')
          }
        });
        return true;
      }
    });
    return next;
  },
  strip: function strip(_strip) {
    if (_strip === void 0) {
      _strip = true;
    }

    var next = this.clone();
    next._strip = _strip;
    return next;
  },
  _option: function _option(key, overrides) {
    return has(overrides, key) ? overrides[key] : this._options[key];
  },
  describe: function describe() {
    var next = this.clone();
    return {
      type: next._type,
      meta: next._meta,
      label: next._label,
      tests: next.tests.map(function (fn) {
        return {
          name: fn.OPTIONS.name,
          params: fn.OPTIONS.params
        };
      }).filter(function (n, idx, list) {
        return list.findIndex(function (c) {
          return c.name === n.name;
        }) === idx;
      })
    };
  },
  defined: function defined(message) {
    if (message === void 0) {
      message = mixed.defined;
    }

    return this.nullable().test({
      message: message,
      name: 'defined',
      exclusive: true,
      test: function test(value) {
        return value !== undefined;
      }
    });
  }
};

var _loop = function _loop() {
  var method = _arr[_i];

  proto[method + "At"] = function (path, value, options) {
    if (options === void 0) {
      options = {};
    }

    var _getIn = getIn(this, path, value, options.context),
        parent = _getIn.parent,
        parentPath = _getIn.parentPath,
        schema = _getIn.schema;

    return schema[method](parent && parent[parentPath], _extends({}, options, {
      parent: parent,
      path: path
    }));
  };
};

for (var _i = 0, _arr = ['validate', 'validateSync']; _i < _arr.length; _i++) {
  _loop();
}

for (var _i2 = 0, _arr2 = ['equals', 'is']; _i2 < _arr2.length; _i2++) {
  var alias = _arr2[_i2];
  proto[alias] = proto.oneOf;
}

for (var _i3 = 0, _arr3 = ['not', 'nope']; _i3 < _arr3.length; _i3++) {
  var _alias = _arr3[_i3];
  proto[_alias] = proto.notOneOf;
}

proto.optional = proto.notRequired;

function inherits(ctor, superCtor, spec) {
  ctor.prototype = Object.create(superCtor.prototype, {
    constructor: {
      value: ctor,
      enumerable: false,
      writable: true,
      configurable: true
    }
  });

  _extends(ctor.prototype, spec);
}

function BooleanSchema() {
  var _this = this;

  if (!(this instanceof BooleanSchema)) return new BooleanSchema();
  SchemaType.call(this, {
    type: 'boolean'
  });
  this.withMutation(function () {
    _this.transform(function (value) {
      if (!this.isType(value)) {
        if (/^(true|1)$/i.test(value)) return true;
        if (/^(false|0)$/i.test(value)) return false;
      }

      return value;
    });
  });
}

inherits(BooleanSchema, SchemaType, {
  _typeCheck: function _typeCheck(v) {
    if (v instanceof Boolean) v = v.valueOf();
    return typeof v === 'boolean';
  }
});

var isAbsent = (function (value) {
  return value == null;
});

var rEmail = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i; // eslint-disable-next-line

var rUrl = /^((https?|ftp):)?\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i;

var isTrimmed = function isTrimmed(value) {
  return isAbsent(value) || value === value.trim();
};

function StringSchema() {
  var _this = this;

  if (!(this instanceof StringSchema)) return new StringSchema();
  SchemaType.call(this, {
    type: 'string'
  });
  this.withMutation(function () {
    _this.transform(function (value) {
      if (this.isType(value)) return value;
      return value != null && value.toString ? value.toString() : value;
    });
  });
}
inherits(StringSchema, SchemaType, {
  _typeCheck: function _typeCheck(value) {
    if (value instanceof String) value = value.valueOf();
    return typeof value === 'string';
  },
  _isPresent: function _isPresent(value) {
    return SchemaType.prototype._cast.call(this, value) && value.length > 0;
  },
  length: function length(_length, message) {
    if (message === void 0) {
      message = string.length;
    }

    return this.test({
      message: message,
      name: 'length',
      exclusive: true,
      params: {
        length: _length
      },
      test: function test(value) {
        return isAbsent(value) || value.length === this.resolve(_length);
      }
    });
  },
  min: function min(_min, message) {
    if (message === void 0) {
      message = string.min;
    }

    return this.test({
      message: message,
      name: 'min',
      exclusive: true,
      params: {
        min: _min
      },
      test: function test(value) {
        return isAbsent(value) || value.length >= this.resolve(_min);
      }
    });
  },
  max: function max(_max, message) {
    if (message === void 0) {
      message = string.max;
    }

    return this.test({
      name: 'max',
      exclusive: true,
      message: message,
      params: {
        max: _max
      },
      test: function test(value) {
        return isAbsent(value) || value.length <= this.resolve(_max);
      }
    });
  },
  matches: function matches(regex, options) {
    var excludeEmptyString = false;
    var message;
    var name;

    if (options) {
      if (typeof options === 'string') message = options;

      if (typeof options === 'object') {
        excludeEmptyString = options.excludeEmptyString;
        message = options.message;
        name = options.name;
      }
    }

    return this.test({
      name: name || 'matches',
      message: message || string.matches,
      params: {
        regex: regex
      },
      test: function test(value) {
        return isAbsent(value) || value === '' && excludeEmptyString || value.search(regex) !== -1;
      }
    });
  },
  email: function email(message) {
    if (message === void 0) {
      message = string.email;
    }

    return this.matches(rEmail, {
      name: 'email',
      message: message,
      excludeEmptyString: true
    });
  },
  url: function url(message) {
    if (message === void 0) {
      message = string.url;
    }

    return this.matches(rUrl, {
      name: 'url',
      message: message,
      excludeEmptyString: true
    });
  },
  //-- transforms --
  ensure: function ensure() {
    return this.default('').transform(function (val) {
      return val === null ? '' : val;
    });
  },
  trim: function trim(message) {
    if (message === void 0) {
      message = string.trim;
    }

    return this.transform(function (val) {
      return val != null ? val.trim() : val;
    }).test({
      message: message,
      name: 'trim',
      test: isTrimmed
    });
  },
  lowercase: function lowercase(message) {
    if (message === void 0) {
      message = string.lowercase;
    }

    return this.transform(function (value) {
      return !isAbsent(value) ? value.toLowerCase() : value;
    }).test({
      message: message,
      name: 'string_case',
      exclusive: true,
      test: function test(value) {
        return isAbsent(value) || value === value.toLowerCase();
      }
    });
  },
  uppercase: function uppercase(message) {
    if (message === void 0) {
      message = string.uppercase;
    }

    return this.transform(function (value) {
      return !isAbsent(value) ? value.toUpperCase() : value;
    }).test({
      message: message,
      name: 'string_case',
      exclusive: true,
      test: function test(value) {
        return isAbsent(value) || value === value.toUpperCase();
      }
    });
  }
});

var isNaN$1 = function isNaN(value) {
  return value != +value;
};

function NumberSchema() {
  var _this = this;

  if (!(this instanceof NumberSchema)) return new NumberSchema();
  SchemaType.call(this, {
    type: 'number'
  });
  this.withMutation(function () {
    _this.transform(function (value) {
      var parsed = value;

      if (typeof parsed === 'string') {
        parsed = parsed.replace(/\s/g, '');
        if (parsed === '') return NaN; // don't use parseFloat to avoid positives on alpha-numeric strings

        parsed = +parsed;
      }

      if (this.isType(parsed)) return parsed;
      return parseFloat(parsed);
    });
  });
}
inherits(NumberSchema, SchemaType, {
  _typeCheck: function _typeCheck(value) {
    if (value instanceof Number) value = value.valueOf();
    return typeof value === 'number' && !isNaN$1(value);
  },
  min: function min(_min, message) {
    if (message === void 0) {
      message = number.min;
    }

    return this.test({
      message: message,
      name: 'min',
      exclusive: true,
      params: {
        min: _min
      },
      test: function test(value) {
        return isAbsent(value) || value >= this.resolve(_min);
      }
    });
  },
  max: function max(_max, message) {
    if (message === void 0) {
      message = number.max;
    }

    return this.test({
      message: message,
      name: 'max',
      exclusive: true,
      params: {
        max: _max
      },
      test: function test(value) {
        return isAbsent(value) || value <= this.resolve(_max);
      }
    });
  },
  lessThan: function lessThan(less, message) {
    if (message === void 0) {
      message = number.lessThan;
    }

    return this.test({
      message: message,
      name: 'max',
      exclusive: true,
      params: {
        less: less
      },
      test: function test(value) {
        return isAbsent(value) || value < this.resolve(less);
      }
    });
  },
  moreThan: function moreThan(more, message) {
    if (message === void 0) {
      message = number.moreThan;
    }

    return this.test({
      message: message,
      name: 'min',
      exclusive: true,
      params: {
        more: more
      },
      test: function test(value) {
        return isAbsent(value) || value > this.resolve(more);
      }
    });
  },
  positive: function positive(msg) {
    if (msg === void 0) {
      msg = number.positive;
    }

    return this.moreThan(0, msg);
  },
  negative: function negative(msg) {
    if (msg === void 0) {
      msg = number.negative;
    }

    return this.lessThan(0, msg);
  },
  integer: function integer(message) {
    if (message === void 0) {
      message = number.integer;
    }

    return this.test({
      name: 'integer',
      message: message,
      test: function test(val) {
        return isAbsent(val) || Number.isInteger(val);
      }
    });
  },
  truncate: function truncate() {
    return this.transform(function (value) {
      return !isAbsent(value) ? value | 0 : value;
    });
  },
  round: function round(method) {
    var avail = ['ceil', 'floor', 'round', 'trunc'];
    method = method && method.toLowerCase() || 'round'; // this exists for symemtry with the new Math.trunc

    if (method === 'trunc') return this.truncate();
    if (avail.indexOf(method.toLowerCase()) === -1) throw new TypeError('Only valid options for round() are: ' + avail.join(', '));
    return this.transform(function (value) {
      return !isAbsent(value) ? Math[method](value) : value;
    });
  }
});

/* eslint-disable */

/**
 *
 * Date.parse with progressive enhancement for ISO 8601 <https://github.com/csnover/js-iso8601>
 * NON-CONFORMANT EDITION.
 * © 2011 Colin Snover <http://zetafleet.com>
 * Released under MIT license.
 */
//              1 YYYY                 2 MM        3 DD              4 HH     5 mm        6 ss            7 msec         8 Z 9 ±    10 tzHH    11 tzmm
var isoReg = /^(\d{4}|[+\-]\d{6})(?:-?(\d{2})(?:-?(\d{2}))?)?(?:[ T]?(\d{2}):?(\d{2})(?::?(\d{2})(?:[,\.](\d{1,}))?)?(?:(Z)|([+\-])(\d{2})(?::?(\d{2}))?)?)?$/;
function parseIsoDate(date) {
  var numericKeys = [1, 4, 5, 6, 7, 10, 11],
      minutesOffset = 0,
      timestamp,
      struct;

  if (struct = isoReg.exec(date)) {
    // avoid NaN timestamps caused by “undefined” values being passed to Date.UTC
    for (var i = 0, k; k = numericKeys[i]; ++i) {
      struct[k] = +struct[k] || 0;
    } // allow undefined days and months


    struct[2] = (+struct[2] || 1) - 1;
    struct[3] = +struct[3] || 1; // allow arbitrary sub-second precision beyond milliseconds

    struct[7] = struct[7] ? String(struct[7]).substr(0, 3) : 0; // timestamps without timezone identifiers should be considered local time

    if ((struct[8] === undefined || struct[8] === '') && (struct[9] === undefined || struct[9] === '')) timestamp = +new Date(struct[1], struct[2], struct[3], struct[4], struct[5], struct[6], struct[7]);else {
      if (struct[8] !== 'Z' && struct[9] !== undefined) {
        minutesOffset = struct[10] * 60 + struct[11];
        if (struct[9] === '+') minutesOffset = 0 - minutesOffset;
      }

      timestamp = Date.UTC(struct[1], struct[2], struct[3], struct[4], struct[5] + minutesOffset, struct[6], struct[7]);
    }
  } else timestamp = Date.parse ? Date.parse(date) : NaN;

  return timestamp;
}

var invalidDate = new Date('');

var isDate = function isDate(obj) {
  return Object.prototype.toString.call(obj) === '[object Date]';
};

function DateSchema() {
  var _this = this;

  if (!(this instanceof DateSchema)) return new DateSchema();
  SchemaType.call(this, {
    type: 'date'
  });
  this.withMutation(function () {
    _this.transform(function (value) {
      if (this.isType(value)) return value;
      value = parseIsoDate(value); // 0 is a valid timestamp equivalent to 1970-01-01T00:00:00Z(unix epoch) or before.

      return !isNaN(value) ? new Date(value) : invalidDate;
    });
  });
}

inherits(DateSchema, SchemaType, {
  _typeCheck: function _typeCheck(v) {
    return isDate(v) && !isNaN(v.getTime());
  },
  min: function min(_min, message) {
    if (message === void 0) {
      message = date.min;
    }

    var limit = _min;

    if (!Reference.isRef(limit)) {
      limit = this.cast(_min);
      if (!this._typeCheck(limit)) throw new TypeError('`min` must be a Date or a value that can be `cast()` to a Date');
    }

    return this.test({
      message: message,
      name: 'min',
      exclusive: true,
      params: {
        min: _min
      },
      test: function test(value) {
        return isAbsent(value) || value >= this.resolve(limit);
      }
    });
  },
  max: function max(_max, message) {
    if (message === void 0) {
      message = date.max;
    }

    var limit = _max;

    if (!Reference.isRef(limit)) {
      limit = this.cast(_max);
      if (!this._typeCheck(limit)) throw new TypeError('`max` must be a Date or a value that can be `cast()` to a Date');
    }

    return this.test({
      message: message,
      name: 'max',
      exclusive: true,
      params: {
        max: _max
      },
      test: function test(value) {
        return isAbsent(value) || value <= this.resolve(limit);
      }
    });
  }
});

function _taggedTemplateLiteralLoose(strings, raw) {
  if (!raw) {
    raw = strings.slice(0);
  }

  strings.raw = raw;
  return strings;
}

/**
 * A specialized version of `_.reduce` for arrays without support for
 * iteratee shorthands.
 *
 * @private
 * @param {Array} [array] The array to iterate over.
 * @param {Function} iteratee The function invoked per iteration.
 * @param {*} [accumulator] The initial value.
 * @param {boolean} [initAccum] Specify using the first element of `array` as
 *  the initial value.
 * @returns {*} Returns the accumulated value.
 */
function arrayReduce(array, iteratee, accumulator, initAccum) {
  var index = -1,
      length = array == null ? 0 : array.length;

  if (initAccum && length) {
    accumulator = array[++index];
  }
  while (++index < length) {
    accumulator = iteratee(accumulator, array[index], index, array);
  }
  return accumulator;
}

/**
 * The base implementation of `_.propertyOf` without support for deep paths.
 *
 * @private
 * @param {Object} object The object to query.
 * @returns {Function} Returns the new accessor function.
 */
function basePropertyOf(object) {
  return function(key) {
    return object == null ? undefined : object[key];
  };
}

/** Used to map Latin Unicode letters to basic Latin letters. */
var deburredLetters = {
  // Latin-1 Supplement block.
  '\xc0': 'A',  '\xc1': 'A', '\xc2': 'A', '\xc3': 'A', '\xc4': 'A', '\xc5': 'A',
  '\xe0': 'a',  '\xe1': 'a', '\xe2': 'a', '\xe3': 'a', '\xe4': 'a', '\xe5': 'a',
  '\xc7': 'C',  '\xe7': 'c',
  '\xd0': 'D',  '\xf0': 'd',
  '\xc8': 'E',  '\xc9': 'E', '\xca': 'E', '\xcb': 'E',
  '\xe8': 'e',  '\xe9': 'e', '\xea': 'e', '\xeb': 'e',
  '\xcc': 'I',  '\xcd': 'I', '\xce': 'I', '\xcf': 'I',
  '\xec': 'i',  '\xed': 'i', '\xee': 'i', '\xef': 'i',
  '\xd1': 'N',  '\xf1': 'n',
  '\xd2': 'O',  '\xd3': 'O', '\xd4': 'O', '\xd5': 'O', '\xd6': 'O', '\xd8': 'O',
  '\xf2': 'o',  '\xf3': 'o', '\xf4': 'o', '\xf5': 'o', '\xf6': 'o', '\xf8': 'o',
  '\xd9': 'U',  '\xda': 'U', '\xdb': 'U', '\xdc': 'U',
  '\xf9': 'u',  '\xfa': 'u', '\xfb': 'u', '\xfc': 'u',
  '\xdd': 'Y',  '\xfd': 'y', '\xff': 'y',
  '\xc6': 'Ae', '\xe6': 'ae',
  '\xde': 'Th', '\xfe': 'th',
  '\xdf': 'ss',
  // Latin Extended-A block.
  '\u0100': 'A',  '\u0102': 'A', '\u0104': 'A',
  '\u0101': 'a',  '\u0103': 'a', '\u0105': 'a',
  '\u0106': 'C',  '\u0108': 'C', '\u010a': 'C', '\u010c': 'C',
  '\u0107': 'c',  '\u0109': 'c', '\u010b': 'c', '\u010d': 'c',
  '\u010e': 'D',  '\u0110': 'D', '\u010f': 'd', '\u0111': 'd',
  '\u0112': 'E',  '\u0114': 'E', '\u0116': 'E', '\u0118': 'E', '\u011a': 'E',
  '\u0113': 'e',  '\u0115': 'e', '\u0117': 'e', '\u0119': 'e', '\u011b': 'e',
  '\u011c': 'G',  '\u011e': 'G', '\u0120': 'G', '\u0122': 'G',
  '\u011d': 'g',  '\u011f': 'g', '\u0121': 'g', '\u0123': 'g',
  '\u0124': 'H',  '\u0126': 'H', '\u0125': 'h', '\u0127': 'h',
  '\u0128': 'I',  '\u012a': 'I', '\u012c': 'I', '\u012e': 'I', '\u0130': 'I',
  '\u0129': 'i',  '\u012b': 'i', '\u012d': 'i', '\u012f': 'i', '\u0131': 'i',
  '\u0134': 'J',  '\u0135': 'j',
  '\u0136': 'K',  '\u0137': 'k', '\u0138': 'k',
  '\u0139': 'L',  '\u013b': 'L', '\u013d': 'L', '\u013f': 'L', '\u0141': 'L',
  '\u013a': 'l',  '\u013c': 'l', '\u013e': 'l', '\u0140': 'l', '\u0142': 'l',
  '\u0143': 'N',  '\u0145': 'N', '\u0147': 'N', '\u014a': 'N',
  '\u0144': 'n',  '\u0146': 'n', '\u0148': 'n', '\u014b': 'n',
  '\u014c': 'O',  '\u014e': 'O', '\u0150': 'O',
  '\u014d': 'o',  '\u014f': 'o', '\u0151': 'o',
  '\u0154': 'R',  '\u0156': 'R', '\u0158': 'R',
  '\u0155': 'r',  '\u0157': 'r', '\u0159': 'r',
  '\u015a': 'S',  '\u015c': 'S', '\u015e': 'S', '\u0160': 'S',
  '\u015b': 's',  '\u015d': 's', '\u015f': 's', '\u0161': 's',
  '\u0162': 'T',  '\u0164': 'T', '\u0166': 'T',
  '\u0163': 't',  '\u0165': 't', '\u0167': 't',
  '\u0168': 'U',  '\u016a': 'U', '\u016c': 'U', '\u016e': 'U', '\u0170': 'U', '\u0172': 'U',
  '\u0169': 'u',  '\u016b': 'u', '\u016d': 'u', '\u016f': 'u', '\u0171': 'u', '\u0173': 'u',
  '\u0174': 'W',  '\u0175': 'w',
  '\u0176': 'Y',  '\u0177': 'y', '\u0178': 'Y',
  '\u0179': 'Z',  '\u017b': 'Z', '\u017d': 'Z',
  '\u017a': 'z',  '\u017c': 'z', '\u017e': 'z',
  '\u0132': 'IJ', '\u0133': 'ij',
  '\u0152': 'Oe', '\u0153': 'oe',
  '\u0149': "'n", '\u017f': 's'
};

/**
 * Used by `_.deburr` to convert Latin-1 Supplement and Latin Extended-A
 * letters to basic Latin letters.
 *
 * @private
 * @param {string} letter The matched letter to deburr.
 * @returns {string} Returns the deburred letter.
 */
var deburrLetter = basePropertyOf(deburredLetters);

/** Used to match Latin Unicode letters (excluding mathematical operators). */
var reLatin = /[\xc0-\xd6\xd8-\xf6\xf8-\xff\u0100-\u017f]/g;

/** Used to compose unicode character classes. */
var rsComboMarksRange$2 = '\\u0300-\\u036f',
    reComboHalfMarksRange$2 = '\\ufe20-\\ufe2f',
    rsComboSymbolsRange$2 = '\\u20d0-\\u20ff',
    rsComboRange$2 = rsComboMarksRange$2 + reComboHalfMarksRange$2 + rsComboSymbolsRange$2;

/** Used to compose unicode capture groups. */
var rsCombo$1 = '[' + rsComboRange$2 + ']';

/**
 * Used to match [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks) and
 * [combining diacritical marks for symbols](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols).
 */
var reComboMark = RegExp(rsCombo$1, 'g');

/**
 * Deburrs `string` by converting
 * [Latin-1 Supplement](https://en.wikipedia.org/wiki/Latin-1_Supplement_(Unicode_block)#Character_table)
 * and [Latin Extended-A](https://en.wikipedia.org/wiki/Latin_Extended-A)
 * letters to basic Latin letters and removing
 * [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks).
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category String
 * @param {string} [string=''] The string to deburr.
 * @returns {string} Returns the deburred string.
 * @example
 *
 * _.deburr('déjà vu');
 * // => 'deja vu'
 */
function deburr(string) {
  string = toString(string);
  return string && string.replace(reLatin, deburrLetter).replace(reComboMark, '');
}

/** Used to match words composed of alphanumeric characters. */
var reAsciiWord = /[^\x00-\x2f\x3a-\x40\x5b-\x60\x7b-\x7f]+/g;

/**
 * Splits an ASCII `string` into an array of its words.
 *
 * @private
 * @param {string} The string to inspect.
 * @returns {Array} Returns the words of `string`.
 */
function asciiWords(string) {
  return string.match(reAsciiWord) || [];
}

/** Used to detect strings that need a more robust regexp to match words. */
var reHasUnicodeWord = /[a-z][A-Z]|[A-Z]{2}[a-z]|[0-9][a-zA-Z]|[a-zA-Z][0-9]|[^a-zA-Z0-9 ]/;

/**
 * Checks if `string` contains a word composed of Unicode symbols.
 *
 * @private
 * @param {string} string The string to inspect.
 * @returns {boolean} Returns `true` if a word is found, else `false`.
 */
function hasUnicodeWord(string) {
  return reHasUnicodeWord.test(string);
}

/** Used to compose unicode character classes. */
var rsAstralRange$2 = '\\ud800-\\udfff',
    rsComboMarksRange$3 = '\\u0300-\\u036f',
    reComboHalfMarksRange$3 = '\\ufe20-\\ufe2f',
    rsComboSymbolsRange$3 = '\\u20d0-\\u20ff',
    rsComboRange$3 = rsComboMarksRange$3 + reComboHalfMarksRange$3 + rsComboSymbolsRange$3,
    rsDingbatRange = '\\u2700-\\u27bf',
    rsLowerRange = 'a-z\\xdf-\\xf6\\xf8-\\xff',
    rsMathOpRange = '\\xac\\xb1\\xd7\\xf7',
    rsNonCharRange = '\\x00-\\x2f\\x3a-\\x40\\x5b-\\x60\\x7b-\\xbf',
    rsPunctuationRange = '\\u2000-\\u206f',
    rsSpaceRange = ' \\t\\x0b\\f\\xa0\\ufeff\\n\\r\\u2028\\u2029\\u1680\\u180e\\u2000\\u2001\\u2002\\u2003\\u2004\\u2005\\u2006\\u2007\\u2008\\u2009\\u200a\\u202f\\u205f\\u3000',
    rsUpperRange = 'A-Z\\xc0-\\xd6\\xd8-\\xde',
    rsVarRange$2 = '\\ufe0e\\ufe0f',
    rsBreakRange = rsMathOpRange + rsNonCharRange + rsPunctuationRange + rsSpaceRange;

/** Used to compose unicode capture groups. */
var rsApos = "['\u2019]",
    rsBreak = '[' + rsBreakRange + ']',
    rsCombo$2 = '[' + rsComboRange$3 + ']',
    rsDigits = '\\d+',
    rsDingbat = '[' + rsDingbatRange + ']',
    rsLower = '[' + rsLowerRange + ']',
    rsMisc = '[^' + rsAstralRange$2 + rsBreakRange + rsDigits + rsDingbatRange + rsLowerRange + rsUpperRange + ']',
    rsFitz$1 = '\\ud83c[\\udffb-\\udfff]',
    rsModifier$1 = '(?:' + rsCombo$2 + '|' + rsFitz$1 + ')',
    rsNonAstral$1 = '[^' + rsAstralRange$2 + ']',
    rsRegional$1 = '(?:\\ud83c[\\udde6-\\uddff]){2}',
    rsSurrPair$1 = '[\\ud800-\\udbff][\\udc00-\\udfff]',
    rsUpper = '[' + rsUpperRange + ']',
    rsZWJ$2 = '\\u200d';

/** Used to compose unicode regexes. */
var rsMiscLower = '(?:' + rsLower + '|' + rsMisc + ')',
    rsMiscUpper = '(?:' + rsUpper + '|' + rsMisc + ')',
    rsOptContrLower = '(?:' + rsApos + '(?:d|ll|m|re|s|t|ve))?',
    rsOptContrUpper = '(?:' + rsApos + '(?:D|LL|M|RE|S|T|VE))?',
    reOptMod$1 = rsModifier$1 + '?',
    rsOptVar$1 = '[' + rsVarRange$2 + ']?',
    rsOptJoin$1 = '(?:' + rsZWJ$2 + '(?:' + [rsNonAstral$1, rsRegional$1, rsSurrPair$1].join('|') + ')' + rsOptVar$1 + reOptMod$1 + ')*',
    rsOrdLower = '\\d*(?:1st|2nd|3rd|(?![123])\\dth)(?=\\b|[A-Z_])',
    rsOrdUpper = '\\d*(?:1ST|2ND|3RD|(?![123])\\dTH)(?=\\b|[a-z_])',
    rsSeq$1 = rsOptVar$1 + reOptMod$1 + rsOptJoin$1,
    rsEmoji = '(?:' + [rsDingbat, rsRegional$1, rsSurrPair$1].join('|') + ')' + rsSeq$1;

/** Used to match complex or compound words. */
var reUnicodeWord = RegExp([
  rsUpper + '?' + rsLower + '+' + rsOptContrLower + '(?=' + [rsBreak, rsUpper, '$'].join('|') + ')',
  rsMiscUpper + '+' + rsOptContrUpper + '(?=' + [rsBreak, rsUpper + rsMiscLower, '$'].join('|') + ')',
  rsUpper + '?' + rsMiscLower + '+' + rsOptContrLower,
  rsUpper + '+' + rsOptContrUpper,
  rsOrdUpper,
  rsOrdLower,
  rsDigits,
  rsEmoji
].join('|'), 'g');

/**
 * Splits a Unicode `string` into an array of its words.
 *
 * @private
 * @param {string} The string to inspect.
 * @returns {Array} Returns the words of `string`.
 */
function unicodeWords(string) {
  return string.match(reUnicodeWord) || [];
}

/**
 * Splits `string` into an array of its words.
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category String
 * @param {string} [string=''] The string to inspect.
 * @param {RegExp|string} [pattern] The pattern to match words.
 * @param- {Object} [guard] Enables use as an iteratee for methods like `_.map`.
 * @returns {Array} Returns the words of `string`.
 * @example
 *
 * _.words('fred, barney, & pebbles');
 * // => ['fred', 'barney', 'pebbles']
 *
 * _.words('fred, barney, & pebbles', /[^, ]+/g);
 * // => ['fred', 'barney', '&', 'pebbles']
 */
function words(string, pattern, guard) {
  string = toString(string);
  pattern = guard ? undefined : pattern;

  if (pattern === undefined) {
    return hasUnicodeWord(string) ? unicodeWords(string) : asciiWords(string);
  }
  return string.match(pattern) || [];
}

/** Used to compose unicode capture groups. */
var rsApos$1 = "['\u2019]";

/** Used to match apostrophes. */
var reApos = RegExp(rsApos$1, 'g');

/**
 * Creates a function like `_.camelCase`.
 *
 * @private
 * @param {Function} callback The function to combine each word.
 * @returns {Function} Returns the new compounder function.
 */
function createCompounder(callback) {
  return function(string) {
    return arrayReduce(words(deburr(string).replace(reApos, '')), callback, '');
  };
}

/**
 * Converts `string` to
 * [snake case](https://en.wikipedia.org/wiki/Snake_case).
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category String
 * @param {string} [string=''] The string to convert.
 * @returns {string} Returns the snake cased string.
 * @example
 *
 * _.snakeCase('Foo Bar');
 * // => 'foo_bar'
 *
 * _.snakeCase('fooBar');
 * // => 'foo_bar'
 *
 * _.snakeCase('--FOO-BAR--');
 * // => 'foo_bar'
 */
var snakeCase = createCompounder(function(result, word, index) {
  return result + (index ? '_' : '') + word.toLowerCase();
});

/**
 * The base implementation of `_.slice` without an iteratee call guard.
 *
 * @private
 * @param {Array} array The array to slice.
 * @param {number} [start=0] The start position.
 * @param {number} [end=array.length] The end position.
 * @returns {Array} Returns the slice of `array`.
 */
function baseSlice(array, start, end) {
  var index = -1,
      length = array.length;

  if (start < 0) {
    start = -start > length ? 0 : (length + start);
  }
  end = end > length ? length : end;
  if (end < 0) {
    end += length;
  }
  length = start > end ? 0 : ((end - start) >>> 0);
  start >>>= 0;

  var result = Array(length);
  while (++index < length) {
    result[index] = array[index + start];
  }
  return result;
}

/**
 * Casts `array` to a slice if it's needed.
 *
 * @private
 * @param {Array} array The array to inspect.
 * @param {number} start The start position.
 * @param {number} [end=array.length] The end position.
 * @returns {Array} Returns the cast slice.
 */
function castSlice(array, start, end) {
  var length = array.length;
  end = end === undefined ? length : end;
  return (!start && end >= length) ? array : baseSlice(array, start, end);
}

/**
 * Creates a function like `_.lowerFirst`.
 *
 * @private
 * @param {string} methodName The name of the `String` case method to use.
 * @returns {Function} Returns the new case function.
 */
function createCaseFirst(methodName) {
  return function(string) {
    string = toString(string);

    var strSymbols = hasUnicode(string)
      ? stringToArray(string)
      : undefined;

    var chr = strSymbols
      ? strSymbols[0]
      : string.charAt(0);

    var trailing = strSymbols
      ? castSlice(strSymbols, 1).join('')
      : string.slice(1);

    return chr[methodName]() + trailing;
  };
}

/**
 * Converts the first character of `string` to upper case.
 *
 * @static
 * @memberOf _
 * @since 4.0.0
 * @category String
 * @param {string} [string=''] The string to convert.
 * @returns {string} Returns the converted string.
 * @example
 *
 * _.upperFirst('fred');
 * // => 'Fred'
 *
 * _.upperFirst('FRED');
 * // => 'FRED'
 */
var upperFirst = createCaseFirst('toUpperCase');

/**
 * Converts the first character of `string` to upper case and the remaining
 * to lower case.
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category String
 * @param {string} [string=''] The string to capitalize.
 * @returns {string} Returns the capitalized string.
 * @example
 *
 * _.capitalize('FRED');
 * // => 'Fred'
 */
function capitalize$1(string) {
  return upperFirst(toString(string).toLowerCase());
}

/**
 * Converts `string` to [camel case](https://en.wikipedia.org/wiki/CamelCase).
 *
 * @static
 * @memberOf _
 * @since 3.0.0
 * @category String
 * @param {string} [string=''] The string to convert.
 * @returns {string} Returns the camel cased string.
 * @example
 *
 * _.camelCase('Foo Bar');
 * // => 'fooBar'
 *
 * _.camelCase('--foo-bar--');
 * // => 'fooBar'
 *
 * _.camelCase('__FOO_BAR__');
 * // => 'fooBar'
 */
var camelCase = createCompounder(function(result, word, index) {
  word = word.toLowerCase();
  return result + (index ? capitalize$1(word) : word);
});

/**
 * The opposite of `_.mapValues`; this method creates an object with the
 * same values as `object` and keys generated by running each own enumerable
 * string keyed property of `object` thru `iteratee`. The iteratee is invoked
 * with three arguments: (value, key, object).
 *
 * @static
 * @memberOf _
 * @since 3.8.0
 * @category Object
 * @param {Object} object The object to iterate over.
 * @param {Function} [iteratee=_.identity] The function invoked per iteration.
 * @returns {Object} Returns the new mapped object.
 * @see _.mapValues
 * @example
 *
 * _.mapKeys({ 'a': 1, 'b': 2 }, function(value, key) {
 *   return key + value;
 * });
 * // => { 'a1': 1, 'b2': 2 }
 */
function mapKeys(object, iteratee) {
  var result = {};
  iteratee = baseIteratee(iteratee);

  baseForOwn(object, function(value, key, object) {
    baseAssignValue(result, iteratee(value, key, object), value);
  });
  return result;
}

/**
 * Topological sorting function
 *
 * @param {Array} edges
 * @returns {Array}
 */

var toposort_1 = function(edges) {
  return toposort(uniqueNodes(edges), edges)
};

var array$1 = toposort;

function toposort(nodes, edges) {
  var cursor = nodes.length
    , sorted = new Array(cursor)
    , visited = {}
    , i = cursor
    // Better data structures make algorithm much faster.
    , outgoingEdges = makeOutgoingEdges(edges)
    , nodesHash = makeNodesHash(nodes);

  // check for unknown nodes
  edges.forEach(function(edge) {
    if (!nodesHash.has(edge[0]) || !nodesHash.has(edge[1])) {
      throw new Error('Unknown node. There is an unknown node in the supplied edges.')
    }
  });

  while (i--) {
    if (!visited[i]) visit(nodes[i], i, new Set());
  }

  return sorted

  function visit(node, i, predecessors) {
    if(predecessors.has(node)) {
      var nodeRep;
      try {
        nodeRep = ", node was:" + JSON.stringify(node);
      } catch(e) {
        nodeRep = "";
      }
      throw new Error('Cyclic dependency' + nodeRep)
    }

    if (!nodesHash.has(node)) {
      throw new Error('Found unknown node. Make sure to provided all involved nodes. Unknown node: '+JSON.stringify(node))
    }

    if (visited[i]) return;
    visited[i] = true;

    var outgoing = outgoingEdges.get(node) || new Set();
    outgoing = Array.from(outgoing);

    if (i = outgoing.length) {
      predecessors.add(node);
      do {
        var child = outgoing[--i];
        visit(child, nodesHash.get(child), predecessors);
      } while (i)
      predecessors.delete(node);
    }

    sorted[--cursor] = node;
  }
}

function uniqueNodes(arr){
  var res = new Set();
  for (var i = 0, len = arr.length; i < len; i++) {
    var edge = arr[i];
    res.add(edge[0]);
    res.add(edge[1]);
  }
  return Array.from(res)
}

function makeOutgoingEdges(arr){
  var edges = new Map();
  for (var i = 0, len = arr.length; i < len; i++) {
    var edge = arr[i];
    if (!edges.has(edge[0])) edges.set(edge[0], new Set());
    if (!edges.has(edge[1])) edges.set(edge[1], new Set());
    edges.get(edge[0]).add(edge[1]);
  }
  return edges
}

function makeNodesHash(arr){
  var res = new Map();
  for (var i = 0, len = arr.length; i < len; i++) {
    res.set(arr[i], i);
  }
  return res
}
toposort_1.array = array$1;

function sortFields(fields, excludes) {
  if (excludes === void 0) {
    excludes = [];
  }

  var edges = [],
      nodes = [];

  function addNode(depPath, key) {
    var node = propertyExpr_2(depPath)[0];
    if (!~nodes.indexOf(node)) nodes.push(node);
    if (!~excludes.indexOf(key + "-" + node)) edges.push([key, node]);
  }

  for (var key in fields) {
    if (has(fields, key)) {
      var value = fields[key];
      if (!~nodes.indexOf(key)) nodes.push(key);
      if (Reference.isRef(value) && value.isSibling) addNode(value.path, key);else if (isSchema(value) && value._deps) value._deps.forEach(function (path) {
        return addNode(path, key);
      });
    }
  }

  return toposort_1.array(nodes, edges).reverse();
}

function findIndex$1(arr, err) {
  var idx = Infinity;
  arr.some(function (key, ii) {
    if (err.path.indexOf(key) !== -1) {
      idx = ii;
      return true;
    }
  });
  return idx;
}

function sortByKeyOrder(fields) {
  var keys = Object.keys(fields);
  return function (a, b) {
    return findIndex$1(keys, a) - findIndex$1(keys, b);
  };
}

function makePath(strings) {
  for (var _len = arguments.length, values = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
    values[_key - 1] = arguments[_key];
  }

  var path = strings.reduce(function (str, next) {
    var value = values.shift();
    return str + (value == null ? '' : value) + next;
  });
  return path.replace(/^\./, '');
}

function _templateObject3() {
  var data = _taggedTemplateLiteralLoose(["", "[\"", "\"]"]);

  _templateObject3 = function _templateObject3() {
    return data;
  };

  return data;
}

function _templateObject2() {
  var data = _taggedTemplateLiteralLoose(["", ".", ""]);

  _templateObject2 = function _templateObject2() {
    return data;
  };

  return data;
}

function _templateObject() {
  var data = _taggedTemplateLiteralLoose(["", ".", ""]);

  _templateObject = function _templateObject() {
    return data;
  };

  return data;
}

var isObject$3 = function isObject(obj) {
  return Object.prototype.toString.call(obj) === '[object Object]';
};

var promise$1 = function promise(sync) {
  return sync ? synchronousPromise_1 : Promise;
};

function unknown(ctx, value) {
  var known = Object.keys(ctx.fields);
  return Object.keys(value).filter(function (key) {
    return known.indexOf(key) === -1;
  });
}

function ObjectSchema(spec) {
  var _this2 = this;

  if (!(this instanceof ObjectSchema)) return new ObjectSchema(spec);
  SchemaType.call(this, {
    type: 'object',
    default: function _default() {
      var _this = this;

      if (!this._nodes.length) return undefined;
      var dft = {};

      this._nodes.forEach(function (key) {
        dft[key] = _this.fields[key].default ? _this.fields[key].default() : undefined;
      });

      return dft;
    }
  });
  this.fields = Object.create(null);
  this._nodes = [];
  this._excludedEdges = [];
  this.withMutation(function () {
    _this2.transform(function coerce(value) {
      if (typeof value === 'string') {
        try {
          value = JSON.parse(value);
        } catch (err) {
          value = null;
        }
      }

      if (this.isType(value)) return value;
      return null;
    });

    if (spec) {
      _this2.shape(spec);
    }
  });
}
inherits(ObjectSchema, SchemaType, {
  _typeCheck: function _typeCheck(value) {
    return isObject$3(value) || typeof value === 'function';
  },
  _cast: function _cast(_value, options) {
    var _this3 = this;

    if (options === void 0) {
      options = {};
    }

    var value = SchemaType.prototype._cast.call(this, _value, options); //should ignore nulls here


    if (value === undefined) return this.default();
    if (!this._typeCheck(value)) return value;
    var fields = this.fields;
    var strip = this._option('stripUnknown', options) === true;

    var props = this._nodes.concat(Object.keys(value).filter(function (v) {
      return _this3._nodes.indexOf(v) === -1;
    }));

    var intermediateValue = {}; // is filled during the transform below

    var innerOptions = _extends({}, options, {
      parent: intermediateValue,
      __validating: false
    });

    var isChanged = false;
    props.forEach(function (prop) {
      var field = fields[prop];
      var exists = has(value, prop);

      if (field) {
        var fieldValue;
        var strict = field._options && field._options.strict; // safe to mutate since this is fired in sequence

        innerOptions.path = makePath(_templateObject(), options.path, prop);
        innerOptions.value = value[prop];
        field = field.resolve(innerOptions);

        if (field._strip === true) {
          isChanged = isChanged || prop in value;
          return;
        }

        fieldValue = !options.__validating || !strict ? field.cast(value[prop], innerOptions) : value[prop];
        if (fieldValue !== undefined) intermediateValue[prop] = fieldValue;
      } else if (exists && !strip) intermediateValue[prop] = value[prop];

      if (intermediateValue[prop] !== value[prop]) isChanged = true;
    });
    return isChanged ? intermediateValue : value;
  },
  _validate: function _validate(_value, opts) {
    var _this4 = this;

    if (opts === void 0) {
      opts = {};
    }

    var endEarly, recursive;
    var sync = opts.sync;
    var errors = [];
    var originalValue = opts.originalValue != null ? opts.originalValue : _value;
    endEarly = this._option('abortEarly', opts);
    recursive = this._option('recursive', opts);
    opts = _extends({}, opts, {
      __validating: true,
      originalValue: originalValue
    });
    return SchemaType.prototype._validate.call(this, _value, opts).catch(propagateErrors(endEarly, errors)).then(function (value) {
      if (!recursive || !isObject$3(value)) {
        // only iterate though actual objects
        if (errors.length) throw errors[0];
        return value;
      }

      originalValue = originalValue || value;

      var validations = _this4._nodes.map(function (key) {
        var path = key.indexOf('.') === -1 ? makePath(_templateObject2(), opts.path, key) : makePath(_templateObject3(), opts.path, key);
        var field = _this4.fields[key];

        var innerOptions = _extends({}, opts, {
          path: path,
          parent: value,
          originalValue: originalValue[key]
        });

        if (field && field.validate) {
          // inner fields are always strict:
          // 1. this isn't strict so the casting will also have cast inner values
          // 2. this is strict in which case the nested values weren't cast either
          innerOptions.strict = true;
          return field.validate(value[key], innerOptions);
        }

        return promise$1(sync).resolve(true);
      });

      return runValidations({
        sync: sync,
        validations: validations,
        value: value,
        errors: errors,
        endEarly: endEarly,
        path: opts.path,
        sort: sortByKeyOrder(_this4.fields)
      });
    });
  },
  concat: function concat(schema) {
    var next = SchemaType.prototype.concat.call(this, schema);
    next._nodes = sortFields(next.fields, next._excludedEdges);
    return next;
  },
  shape: function shape(schema, excludes) {
    if (excludes === void 0) {
      excludes = [];
    }

    var next = this.clone();

    var fields = _extends(next.fields, schema);

    next.fields = fields;

    if (excludes.length) {
      if (!Array.isArray(excludes[0])) excludes = [excludes];
      var keys = excludes.map(function (_ref) {
        var first = _ref[0],
            second = _ref[1];
        return first + "-" + second;
      });
      next._excludedEdges = next._excludedEdges.concat(keys);
    }

    next._nodes = sortFields(fields, next._excludedEdges);
    return next;
  },
  from: function from(_from, to, alias) {
    var fromGetter = propertyExpr_5(_from, true);
    return this.transform(function (obj) {
      if (obj == null) return obj;
      var newObj = obj;

      if (has(obj, _from)) {
        newObj = _extends({}, obj);
        if (!alias) delete newObj[_from];
        newObj[to] = fromGetter(obj);
      }

      return newObj;
    });
  },
  noUnknown: function noUnknown(noAllow, message) {
    if (noAllow === void 0) {
      noAllow = true;
    }

    if (message === void 0) {
      message = object.noUnknown;
    }

    if (typeof noAllow === 'string') {
      message = noAllow;
      noAllow = true;
    }

    var next = this.test({
      name: 'noUnknown',
      exclusive: true,
      message: message,
      test: function test(value) {
        var unknownKeys = unknown(this.schema, value);
        return value == null || !noAllow || unknownKeys.length === 0 || this.createError({
          params: {
            unknown: unknownKeys.join(', ')
          }
        });
      }
    });
    next._options.stripUnknown = noAllow;
    return next;
  },
  unknown: function unknown(allow, message) {
    if (allow === void 0) {
      allow = true;
    }

    if (message === void 0) {
      message = object.noUnknown;
    }

    return this.noUnknown(!allow, message);
  },
  transformKeys: function transformKeys(fn) {
    return this.transform(function (obj) {
      return obj && mapKeys(obj, function (_, key) {
        return fn(key);
      });
    });
  },
  camelCase: function camelCase$1() {
    return this.transformKeys(camelCase);
  },
  snakeCase: function snakeCase$1() {
    return this.transformKeys(snakeCase);
  },
  constantCase: function constantCase() {
    return this.transformKeys(function (key) {
      return snakeCase(key).toUpperCase();
    });
  },
  describe: function describe() {
    var base = SchemaType.prototype.describe.call(this);
    base.fields = mapValues(this.fields, function (value) {
      return value.describe();
    });
    return base;
  }
});

function _templateObject2$1() {
  var data = _taggedTemplateLiteralLoose(["", "[", "]"]);

  _templateObject2$1 = function _templateObject2() {
    return data;
  };

  return data;
}

function _templateObject$1() {
  var data = _taggedTemplateLiteralLoose(["", "[", "]"]);

  _templateObject$1 = function _templateObject() {
    return data;
  };

  return data;
}

function ArraySchema(type) {
  var _this = this;

  if (!(this instanceof ArraySchema)) return new ArraySchema(type);
  SchemaType.call(this, {
    type: 'array'
  }); // `undefined` specifically means uninitialized, as opposed to
  // "no subtype"

  this._subType = undefined;
  this.innerType = undefined;
  this.withMutation(function () {
    _this.transform(function (values) {
      if (typeof values === 'string') try {
        values = JSON.parse(values);
      } catch (err) {
        values = null;
      }
      return this.isType(values) ? values : null;
    });

    if (type) _this.of(type);
  });
}

inherits(ArraySchema, SchemaType, {
  _typeCheck: function _typeCheck(v) {
    return Array.isArray(v);
  },
  _cast: function _cast(_value, _opts) {
    var _this2 = this;

    var value = SchemaType.prototype._cast.call(this, _value, _opts); //should ignore nulls here


    if (!this._typeCheck(value) || !this.innerType) return value;
    var isChanged = false;
    var castArray = value.map(function (v, idx) {
      var castElement = _this2.innerType.cast(v, _extends({}, _opts, {
        path: makePath(_templateObject$1(), _opts.path, idx)
      }));

      if (castElement !== v) {
        isChanged = true;
      }

      return castElement;
    });
    return isChanged ? castArray : value;
  },
  _validate: function _validate(_value, options) {
    var _this3 = this;

    if (options === void 0) {
      options = {};
    }

    var errors = [];
    var sync = options.sync;
    var path = options.path;
    var innerType = this.innerType;

    var endEarly = this._option('abortEarly', options);

    var recursive = this._option('recursive', options);

    var originalValue = options.originalValue != null ? options.originalValue : _value;
    return SchemaType.prototype._validate.call(this, _value, options).catch(propagateErrors(endEarly, errors)).then(function (value) {
      if (!recursive || !innerType || !_this3._typeCheck(value)) {
        if (errors.length) throw errors[0];
        return value;
      }

      originalValue = originalValue || value;
      var validations = value.map(function (item, idx) {
        var path = makePath(_templateObject2$1(), options.path, idx); // object._validate note for isStrict explanation

        var innerOptions = _extends({}, options, {
          path: path,
          strict: true,
          parent: value,
          originalValue: originalValue[idx]
        });

        if (innerType.validate) return innerType.validate(item, innerOptions);
        return true;
      });
      return runValidations({
        sync: sync,
        path: path,
        value: value,
        errors: errors,
        endEarly: endEarly,
        validations: validations
      });
    });
  },
  _isPresent: function _isPresent(value) {
    return SchemaType.prototype._cast.call(this, value) && value.length > 0;
  },
  of: function of(schema) {
    var next = this.clone();
    if (schema !== false && !isSchema(schema)) throw new TypeError('`array.of()` sub-schema must be a valid yup schema, or `false` to negate a current sub-schema. ' + 'not: ' + printValue(schema));
    next._subType = schema;
    next.innerType = schema;
    return next;
  },
  min: function min(_min, message) {
    message = message || array.min;
    return this.test({
      message: message,
      name: 'min',
      exclusive: true,
      params: {
        min: _min
      },
      test: function test(value) {
        return isAbsent(value) || value.length >= this.resolve(_min);
      }
    });
  },
  max: function max(_max, message) {
    message = message || array.max;
    return this.test({
      message: message,
      name: 'max',
      exclusive: true,
      params: {
        max: _max
      },
      test: function test(value) {
        return isAbsent(value) || value.length <= this.resolve(_max);
      }
    });
  },
  ensure: function ensure() {
    var _this4 = this;

    return this.default(function () {
      return [];
    }).transform(function (val, original) {
      // We don't want to return `null` for nullable schema
      if (_this4._typeCheck(val)) return val;
      return original == null ? [] : [].concat(original);
    });
  },
  compact: function compact(rejector) {
    var reject = !rejector ? function (v) {
      return !!v;
    } : function (v, i, a) {
      return !rejector(v, i, a);
    };
    return this.transform(function (values) {
      return values != null ? values.filter(reject) : values;
    });
  },
  describe: function describe() {
    var base = SchemaType.prototype.describe.call(this);
    if (this.innerType) base.innerType = this.innerType.describe();
    return base;
  }
});

var Lazy = /*#__PURE__*/function () {
  function Lazy(mapFn) {
    this._resolve = function (value, options) {
      var schema = mapFn(value, options);
      if (!isSchema(schema)) throw new TypeError('lazy() functions must return a valid schema');
      return schema.resolve(options);
    };
  }

  var _proto = Lazy.prototype;

  _proto.resolve = function resolve(options) {
    return this._resolve(options.value, options);
  };

  _proto.cast = function cast(value, options) {
    return this._resolve(value, options).cast(value, options);
  };

  _proto.validate = function validate(value, options) {
    return this._resolve(value, options).validate(value, options);
  };

  _proto.validateSync = function validateSync(value, options) {
    return this._resolve(value, options).validateSync(value, options);
  };

  _proto.validateAt = function validateAt(path, value, options) {
    return this._resolve(value, options).validateAt(path, value, options);
  };

  _proto.validateSyncAt = function validateSyncAt(path, value, options) {
    return this._resolve(value, options).validateSyncAt(path, value, options);
  };

  return Lazy;
}();

Lazy.prototype.__isYupSchema__ = true;

function setLocale(custom) {
  Object.keys(custom).forEach(function (type) {
    Object.keys(custom[type]).forEach(function (method) {
      locale$2[type][method] = custom[type][method];
    });
  });
}

var boolean$1 = BooleanSchema;

var ref = function ref(key, options) {
  return new Reference(key, options);
};

var lazy = function lazy(fn) {
  return new Lazy(fn);
};

function addMethod(schemaType, name, fn) {
  if (!schemaType || !isSchema(schemaType.prototype)) throw new TypeError('You must provide a yup schema constructor function');
  if (typeof name !== 'string') throw new TypeError('A Method name must be provided');
  if (typeof fn !== 'function') throw new TypeError('Method function must be provided');
  schemaType.prototype[name] = fn;
}

var es = /*#__PURE__*/Object.freeze({
    __proto__: null,
    mixed: SchemaType,
    string: StringSchema,
    number: NumberSchema,
    bool: BooleanSchema,
    boolean: boolean$1,
    date: DateSchema,
    object: ObjectSchema,
    array: ArraySchema,
    ref: ref,
    lazy: lazy,
    reach: reach,
    isSchema: isSchema,
    addMethod: addMethod,
    setLocale: setLocale,
    ValidationError: ValidationError
});

var dist = createCommonjsModule(function (module, exports) {

Object.defineProperty(exports, '__esModule', { value: true });



(function (MangopayLegalStatus) {
    MangopayLegalStatus["Organization"] = "Organization";
    MangopayLegalStatus["Business"] = "Business";
    MangopayLegalStatus["Soletrader"] = "Soletrader";
})(exports.MangopayLegalStatus || (exports.MangopayLegalStatus = {}));
(function (MangopayKYCLevel) {
    MangopayKYCLevel["Light"] = "Light";
    MangopayKYCLevel["Regular"] = "Regular";
})(exports.MangopayKYCLevel || (exports.MangopayKYCLevel = {}));

es.setLocale({
    mixed: {
        required: 'mixed.required',
        notType: 'mixed.notType',
        oneOf: 'mixed.oneOf',
    },
    string: {
        min: function (_a) {
            var min = _a.min;
            return ({ key: 'string.min', values: { min: min } });
        },
        length: function (_a) {
            var length = _a.length;
            return ({ key: 'string.length', values: { length: length } });
        },
        email: 'string.email',
    },
    date: {
        max: function (_a) {
            var max = _a.max;
            return ({ key: 'date.max', values: { max: max } });
        },
    },
});

function toInteger(dirtyNumber) {
  if (dirtyNumber === null || dirtyNumber === true || dirtyNumber === false) {
    return NaN;
  }

  var number = Number(dirtyNumber);

  if (isNaN(number)) {
    return number;
  }

  return number < 0 ? Math.ceil(number) : Math.floor(number);
}

function requiredArgs(required, args) {
  if (args.length < required) {
    throw new TypeError(required + ' argument' + (required > 1 ? 's' : '') + ' required, but only ' + args.length + ' present');
  }
}

/**
 * @name toDate
 * @category Common Helpers
 * @summary Convert the given argument to an instance of Date.
 *
 * @description
 * Convert the given argument to an instance of Date.
 *
 * If the argument is an instance of Date, the function returns its clone.
 *
 * If the argument is a number, it is treated as a timestamp.
 *
 * If the argument is none of the above, the function returns Invalid Date.
 *
 * **Note**: *all* Date arguments passed to any *date-fns* function is processed by `toDate`.
 *
 * @param {Date|Number} argument - the value to convert
 * @returns {Date} the parsed date in the local time zone
 * @throws {TypeError} 1 argument required
 *
 * @example
 * // Clone the date:
 * const result = toDate(new Date(2014, 1, 11, 11, 30, 30))
 * //=> Tue Feb 11 2014 11:30:30
 *
 * @example
 * // Convert the timestamp to date:
 * const result = toDate(1392098430000)
 * //=> Tue Feb 11 2014 11:30:30
 */

function toDate(argument) {
  requiredArgs(1, arguments);
  var argStr = Object.prototype.toString.call(argument); // Clone the date

  if (argument instanceof Date || typeof argument === 'object' && argStr === '[object Date]') {
    // Prevent the date to lose the milliseconds when passed to new Date() in IE10
    return new Date(argument.getTime());
  } else if (typeof argument === 'number' || argStr === '[object Number]') {
    return new Date(argument);
  } else {
    if ((typeof argument === 'string' || argStr === '[object String]') && typeof console !== 'undefined') {
      // eslint-disable-next-line no-console
      console.warn("Starting with v2.0.0-beta.1 date-fns doesn't accept strings as arguments. Please use `parseISO` to parse strings. See: https://git.io/fjule"); // eslint-disable-next-line no-console

      console.warn(new Error().stack);
    }

    return new Date(NaN);
  }
}

/**
 * @name getDaysInMonth
 * @category Month Helpers
 * @summary Get the number of days in a month of the given date.
 *
 * @description
 * Get the number of days in a month of the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the given date
 * @returns {Number} the number of days in a month
 * @throws {TypeError} 1 argument required
 *
 * @example
 * // How many days are in February 2000?
 * var result = getDaysInMonth(new Date(2000, 1))
 * //=> 29
 */

function getDaysInMonth(dirtyDate) {
  requiredArgs(1, arguments);
  var date = toDate(dirtyDate);
  var year = date.getFullYear();
  var monthIndex = date.getMonth();
  var lastDayOfMonth = new Date(0);
  lastDayOfMonth.setFullYear(year, monthIndex + 1, 0);
  lastDayOfMonth.setHours(0, 0, 0, 0);
  return lastDayOfMonth.getDate();
}

/**
 * @name addMonths
 * @category Month Helpers
 * @summary Add the specified number of months to the given date.
 *
 * @description
 * Add the specified number of months to the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date to be changed
 * @param {Number} amount - the amount of months to be added. Positive decimals will be rounded using `Math.floor`, decimals less than zero will be rounded using `Math.ceil`.
 * @returns {Date} the new date with the months added
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Add 5 months to 1 September 2014:
 * var result = addMonths(new Date(2014, 8, 1), 5)
 * //=> Sun Feb 01 2015 00:00:00
 */

function addMonths(dirtyDate, dirtyAmount) {
  requiredArgs(2, arguments);
  var date = toDate(dirtyDate);
  var amount = toInteger(dirtyAmount);
  var desiredMonth = date.getMonth() + amount;
  var dateWithDesiredMonth = new Date(0);
  dateWithDesiredMonth.setFullYear(date.getFullYear(), desiredMonth, 1);
  dateWithDesiredMonth.setHours(0, 0, 0, 0);
  var daysInMonth = getDaysInMonth(dateWithDesiredMonth); // Set the last day of the new month
  // if the original date was the last day of the longer month

  date.setMonth(desiredMonth, Math.min(daysInMonth, date.getDate()));
  return date;
}

/**
 * @name addYears
 * @category Year Helpers
 * @summary Add the specified number of years to the given date.
 *
 * @description
 * Add the specified number of years to the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date to be changed
 * @param {Number} amount - the amount of years to be added. Positive decimals will be rounded using `Math.floor`, decimals less than zero will be rounded using `Math.ceil`.
 * @returns {Date} the new date with the years added
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Add 5 years to 1 September 2014:
 * var result = addYears(new Date(2014, 8, 1), 5)
 * //=> Sun Sep 01 2019 00:00:00
 */

function addYears(dirtyDate, dirtyAmount) {
  requiredArgs(2, arguments);
  var amount = toInteger(dirtyAmount);
  return addMonths(dirtyDate, amount * 12);
}

/**
 * @name subYears
 * @category Year Helpers
 * @summary Subtract the specified number of years from the given date.
 *
 * @description
 * Subtract the specified number of years from the given date.
 *
 * ### v2.0.0 breaking changes:
 *
 * - [Changes that are common for the whole library](https://github.com/date-fns/date-fns/blob/master/docs/upgradeGuide.md#Common-Changes).
 *
 * @param {Date|Number} date - the date to be changed
 * @param {Number} amount - the amount of years to be subtracted. Positive decimals will be rounded using `Math.floor`, decimals less than zero will be rounded using `Math.ceil`.
 * @returns {Date} the new date with the years subtracted
 * @throws {TypeError} 2 arguments required
 *
 * @example
 * // Subtract 5 years from 1 September 2014:
 * var result = subYears(new Date(2014, 8, 1), 5)
 * //=> Tue Sep 01 2009 00:00:00
 */

function subYears(dirtyDate, dirtyAmount) {
  requiredArgs(2, arguments);
  var amount = toInteger(dirtyAmount);
  return addYears(dirtyDate, -amount);
}

var getLegalAgeByNationality = function (nationality) {
    if (!nationality)
        return 18;
    var n = nationality.toLocaleLowerCase();
    switch (n) {
        default:
            return 18;
    }
};
// eslint-disable-next-line @typescript-eslint/no-unused-vars
var legalAgeSchema = (function (nationality) {
    return es.date().max(subYears(new Date(), getLegalAgeByNationality(nationality)), 'custom.legalAge');
});

var groupLegalReprSchema = es.object().shape({
    address1: es.string().required(),
    zipCode: es.string().required(),
    city: es.string().required(),
    nationality: es.string().length(2).required(),
    countryOfResidence: es.string().length(2).required(),
    birthDate: es
        .date()
        .when('countryOfResidence', function (countryOfResidence) { return legalAgeSchema(countryOfResidence).required(); }),
});

var loginSchema = es.object().shape({
    email: es.string().email().required(),
    password: es.string().required(),
});

var userSchema = es.object().shape({
    firstName: es.string().min(2).required(),
});

/*!
 * @license
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
/**
 * Validate IBAN
 * @example
 * // returns true
 * ibantools.isValidIBAN("NL91ABNA0517164300");
 * @example
 * // returns false
 * ibantools.isValidIBAN("NL92ABNA0517164300");
 * @alias module:ibantools.isValidIBAN
 * @param {string} IBAN IBAN
 * @return {boolean} valid
 */
function isValidIBAN(iban) {
    if (iban !== undefined && iban !== null) {
        var reg = new RegExp("^[0-9]{2}$", "");
        var spec = countrySpecs[iban.slice(0, 2)];
        if (spec !== undefined &&
            spec.chars === iban.length &&
            reg.test(iban.slice(2, 4)) &&
            checkFormatBBAN(iban.slice(4), spec.bban_regexp) &&
            isValidIBANChecksum(iban)) {
            return true;
        }
    }
    return false;
}
/**
 * Check BBAN format
 * @param {string} BBAN
 * @param {string} Regexp BBAN validation regexp
 * @return {boolean} valid
 */
function checkFormatBBAN(bban, bformat) {
    var reg = new RegExp(bformat, "");
    return reg.test(bban);
}
/**
 * Calculate checksum of IBAN and compares it with checksum provided in IBANregistry
 * @param {string} IBAN
 * @return {boolean}
 */
function isValidIBANChecksum(iban) {
    var providedChecksum = parseInt(iban.slice(2, 4), 10);
    var temp = iban.slice(3) + iban.slice(0, 2) + "00";
    var validationString = "";
    for (var n = 1; n < temp.length; n++) {
        var c = temp.charCodeAt(n);
        if (c >= 65) {
            validationString += (c - 55).toString();
        }
        else {
            validationString += temp[n];
        }
    }
    while (validationString.length > 2) {
        var part = validationString.slice(0, 6);
        validationString =
            (parseInt(part, 10) % 97).toString() +
                validationString.slice(part.length);
    }
    var rest = parseInt(validationString, 10) % 97;
    return 98 - rest === providedChecksum;
}
/**
 * Validate BIC/SWIFT
 * @example
 * // returns true
 * ibantools.isValidBIC("ABNANL2A");
 * @example
 * // returns true
 * ibantools.isValidBIC("NEDSZAJJXXX");
 * @example
 * // returns false
 * ibantools.isValidBIC("ABN4NL2A");
 * @example
 * // returns false
 * ibantools.isValidBIC("ABNA NL 2A");
 * @alias module:ibantools.isValidBIC
 * @param {string} BIC BIC
 * @return {boolean} valid
 */
function isValidBIC(bic) {
    var reg = new RegExp("^[a-zA-Z]{6}[a-zA-Z0-9]{2}([a-zA-Z0-9]{3})?$", "");
    var spec = countrySpecs[bic.toUpperCase().slice(4, 6)];
    return reg.test(bic) && spec !== undefined;
}
// Country specifications
var countrySpecs = {
    AD: { chars: 24, bban_regexp: "^[0-9]{8}[A-Z0-9]{12}$", IBANRegistry: true },
    AE: { chars: 23, bban_regexp: "^[0-9]{3}[0-9]{16}$", IBANRegistry: true },
    AF: { chars: null, bban_regexp: null, IBANRegistry: false },
    AG: { chars: null, bban_regexp: null, IBANRegistry: false },
    AI: { chars: null, bban_regexp: null, IBANRegistry: false },
    AL: { chars: 28, bban_regexp: "^[0-9]{8}[A-Z0-9]{16}$", IBANRegistry: true },
    AM: { chars: null, bban_regexp: null, IBANRegistry: false },
    AO: { chars: 25, bban_regexp: "^[0-9]{21}$", IBANRegistry: false },
    AQ: { chars: null, bban_regexp: null, IBANRegistry: false },
    AR: { chars: null, bban_regexp: null, IBANRegistry: false },
    AS: { chars: null, bban_regexp: null, IBANRegistry: false },
    AT: { chars: 20, bban_regexp: "^[0-9]{16}$", IBANRegistry: true },
    AU: { chars: null, bban_regexp: null, IBANRegistry: false },
    AW: { chars: null, bban_regexp: null, IBANRegistry: false },
    AX: { chars: 18, bban_regexp: "^[0-9]{14}$", IBANRegistry: true },
    AZ: { chars: 28, bban_regexp: "^[A-Z]{4}[0-9]{20}$", IBANRegistry: true },
    BA: { chars: 20, bban_regexp: "^[0-9]{16}$", IBANRegistry: true },
    BB: { chars: null, bban_regexp: null, IBANRegistry: false },
    BD: { chars: null, bban_regexp: null, IBANRegistry: false },
    BE: { chars: 16, bban_regexp: "^[0-9]{12}$", IBANRegistry: true },
    BF: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    BG: {
        chars: 22,
        bban_regexp: "^[A-Z]{4}[0-9]{6}[A-Z0-9]{8}$",
        IBANRegistry: true
    },
    BH: { chars: 22, bban_regexp: "^[A-Z]{4}[A-Z0-9]{14}$", IBANRegistry: true },
    BI: { chars: 16, bban_regexp: "^[0-9]{12}$", IBANRegistry: false },
    BJ: { chars: 28, bban_regexp: "^[A-Z]{1}[0-9]{23}$", IBANRegistry: false },
    BL: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    BM: { chars: null, bban_regexp: null, IBANRegistry: false },
    BN: { chars: null, bban_regexp: null, IBANRegistry: false },
    BO: { chars: null, bban_regexp: null, IBANRegistry: false },
    BQ: { chars: null, bban_regexp: null, IBANRegistry: false },
    BR: {
        chars: 29,
        bban_regexp: "^[0-9]{23}[A-Z]{1}[A-Z0-9]{1}$",
        IBANRegistry: true
    },
    BS: { chars: null, bban_regexp: null, IBANRegistry: false },
    BT: { chars: null, bban_regexp: null, IBANRegistry: false },
    BV: { chars: null, bban_regexp: null, IBANRegistry: false },
    BW: { chars: null, bban_regexp: null, IBANRegistry: false },
    BY: {
        chars: 28,
        bban_regexp: "^[A-Z]{4}[0-9]{4}[A-Z0-9]{16}$",
        IBANRegistry: true
    },
    BZ: { chars: null, bban_regexp: null, IBANRegistry: false },
    CA: { chars: null, bban_regexp: null, IBANRegistry: false },
    CC: { chars: null, bban_regexp: null, IBANRegistry: false },
    CD: { chars: null, bban_regexp: null, IBANRegistry: false },
    CF: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    CG: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    CH: { chars: 21, bban_regexp: "^[0-9]{5}[A-Z0-9]{12}$", IBANRegistry: true },
    CI: { chars: 28, bban_regexp: "^[A-Z]{1}[0-9]{23}$", IBANRegistry: false },
    CK: { chars: null, bban_regexp: null, IBANRegistry: false },
    CL: { chars: null, bban_regexp: null, IBANRegistry: false },
    CM: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    CN: { chars: null, bban_regexp: null, IBANRegistry: false },
    CO: { chars: null, bban_regexp: null, IBANRegistry: false },
    CR: { chars: 22, bban_regexp: "^[0-9]{18}$", IBANRegistry: true },
    CU: { chars: null, bban_regexp: null, IBANRegistry: false },
    CV: { chars: null, bban_regexp: null, IBANRegistry: false },
    CW: { chars: null, bban_regexp: null, IBANRegistry: false },
    CX: { chars: null, bban_regexp: null, IBANRegistry: false },
    CY: { chars: 28, bban_regexp: "^[0-9]{8}[A-Z0-9]{16}$", IBANRegistry: true },
    CZ: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: true },
    DE: { chars: 22, bban_regexp: "^[0-9]{18}$", IBANRegistry: true },
    DJ: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    DK: { chars: 18, bban_regexp: "^[0-9]{14}$", IBANRegistry: true },
    DM: { chars: null, bban_regexp: null, IBANRegistry: false },
    DO: { chars: 28, bban_regexp: "^[A-Z]{4}[0-9]{20}$", IBANRegistry: true },
    DZ: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: false },
    EC: { chars: null, bban_regexp: null, IBANRegistry: false },
    EE: { chars: 20, bban_regexp: "^[0-9]{16}$", IBANRegistry: true },
    EG: { chars: 29, bban_regexp: "^[0-9]{25}", IBANRegistry: true },
    EH: { chars: null, bban_regexp: null, IBANRegistry: false },
    ER: { chars: null, bban_regexp: null, IBANRegistry: false },
    ES: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: true },
    ET: { chars: null, bban_regexp: null, IBANRegistry: false },
    FI: { chars: 18, bban_regexp: "^[0-9]{14}$", IBANRegistry: true },
    FJ: { chars: null, bban_regexp: null, IBANRegistry: false },
    FK: { chars: null, bban_regexp: null, IBANRegistry: false },
    FM: { chars: null, bban_regexp: null, IBANRegistry: false },
    FO: { chars: 18, bban_regexp: "^[0-9]{14}$", IBANRegistry: true },
    FR: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    GA: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    GB: { chars: 22, bban_regexp: "^[A-Z]{4}[0-9]{14}$", IBANRegistry: true },
    GD: { chars: null, bban_regexp: null, IBANRegistry: false },
    GE: { chars: 22, bban_regexp: "^[A-Z0-9]{2}[0-9]{16}$", IBANRegistry: true },
    GF: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    GG: { chars: null, bban_regexp: null, IBANRegistry: false },
    GH: { chars: null, bban_regexp: null, IBANRegistry: false },
    GI: { chars: 23, bban_regexp: "^[A-Z]{4}[A-Z0-9]{15}$", IBANRegistry: true },
    GL: { chars: 18, bban_regexp: "^[0-9]{14}$", IBANRegistry: true },
    GM: { chars: null, bban_regexp: null, IBANRegistry: false },
    GN: { chars: null, bban_regexp: null, IBANRegistry: false },
    GP: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    GQ: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    GR: { chars: 27, bban_regexp: "^[0-9]{7}[A-Z0-9]{16}$", IBANRegistry: true },
    GS: { chars: null, bban_regexp: null, IBANRegistry: false },
    GT: { chars: 28, bban_regexp: "^[A-Z0-9]{24}$", IBANRegistry: true },
    GU: { chars: null, bban_regexp: null, IBANRegistry: false },
    GW: { chars: 25, bban_regexp: "^[A-Z]{2}[0-9]{19}$", IBANRegistry: false },
    GY: { chars: null, bban_regexp: null, IBANRegistry: false },
    HK: { chars: null, bban_regexp: null, IBANRegistry: false },
    HM: { chars: null, bban_regexp: null, IBANRegistry: false },
    HN: { chars: 28, bban_regexp: "^[A-Z]{4}[0-9]{20}$", IBANRegistry: false },
    HR: { chars: 21, bban_regexp: "^[0-9]{17}$", IBANRegistry: true },
    HT: { chars: null, bban_regexp: null, IBANRegistry: false },
    HU: { chars: 28, bban_regexp: "^[0-9]{24}$", IBANRegistry: true },
    ID: { chars: null, bban_regexp: null, IBANRegistry: false },
    IE: { chars: 22, bban_regexp: "^[A-Z0-9]{4}[0-9]{14}$", IBANRegistry: true },
    IL: { chars: 23, bban_regexp: "^[0-9]{19}$", IBANRegistry: true },
    IM: { chars: null, bban_regexp: null, IBANRegistry: false },
    IN: { chars: null, bban_regexp: null, IBANRegistry: false },
    IO: { chars: null, bban_regexp: null, IBANRegistry: false },
    IQ: { chars: 23, bban_regexp: "^[A-Z]{4}[0-9]{15}$", IBANRegistry: true },
    IR: { chars: 26, bban_regexp: "^[0-9]{22}$", IBANRegistry: false },
    IS: { chars: 26, bban_regexp: "^[0-9]{22}$", IBANRegistry: true },
    IT: {
        chars: 27,
        bban_regexp: "^[A-Z]{1}[0-9]{10}[A-Z0-9]{12}$",
        IBANRegistry: true
    },
    JE: { chars: null, bban_regexp: null, IBANRegistry: false },
    JM: { chars: null, bban_regexp: null, IBANRegistry: false },
    JO: {
        chars: 30,
        bban_regexp: "^[A-Z]{4}[0-9]{4}[A-Z0-9]{18}$",
        IBANRegistry: true
    },
    JP: { chars: null, bban_regexp: null, IBANRegistry: false },
    KE: { chars: null, bban_regexp: null, IBANRegistry: false },
    KG: { chars: null, bban_regexp: null, IBANRegistry: false },
    KH: { chars: null, bban_regexp: null, IBANRegistry: false },
    KI: { chars: null, bban_regexp: null, IBANRegistry: false },
    KM: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    KN: { chars: null, bban_regexp: null, IBANRegistry: false },
    KP: { chars: null, bban_regexp: null, IBANRegistry: false },
    KR: { chars: null, bban_regexp: null, IBANRegistry: false },
    KW: { chars: 30, bban_regexp: "^[A-Z]{4}[A-Z0-9]{22}$", IBANRegistry: true },
    KY: { chars: null, bban_regexp: null, IBANRegistry: false },
    KZ: { chars: 20, bban_regexp: "^[0-9]{3}[A-Z0-9]{13}$", IBANRegistry: true },
    LA: { chars: null, bban_regexp: null, IBANRegistry: false },
    LB: { chars: 28, bban_regexp: "^[0-9]{4}[A-Z0-9]{20}$", IBANRegistry: true },
    LC: { chars: 32, bban_regexp: "^[A-Z]{4}[A-Z0-9]{24}$", IBANRegistry: true },
    LI: { chars: 21, bban_regexp: "^[0-9]{5}[A-Z0-9]{12}$", IBANRegistry: true },
    LK: { chars: null, bban_regexp: null, IBANRegistry: false },
    LR: { chars: null, bban_regexp: null, IBANRegistry: false },
    LS: { chars: null, bban_regexp: null, IBANRegistry: false },
    LT: { chars: 20, bban_regexp: "^[0-9]{16}$", IBANRegistry: true },
    LU: { chars: 20, bban_regexp: "^[0-9]{3}[A-Z0-9]{13}$", IBANRegistry: true },
    LV: { chars: 21, bban_regexp: "^[A-Z]{4}[A-Z0-9]{13}$", IBANRegistry: true },
    LY: { chars: null, bban_regexp: null, IBANRegistry: false },
    MA: { chars: 28, bban_regexp: "^[0-9]{24}$", IBANRegistry: false },
    MC: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    MD: {
        chars: 24,
        bban_regexp: "^[A-Z0-9]{2}[A-Z0-9]{18}$",
        IBANRegistry: true
    },
    ME: { chars: 22, bban_regexp: "^[0-9]{18}$", IBANRegistry: true },
    MF: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    MG: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    MH: { chars: null, bban_regexp: null, IBANRegistry: false },
    MK: {
        chars: 19,
        bban_regexp: "^[0-9]{3}[A-Z0-9]{10}[0-9]{2}$",
        IBANRegistry: true
    },
    ML: { chars: 28, bban_regexp: "^[A-Z]{1}[0-9]{23}$", IBANRegistry: false },
    MM: { chars: null, bban_regexp: null, IBANRegistry: false },
    MN: { chars: null, bban_regexp: null, IBANRegistry: false },
    MO: { chars: null, bban_regexp: null, IBANRegistry: false },
    MP: { chars: null, bban_regexp: null, IBANRegistry: false },
    MQ: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    MR: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: true },
    MS: { chars: null, bban_regexp: null, IBANRegistry: false },
    MT: {
        chars: 31,
        bban_regexp: "^[A-Z]{4}[0-9]{5}[A-Z0-9]{18}$",
        IBANRegistry: true
    },
    MU: {
        chars: 30,
        bban_regexp: "^[A-Z]{4}[0-9]{19}[A-Z]{3}$",
        IBANRegistry: true
    },
    MV: { chars: null, bban_regexp: null, IBANRegistry: false },
    MW: { chars: null, bban_regexp: null, IBANRegistry: false },
    MX: { chars: null, bban_regexp: null, IBANRegistry: false },
    MY: { chars: null, bban_regexp: null, IBANRegistry: false },
    MZ: { chars: 25, bban_regexp: "^[0-9]{21}$", IBANRegistry: false },
    NA: { chars: null, bban_regexp: null, IBANRegistry: false },
    NC: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    NE: { chars: 28, bban_regexp: "^[A-Z]{2}[0-9]{22}$", IBANRegistry: false },
    NF: { chars: null, bban_regexp: null, IBANRegistry: false },
    NG: { chars: null, bban_regexp: null, IBANRegistry: false },
    NI: { chars: 32, bban_regexp: "^[A-Z]{4}[0-9]{24}$", IBANRegistry: false },
    NL: { chars: 18, bban_regexp: "^[A-Z]{4}[0-9]{10}$", IBANRegistry: true },
    NO: { chars: 15, bban_regexp: "^[0-9]{11}$", IBANRegistry: true },
    NP: { chars: null, bban_regexp: null, IBANRegistry: false },
    NR: { chars: null, bban_regexp: null, IBANRegistry: false },
    NU: { chars: null, bban_regexp: null, IBANRegistry: false },
    NZ: { chars: null, bban_regexp: null, IBANRegistry: false },
    OM: { chars: null, bban_regexp: null, IBANRegistry: false },
    PA: { chars: null, bban_regexp: null, IBANRegistry: false },
    PE: { chars: null, bban_regexp: null, IBANRegistry: false },
    PF: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    PG: { chars: null, bban_regexp: null, IBANRegistry: false },
    PH: { chars: null, bban_regexp: null, IBANRegistry: false },
    PK: { chars: 24, bban_regexp: "^[A-Z0-9]{4}[0-9]{16}$", IBANRegistry: true },
    PL: { chars: 28, bban_regexp: "^[0-9]{24}$", IBANRegistry: true },
    PM: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    PN: { chars: null, bban_regexp: null, IBANRegistry: false },
    PR: { chars: null, bban_regexp: null, IBANRegistry: false },
    PS: { chars: 29, bban_regexp: "^[A-Z0-9]{4}[0-9]{21}$", IBANRegistry: true },
    PT: { chars: 25, bban_regexp: "^[0-9]{21}$", IBANRegistry: true },
    PW: { chars: null, bban_regexp: null, IBANRegistry: false },
    PY: { chars: null, bban_regexp: null, IBANRegistry: false },
    QA: { chars: 29, bban_regexp: "^[A-Z]{4}[A-Z0-9]{21}$", IBANRegistry: true },
    RE: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    RO: { chars: 24, bban_regexp: "^[A-Z]{4}[A-Z0-9]{16}$", IBANRegistry: true },
    RS: { chars: 22, bban_regexp: "^[0-9]{18}$", IBANRegistry: true },
    RU: { chars: null, bban_regexp: null, IBANRegistry: false },
    RW: { chars: null, bban_regexp: null, IBANRegistry: false },
    SA: { chars: 24, bban_regexp: "^[0-9]{2}[A-Z0-9]{18}$", IBANRegistry: true },
    SB: { chars: null, bban_regexp: null, IBANRegistry: false },
    SC: {
        chars: 31,
        bban_regexp: "^[[A-Z]{4}[]0-9]{20}[A-Z]{3}$",
        IBANRegistry: true
    },
    SD: { chars: null, bban_regexp: null, IBANRegistry: false },
    SE: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: true },
    SG: { chars: null, bban_regexp: null, IBANRegistry: false },
    SH: { chars: null, bban_regexp: null, IBANRegistry: false },
    SI: { chars: 19, bban_regexp: "^[0-9]{15}$", IBANRegistry: true },
    SJ: { chars: null, bban_regexp: null, IBANRegistry: false },
    SK: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: true },
    SL: { chars: null, bban_regexp: null, IBANRegistry: false },
    SM: {
        chars: 27,
        bban_regexp: "^[A-Z]{1}[0-9]{10}[A-Z0-9]{12}$",
        IBANRegistry: true
    },
    SN: { chars: 28, bban_regexp: "^[A-Z]{1}[0-9]{23}$", IBANRegistry: false },
    SO: { chars: null, bban_regexp: null, IBANRegistry: false },
    SR: { chars: null, bban_regexp: null, IBANRegistry: false },
    SS: { chars: null, bban_regexp: null, IBANRegistry: false },
    ST: { chars: 25, bban_regexp: "^[0-9]{21}$", IBANRegistry: true },
    SV: { chars: 28, bban_regexp: "^[A-Z]{4}[0-9]{20}$", IBANRegistry: true },
    SX: { chars: null, bban_regexp: null, IBANRegistry: false },
    SY: { chars: null, bban_regexp: null, IBANRegistry: false },
    SZ: { chars: null, bban_regexp: null, IBANRegistry: false },
    TC: { chars: null, bban_regexp: null, IBANRegistry: false },
    TD: { chars: 27, bban_regexp: "^[0-9]{23}$", IBANRegistry: false },
    TF: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    TG: { chars: 28, bban_regexp: "^[A-Z]{2}[0-9]{22}$", IBANRegistry: false },
    TH: { chars: null, bban_regexp: null, IBANRegistry: false },
    TJ: { chars: null, bban_regexp: null, IBANRegistry: false },
    TK: { chars: null, bban_regexp: null, IBANRegistry: false },
    TL: { chars: 23, bban_regexp: "^[0-9]{19}$", IBANRegistry: true },
    TM: { chars: null, bban_regexp: null, IBANRegistry: false },
    TN: { chars: 24, bban_regexp: "^[0-9]{20}$", IBANRegistry: true },
    TO: { chars: null, bban_regexp: null, IBANRegistry: false },
    TR: { chars: 26, bban_regexp: "^[0-9]{5}[A-Z0-9]{17}$", IBANRegistry: true },
    TT: { chars: null, bban_regexp: null, IBANRegistry: false },
    TV: { chars: null, bban_regexp: null, IBANRegistry: false },
    TW: { chars: null, bban_regexp: null, IBANRegistry: false },
    TZ: { chars: null, bban_regexp: null, IBANRegistry: false },
    UA: { chars: 29, bban_regexp: "^[0-9]{6}[A-Z0-9]{19}$", IBANRegistry: true },
    UG: { chars: null, bban_regexp: null, IBANRegistry: false },
    UM: { chars: null, bban_regexp: null, IBANRegistry: false },
    US: { chars: null, bban_regexp: null, IBANRegistry: false },
    UY: { chars: null, bban_regexp: null, IBANRegistry: false },
    UZ: { chars: null, bban_regexp: null, IBANRegistry: false },
    VA: { chars: 22, bban_regexp: "^[0-9]{18}", IBANRegistry: true },
    VC: { chars: null, bban_regexp: null, IBANRegistry: false },
    VE: { chars: null, bban_regexp: null, IBANRegistry: false },
    VG: { chars: 24, bban_regexp: "^[A-Z0-9]{4}[0-9]{16}$", IBANRegistry: true },
    VI: { chars: null, bban_regexp: null, IBANRegistry: false },
    VN: { chars: null, bban_regexp: null, IBANRegistry: false },
    VU: { chars: null, bban_regexp: null, IBANRegistry: false },
    WF: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    WS: { chars: null, bban_regexp: null, IBANRegistry: false },
    XK: { chars: 20, bban_regexp: "^[0-9]{16}$", IBANRegistry: true },
    YE: { chars: null, bban_regexp: null, IBANRegistry: false },
    YT: {
        chars: 27,
        bban_regexp: "^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$",
        IBANRegistry: true
    },
    ZA: { chars: null, bban_regexp: null, IBANRegistry: false },
    ZM: { chars: null, bban_regexp: null, IBANRegistry: false },
    ZW: { chars: null, bban_regexp: null, IBANRegistry: false }
};

var mangopayBankAccountSchema = es.object().shape({
    ownerName: es.string().required(),
    address1: es.string().required(),
    address2: es.string(),
    city: es.string().required(),
    zipCode: es.string().required(),
    country: es.string().length(2).required(),
    iban: es
        .string()
        .required()
        .test('iban', 'custom.iban', function (value) { return isValidIBAN(value || ''); }),
    bic: es
        .string()
        .notRequired()
        .test('bic', 'custom.bic', function (value) { return (!value || value === '' ? true : isValidBIC(value || '')); }),
});

var isLuhn = (function (toCheck) {
    if (!toCheck)
        return false;
    var value = toCheck.replace(/[\s]/g, '');
    if (!/^\d+$/.test(value))
        return false;
    var length = value.length;
    var n;
    var total = 0;
    var odd = false;
    for (var i = length; i > 0; i -= 1) {
        n = parseInt(value.charAt(i - 1), 10);
        if (!odd)
            total += n;
        else {
            n *= 2;
            n = n > 9 ? n - 9 : n;
            total += n;
        }
        odd = !odd;
    }
    return total !== 0 && total % 10 === 0;
});

var mangopayLegalUserSchema = es.object().shape({
    name: es.string().required(),
    email: es.string().email().required(),
    legalStatus: es
        .string()
        .required()
        .oneOf([exports.MangopayLegalStatus.Business, exports.MangopayLegalStatus.Organization, exports.MangopayLegalStatus.Soletrader]),
    companyNumber: es.string().when('legalStatus', {
        is: function (val) { return val === exports.MangopayLegalStatus.Business || val === exports.MangopayLegalStatus.Soletrader; },
        then: es.string().required().test('luhn', 'custom.luhn', isLuhn),
        otherwise: es.string().notRequired(),
    }),
    legalRepr: groupLegalReprSchema,
});

exports.customYup = es;
exports.groupLegalReprSchema = groupLegalReprSchema;
exports.loginSchema = loginSchema;
exports.mangopayBankAccountSchema = mangopayBankAccountSchema;
exports.mangopayLegalUserSchema = mangopayLegalUserSchema;
exports.userSchema = userSchema;

});

unwrapExports(dist);
var dist_1 = dist.MangopayLegalStatus;
var dist_2 = dist.MangopayKYCLevel;
var dist_3 = dist.customYup;
var dist_4 = dist.groupLegalReprSchema;
var dist_5 = dist.loginSchema;
var dist_6 = dist.mangopayBankAccountSchema;
var dist_7 = dist.mangopayLegalUserSchema;
var dist_8 = dist.userSchema;

var yupHelperTextTranslator = (function (t, helperText) {
    if (helperText) {
        var key = void 0;
        var values = {};
        if (typeof helperText === 'object') {
            key = helperText.key;
            values = helperText.values;
        }
        else {
            key = helperText;
        }
        return t(key, values);
    }
    return undefined;
});

function withHelperTextTranslation(Wrapped, tranformPropsFunc) {
    var Wrapper = function (props) {
        var t = useTranslation(['yup'], { useSuspense: false }).t;
        var p = tranformPropsFunc ? tranformPropsFunc(props) : props;
        p.helperText = yupHelperTextTranslator(t, p.helperText);
        return React__default.createElement(Wrapped, __assign({}, p));
    };
    return Wrapper;
}

var CustomTextField = withHelperTextTranslation(core.TextField, formikMaterialUi.fieldToTextField);
function generateFields(fields, formikProps) {
    return fields.map(function (field) {
        if (field.type === 'default') {
            return (React__default.createElement(formik.Field, { key: field.name, component: field.component || CustomTextField, fullWidth: true, margin: "normal", label: field.label, name: field.name, disabled: field.disabled, required: field.required || false }));
        }
        return field.render(field.name, formikProps);
    });
}
function generateInitialValues(fields) {
    return fields.reduce(function (acc, field) {
        acc[field.name] = field.initialValues;
        return acc;
    }, {});
}

var ExpansionPanel = core.withStyles({
    root: {
        // border: '1px solid rgba(0, 0, 0, .125)',
        boxShadow: 'none',
        '&:not(:last-child)': {
            borderBottom: 0,
        },
        '&:before': {
            display: 'none',
        },
        '&$expanded': {
            margin: 'auto',
        },
    },
    expanded: {},
})(core.ExpansionPanel);

var ExpansionPanelSummary = core.withStyles({
    root: {
        backgroundColor: 'rgba(0, 0, 0, .03)',
        borderBottom: '1px solid rgba(0, 0, 0, .125)',
        // marginBottom: -1,
        minHeight: 56,
        '&$expanded': {
            minHeight: 56,
        },
    },
    content: {
        '&$expanded': {
            margin: '12px 0',
        },
    },
    expanded: {},
})(core.ExpansionPanelSummary);

// yup.setLocale({
//   string: {
//     min: 'MMMMM',
//     // min: ({ min }) => i18n('yup.string.min', { min }),
//   },
// })
var UserForm = function (_a) {
    var user = _a.user, onSubmit = _a.onSubmit;
    var t = useTranslation(['translation', 'users/form']).t;
    var fields = [
        {
            type: 'default',
            name: 'firstName',
            initialValues: (user === null || user === void 0 ? void 0 : user.firstName) || '',
            label: t('firstName'),
            required: true,
        },
        {
            type: 'default',
            name: 'lastName',
            initialValues: (user === null || user === void 0 ? void 0 : user.lastName) || '',
            label: t('lastName'),
            required: true,
        },
        {
            type: 'default',
            name: 'email',
            initialValues: (user === null || user === void 0 ? void 0 : user.email) || '',
            label: t('email'),
            disabled: true,
        },
    ];
    var contactFields = [
        {
            type: 'default',
            name: 'phone',
            initialValues: (user === null || user === void 0 ? void 0 : user.phone) || '',
            label: t('phone'),
        },
        {
            type: 'default',
            name: 'address1',
            initialValues: (user === null || user === void 0 ? void 0 : user.address1) || '',
            label: t('address1'),
        },
        {
            type: 'default',
            name: 'address2',
            initialValues: (user === null || user === void 0 ? void 0 : user.address2) || '',
            label: t('address2'),
        },
        {
            type: 'default',
            name: 'zipCode',
            initialValues: (user === null || user === void 0 ? void 0 : user.zipCode) || '',
            label: t('zipCode'),
        },
        {
            type: 'default',
            name: 'city',
            initialValues: (user === null || user === void 0 ? void 0 : user.city) || '',
            label: t('city'),
        },
    ];
    var spouseInformations = [
        {
            type: 'default',
            name: 'firstName2',
            initialValues: (user === null || user === void 0 ? void 0 : user.firstName2) || '',
            label: t('users/form:firstName2'),
        },
        {
            type: 'default',
            name: 'lastName2',
            initialValues: (user === null || user === void 0 ? void 0 : user.lastName2) || '',
            label: t('users/form:lastName2'),
        },
        {
            type: 'default',
            name: 'email2',
            initialValues: (user === null || user === void 0 ? void 0 : user.email2) || '',
            label: t('users/form:email2'),
        },
        {
            type: 'default',
            name: 'phone2',
            initialValues: (user === null || user === void 0 ? void 0 : user.phone2) || '',
            label: t('users/form:phone2'),
        },
    ];
    var initialValues = __assign(__assign(__assign({}, generateInitialValues(fields)), generateInitialValues(contactFields)), generateInitialValues(spouseInformations));
    return (React__default.createElement(formik.Formik, { initialValues: initialValues, validationSchema: dist_8, onSubmit: onSubmit }, function (formikProps) { return (React__default.createElement(formik.Form, null,
        formikProps.status && (React__default.createElement(core.Box, { my: 2 },
            React__default.createElement(lab.Alert, { severity: "error" }, formikProps.status))),
        React__default.createElement(core.Box, null,
            React__default.createElement(ExpansionPanel, { expanded: true },
                React__default.createElement(core.ExpansionPanelDetails, null,
                    React__default.createElement(core.Box, { width: "100%" }, generateFields(fields, formikProps)))),
            React__default.createElement(ExpansionPanel, { defaultExpanded: true },
                React__default.createElement(ExpansionPanelSummary, { expandIcon: React__default.createElement(ExpandMoreIcon, null) },
                    React__default.createElement(core.Typography, null, t('users/form:contactInfos'))),
                React__default.createElement(core.ExpansionPanelDetails, null,
                    React__default.createElement(core.Box, { width: "100%" }, generateFields(contactFields, formikProps)))),
            React__default.createElement(ExpansionPanel, { defaultExpanded: true },
                React__default.createElement(ExpansionPanelSummary, { expandIcon: React__default.createElement(ExpandMoreIcon, null) },
                    React__default.createElement(core.Typography, null, t('users/form:spose'))),
                React__default.createElement(core.ExpansionPanelDetails, null,
                    React__default.createElement(core.Box, { width: "100%" }, generateFields(spouseInformations, formikProps))))),
        React__default.createElement(core.Box, { pt: 4, pb: 2, display: "flex", justifyContent: "center" },
            React__default.createElement(core.Button, { variant: "contained", color: "primary", type: "submit", disabled: formikProps.isSubmitting }, "Valider")))); }));
};

var tFile$2 = 'neo/distrib-slots';
var shortTKey$2 = tFile$2 + ":userInNeed";
var parseUserOptions = function (user, prevOptions) {
    var options = [];
    var getChecked = function (name, value) {
        if (!value)
            return false;
        if (prevOptions) {
            var founded = prevOptions.find(function (o) { return o.name === name; });
            return founded ? founded.checked : false;
        }
        return true;
    };
    options.push({
        name: 'email',
        label: 'email',
        value: user.email,
        checked: getChecked('email', user.email),
        disabled: false,
        canEdit: false,
    });
    var address = formatUserAddress(user);
    options.push({
        name: 'address',
        label: 'address',
        value: address,
        checked: getChecked('address', address),
        disabled: !address,
        canEdit: true,
    });
    options.push({
        name: 'phone',
        label: 'phone',
        value: user.phone,
        checked: getChecked('phone', user.phone),
        disabled: !user.phone,
        canEdit: true,
    });
    return options;
};
var PermissionsStep = function (_a) {
    var onConfirm = _a.onConfirm, onCancel = _a.onCancel;
    var t = useTranslation(['translation', tFile$2]).t;
    var _b = React__default.useState(), me = _b[0], setMe = _b[1];
    var _c = React__default.useState(), error = _c[0], setError = _c[1];
    var _d = React__default.useState([]), options = _d[0], setOptions = _d[1];
    var _e = React__default.useState(false), dialogOpened = _e[0], toggleDialogOpened = _e[1];
    var _f = React__default.useState(false), submitting = _f[0], toggleSubmitting = _f[1];
    var valid = options && !!options.find(function (option) { return option.checked; });
    /** */
    var openDialog = function () {
        toggleDialogOpened(true);
    };
    var closeDialog = function () {
        if (submitting)
            return;
        toggleDialogOpened(false);
    };
    /** */
    var onCheckoxChange = function (e) {
        setOptions(options.map(function (slot) {
            if (slot.name === e.target.name) {
                return __assign(__assign({}, slot), { checked: e.target.checked });
            }
            return slot;
        }));
    };
    var onConfirmClick = function () {
        onConfirm(options.filter(function (option) { return option.checked; }).map(function (option) { return option.name; }));
    };
    var onFormSubmit = function (values, bag) { return __awaiter(void 0, void 0, void 0, function () {
        var formData_1, user, err_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    toggleSubmitting(true);
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, , 4]);
                    formData_1 = new FormData();
                    Object.keys(values).forEach(function (key) {
                        formData_1.append(key, values[key]);
                    });
                    return [4 /*yield*/, api$1.updateMe(formData_1, 'data')];
                case 2:
                    user = _a.sent();
                    if (!user)
                        throw new Error('');
                    setMe(user);
                    setOptions(parseUserOptions(user, options));
                    toggleSubmitting(false);
                    bag.setErrors(t('error'));
                    bag.setSubmitting(false);
                    setTimeout(function () {
                        closeDialog();
                    });
                    return [3 /*break*/, 4];
                case 3:
                    err_1 = _a.sent();
                    toggleSubmitting(false);
                    bag.setStatus(t('error', { error: err_1 }));
                    bag.setSubmitting(false);
                    return [3 /*break*/, 4];
                case 4: return [2 /*return*/];
            }
        });
    }); };
    /** */
    React__default.useEffect(function () {
        var active = true;
        var fetchMe = function () { return __awaiter(void 0, void 0, void 0, function () {
            var user, err_2;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        _a.trys.push([0, 2, , 3]);
                        return [4 /*yield*/, api$1.me()];
                    case 1:
                        user = _a.sent();
                        if (active && user) {
                            setMe(user);
                            setOptions(parseUserOptions(user));
                        }
                        return [3 /*break*/, 3];
                    case 2:
                        err_2 = _a.sent();
                        setError(t('error'));
                        return [3 /*break*/, 3];
                    case 3: return [2 /*return*/];
                }
            });
        }); };
        fetchMe();
        return function () {
            active = false;
        };
    }, []);
    /** */
    return (React__default.createElement(React__default.Fragment, null,
        React__default.createElement(core.Box, null,
            React__default.createElement(core.Typography, { color: "primary" }, t(shortTKey$2 + ".consentement")),
            error && React__default.createElement(lab.Alert, { severity: "error" }, error),
            !me ? (React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                React__default.createElement(core.CircularProgress, null))) : (React__default.createElement(React__default.Fragment, null,
                React__default.createElement(core.List, null, options.map(function (option) { return (React__default.createElement(core.ListItem, { key: option.name },
                    React__default.createElement(core.ListItemText, { primary: t(option.label), secondary: option.value || t(shortTKey$2 + ".no" + option.label) }),
                    React__default.createElement(core.ListItemSecondaryAction, null,
                        option.canEdit && (React__default.createElement(core.ListItemIcon, null,
                            React__default.createElement(core.IconButton, { onClick: openDialog },
                                React__default.createElement(EditIcon, null)))),
                        React__default.createElement(core.ListItemIcon, null,
                            React__default.createElement(core.Checkbox, { checked: option.checked, disabled: option.disabled, name: option.name, tabIndex: -1, disableRipple: true, onChange: onCheckoxChange }))))); })),
                React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                    React__default.createElement(core.Button, { onClick: onCancel }, t('cancel')),
                    React__default.createElement(core.Box, { mx: 1 }),
                    React__default.createElement(core.Button, { variant: "contained", color: "primary", disabled: !valid, onClick: onConfirmClick }, t('validate')))))),
        React__default.createElement(core.Dialog, { open: dialogOpened, onClose: closeDialog },
            React__default.createElement(React__default.Fragment, null, me && (React__default.createElement(React__default.Fragment, null,
                React__default.createElement(core.Box, { pt: 2, px: 2 },
                    React__default.createElement(core.Typography, { variant: "h6" }, t(shortTKey$2 + ".userFormTitle"))),
                React__default.createElement(core.Box, { px: 2 },
                    React__default.createElement(UserForm, { user: me, onSubmit: onFormSubmit }))))))));
};

var tFile$3 = 'neo/distrib-slots';
var shortTKey$3 = tFile$3 + ":userSlotsSelector.selector";
var GreenLinearProgress = core.withStyles({
    colorPrimary: {
        opacity: 0.5,
        backgroundColor: '#e8f5e9',
    },
    barColorPrimary: {
        backgroundColor: '#4caf50',
    },
})(core.LinearProgress);
var OrangeLinearProgress = core.withStyles({
    colorPrimary: {
        opacity: 0.5,
        backgroundColor: '#fff3e0',
    },
    barColorPrimary: {
        backgroundColor: '#e65100',
    },
})(core.LinearProgress);
var SlotsStep = function (_a) {
    var slots = _a.slots, isLastStep = _a.isLastStep, onSelect = _a.onSelect, onCancel = _a.onCancel;
    var t = useTranslation(['translation', tFile$3]).t;
    var maxUserRegistered = slots.reduce(function (acc, slot) {
        if (acc < slot.registeredUserIds.length)
            return slot.registeredUserIds.length;
        return acc;
    }, 0);
    var _b = React__default.useState(slots.map(function (slot) {
        var prc = maxUserRegistered > 0 ? slot.registeredUserIds.length / maxUserRegistered : 0;
        return __assign(__assign({}, slot), { name: "slot-" + slot.id, checked: prc <= 0.75, nbUsers: slot.registeredUserIds.length, prc: prc });
    })), selection = _b[0], setSelection = _b[1];
    var valid = !!selection.find(function (slot) { return slot.checked; });
    /** */
    var onCheckoxChange = function (e) {
        setSelection(selection.map(function (slot) {
            if (slot.name === e.target.name) {
                return __assign(__assign({}, slot), { checked: e.target.checked });
            }
            return slot;
        }));
    };
    var onNextClick = function () {
        if (!valid)
            return;
        onSelect(selection.reduce(function (acc, slot) {
            if (slot.checked) {
                acc.push(slot.id);
            }
            return acc;
        }, []));
    };
    /** */
    return (React__default.createElement(React__default.Fragment, null,
        React__default.createElement(core.Box, { mb: 2 },
            React__default.createElement(core.Typography, { color: "primary", variant: "h6", align: "center" }, t(shortTKey$3 + ".chooseSlot")),
            React__default.createElement(core.Box, { mt: 1 },
                React__default.createElement(core.Typography, { variant: "body2", align: "center" }, t(shortTKey$3 + ".chooseSlotSub")))),
        React__default.createElement(core.List, null, selection.map(function (slot) { return (React__default.createElement(React__default.Fragment, { key: slot.name },
            React__default.createElement(core.ListItem, null,
                React__default.createElement(core.ListItemText, { primary: "De " + format$1(slot.start, "HH'h'mm") + " \u00E0 " + format$1(slot.end, "HH'h'mm"), secondary: t(shortTKey$3 + "." + (slot.prc === 0 ? 'noneUsersInSlot' : 'usersInSlot'), {
                        count: slot.nbUsers,
                    }) }),
                React__default.createElement(core.ListItemSecondaryAction, null,
                    React__default.createElement(core.ListItemIcon, null,
                        React__default.createElement(core.Checkbox, { checked: slot.checked, name: slot.name, tabIndex: -1, disableRipple: true, onChange: onCheckoxChange })))),
            React__default.createElement(core.Box, { px: 2, pr: 4, mb: 2 }, slot.prc > 0.75 ? (React__default.createElement(OrangeLinearProgress, { variant: "determinate", value: slot.prc * 90 })) : (React__default.createElement(GreenLinearProgress, { variant: "determinate", value: slot.prc * 100 }))))); })),
        React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
            onCancel && (React__default.createElement(core.Box, { mr: 2 },
                React__default.createElement(core.Button, { onClick: onCancel }, t('cancel')))),
            React__default.createElement(core.Button, { variant: isLastStep ? 'contained' : 'outlined', color: "primary", disabled: !valid, onClick: onNextClick }, t(isLastStep ? 'validate' : 'continue')))));
};

var InNeedUserListItem = function (_a) {
    var user = _a.user, userInfos = _a.userInfos, children = _a.children;
    return (React__default.createElement(core.ListItem, { alignItems: "center" },
        React__default.createElement(core.ListItemText
        // primary={`${user.firstName} ${user.lastName}`}
        , { 
            // primary={`${user.firstName} ${user.lastName}`}
            primary: React__default.createElement(core.Box, { component: "span", display: "flex", justifyContent: "center" },
                React__default.createElement(core.Typography, { component: "span" }, user.firstName + " " + user.lastName)), secondary: React__default.createElement(core.Box, { component: "span", display: "flex", flexDirection: "column", alignItems: "center" },
                userInfos && userInfos.includes('address') && (React__default.createElement(core.Typography, { variant: "body2", color: "textSecondary", component: "span" }, formatUserAddress(user))),
                userInfos && userInfos.includes('phone') && (React__default.createElement(core.Typography, { variant: "body2", color: "textSecondary", component: "span" }, user.phone)),
                userInfos && userInfos.includes('email') && (React__default.createElement(core.Typography, { variant: "body2", color: "textSecondary", component: "span" }, user.email))) }),
        children && React__default.createElement(core.ListItemSecondaryAction, null, children)));
};

var tFile$4 = 'neo/distrib-slots';
var shortTKey$4 = tFile$4 + ":userInNeedSelected";
var VoluntaryStep = function (_a) {
    var inNeedUsers = _a.inNeedUsers, onConfirm = _a.onConfirm, onCancel = _a.onCancel;
    var t = useTranslation(['translation', tFile$4]).t;
    var _b = React__default.useState(inNeedUsers.map(function (user) { return (__assign(__assign({}, user), { fieldName: "user-" + user.id, checked: false })); })), users = _b[0], setUsers = _b[1];
    /** */
    var onCheckoxChange = function (e) {
        setUsers(users.map(function (user) {
            if (user.fieldName === e.target.name) {
                return __assign(__assign({}, user), { checked: e.target.checked });
            }
            return user;
        }));
    };
    var onConfirmClick = function () {
        onConfirm(users.filter(function (user) { return user.checked; }).map(function (user) { return user.id; }));
    };
    /** */
    return (React__default.createElement(core.Box, null,
        React__default.createElement(core.Typography, { color: "primary" }, t(shortTKey$4 + ".choose")),
        React__default.createElement(core.List, null, users.map(function (user) { return (React__default.createElement(InNeedUserListItem, { key: user.id, user: user, userInfos: ['address'] },
            React__default.createElement(core.ListItemIcon, null,
                React__default.createElement(core.Checkbox, { checked: user.checked, name: user.fieldName, tabIndex: -1, disableRipple: true, onChange: onCheckoxChange })))); })),
        React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
            React__default.createElement(core.Button, { onClick: onCancel }, t('cancel')),
            React__default.createElement(core.Box, { mx: 2 }),
            React__default.createElement(core.Button, { variant: "contained", color: "primary", onClick: onConfirmClick }, t('validate')))));
};

var tFile$5 = 'neo/distrib-slots';
var shortTKey$5 = tFile$5 + ":userSlotsSelector";
var SummaryStep = function (_a) {
    var mode = _a.mode, slots = _a.slots, registeredSlotIds = _a.registeredSlotIds, voluntaryFor = _a.voluntaryFor, inNeedUsers = _a.inNeedUsers, onSalesProcess = _a.onSalesProcess, changeSlots = _a.changeSlots, addInNeeds = _a.addInNeeds, close = _a.close;
    var t = useTranslation(['translation', tFile$5]).t;
    var confirmMessage = '';
    if (mode === 'inNeed') {
        confirmMessage = t(shortTKey$5 + ".end.inNeed");
    }
    else if (mode === 'voluntary') {
        confirmMessage = t(shortTKey$5 + ".end.voluntary");
    }
    else {
        confirmMessage = t(shortTKey$5 + ".end.solo");
    }
    return (React__default.createElement(core.Box, { py: 2 },
        React__default.createElement(core.Typography, { align: "center" }, confirmMessage),
        registeredSlotIds && registeredSlotIds.length > 0 && (React__default.createElement(core.Box, { mt: 2 },
            React__default.createElement(core.Box, { display: "flex", flexDirection: "column", alignItems: "center" },
                React__default.createElement(core.Typography, { variant: "h6", color: "primary" }, t(shortTKey$5 + ".selectedSlots")),
                React__default.createElement(core.List, null, slots
                    .filter(function (s) { return (registeredSlotIds === null || registeredSlotIds === void 0 ? void 0 : registeredSlotIds.includes(s.id)) || false; })
                    .map(function (slot) { return (React__default.createElement(core.ListItem, { key: slot.id, alignItems: "center" },
                    React__default.createElement(core.ListItemText, { primary: "De " + format$1(slot.start, "HH'h'mm") + " \u00E0 " + format$1(slot.end, "HH'h'mm") }))); })),
                React__default.createElement(core.Box, { p: 1 },
                    React__default.createElement(core.Button, { variant: !onSalesProcess ? 'contained' : 'outlined', color: "primary", onClick: changeSlots }, t('change')))))),
        React__default.createElement(core.Box, { my: 2 },
            React__default.createElement(core.Divider, null)),
        voluntaryFor && voluntaryFor.length > 0 && (React__default.createElement(core.Box, null,
            React__default.createElement(core.Typography, { align: "center" }, t(shortTKey$5 + ".end.voluntaryDetails")),
            React__default.createElement(core.List, null, voluntaryFor.map(function (user) { return (React__default.createElement(InNeedUserListItem, { key: user.id, user: user, userInfos: ['adress', 'email', 'phone'] })); })))),
        mode === 'voluntary' && inNeedUsers && inNeedUsers.length > 0 && (React__default.createElement(core.Box, { p: 1, display: "flex", justifyContent: "center" },
            React__default.createElement(core.Button, { variant: !onSalesProcess ? 'contained' : 'outlined', color: "primary", onClick: addInNeeds }, t('add')))),
        React__default.createElement(core.Box, { my: 2 },
            React__default.createElement(core.Divider, null)),
        React__default.createElement(core.Box, { display: "flex", justifyContent: "center" },
            React__default.createElement(core.Button, { variant: onSalesProcess ? 'contained' : 'outlined', color: onSalesProcess ? 'primary' : 'default', onClick: close }, t(onSalesProcess ? 'continue' : 'close')))));
};

var UserDistribSlotsSelectorView = function (_a) {
    var _b = _a.onSalesProcess, onSalesProcess = _b === void 0 ? false : _b;
    var _c = useViewCtx(), currentStep = _c.currentStep, open = _c.open, loading = _c.loading, error = _c.error, distribMode = _c.distribMode, mode = _c.mode, slots = _c.slots, inNeedUsers = _c.inNeedUsers, registeredSlotIds = _c.registeredSlotIds, voluntaryFor = _c.voluntaryFor, closeDialog = _c.closeDialog, back = _c.back, selectMode = _c.selectMode, selectPermissions = _c.selectPermissions, selectSlots = _c.selectSlots, selectInNeedUsers = _c.selectInNeedUsers, changeSlots = _c.changeSlots, addInNeeds = _c.addInNeeds;
    /** */
    var renderStep = function () {
        if (currentStep === 'loading' || loading)
            return (React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                React__default.createElement(core.CircularProgress, null)));
        switch (currentStep) {
            case 'select-mode':
                return React__default.createElement(ModeStep, { onSelect: selectMode });
            case 'select-permissions':
                return React__default.createElement(PermissionsStep, { onConfirm: selectPermissions, onCancel: back });
            case 'select-slots':
                return (React__default.createElement(SlotsStep, { slots: slots, isLastStep: mode === 'solo', onSelect: selectSlots, onCancel: distribMode === 'default' ? back : undefined }));
            case 'select-inNeed':
                return React__default.createElement(VoluntaryStep, { inNeedUsers: inNeedUsers, onConfirm: selectInNeedUsers, onCancel: back });
            case 'summary':
                return (React__default.createElement(SummaryStep, { mode: mode, slots: slots, registeredSlotIds: registeredSlotIds, voluntaryFor: voluntaryFor, inNeedUsers: inNeedUsers, onSalesProcess: onSalesProcess, changeSlots: changeSlots, addInNeeds: addInNeeds, close: closeDialog }));
            case 'resolved':
                return React__default.createElement("div", null, "resolved");
            default:
                return React__default.createElement(React__default.Fragment, null);
        }
    };
    /** */
    return (React__default.createElement(MasterDialog, { open: open, canClose: loading, onClose: closeDialog },
        error && (React__default.createElement(core.Box, { p: 2 },
            React__default.createElement(lab.Alert, { severity: "error" }, error))),
        renderStep()));
};
var UserDistribSlotsSelectorView$1 = withNeolithicProvider(withi18n(function (_a) {
    var distribId = _a.distribId, onRegister = _a.onRegister, onCancel = _a.onCancel, onSalesProcess = _a.onSalesProcess;
    return (React__default.createElement(ViewCtxProvider, { distribId: distribId, onRegister: onRegister, onCancel: onCancel },
        React__default.createElement(UserDistribSlotsSelectorView, { onSalesProcess: onSalesProcess })));
}));

var Print = createCommonjsModule(function (module, exports) {



Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = interopRequireDefault(React__default);

var _createSvgIcon = interopRequireDefault(createSvgIcon_1);

var _default = (0, _createSvgIcon.default)(_react.default.createElement("path", {
  d: "M19 8H5c-1.66 0-3 1.34-3 3v6h4v4h12v-4h4v-6c0-1.66-1.34-3-3-3zm-3 11H8v-5h8v5zm3-7c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm-1-9H6v4h12V3z"
}), 'Print');

exports.default = _default;
});

var PrintIcon = unwrapExports(Print);

var lib = createCommonjsModule(function (module, exports) {
!function(t,e){module.exports=e(React__default,ReactDOM);}("undefined"!=typeof self?self:commonjsGlobal,(function(t,e){return function(t){var e={};function n(r){if(e[r])return e[r].exports;var o=e[r]={i:r,l:!1,exports:{}};return t[r].call(o.exports,o,o.exports,n),o.l=!0,o.exports}return n.m=t,n.c=e,n.d=function(t,e,r){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:r});},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0});},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var r=Object.create(null);if(n.r(r),Object.defineProperty(r,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var o in t)n.d(r,o,function(e){return t[e]}.bind(null,o));return r},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=0)}([function(t,e,n){Object.defineProperty(e,"__esModule",{value:!0});var r=n(1),o=n(2),i=n(3),a=function(t){function e(){var e=null!==t&&t.apply(this,arguments)||this;return e.startPrint=function(t,n){var r=e.props.removeAfterPrint;setTimeout((function(){if(t.contentWindow.focus(),t.contentWindow.print(),n&&n(),r){var e=document.getElementById("printWindow");e&&document.body.removeChild(e);}}),500);},e.triggerPrint=function(t){var n=e.props,r=n.onAfterPrint,o=n.onBeforePrint,i=n.onPrintError;if(o){var a=o();a&&"function"==typeof a.then?a.then((function(){e.startPrint(t,r);})).catch((function(t){i&&i("onBeforePrint",t);})):e.startPrint(t,r);}else e.startPrint(t,r);},e.handleClick=function(){var t=e.props,n=t.onBeforeGetContent,r=t.onPrintError;if(n){var o=n();o&&"function"==typeof o.then?o.then(e.handlePrint).catch((function(t){r&&r("onBeforeGetContent",t);})):e.handlePrint();}else e.handlePrint();},e.handlePrint=function(){var t=e.props,n=t.bodyClass,r=void 0===n?"":n,o=t.content,a=t.copyStyles,u=void 0===a||a,c=t.pageStyle,l=t.suppressErrors,f=o();if(void 0!==f)if(null!==f){var s=document.createElement("iframe");s.style.position="absolute",s.style.top="-1000px",s.style.left="-1000px",s.id="printWindow",s.title="Print Window";var d=i.findDOMNode(f),p=document.querySelectorAll("link[rel='stylesheet'], img");e.linkTotal=p.length||0,e.linksLoaded=[],e.linksErrored=[];var y=function(t,n){n?e.linksLoaded.push(t):(l||console.error('"react-to-print" was unable to load a link. It may be invalid. "react-to-print" will continue attempting to print the page. The link the errored was:',t),e.linksErrored.push(t)),e.linksLoaded.length+e.linksErrored.length===e.linkTotal&&e.triggerPrint(s);};s.onload=function(){window.navigator&&window.navigator.userAgent.indexOf("Trident/7.0")>-1&&(s.onload=null);var t=s.contentDocument||s.contentWindow.document,n=d.querySelectorAll("canvas");if(t){t.open(),t.write(d.outerHTML),t.close();var o=void 0===c?"@page { size: auto;  margin: 0mm; } @media print { body { -webkit-print-color-adjust: exact; } }":c,i=t.createElement("style");i.appendChild(t.createTextNode(o)),t.head.appendChild(i),r.length&&t.body.classList.add(r);for(var a=t.querySelectorAll("canvas"),l=0,f=a.length;l<f;++l){var p=(v=a[l]).getContext("2d");p&&p.drawImage(n[l],0,0);}if(!1!==u)for(var h=document.querySelectorAll("style, link[rel='stylesheet'], img"),b=(l=0,h.length);l<b;++l){var v;if("STYLE"===(v=h[l]).tagName){var m=t.createElement(v.tagName),g=v.sheet;if(g){for(var w="",_=0,P=g.cssRules.length;_<P;++_)"string"==typeof g.cssRules[_].cssText&&(w+=g.cssRules[_].cssText+"\r\n");m.setAttribute("id","react-to-print-"+l),m.appendChild(t.createTextNode(w)),t.head.appendChild(m);}}else if(v.hasAttribute("href")&&v.getAttribute("href")||v.hasAttribute("src")&&v.getAttribute("src")){m=t.createElement(v.tagName),_=0;for(var x=v.attributes.length;_<x;++_){var O=v.attributes[_];O&&m.setAttribute(O.nodeName,O.nodeValue||"");}m.onload=y.bind(null,m,!0),m.onerror=y.bind(null,m,!1),t.head.appendChild(m);}else console.warn('"react-to-print" encountered a <link> tag with an empty "href" attribute. In addition to being invalid HTML, this can cause problems in many browsers, and so the <link> was not loaded. The <link> is:',v),y(v,!0);}}0!==e.linkTotal&&!1!==u||e.triggerPrint(s);};var h=document.getElementById("printWindow");h&&document.body.removeChild(h),document.body.appendChild(s);}else l||console.error('There is nothing to print because the "content" prop returned "null". Please ensure "content" is renderable before allowing "react-to-print" to be called.');else l||console.error('Refs are not available for stateless components. For "react-to-print" to work only Class based components can be printed');},e}return r.__extends(e,t),e.prototype.render=function(){var t=this.props.trigger;return o.cloneElement(t(),{onClick:this.handleClick})},e}(o.Component);e.default=a;},function(t,e,n){n.r(e),n.d(e,"__extends",(function(){return o})),n.d(e,"__assign",(function(){return i})),n.d(e,"__rest",(function(){return a})),n.d(e,"__decorate",(function(){return u})),n.d(e,"__param",(function(){return c})),n.d(e,"__metadata",(function(){return l})),n.d(e,"__awaiter",(function(){return f})),n.d(e,"__generator",(function(){return s})),n.d(e,"__exportStar",(function(){return d})),n.d(e,"__values",(function(){return p})),n.d(e,"__read",(function(){return y})),n.d(e,"__spread",(function(){return h})),n.d(e,"__await",(function(){return b})),n.d(e,"__asyncGenerator",(function(){return v})),n.d(e,"__asyncDelegator",(function(){return m})),n.d(e,"__asyncValues",(function(){return g})),n.d(e,"__makeTemplateObject",(function(){return w})),n.d(e,"__importStar",(function(){return _})),n.d(e,"__importDefault",(function(){return P}));
/*! *****************************************************************************
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at http://www.apache.org/licenses/LICENSE-2.0

THIS CODE IS PROVIDED ON AN *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
MERCHANTABLITY OR NON-INFRINGEMENT.

See the Apache Version 2.0 License for specific language governing permissions
and limitations under the License.
***************************************************************************** */
var r=function(t,e){return (r=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(t,e){t.__proto__=e;}||function(t,e){for(var n in e)e.hasOwnProperty(n)&&(t[n]=e[n]);})(t,e)};function o(t,e){function n(){this.constructor=t;}r(t,e),t.prototype=null===e?Object.create(e):(n.prototype=e.prototype,new n);}var i=function(){return (i=Object.assign||function(t){for(var e,n=1,r=arguments.length;n<r;n++)for(var o in e=arguments[n])Object.prototype.hasOwnProperty.call(e,o)&&(t[o]=e[o]);return t}).apply(this,arguments)};function a(t,e){var n={};for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&e.indexOf(r)<0&&(n[r]=t[r]);if(null!=t&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(t);o<r.length;o++)e.indexOf(r[o])<0&&(n[r[o]]=t[r[o]]);}return n}function u(t,e,n,r){var o,i=arguments.length,a=i<3?e:null===r?r=Object.getOwnPropertyDescriptor(e,n):r;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)a=Reflect.decorate(t,e,n,r);else for(var u=t.length-1;u>=0;u--)(o=t[u])&&(a=(i<3?o(a):i>3?o(e,n,a):o(e,n))||a);return i>3&&a&&Object.defineProperty(e,n,a),a}function c(t,e){return function(n,r){e(n,r,t);}}function l(t,e){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(t,e)}function f(t,e,n,r){return new(n||(n=Promise))((function(o,i){function a(t){try{c(r.next(t));}catch(t){i(t);}}function u(t){try{c(r.throw(t));}catch(t){i(t);}}function c(t){t.done?o(t.value):new n((function(e){e(t.value);})).then(a,u);}c((r=r.apply(t,e||[])).next());}))}function s(t,e){var n,r,o,i,a={label:0,sent:function(){if(1&o[0])throw o[1];return o[1]},trys:[],ops:[]};return i={next:u(0),throw:u(1),return:u(2)},"function"==typeof Symbol&&(i[Symbol.iterator]=function(){return this}),i;function u(i){return function(u){return function(i){if(n)throw new TypeError("Generator is already executing.");for(;a;)try{if(n=1,r&&(o=2&i[0]?r.return:i[0]?r.throw||((o=r.return)&&o.call(r),0):r.next)&&!(o=o.call(r,i[1])).done)return o;switch(r=0,o&&(i=[2&i[0],o.value]),i[0]){case 0:case 1:o=i;break;case 4:return a.label++,{value:i[1],done:!1};case 5:a.label++,r=i[1],i=[0];continue;case 7:i=a.ops.pop(),a.trys.pop();continue;default:if(!(o=(o=a.trys).length>0&&o[o.length-1])&&(6===i[0]||2===i[0])){a=0;continue}if(3===i[0]&&(!o||i[1]>o[0]&&i[1]<o[3])){a.label=i[1];break}if(6===i[0]&&a.label<o[1]){a.label=o[1],o=i;break}if(o&&a.label<o[2]){a.label=o[2],a.ops.push(i);break}o[2]&&a.ops.pop(),a.trys.pop();continue}i=e.call(t,a);}catch(t){i=[6,t],r=0;}finally{n=o=0;}if(5&i[0])throw i[1];return {value:i[0]?i[1]:void 0,done:!0}}([i,u])}}}function d(t,e){for(var n in t)e.hasOwnProperty(n)||(e[n]=t[n]);}function p(t){var e="function"==typeof Symbol&&t[Symbol.iterator],n=0;return e?e.call(t):{next:function(){return t&&n>=t.length&&(t=void 0),{value:t&&t[n++],done:!t}}}}function y(t,e){var n="function"==typeof Symbol&&t[Symbol.iterator];if(!n)return t;var r,o,i=n.call(t),a=[];try{for(;(void 0===e||e-- >0)&&!(r=i.next()).done;)a.push(r.value);}catch(t){o={error:t};}finally{try{r&&!r.done&&(n=i.return)&&n.call(i);}finally{if(o)throw o.error}}return a}function h(){for(var t=[],e=0;e<arguments.length;e++)t=t.concat(y(arguments[e]));return t}function b(t){return this instanceof b?(this.v=t,this):new b(t)}function v(t,e,n){if(!Symbol.asyncIterator)throw new TypeError("Symbol.asyncIterator is not defined.");var r,o=n.apply(t,e||[]),i=[];return r={},a("next"),a("throw"),a("return"),r[Symbol.asyncIterator]=function(){return this},r;function a(t){o[t]&&(r[t]=function(e){return new Promise((function(n,r){i.push([t,e,n,r])>1||u(t,e);}))});}function u(t,e){try{(n=o[t](e)).value instanceof b?Promise.resolve(n.value.v).then(c,l):f(i[0][2],n);}catch(t){f(i[0][3],t);}var n;}function c(t){u("next",t);}function l(t){u("throw",t);}function f(t,e){t(e),i.shift(),i.length&&u(i[0][0],i[0][1]);}}function m(t){var e,n;return e={},r("next"),r("throw",(function(t){throw t})),r("return"),e[Symbol.iterator]=function(){return this},e;function r(r,o){e[r]=t[r]?function(e){return (n=!n)?{value:b(t[r](e)),done:"return"===r}:o?o(e):e}:o;}}function g(t){if(!Symbol.asyncIterator)throw new TypeError("Symbol.asyncIterator is not defined.");var e,n=t[Symbol.asyncIterator];return n?n.call(t):(t=p(t),e={},r("next"),r("throw"),r("return"),e[Symbol.asyncIterator]=function(){return this},e);function r(n){e[n]=t[n]&&function(e){return new Promise((function(r,o){(function(t,e,n,r){Promise.resolve(r).then((function(e){t({value:e,done:n});}),e);})(r,o,(e=t[n](e)).done,e.value);}))};}}function w(t,e){return Object.defineProperty?Object.defineProperty(t,"raw",{value:e}):t.raw=e,t}function _(t){if(t&&t.__esModule)return t;var e={};if(null!=t)for(var n in t)Object.hasOwnProperty.call(t,n)&&(e[n]=t[n]);return e.default=t,e}function P(t){return t&&t.__esModule?t:{default:t}}},function(e,n){e.exports=t;},function(t,n){t.exports=e;}])}));
});

var ReactToPrint = unwrapExports(lib);
var lib_1 = lib.lib;

var tFile$6 = 'neo/distrib-slots';
var shortTKey$6 = tFile$6 + ":resolver";
var InNeedNotResolvedUsersTable = function (_a) {
    var users = _a.users;
    var t = useTranslation(['translation', tFile$6]).t;
    /** */
    return (React__default.createElement(core.Box, { p: 2 },
        React__default.createElement(core.Table, { size: "small" },
            React__default.createElement(core.TableHead, null,
                React__default.createElement(core.TableRow, null,
                    React__default.createElement(core.TableCell, { align: "center", style: {
                            backgroundColor: '#F1F1F1',
                            fontWeight: 700,
                        }, colSpan: 2 }, t(shortTKey$6 + ".userInNeedsNotLocked")))),
            React__default.createElement(core.TableBody, null, users.map(function (user) { return (React__default.createElement(core.TableRow, { key: user.id },
                React__default.createElement(core.TableCell, null, user.firstName + " " + user.lastName),
                React__default.createElement(core.TableCell, null, formatUserAddress(user)))); })))));
};

var tFile$7 = 'neo/distrib-slots';
var shortTKey$7 = tFile$7 + ":resolver";
var formatSlot = function (slot) { return "De " + format$1(slot.start, "HH'h'mm") + " \u00E0 " + format$1(slot.end, "HH'h'mm"); };
var formatUser = function (user) {
    return user.firstName.charAt(0).toUpperCase() + user.firstName.slice(1) + " " + user.lastName.toUpperCase() + "\n ";
};
var SlotsResolvedTable = function (_a) {
    var distrib = _a.distrib;
    var t = useTranslation(['translation', tFile$7]).t;
    /** */
    var getInNeedUsersOfVoluntaryList = function (userId) {
        if (!distrib)
            return [];
        if (!Object.keys(distrib.voluntaryMap).includes("" + userId))
            return [];
        var res = [];
        var v = distrib.voluntaryMap["" + userId];
        if (v) {
            v.forEach(function (id) {
                var inNeed = (distrib.inNeedUsers || []).find(function (u) { return u.id === id; });
                if (inNeed)
                    res.push(inNeed);
            });
        }
        return res.map(formatUser).join(', ');
    };
    /** */
    var renderSlotHalfTable = function (users) {
        return (React__default.createElement(core.Table, { size: "small" },
            React__default.createElement(core.TableHead, null,
                React__default.createElement(core.TableRow, null,
                    React__default.createElement(core.TableCell, { align: "center", style: {
                            backgroundColor: '#F1F1F1',
                            fontWeight: 700,
                        } }, t(shortTKey$7 + ".user")),
                    React__default.createElement(core.TableCell, { align: "center", style: {
                            backgroundColor: '#F1F1F1',
                            fontWeight: 700,
                        } }, t(shortTKey$7 + ".getOrderFor")))),
            React__default.createElement(core.TableBody, null, users.map(function (user) { return (React__default.createElement(core.TableRow, { key: user.id },
                React__default.createElement(core.TableCell, null, Object.keys(distrib.voluntaryMap).includes("" + user.id) ? (React__default.createElement("b", null, formatUser(user) + "*")) : (formatUser(user))),
                React__default.createElement(core.TableCell, { align: "center" }, getInNeedUsersOfVoluntaryList(user.id)))); }))));
    };
    var renderSlotTable = function (slot) {
        var users = slot.selectedUserIds
            .map(function (id) { return distrib.users.find(function (u) { return u.id === id; }); })
            .sort(function (u1, u2) { return u1.lastName.toUpperCase().localeCompare(u2.lastName.toUpperCase()); });
        var half = Math.ceil(users.length / 2);
        return (React__default.createElement(core.Box, { display: "flex" },
            React__default.createElement(core.Box, { flex: 1 }, renderSlotHalfTable(users.slice(0, half))),
            React__default.createElement(core.Box, { width: 2, border: "1px solid #ccc" }),
            React__default.createElement(core.Box, { flex: 1 }, half + 1 <= users.length && renderSlotHalfTable(users.slice(half, users.length)))));
    };
    /** */
    return (React__default.createElement(core.CardContent, null,
        distrib.slots &&
            distrib.slots
                .filter(function (slot) { return slot.selectedUserIds.length > 0; })
                .map(function (slot) { return (React__default.createElement(React__default.Fragment, { key: slot.id },
                React__default.createElement(core.Box, { mb: 2 },
                    React__default.createElement(core.Box, { p: 1, bgcolor: "#F5F5F5" },
                        React__default.createElement(core.Typography, { align: "center" }, formatSlot(slot))),
                    renderSlotTable(slot)))); }),
        React__default.createElement(core.Box, { pt: 2 },
            React__default.createElement(core.Typography, null,
                React__default.createElement("b", null, "*"),
                React__default.createElement("span", null, " " + t(shortTKey$7 + ".voluntaries"))))));
};

var tFile$8 = 'neo/distrib-slots';
var shortTKey$8 = tFile$8 + ":resolver";
var DistribSlotsResolver = function (_a) {
    var distribId = _a.distribId;
    var t = useTranslation(['translation', tFile$8]).t;
    var toPrintRef = React__default.useRef(null);
    var _b = React__default.useState(), distrib = _b[0], setDistrib = _b[1];
    /** */
    React__default.useEffect(function () {
        var active = true;
        var load = function () { return __awaiter(void 0, void 0, void 0, function () {
            var res;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, api$1.distrib.getResolvedDistrib(distribId, function (data) {
                            return __assign(__assign({}, parseDistribVo(data)), { voluntaryMap: data.voluntaryMap ? data.voluntaryMap : {}, users: data.users ? data.users.map(parseUserVo) : [], otherUsers: data.otherUsers ? data.otherUsers.map(parseUserVo) : [] });
                        })];
                    case 1:
                        res = _a.sent();
                        if (active && res) {
                            setDistrib(res);
                        }
                        return [2 /*return*/];
                }
            });
        }); };
        load();
        return function () {
            active = false;
        };
    }, []);
    /** */
    if (!distrib)
        return (React__default.createElement(core.Box, { p: 2 },
            React__default.createElement(core.CircularProgress, null)));
    if (!distrib.slots || !distrib.orderEndDate)
        return (React__default.createElement(core.Card, null,
            React__default.createElement(core.CardContent, null,
                React__default.createElement(core.Typography, null, t(shortTKey$8 + ".slotsNotActivated")))));
    if (isBefore(new Date(), distrib.orderEndDate)) {
        return (React__default.createElement(core.Card, null,
            React__default.createElement(core.CardContent, null,
                React__default.createElement(core.Typography, null, t(shortTKey$8 + ".distribNotClosed")))));
    }
    var isResolved = distrib.slots.reduce(function (acc, slot) {
        if (acc || slot.selectedUserIds.length > 0)
            return true;
        return acc;
    }, false);
    if (!isResolved) {
        return (React__default.createElement(core.Card, null,
            React__default.createElement(core.CardContent, null,
                React__default.createElement(core.Typography, null, t(shortTKey$8 + ".resolving")))));
    }
    var iNeedLockedUserIds = Object.values(distrib.voluntaryMap).reduce(function (acc, vs) { return __spreadArrays(acc, vs); }, []);
    var inNeedUsersNotLocked = (distrib.inNeedUsers || []).filter(function (u) { return !iNeedLockedUserIds.includes(u.id); });
    return (React__default.createElement(React__default.Fragment, null,
        React__default.createElement(core.Card, null,
            React__default.createElement("div", { ref: toPrintRef },
                inNeedUsersNotLocked.length > 0 && (React__default.createElement(core.CardContent, null,
                    React__default.createElement(InNeedNotResolvedUsersTable, { users: inNeedUsersNotLocked }))),
                distrib.slots && (React__default.createElement(core.CardContent, null,
                    React__default.createElement(SlotsResolvedTable, { distrib: distrib }))),
                distrib.otherUsers && distrib.otherUsers.length > 0 && (React__default.createElement(core.CardContent, null,
                    React__default.createElement(core.Typography, null, t(shortTKey$8 + ".otherUsersList", {
                        list: distrib.otherUsers.map(function (u) { return u.firstName + " " + u.lastName; }).join(', '),
                    }))))),
            React__default.createElement(core.Box, { p: 2, pt: 0, display: "flex", justifyContent: "center" },
                React__default.createElement(ReactToPrint, { trigger: function () { return (React__default.createElement(core.Button, { variant: "contained", color: "primary", startIcon: React__default.createElement(PrintIcon, null) },
                        React__default.createElement(core.Typography, null, "Imprimer"))); }, content: function () { return toPrintRef.current; } })))));
};
var DistribSlotsResolver$1 = withNeolithicProvider(withi18n(DistribSlotsResolver));

var useStyles$2 = core.makeStyles(function () { return ({
    map: {
        width: '100%',
        height: '100%',
    },
}); });
var firstLetterToUpperCase = function (s) { return "" + s.charAt(0).toUpperCase() + s.slice(1).toLocaleLowerCase(); };
var formatAddress = function (place) {
    var res = '';
    if (place.address1) {
        res = "" + place.address1;
        if (place.address2) {
            res = res + " " + place.address2;
        }
        res = res + " ";
    }
    if (place.zipCode) {
        res = res + " " + place.zipCode;
    }
    if (place.city) {
        res = res + " " + firstLetterToUpperCase(place.city);
    }
    return res;
};
var PlaceDialogView = function (_a) {
    var placeId = _a.placeId, onClose = _a.onClose;
    var _b = React__default.useState(), place = _b[0], setPlace = _b[1];
    var _c = React__default.useState(), error = _c[0], setError = _c[1];
    var _d = React__default.useState(false), loading = _d[0], toggleLoaging = _d[1];
    var cs = useStyles$2();
    /** */
    React__default.useEffect(function () {
        var active = true;
        var fetchPlace = function () { return __awaiter(void 0, void 0, void 0, function () {
            var res, err_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        toggleLoaging(true);
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, 4, 5]);
                        return [4 /*yield*/, api$1.place.getPlace(placeId)];
                    case 2:
                        res = _a.sent();
                        if (res && active) {
                            setPlace(res);
                        }
                        return [3 /*break*/, 5];
                    case 3:
                        err_1 = _a.sent();
                        setError(err_1);
                        return [3 /*break*/, 5];
                    case 4:
                        toggleLoaging(false);
                        return [7 /*endfinally*/];
                    case 5: return [2 /*return*/];
                }
            });
        }); };
        fetchPlace();
        return function () {
            active = false;
        };
    }, [placeId]);
    /** */
    var renderTitle = function () {
        if (place) {
            return (React__default.createElement(React__default.Fragment, null,
                React__default.createElement(core.Typography, { variant: "h5" }, "" + place.name.charAt(0).toUpperCase() + place.name.slice(1)),
                React__default.createElement(core.Typography, null, formatAddress(place))));
        }
        return React__default.createElement(React__default.Fragment, null);
    };
    var renderContent = function () {
        if (loading || !place) {
            return (React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
                React__default.createElement(core.CircularProgress, null)));
        }
        if (error) {
            return (React__default.createElement(core.Box, { p: 2 },
                React__default.createElement(lab.Alert, { severity: "error" }, error)));
        }
        if (place.lat && place.lng) {
            var center = { lat: place.lat || 0, lng: place.lng || 0 };
            return (React__default.createElement(core.Box, { position: "relative", pt: "63%" },
                React__default.createElement(core.Box, { position: "absolute", top: 0, bottom: 0, left: 0, right: 0 },
                    React__default.createElement(reactLeaflet.Map, { className: cs.map, center: center, zoom: 13 },
                        React__default.createElement(reactLeaflet.TileLayer, { attribution: '&copy <a href="http://osm.org/copyright">OpenStreetMap</a> contributors', url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" }),
                        React__default.createElement(reactLeaflet.Marker, { position: center })))));
        }
        return React__default.createElement(React__default.Fragment, null);
    };
    /** */
    if (loading)
        return React__default.createElement(core.Box, { p: 2 });
    return (React__default.createElement(core.Dialog, { open: true, fullWidth: true, onClose: onClose },
        React__default.createElement(core.DialogTitle, null,
            React__default.createElement(core.Box, { display: "flex", justifyContent: "space-between", alignItems: "center" },
                React__default.createElement(core.Box, null, renderTitle()),
                React__default.createElement(core.Box, { ml: 2 },
                    React__default.createElement(core.IconButton, { onClick: onClose },
                        React__default.createElement(CloseIcon, null))))),
        React__default.createElement(core.DialogContent, null, renderContent())));
};
var PlaceDialogView$1 = withNeolithicProvider(withi18n(PlaceDialogView));

var useStyles$3 = core.makeStyles(function () { return ({
    map: {
        width: '100%',
        height: '100%',
    },
}); });
var PlaceView = function (_a) {
    var placeId = _a.placeId;
    var _b = React__default.useState(), place = _b[0], setPlace = _b[1];
    var _c = React__default.useState(), error = _c[0], setError = _c[1];
    var _d = React__default.useState(false), loading = _d[0], toggleLoaging = _d[1];
    var cs = useStyles$3();
    /** */
    React__default.useEffect(function () {
        var active = true;
        var fetchPlace = function () { return __awaiter(void 0, void 0, void 0, function () {
            var res, err_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        toggleLoaging(true);
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, 4, 5]);
                        return [4 /*yield*/, api$1.place.getPlace(placeId)];
                    case 2:
                        res = _a.sent();
                        if (res && active) {
                            setPlace(res);
                        }
                        return [3 /*break*/, 5];
                    case 3:
                        err_1 = _a.sent();
                        setError(err_1);
                        return [3 /*break*/, 5];
                    case 4:
                        toggleLoaging(false);
                        return [7 /*endfinally*/];
                    case 5: return [2 /*return*/];
                }
            });
        }); };
        fetchPlace();
        return function () {
            active = false;
        };
    }, [placeId]);
    /** */
    if (loading || !place || !(place.lat && place.lng)) {
        return (React__default.createElement(core.Box, { p: 2, display: "flex", justifyContent: "center" },
            React__default.createElement(core.CircularProgress, null)));
    }
    if (error) {
        return (React__default.createElement(core.Box, { p: 2 },
            React__default.createElement(lab.Alert, { severity: "error" }, error)));
    }
    var center = { lat: place.lat || 0, lng: place.lng || 0 };
    return (React__default.createElement(reactLeaflet.Map, { className: cs.map, center: center, zoom: 13 },
        React__default.createElement(reactLeaflet.TileLayer, { attribution: '&copy <a href="http://osm.org/copyright">OpenStreetMap</a> contributors', url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" }),
        React__default.createElement(reactLeaflet.Marker, { position: center })));
};
var PlaceView$1 = withNeolithicProvider(withi18n(PlaceView));

var createApp = function (elementId, children) {
    ReactDOM.render(React__default.createElement(React__default.Fragment, null, children), document.getElementById(elementId));
};
var NeolithicViewsGenerator = /** @class */ (function () {
    function NeolithicViewsGenerator() {
    }
    NeolithicViewsGenerator.setApiUrl = function (url) {
        api$1.setUrl(url);
    };
    NeolithicViewsGenerator.activateDistribSlots = function (elementId, props) {
        createApp(elementId, React__default.createElement(ActivateDistribSlotsView$1, __assign({}, props)));
    };
    NeolithicViewsGenerator.userDistribSlotsSelector = function (elementId, props) {
        var el = document.getElementById(elementId);
        if (el) {
            ReactDOM.unmountComponentAtNode(el);
        }
        createApp(elementId, React__default.createElement(UserDistribSlotsSelectorView$1, __assign({}, props)));
    };
    NeolithicViewsGenerator.distribSlotsResolver = function (elementId, props) {
        createApp(elementId, React__default.createElement(DistribSlotsResolver$1, __assign({}, props)));
    };
    NeolithicViewsGenerator.placeDialog = function (elementId, props) {
        var onClose = function () {
            var el = document.getElementById(elementId);
            if (!el)
                return;
            ReactDOM.unmountComponentAtNode(el);
        };
        createApp(elementId, React__default.createElement(PlaceDialogView$1, __assign({}, props, { onClose: onClose })));
    };
    NeolithicViewsGenerator.place = function (elementId, props) {
        createApp(elementId, React__default.createElement(PlaceView$1, __assign({}, props)));
    };
    return NeolithicViewsGenerator;
}());

function GeoAutocomplete$1(p) {
    return withNeolithicProvider(GeoAutocomplete)(p);
}
var index = (function () { return null; });

exports.GeoAutocomplete = GeoAutocomplete$1;
exports.NeolithicViewsGenerator = NeolithicViewsGenerator;
exports.default = index;
//# sourceMappingURL=index.js.map
