export interface UserData {
    id: number;
    firstName: string;
    lastName: string;
    email: string;
    phone: string | null;
    address1: string | null;
    address2: string | null;
    zipCode: string | null;
    city: string | null;
    nationality: string | null;
    countryOfResidence: string | null;
    birthDate: string | null;
    firstName2: string | null;
    lastName2: string | null;
    email2: string | null;
    phone2: string | null;
}
export interface UserVo {
    id: number;
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
export declare const parseUserVo: (data: UserData) => UserVo;
export declare const formatUserName: (user: UserVo) => string;
export declare const formatUserAddress: (user: UserVo) => string | undefined;
