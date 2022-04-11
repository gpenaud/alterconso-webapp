package react.formik;

import react.ReactComponent;
import react.ReactNode;

typedef FieldProps = {
    name: String,
    ?as: Dynamic,
    ?type: String,
    ?label: String,
    ?children: ReactNode,
    ?component: Dynamic,
    ?fullWidth: Bool,
    ?required: Bool,
    ?InputProps: Dynamic,
    ?inputProps: Dynamic,
    ?labelId: String,
    ?cancelLabel: String,
    ?format: String,
};

@:jsRequire('formik', 'Field')
extern class Field extends react.ReactComponentOfProps<FieldProps> {}