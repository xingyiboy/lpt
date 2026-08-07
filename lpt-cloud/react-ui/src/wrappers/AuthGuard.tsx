import React from 'react';
import { history } from '@umijs/max';
import { getAccessToken } from '@/access';

/**
 * 登录守卫 wrapper:
 * 无 token 访问受保护页面时, 强制跳转到登录页(/dlzt/user/login)
 * 注意: 用 window.location 确保绝对路径带 base 前缀, 避免 umi history 相对跳转丢前缀
 */
const AuthGuard: React.FC<{ children?: React.ReactNode }> = ({ children }) => {
  const token = getAccessToken();
  if (!token) {
    const fullPath = window.location.pathname;
    const isLogin = fullPath === '/dlzt/user/login' || fullPath === '/user/login';
    if (!isLogin) {
      window.location.href = '/dlzt/user/login';
      return null;
    }
  }
  return <>{children}</>;
};

export default AuthGuard;
