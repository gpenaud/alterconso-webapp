package react.formikMUI;

import react.ReactComponent;
import mui.core.Input.InputProps;
import mui.core.Select.SelectProps as MUISelectProps;

typedef SelectProps = {
    >MUISelectProps,
    name: String,
};

@:jsRequire('formik-material-ui', 'Select')
extern class Select extends react.ReactComponentOfProps<SelectProps> {}