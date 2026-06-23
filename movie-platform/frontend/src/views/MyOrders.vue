<template>
  <div>
    <h1>我的订单</h1>

    <!-- 状态筛选 -->
    <el-radio-group v-model="statusFilter" @change="fetchOrders">
      <el-radio-button label="">全部</el-radio-button>
      <el-radio-button label="pending">待支付</el-radio-button>
      <el-radio-button label="paid">已支付</el-radio-button>
      <el-radio-button label="cancelled">已取消</el-radio-button>
    </el-radio-group>

    <!-- 订单列表 -->
    <el-table :data="orders">
      <el-table-column prop="order_no" label="订单号" />
      <el-table-column prop="session_info.movie.name" label="电影" />
      <el-table-column prop="session_info.hall.name" label="影厅" />
      <el-table-column prop="quantity" label="数量" />
      <el-table-column prop="total_price" label="金额" />
      <el-table-column label="状态" width="150">
        <template slot-scope="scope">
          <el-tag :type="statusType(scope.row.status)" size="small">
            {{ statusText(scope.row.status) }}
          </el-tag>
          <div v-if="scope.row.status === 'pending'" style="margin-top:4px">
            <Countdown :createdAt="scope.row.created_at" @timeout="fetchOrders" />
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button v-if="scope.row.status === 'pending'" type="success" size="small" @click="pay(scope.row.id)">
            支付
          </el-button>
          <el-button v-if="scope.row.status === 'pending'" type="danger" size="small" @click="cancel(scope.row.id)">
            取消
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      background
      layout="prev, pager, next"
      :total="total"
      :page-size="8"
      @current-change="onPageChange"
    />
  </div>
</template>

<script>
import { getOrders, payOrder, cancelOrder } from '../api/orders'
import Countdown from '../components/Countdown.vue'

export default {
  components: { Countdown },
  data () {
    return {
      orders: [],
      total: 0,
      page: 1,
      statusFilter: ''
    }
  },
  mounted () {
    this.fetchOrders()
  },
  methods: {
    async fetchOrders () {
      const params = { page: this.page }
      if (this.statusFilter) params.status = this.statusFilter
      const res = await getOrders(params)
      this.orders = res.data.results
      this.total = res.data.count
    },
    async pay (id) {
      await payOrder(id)
      this.$message.success('支付成功')
      this.fetchOrders()
    },
    async cancel (id) {
      await cancelOrder(id)
      this.$message.success('已取消')
      this.fetchOrders()
    },
    onPageChange (page) {
      this.page = page
      this.fetchOrders()
    },
    statusType (s) {
      return { pending: 'warning', paid: 'success', cancelled: 'info' }[s]
    },
    statusText (s) {
      return { pending: '待支付', paid: '已支付', cancelled: '已取消' }[s]
    }
  }
}
</script>
