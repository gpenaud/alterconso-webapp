/// <reference types="react" />
import { Mode } from '../../interfaces';
interface Props {
    onSelect: (mode: Mode | undefined) => void;
}
declare const ModeStep: ({ onSelect }: Props) => JSX.Element;
export default ModeStep;
