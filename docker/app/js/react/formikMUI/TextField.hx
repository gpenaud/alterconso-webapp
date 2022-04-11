package react.formikMUI;

import react.ReactComponent;
import mui.core.TextField.TextFieldProps as MUITextFieldProps;

typedef TextFieldProps = {
    >MUITextFieldProps,
    name: String,
};

@:jsRequire('formik-material-ui', 'TextField')
extern class TextField extends react.ReactComponentOfProps<TextFieldProps> {}