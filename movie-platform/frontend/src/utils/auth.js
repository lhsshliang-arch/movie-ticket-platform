// Token 读写工具
const TOKEN_KEY = 'access'
const REFRESH_KEY = 'refresh'

export function getToken () {
  return localStorage.getItem(TOKEN_KEY)
}

export function getRefreshToken () {
  return localStorage.getItem(REFRESH_KEY)
}

export function setToken (access, refresh) {
  localStorage.setItem(TOKEN_KEY, access)
  localStorage.setItem(REFRESH_KEY, refresh)
}

export function removeToken () {
  localStorage.removeItem(TOKEN_KEY)
  localStorage.removeItem(REFRESH_KEY)
}

export function isLoggedIn () {
  return !!getToken()
}
