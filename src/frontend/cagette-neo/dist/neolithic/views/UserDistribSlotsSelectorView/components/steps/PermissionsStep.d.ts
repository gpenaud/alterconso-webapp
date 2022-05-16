/// <reference types="react" />
interface Props {
    onConfirm: (allowed: string[]) => void;
    onCancel: () => void;
}
declare const PermissionsStep: ({ onConfirm, onCancel }: Props) => JSX.Element;
export default PermissionsStep;
