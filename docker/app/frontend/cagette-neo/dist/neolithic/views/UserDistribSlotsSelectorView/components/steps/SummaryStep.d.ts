/// <reference types="react" />
import { DistribSlotVo, UserVo } from '../../../../../vo';
import { Mode } from '../../interfaces';
interface Props {
    mode: Mode;
    slots: DistribSlotVo[];
    registeredSlotIds?: number[];
    voluntaryFor?: UserVo[];
    inNeedUsers?: UserVo[];
    onSalesProcess: boolean;
    changeSlots: () => void;
    addInNeeds: () => void;
    close: () => void;
}
declare const SummaryStep: ({ mode, slots, registeredSlotIds, voluntaryFor, inNeedUsers, onSalesProcess, changeSlots, addInNeeds, close, }: Props) => JSX.Element;
export default SummaryStep;
