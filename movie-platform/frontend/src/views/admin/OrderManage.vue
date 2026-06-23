<template>
  <div>
    <h2>订单管理</h2>

    <el-radio-group v-model="statusFilter" @change="fetchOrders">
      <el-radio-button label="">全部</el-radio-button>
      <el-radio-button label="pending">待支付</el-radio-button>
      <el-radio-button label="paid">已支付</el-radio-button>
      <el-radio-button label="cancelled">已取消</el-radio-button>
    </el-radio-group>

    <el-table :data="orders">
      <el-table-column prop="order_no" label="订单号" />
      <el-table-column prop="username" label="用户" />
      <el-table-column prop="quantity" label="数量" />
      <el-table-column prop="total_price" label="金额" />
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-tag :type="{ pending: 'warning', paid: 'success', cancelled: 'info' }[scope.row.status]">
            {{ { pending: '待支付', paid: '已支付', cancelled: '已取消' }[scope.row.status] }}
          </el-tag>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { getAllOrders } from '../../api/admin'

export default {
  data () {
    return {
      orders: [],
      statusFilter: ''
    }
  },
  mounted () {
    this.fetchOrders()
  },
  methods: {
    async fetchOrders () {
      const params = { page_size: 999 }
      if (this.statusFilter) params.status = this.statusFilter
      const res = await getAllOrders(params)
      this.orders = res.data.results
    }
  }
}
</script>
