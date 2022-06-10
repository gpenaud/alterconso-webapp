declare const _default: {
    setUrl(url: string): void;
    login(email: string, password: string): Promise<import("./vo").UserVo | null>;
    me(): Promise<import("./vo").UserVo | null>;
    updateMe(data: any, type?: "json" | "data"): Promise<import("./vo").UserVo | null>;
    getGroup(id: number): Promise<import("./vo").GroupVo | null>;
    getUser(id: number): Promise<import("./vo").UserVo | null>;
    getGroupUsers(id: number): Promise<any>;
    place: {
        getPlace(id: number): Promise<import("./vo").PlaceVo | null>;
    };
    distrib: {
        getDistrib(id: number): Promise<import("./vo").DistribVo | null>;
        getResolvedDistrib<T>(id: number, parser: (data: any) => T): Promise<T | null>;
        activateSlots(id: number, data: any, type?: "json" | "data"): Promise<import("./vo").DistribVo | null>;
        disableSlots(id: number): Promise<import("./vo").DistribVo | null>;
        registerMe(distribId: number, data: any, type?: "json" | "data"): Promise<any>;
        getStatus(distribId: number): Promise<any>;
    };
};
export default _default;
