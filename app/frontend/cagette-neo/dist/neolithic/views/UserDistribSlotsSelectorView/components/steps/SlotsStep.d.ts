/// <reference types="react" />
import { DistribSlotVo } from '../../../../../vo';
interface Props {
    slots: DistribSlotVo[];
    isLastStep: boolean;
    onSelect: (slotIds: number[]) => void;
    onCancel?: () => void;
}
declare const SlotsStep: ({ slots, isLastStep, onSelect, onCancel }: Props) => JSX.Element;
export default SlotsStep;
