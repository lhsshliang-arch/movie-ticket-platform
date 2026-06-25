<template>
  <div>
    <h2>数据统计</h2>

    <!-- 日期范围 -->
    <el-date-picker
      v-model="dateRange"
      type="daterange"
      range-separator="至"
      start-placeholder="开始日期"
      end-placeholder="结束日期"
      value-format="yyyy-MM-dd"
      @change="fetchAll"
    />

    <!-- 概览卡片 -->
    <el-row :gutter="20" style="margin-top:20px">
      <el-col :span="6" v-for="card in cards" :key="card.label">
        <el-card>
          <h3>{{ card.value }}</h3>
          <p>{{ card.label }}</p>
        </el-card>
      </el-col>
    </el-row>

    <!-- 图表 -->
    <el-row :gutter="20" style="margin-top:20px">
      <el-col :span="12">
        <el-card>
          <h3>分类订单统计</h3>
          <PieChart :data="categoryData" />
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <h3>每日票房</h3>
          <LineChart :data="boxOfficeData" />
        </el-card>
      </el-col>
    </el-row>
    <el-row style="margin-top:20px">
      <el-col :span="24">
        <el-card>
          <h3>热映电影销量排行</h3>
          <BarChart :data="rankingData" />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getStatsOverview, getCategoryOrders, getDailyBoxOffice, getMovieRanking } from '../../api/admin'
import PieChart from '../../components/charts/PieChart.vue'
import LineChart from '../../components/charts/LineChart.vue'
import BarChart from '../../components/charts/BarChart.vue'

export default {
  name: 'AdminStats',
  components: { PieChart, LineChart, BarChart },
  data () {
    const today = new Date()
    const weekAgo = new Date(today.getTime() - 7 * 24 * 3600 * 1000)
    return {
      dateRange: [
        weekAgo.toISOString().slice(0, 10),
        today.toISOString().slice(0, 10)
      ],
      cards: [
        { label: '总订单', value: 0 },
        { label: '总票房', value: '¥0' },
        { label: '总场次', value: 0 },
        { label: '在映电影', value: 0 }
      ],
      categoryData: [],
      boxOfficeData: [],
      rankingData: []
    }
  },
  mounted () {
    this.fetchAll()
  },
  methods: {
    async fetchAll () {
      const [start, end] = this.dateRange
      const params = { start, end }

      try {
        const [overview, category, boxOffice, ranking] = await Promise.all([
          getStatsOverview(),
          getCategoryOrders(params),
          getDailyBoxOffice(params),
          getMovieRanking()
        ])

        const d = overview.data
        this.cards = [
          { label: '总订单', value: d.order_count },
          { label: '总票房', value: '¥' + d.box_office },
          { label: '总场次', value: d.session_count },
          { label: '在映电影', value: d.active_movie_count }
        ]
        this.categoryData = category.data
        this.boxOfficeData = boxOffice.data
        this.rankingData = ranking.data
      } catch (e) {
        this.$message.error('加载统计数据失败')
      }
    }
  }
}
</script>
