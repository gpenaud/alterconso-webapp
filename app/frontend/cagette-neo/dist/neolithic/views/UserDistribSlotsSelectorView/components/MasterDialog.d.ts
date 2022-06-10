import React from 'react';
interface Props {
    open: boolean;
    canClose: boolean;
    children: React.ReactNode;
    onClose: () => void;
}
declare const MasterDialog: ({ open, canClose, children, onClose }: Props) => JSX.Element;
export default MasterDialog;
