/*
 * @Date: 2025-03-13 10:21:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-24 15:17:03
 * @FilePath: \react-ui\config\defaultSettings.ts
 */
import { ProLayoutProps } from '@ant-design/pro-components';

/**
 * @name
 */
const Settings: ProLayoutProps & {
  pwa?: boolean;
  logo?: string;
} = {
  navTheme: 'light',
  colorPrimary: '#52C41A',
  layout: 'mix',
  contentWidth: 'Fluid',
  fixedHeader: true,
  fixSiderbar: true,
  splitMenus: false,
  colorWeak: false,
  title: '令牌通',
  pwa: true,
  logo: '/favicon.ico',
  iconfontUrl: '',
  siderMenuType: 'sub',
  token: {
    // 参见ts声明，demo 见文档，通过token 修改样式
    //https://procomponents.ant.design/components/layout#%E9%80%9A%E8%BF%87-token-%E4%BF%AE%E6%94%B9%E6%A0%B7%E5%BC%8F
  },
};
export default Settings;
