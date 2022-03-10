import React from 'react';
import { ConfirmDialogProps } from './ConfirmDialog';
declare type ConfirmProps = Omit<ConfirmDialogProps, 'open' | 'onCancel' | 'onConfirm'>;
export default function <T>(Component: React.ComponentType<T>, dialogProps: ConfirmProps): (props: T) => JSX.Element;
export {};
