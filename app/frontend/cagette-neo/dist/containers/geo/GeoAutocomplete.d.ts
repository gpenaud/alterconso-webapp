import React from 'react';
interface Props {
    initialValue?: string;
    label?: string;
    noOptionsText?: React.ReactNode;
    mapboxToken?: string;
    onChange: (value: any) => void;
}
declare const GeoAutocomplete: ({ initialValue, label, noOptionsText, mapboxToken, onChange }: Props) => JSX.Element;
export default GeoAutocomplete;
