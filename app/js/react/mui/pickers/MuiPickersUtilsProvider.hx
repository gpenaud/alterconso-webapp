  
package react.mui.pickers;

import react.ReactComponent;

typedef MuiPickersUtilsProviderProps = {
  utils: Dynamic, // TODO
  ?locale: Dynamic, // TODO
};

@:jsRequire('@material-ui/pickers', 'MuiPickersUtilsProvider')
extern class MuiPickersUtilsProvider extends react.ReactComponentOfProps<MuiPickersUtilsProviderProps> {}
