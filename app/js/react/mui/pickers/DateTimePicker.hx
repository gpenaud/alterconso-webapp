package react.mui.pickers;

import react.ReactComponent;
import react.mui.pickers.IPickerProps;

typedef DateTimePickerProps = {
  ?ampm: Bool
};

@:jsRequire('@material-ui/pickers', 'DateTimePicker')
extern class DateTimePicker extends react.ReactComponentOfProps<IPickerProps & DateTimePickerProps> {}
