/// <reference types="react" />
export interface ConfirmDialogProps {
    open: boolean;
    cancelButtonLabel: string;
    confirmButtonLabel: string;
    title?: string;
    message?: string;
    onCancel: () => void;
    onConfirm: () => void;
}
declare const ConfirmDialog: ({ open, cancelButtonLabel, confirmButtonLabel, title, message, onCancel, onConfirm, }: ConfirmDialogProps) => JSX.Element;
export default ConfirmDialog;
