/*
 * @Date: 2025-03-16 16:12:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-18 18:27:16
 * @FilePath: \lpt-single-item\react-ui\src\components\Footer\index.tsx
 */
import { GithubOutlined } from '@ant-design/icons';
import { DefaultFooter } from '@ant-design/pro-components';
import React from 'react';

const Footer: React.FC = () => {
  return (
    <DefaultFooter
      style={{
        background: 'none',
      }}
      links={[
        {
          key: 'LPT',
          title: 'LPT',
          href: 'http://113.45.31.128/home',
          blankTarget: true,
        },
      ]}
    />
  );
};

export default Footer;
