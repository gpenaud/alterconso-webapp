import React from 'react';
import { DistribSlotVo, UserVo } from '../../../vo';
import { Step, Mode } from './interfaces';
interface ViewCtxProps {
    currentStep: Step;
    open: boolean;
    loading: boolean;
    error?: string;
    distribMode?: 'solo-only' | 'default';
    mode?: Mode;
    slots: DistribSlotVo[];
    inNeedUsers: UserVo[];
    registeredSlotIds?: number[];
    voluntaryFor?: UserVo[];
    closeDialog: () => void;
    back: () => void;
    selectMode: (mode: Mode) => void;
    selectPermissions: (permissions: string[]) => void;
    selectSlots: (slotIds: number[]) => void;
    selectInNeedUsers: (userIds: number[]) => void;
    changeSlots: () => void;
    addInNeeds: () => void;
}
export declare const ViewCtx: React.Context<ViewCtxProps>;
export declare const ViewCtxProvider: ({ distribId, children, onRegister, onCancel, }: {
    distribId: number;
    children: React.ReactNode;
    onRegister: () => void;
    onCancel: () => void;
}) => JSX.Element;
export declare const useViewCtx: () => ViewCtxProps;
export {};
