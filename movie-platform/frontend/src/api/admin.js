import api from './index'

// 影厅管理
export function getHalls (params) {
  return api.get('/movies/admin/halls/', { params })
}

export function createHall (data) {
  return api.post('/movies/admin/halls/', data)
}

export function updateHall (id, data) {
  return api.put(`/movies/admin/halls/update/${id}/`, data)
}

export function deleteHall (id) {
  return api.delete(`/movies/admin/halls/delete/${id}/`)
}

// 场次管理
export function getSessions (params) {
  return api.get('/movies/admin/sessions/', { params })
}

export function createSession (data) {
  return api.post('/movies/admin/sessions/', data)
}

export function updateSession (id, data) {
  return api.put(`/movies/admin/sessions/update/${id}/`, data)
}

export function deleteSession (id) {
  return api.delete(`/movies/admin/sessions/delete/${id}/`)
}

// 影院管理
export function getCinemas (params) {
  return api.get('/movies/admin/cinemas/', { params })
}

export function createCinema (data) {
  return api.post('/movies/admin/cinemas/', data)
}

export function updateCinema (id, data) {
  return api.put(`/movies/admin/cinemas/update/${id}/`, data)
}

export function deleteCinema (id) {
  return api.delete(`/movies/admin/cinemas/delete/${id}/`)
}

// 分类（公共）
export function getCategories () {
  return api.get('/movies/categories/')
}

// 订单管理（管理员）
export function getAllOrders (params) {
  return api.get('/orders/all/', { params })
}

export function updateOrderStatus (id, data) {
  return api.patch(`/orders/admin/${id}/`, data)
}

// 统计
export function getStatsOverview () {
  return api.get('/admin/stats/overview/')
}

export function getCategoryOrders (params) {
  return api.get('/admin/stats/category-orders/', { params })
}

export function getDailyBoxOffice (params) {
  return api.get('/admin/stats/daily-box-office/', { params })
}

export function getMovieRanking (params) {
  return api.get('/admin/stats/movie-ranking/', { params })
}
