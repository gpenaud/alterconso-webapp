/// <reference types="react" />
import { UserVo } from '../../../../../vo';
interface Props {
    inNeedUsers: UserVo[];
    onConfirm: (userIds: number[]) => void;
    onCancel: () => void;
}
declare const VoluntaryStep: ({ inNeedUsers, onConfirm, onCancel }: Props) => JSX.Element;
export default VoluntaryStep;
