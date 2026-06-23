import api from './index'

export function login (username, password) {
  return api.post('/auth/login/', { username, password })
}

export function register (data) {
  return api.post('/auth/register/', data)
}

export function getProfile () {
  return api.get('/auth/profile/')
}

export function updateProfile (data) {
  // data 为 FormData（支持头像上传）或普通对象
  const isFormData = data instanceof FormData
  return api.patch('/auth/profile/', data, {
    headers: isFormData ? { 'Content-Type': 'multipart/form-data' } : {}
  })
}
