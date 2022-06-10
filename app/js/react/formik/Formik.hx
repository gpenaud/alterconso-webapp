package react.formik;

import react.ReactComponent;
import react.ReactNode;

typedef FormikProps = {
    initialValues: Dynamic,
    children: (props: Dynamic) -> ReactNode,
    onSubmit: (values: Dynamic, formikBag: Dynamic) -> Void
};

@:jsRequire('formik', 'Formik')
extern class Formik extends react.ReactComponentOfProps<FormikProps> {}