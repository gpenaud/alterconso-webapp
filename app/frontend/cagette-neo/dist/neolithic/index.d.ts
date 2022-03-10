import { ActivateDistribSlotsViewProps } from './views/ActivateDistribSlotsView/ActivateDistribSlotsView';
import { UserDistribSlotsSelectorViewProps } from './views/UserDistribSlotsSelectorView';
import { DistribSlotsResolverProps } from './views/DistribSlotsResolver';
import { PlaceDialogViewProps } from './views/PlaceDialogView';
import { PlaceViewProps } from './views/PlaceView';
export default class NeolithicViewsGenerator {
    static setApiUrl(url: string): void;
    static activateDistribSlots(elementId: string, props: ActivateDistribSlotsViewProps): void;
    static userDistribSlotsSelector(elementId: string, props: UserDistribSlotsSelectorViewProps): void;
    static distribSlotsResolver(elementId: string, props: DistribSlotsResolverProps): void;
    static placeDialog(elementId: string, props: Omit<PlaceDialogViewProps, 'onClose'>): void;
    static place(elementId: string, props: PlaceViewProps): void;
}
