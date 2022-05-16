export declare const format: (date: number | Date, f: string, strOptions?: {
    firstLetterUppercase?: boolean | undefined;
} | undefined) => string;
export declare const formatDistance: (date: number | Date, baseDate: Date, options?: {
    includeSeconds?: boolean | undefined;
    addSuffix?: boolean | undefined;
} | undefined, strOptions?: {
    firstLetterUppercase?: boolean | undefined;
} | undefined) => string;
export declare const formatDistanceStrict: (date: number | Date, baseDate: Date, options?: {
    addSuffix?: boolean | undefined;
    unit?: "second" | "minute" | "hour" | "day" | "month" | "year" | undefined;
    roundingMethod?: "floor" | "ceil" | "round" | undefined;
} | undefined, strOptions?: {
    firstLetterUppercase?: boolean | undefined;
} | undefined) => string;
export declare const formatRelative: (date: number | Date, baseDate: Date, options?: {
    weekStartsOn?: 0 | 1 | 2 | 3 | 4 | 5 | 6 | undefined;
} | undefined, strOptions?: {
    firstLetterUppercase?: boolean | undefined;
} | undefined) => string;
