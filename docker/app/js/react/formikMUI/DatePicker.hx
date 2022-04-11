package react.formikMUI;

import react.ReactComponent;

typedef DatePickerProps = {
    name: String,
    ?label: String,
    ?cancelLabel: String,
    ?fullWidth: Bool,
    ?required: Bool,
    ?format: String,
    ?InputProps: Dynamic,
    ?helperText: Dynamic
};

@:jsRequire('formik-material-ui-pickers', 'DatePicker')
extern class DatePicker extends react.ReactComponentOfProps<DatePickerProps> {}