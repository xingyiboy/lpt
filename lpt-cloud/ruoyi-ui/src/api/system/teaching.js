import request from '@/utils/request'

// 查询官网教程列表
export function listTeaching(query) {
  return request({
    url: '/system/teaching/list',
    method: 'get',
    params: query
  })
}

// 查询官网教程详细
export function getTeaching(id) {
  return request({
    url: '/system/teaching/' + id,
    method: 'get'
  })
}

// 新增官网教程
export function addTeaching(data) {
  return request({
    url: '/system/teaching',
    method: 'post',
    data: data
  })
}

// 修改官网教程
export function updateTeaching(data) {
  return request({
    url: '/system/teaching',
    method: 'put',
    data: data
  })
}

// 删除官网教程
export function delTeaching(id) {
  return request({
    url: '/system/teaching/' + id,
    method: 'delete'
  })
}
