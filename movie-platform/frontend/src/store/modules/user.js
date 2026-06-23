import { login as apiLogin, register as apiRegister, getProfile, updateProfile } from '../../api/auth'
import { setToken, removeToken } from '../../utils/auth'

export default {
  namespaced: true,

  state: { user: null, isLoggedIn: false },

  mutations: {
    SET_USER (state, user) { state.user = user; state.isLoggedIn = true },
    CLEAR_USER (state) { state.user = null; state.isLoggedIn = false }
  },

  actions: {
    async login ({ commit }, { username, password }) {
      const res = await apiLogin(username, password)
      setToken(res.data.access, res.data.refresh)
      const profile = await getProfile()
      commit('SET_USER', profile.data)
    },

    async register ({ commit }, data) {
      const res = await apiRegister(data)
      // 后端注册成功返回 access + refresh
      if (res.data.access) {
        setToken(res.data.access, res.data.refresh)
        const profile = await getProfile()
        commit('SET_USER', profile.data)
      }
    },

    async fetchProfile ({ commit }) {
      try {
        const res = await getProfile()
        commit('SET_USER', res.data)
      } catch (e) {
        commit('CLEAR_USER')
        removeToken()
      }
    },

    async updateProfile ({ commit }, data) {
      const res = await updateProfile(data)
      commit('SET_USER', res.data)
    },

    logout ({ commit }) {
      removeToken()
      commit('CLEAR_USER')
    }
  }
}
