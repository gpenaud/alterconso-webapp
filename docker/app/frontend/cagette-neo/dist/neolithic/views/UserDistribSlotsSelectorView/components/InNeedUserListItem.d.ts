import React from 'react';
import { UserVo } from '../../../../vo';
interface Props {
    user: UserVo;
    userInfos: string[];
    children?: React.ReactNode;
}
declare const InNeedUserListItem: ({ user, userInfos, children }: Props) => JSX.Element;
export default InNeedUserListItem;
