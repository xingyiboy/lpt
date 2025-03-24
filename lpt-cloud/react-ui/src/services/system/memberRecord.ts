import { request } from '@umijs/max';

// 查询会员登录记录列表
export async function getLptMemberRecordList(
  params?: API.System.LptMemberRecord,
  options?: { [key: string]: any },
) {
  return request<API.TableDataInfo>('/api/system/memberRecord/list', {
    method: 'GET',
    params,
    ...(options || {}),
  });
}

// 获取会员登录记录详细信息
export function getLptMemberRecord(id: number) {
  return request<API.Result>(`/api/system/memberRecord/${id}`, {
    method: 'GET',
  });
}

// 新增会员登录记录
export async function addLptMemberRecord(data: API.System.LptMemberRecord) {
  return request<API.Result>('/api/system/memberRecord', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    data: data,
  });
}

// 修改会员登录记录
export async function updateLptMemberRecord(data: API.System.LptMemberRecord) {
  return request<API.Result>('/api/system/memberRecord', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
    },
    data: data,
  });
}

// 删除会员登录记录
export async function removeLptMemberRecord(ids: string) {
  return request<API.Result>(`/api/system/memberRecord/${ids}`, {
    method: 'DELETE',
  });
}

// 导出会员登录记录
export function exportLptMemberRecord(params?: API.System.LptMemberRecord) {
  return request<BlobPart>('/api/system/memberRecord/export', {
    method: 'POST',
    params,
    responseType: 'blob',
  });
}
