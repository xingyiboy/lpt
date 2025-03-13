import { request } from '@umijs/max';

// 查询成员列表
export async function getLptMemberList(
  params?: API.System.LptMember,
  options?: { [key: string]: any },
) {
  return request<API.TableDataInfo>('/api/system/member/list', {
    method: 'GET',
    params,
    ...(options || {}),
  });
}

// 获取成员详细信息
export function getLptMember(id: number) {
  return request<API.Result>(`/api/system/member/${id}`, {
    method: 'GET',
  });
}

// 新增成员
export async function addLptMember(data: API.System.LptMember) {
  return request<API.Result>('/api/system/member', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    data: data,
  });
}

// 修改成员
export async function updateLptMember(data: API.System.LptMember) {
  return request<API.Result>('/api/system/member', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
    },
    data: data,
  });
}

// 删除成员
export async function removeLptMember(ids: number[]) {
  return request<API.Result>(`/api/system/member/${ids}`, {
    method: 'DELETE',
  });
}

// 导出成员
export function exportLptMember(params?: API.System.LptMember) {
  return request<BlobPart>('/api/system/member/export', {
    method: 'POST',
    params,
    responseType: 'blob',
  });
}
