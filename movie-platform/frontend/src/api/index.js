import axios from 'axios'
import { getToken, getRefreshToken, setToken, removeToken } from '../utils/auth'

const api = axios.create({
  baseURL: '/api'
})

// 请求拦截器：自动注入 token
api.interceptors.request.use(config => {
  const token = getToken()
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// 响应拦截器：401 自动刷新 token
api.interceptors.response.use(
  response => response,
  async error => {
    const originalRequest = error.config

    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true
      const refresh = getRefreshToken()
      if (refresh) {
        try {
          const res = await axios.post('/api/auth/refresh/', { refresh })
          setToken(res.data.access, refresh)
          originalRequest.headers.Authorization = `Bearer ${res.data.access}`
          return api(originalRequest)
        } catch (e) {
          removeToken()
          window.location.href = '/login'
        }
      } else {
        removeToken()
        window.location.href = '/login'
      }
    }
    return Promise.reject(error)
  }
)

export default api
