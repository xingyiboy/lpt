import { request } from '@umijs/max';

// 查询用户验证模式列表
export async function getVerificationList(params?: API.System.VerificationListParams) {
  return request<API.System.VerificationPageResult>('/api/system/verification/list', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json;charset=UTF-8',
    },
    params,
  });
}

// 查询用户验证模式详细
export function getVerification(id: number) {
  return request<API.System.VerificationInfoResult>(`/api/system/verification/${id}`, {
    method: 'GET',
  });
}

// 新增用户验证模式
export async function addVerification(params: API.System.Verification) {
  return request<API.Result>('/api/system/verification', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json;charset=UTF-8',
    },
    data: params,
  });
}

// 修改用户验证模式
export async function updateVerification(params: API.System.Verification) {
  return request<API.Result>('/api/system/verification', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json;charset=UTF-8',
    },
    data: params,
  });
}

// 删除用户验证模式
export async function removeVerification(ids: string) {
  return request<API.Result>(`/api/system/verification/${ids}`, {
    method: 'DELETE',
  });
}

// 导出用户验证模式
export function exportVerification(params?: API.System.VerificationListParams) {
  return request<API.Result>(`/api/system/verification/export`, {
    method: 'GET',
    params,
  });
}
