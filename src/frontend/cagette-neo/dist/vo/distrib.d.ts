import { UserVo } from './user';
export interface DistribSlotVo {
    id: number;
    distribId: number;
    selectedUserIds: number[];
    registeredUserIds: number[];
    start: Date;
    end: Date;
}
export interface DistribVo {
    id: number;
    start?: Date;
    end?: Date;
    orderEndDate?: Date;
    mode: 'solo-only' | 'default';
    slots?: DistribSlotVo[];
    inNeedUsers?: UserVo[];
}
export declare const parseDistribVo: (data: any) => DistribVo;
