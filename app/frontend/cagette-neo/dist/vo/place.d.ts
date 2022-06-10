export interface PlaceVo {
    id: number;
    name: string;
    address1?: string;
    address2?: string;
    city?: string;
    zipCode?: string;
    lat?: number;
    lng?: number;
}
export declare const parsePlaceVo: (data: any) => PlaceVo;
