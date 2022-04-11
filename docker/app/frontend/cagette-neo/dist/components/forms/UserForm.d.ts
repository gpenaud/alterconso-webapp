/// <reference types="react" />
import { FormikHelpers } from 'formik';
import { UserVo } from '../../vo';
interface Props {
    user?: UserVo;
    onSubmit: (values: FormValues, bag: FormikBag) => void;
}
export interface FormValues {
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
    address1?: string;
    address2?: string;
    zipCode?: string;
    city?: string;
    nationality?: string;
    countryOfResidence?: string;
    birthDate?: string;
    firstName2?: string;
    lastName2?: string;
    email2?: string;
    phone2?: string;
}
export declare type FormikBag = FormikHelpers<FormValues>;
declare const UserForm: ({ user, onSubmit }: Props) => JSX.Element;
export default UserForm;
