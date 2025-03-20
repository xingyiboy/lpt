/*
 * @Date: 2025-03-13 10:21:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-13 19:47:04
 * @FilePath: \react-ui\src\locales\zh-CN.ts
 */
import app from './zh-CN/app';
import component from './zh-CN/component';
import globalHeader from './zh-CN/globalHeader';
import sysmenu from './zh-CN/menu';
import job from './zh-CN/monitor/job';
import joblog from './zh-CN/monitor/job-log';
import logininfor from './zh-CN/monitor/logininfor';
import onlineUser from './zh-CN/monitor/onlineUser';
import operlog from './zh-CN/monitor/operlog';
import server from './zh-CN/monitor/server';
import pages from './zh-CN/pages';
import pwa from './zh-CN/pwa';
import settingDrawer from './zh-CN/settingDrawer';
import settings from './zh-CN/settings';
import config from './zh-CN/system/config';
import dept from './zh-CN/system/dept';
import dict from './zh-CN/system/dict';
import dictData from './zh-CN/system/dict-data';
import menu from './zh-CN/system/menu';
import notice from './zh-CN/system/notice';
import post from './zh-CN/system/post';
import role from './zh-CN/system/role';
import user from './zh-CN/system/user';

export default {
  'navBar.lang': '语言',
  'layout.user.link.help': '帮助',
  'layout.user.link.privacy': '隐私',
  'layout.user.link.terms': '条款',
  'app.copyright.produced': '令牌通出品',
  'app.preview.down.block': '下载此页面到本地项目',
  'app.welcome.link.fetch-blocks': '获取全部区块',
  'app.welcome.link.block-list': '基于 block 开发，快速构建标准页面',
  ...app,
  ...pages,
  ...globalHeader,
  ...sysmenu,
  ...settingDrawer,
  ...settings,
  ...pwa,
  ...component,
  ...user,
  ...menu,
  ...dict,
  ...dictData,
  ...role,
  ...dept,
  ...post,
  ...config,
  ...notice,
  ...operlog,
  ...logininfor,
  ...onlineUser,
  ...job,
  ...joblog,
  ...server,
};
