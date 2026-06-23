<template>
  <div v-if="session">
    <h1>确认订单</h1>
    <el-card>
      <p>电影: {{ session.movie?.name }}</p>
      <p>影厅: {{ session.hall?.name }}</p>
      <p>时间: {{ formatTime(session.start_time) }}</p>
      <p>单价: ¥{{ session.price }}</p>
      <p>余票: {{ session.remaining_tickets }}</p>

      <el-input-number v-model="quantity" :min="1" :max="session.remaining_tickets" style="margin:10px 0" />

      <h2>合计: ¥{{ (quantity * parseFloat(session.price)).toFixed(2) }}</h2>

      <el-button type="primary" @click="submitOrder" :loading="submitting">
        确认下单
      </el-button>
    </el-card>
  </div>
  <div v-else-if="error">
    <p>{{ error }}</p>
  </div>
</template>

<script>
import api from '../api/index'
import { createOrder } from '../api/orders'

export default {
  name: 'OrderConfirmPage',
  data () {
    return {
      session: null,
      error: '',
      quantity: 1,
      submitting: false
    }
  },
  async mounted () {
    try {
      const res = await api.get(`/movies/sessions/${this.$route.params.sessionId}/`)
      this.session = res.data
    } catch (e) {
      this.error = '场次不存在或已过期'
    }
  },
  methods: {
    formatTime (time) {
      if (!time) return ''
      return new Date(time).toLocaleString('zh-CN')
    },
    async submitOrder () {
      this.submitting = true
      try {
        await createOrder({ session: this.session.id, quantity: this.quantity })
        this.$message.success('下单成功，请在15分钟内完成支付')
        this.$router.push('/orders')
      } catch (e) {
        const data = e.response?.data
        const msg = Array.isArray(data) ? data.join('; ') : (typeof data === 'string' ? data : '下单失败')
        this.$message.error(msg)
      } finally {
        this.submitting = false
      }
    }
  }
}
</script>
