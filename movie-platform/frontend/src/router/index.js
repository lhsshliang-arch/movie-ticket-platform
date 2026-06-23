import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import { getToken } from '../utils/auth'

Vue.use(VueRouter)

const routes = [
  // ========== 用户端 ==========
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/movie/:id',
    name: 'MovieDetail',
    component: () => import('../views/MovieDetail.vue')
  },
  {
    path: '/order/:sessionId',
    name: 'OrderConfirm',
    component: () => import('../views/OrderConfirm.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/orders',
    name: 'MyOrders',
    component: () => import('../views/MyOrders.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('../views/Profile.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { guest: true } // 已登录则跳首页
  },

  // ========== 管理后台 ==========
  {
    path: '/admin/dashboard',
    name: 'AdminDashboard',
    component: () => import('../views/admin/Dashboard.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/movies',
    name: 'AdminMovies',
    component: () => import('../views/admin/MovieManage.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/cinemas',
    name: 'AdminCinemas',
    component: () => import('../views/admin/CinemaManage.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/halls',
    name: 'AdminHalls',
    component: () => import('../views/admin/HallManage.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/sessions',
    name: 'AdminSessions',
    component: () => import('../views/admin/SessionManage.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/orders',
    name: 'AdminOrders',
    component: () => import('../views/admin/OrderManage.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  },
  {
    path: '/admin/stats',
    name: 'AdminStats',
    component: () => import('../views/admin/Stats.vue'),
    meta: { requiresAuth: true, requiresAdmin: true }
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 路由守卫
router.beforeEach(async (to, from, next) => {
  const loggedIn = !!getToken()
  const hasUser = store.state.user.user

  // 已登录 → 拉取用户信息（仅首次）
  if (loggedIn && !hasUser) {
    try {
      await store.dispatch('user/fetchProfile')
    } catch (e) {
      store.dispatch('user/logout')
      next('/login')
      return
    }
  }

  const isAdmin = store.state.user.user?.is_staff

  // 需要登录
  if (to.meta.requiresAuth && !loggedIn) {
    next('/login')
    return
  }

  // 管理员页面
  if (to.meta.requiresAdmin && !isAdmin) {
    next('/')
    return
  }

  // 已登录时访问登录页 → 跳首页
  if (to.meta.guest && loggedIn) {
    next('/')
    return
  }

  next()
})

export default router
