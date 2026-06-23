<template>
  <div>
    <h2>管理后台</h2>
    <p>欢迎，{{ user.username }}</p>

    <!-- 概览卡片 -->
    <el-row :gutter="20">
      <el-col :span="6" v-for="card in cards" :key="card.label">
        <el-card>
          <h3>{{ card.value }}</h3>
          <p>{{ card.label }}</p>
        </el-card>
      </el-col>
    </el-row>

    <!-- 快捷入口 -->
    <el-row :gutter="20" style="margin-top:20px">
      <el-col :span="6">
        <el-button @click="$router.push('/admin/movies')">电影管理</el-button>
      </el-col>
      <el-col :span="6">
        <el-button @click="$router.push('/admin/halls')">影厅管理</el-button>
      </el-col>
      <el-col :span="6">
        <el-button @click="$router.push('/admin/sessions')">场次管理</el-button>
      </el-col>
      <el-col :span="6">
        <el-button @click="$router.push('/admin/stats')">数据统计</el-button>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import { getStatsOverview } from '../../api/admin'

export default {
  name: 'AdminDashboard',
  computed: {
    ...mapState('user', { user: 'user' })
  },
  data () {
    return {
      cards: [
        { label: '今日订单', value: 0 },
        { label: '今日票房', value: '0' },
        { label: '今日场次', value: 0 },
        { label: '在映电影', value: 0 }
      ]
    }
  },
  async mounted () {
    try {
      const res = await getStatsOverview()
      const d = res.data
      this.cards = [
        { label: '今日订单', value: d.order_count },
        { label: '今日票房', value: '¥' + d.box_office },
        { label: '今日场次', value: d.session_count },
        { label: '在映电影', value: d.active_movie_count }
      ]
    } catch (e) {
      this.$message.error('加载统计数据失败')
    }
  }
}
</script>
