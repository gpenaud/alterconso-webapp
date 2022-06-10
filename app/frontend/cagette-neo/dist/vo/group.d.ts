import { UserVo, UserData } from './user';
export interface GroupPreviewData {
    id: number;
    name: string;
}
export interface GroupData extends GroupPreviewData {
    iban: string | null;
    user: UserData | null;
}
export interface GroupPreviewVo {
    id: number;
    name: string;
}
export interface GroupVo extends GroupPreviewVo {
    iban?: string;
    user?: UserVo;
}
export declare const parseGroupPreviewVo: (data: GroupPreviewData) => GroupPreviewVo;
export declare const parseGroupVo: (data: GroupData) => GroupVo;
