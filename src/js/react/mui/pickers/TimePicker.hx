package react.mui.pickers;

import react.ReactComponent;
import react.mui.pickers.IPickerProps;

typedef TimePickerProps = {
  ?ampm: Bool
};

@:jsRequire('@material-ui/pickers', 'TimePicker')
extern class TimePicker extends react.ReactComponentOfProps<IPickerProps & TimePickerProps> {}
