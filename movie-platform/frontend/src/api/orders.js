import api from './index'

export function createOrder (data) {
  return api.post('/orders/', data)
}

export function getOrders (params) {
  return api.get('/orders/', { params })
}

export function getOrderDetail (id) {
  return api.get(`/orders/${id}/`)
}

export function payOrder (id) {
  return api.patch(`/orders/${id}/pay/`)
}

export function cancelOrder (id) {
  return api.patch(`/orders/${id}/cancel/`)
}
