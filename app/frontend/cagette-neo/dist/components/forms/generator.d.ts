import React from 'react';
import { FormikProps } from 'formik';
interface BaseFieldGeneratorProps {
    name: string;
    initialValues: any;
    validator?: any;
}
interface CustomFieldGeneratorProps extends BaseFieldGeneratorProps {
    type: 'custom';
    render: <T>(name: string, props: FormikProps<T>) => React.ReactNode;
}
interface DefaultFieldGeneratorProps extends BaseFieldGeneratorProps {
    type: 'default';
    label?: string;
    required?: boolean;
    disabled?: boolean;
    component?: any;
}
export declare type FieldGeneratorProps = CustomFieldGeneratorProps | DefaultFieldGeneratorProps;
export declare function generateFields<T>(fields: FieldGeneratorProps[], formikProps: FormikProps<T>): ({} | null | undefined)[];
export declare function generateInitialValues<T>(fields: FieldGeneratorProps[]): T;
export declare function generateValidationSchema(fields: FieldGeneratorProps[]): {};
export {};
