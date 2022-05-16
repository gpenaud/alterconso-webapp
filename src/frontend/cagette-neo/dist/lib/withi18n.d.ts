import React from 'react';
import './i18n';
declare const withi18n: <T extends object>(Wrapped: React.ComponentType<T>) => (props: T) => JSX.Element;
export default withi18n;
