/*
 * @Date: 2025-03-13 10:21:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-13 18:17:41
 * @FilePath: \react-ui\src\components\RightContent\index.tsx
 */
import { useEmotionCss } from '@ant-design/use-emotion-css';
import { SelectLang, useModel } from '@umijs/max';
import React from 'react';
import Avatar from './AvatarDropdown';

export type SiderTheme = 'light' | 'dark';

const GlobalHeaderRight: React.FC = () => {
  const className = useEmotionCss(() => {
    return {
      display: 'flex',
      height: '48px',
      marginLeft: 'auto',
      overflow: 'hidden',
      gap: 8,
    };
  });

  const actionClassName = useEmotionCss(({ token }) => {
    return {
      display: 'flex',
      float: 'right',
      height: '48px',
      marginLeft: 'auto',
      overflow: 'hidden',
      cursor: 'pointer',
      padding: '0 12px',
      borderRadius: token.borderRadius,
      '&:hover': {
        backgroundColor: token.colorBgTextHover,
      },
    };
  });

  const { initialState } = useModel('@@initialState');

  if (!initialState || !initialState.settings) {
    return null;
  }

  return (
    <div className={className}>
      <Avatar menu={true} />
      <SelectLang className={actionClassName} />
    </div>
  );
};
export default GlobalHeaderRight;
