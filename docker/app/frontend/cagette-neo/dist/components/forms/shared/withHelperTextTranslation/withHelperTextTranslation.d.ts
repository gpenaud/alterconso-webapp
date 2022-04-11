import React from 'react';
export default function withHelperTextTranslation<T extends {
    helperText?: React.ReactNode;
}>(Wrapped: React.ComponentType<T>, tranformPropsFunc?: Function): (props: T) => JSX.Element;
