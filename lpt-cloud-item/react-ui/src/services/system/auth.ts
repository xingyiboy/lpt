/*
 * @Date: 2025-03-16 16:12:48
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-18 18:46:08
 * @FilePath: \lpt-single-item\react-ui\src\services\system\auth.ts
 */
import { request } from '@umijs/max';

/** 登录接口 POST  */
export async function login(body: API.LoginParams, options?: Record<string, any>) {
  return request<API.LoginResult>('/api/login', {
    method: 'POST',
    headers: {
      isToken: false,
      'Content-Type': 'application/json',
    },
    data: body,
    ...(options || {}),
  });
}

/** 注册接口 POST  */
export async function register(body: API.LoginParams, options?: Record<string, any>) {
  return request<API.LoginResult>('/api/register', {
    method: 'POST',
    headers: {
      isToken: false,
      'Content-Type': 'application/json',
    },
    data: body,
    ...(options || {}),
  });
}

/** 退出登录接口 POST /api/login/outLogin */
export async function logout() {
  return request<Record<string, any>>('/api/logout', {
    method: 'delete',
  });
}

// 获取手机验证码
export async function getMobileCaptcha(mobile: string) {
  return request(`/api/login/captcha?mobile=${mobile}`);
}
