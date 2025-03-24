/*
 * @Date: 2025-03-13 10:21:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-24 15:19:41
 * @FilePath: \react-ui\src\components\Footer\index.tsx
 */
import { DefaultFooter } from '@ant-design/pro-components';
import { useIntl } from '@umijs/max';
import React from 'react';

const Footer: React.FC = () => {
  const intl = useIntl();
  const defaultMessage = intl.formatMessage({
    id: 'app.copyright.produced',
    defaultMessage: '令牌桶团队出品',
  });

  const currentYear = new Date().getFullYear();

  return (
    <DefaultFooter
      style={{
        background: 'none',
      }}
      copyright={`${currentYear} ${defaultMessage}`}
      links={[
        {
          key: '令牌通',
          title: '令牌通',
          href: 'http://113.45.31.128:9999/homen',
          blankTarget: true,
        },
        {
          key: 'LPT',
          title: 'LPT',
          href: 'http://113.45.31.128:9999/homen',
          blankTarget: true,
        },
      ]}
    />
  );
};

export default Footer;
