import api from './index'

export function getMovies (params) {
  return api.get('/movies/', { params })
}

export function getMovieDetail (id) {
  return api.get(`/movies/${id}/`)
}

export function getMovieSessions (id) {
  return api.get(`/movies/${id}/sessions/`)
}

// 管理员
export function createMovie (data) {
  return api.post('/movies/admin/create/', data, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}

export function updateMovie (id, data) {
  return api.patch(`/movies/admin/update/${id}/`, data, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}

export function deleteMovie (id) {
  return api.delete(`/movies/admin/delete/${id}/`)
}

export function toggleWant (id) {
  return api.post(`/movies/${id}/want/`)
}

export function getWantedMovies () {
  return api.get('/movies/wanted/')
}

export function getRecommendations () {
  return api.get('/movies/recommend/')
}
