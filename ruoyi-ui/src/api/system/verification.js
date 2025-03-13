import request from '@/utils/request'

// 查询用户验证模式列表
export function listVerification(query) {
  return request({
    url: '/system/verification/list',
    method: 'get',
    params: query
  })
}

// 查询用户验证模式详细
export function getVerification(id) {
  return request({
    url: '/system/verification/' + id,
    method: 'get'
  })
}

// 新增用户验证模式
export function addVerification(data) {
  return request({
    url: '/system/verification',
    method: 'post',
    data: data
  })
}

// 修改用户验证模式
export function updateVerification(data) {
  return request({
    url: '/system/verification',
    method: 'put',
    data: data
  })
}

// 删除用户验证模式
export function delVerification(id) {
  return request({
    url: '/system/verification/' + id,
    method: 'delete'
  })
}
