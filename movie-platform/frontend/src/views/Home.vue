<template>
  <div>
    <!-- 猜你喜欢 -->
    <template v-if="recommendations.length > 0">
      <div style="display:flex;align-items:center;margin-bottom:16px">
        <h2 style="margin:0;font-size:20px">猜你喜欢</h2>
      </div>
      <el-row :gutter="20" type="flex">
        <el-col v-for="movie in recommendations" :key="movie.id" :span="6" style="margin-bottom:20px">
          <MovieCard :movie="movie" :wanted="wantedIds.includes(movie.id)" />
        </el-col>
      </el-row>
      <el-divider />
    </template>

    <!-- 工具栏 -->
    <div style="display:flex;align-items:center;margin-bottom:20px;gap:12px;flex-wrap:wrap">
      <el-input v-model="search" placeholder="搜索电影" clearable @clear="onSearch" @keyup.enter.native="onSearch" style="width:240px">
        <el-button slot="append" icon="el-icon-search" @click="onSearch" />
      </el-input>
      <el-radio-group v-model="statusFilter" @change="fetchMovies" size="small">
        <el-radio-button label="">全部</el-radio-button>
        <el-radio-button label="hot">热映</el-radio-button>
        <el-radio-button label="coming">即将上映</el-radio-button>
      </el-radio-group>
      <el-select v-model="categoryFilter" placeholder="全部分类" clearable @change="fetchMovies" size="small" style="width:140px">
        <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
      </el-select>
    </div>

    <!-- 电影列表 -->
    <el-row :gutter="20">
      <el-col v-for="movie in movies" :key="movie.id" :span="6" style="margin-bottom:20px">
        <MovieCard :movie="movie" :wanted="wantedIds.includes(movie.id)" />
      </el-col>
    </el-row>

    <!-- 分页 -->
    <el-pagination
      v-if="total > 8"
      background
      layout="prev, pager, next"
      :total="total"
      :page-size="8"
      @current-change="onPageChange"
    />
  </div>
</template>

<script>
import { getMovies, getWantedMovies, getRecommendations } from '../api/movies'
import { getCategories } from '../api/admin'
import MovieCard from '../components/MovieCard.vue'

export default {
  name: 'HomePage',
  components: { MovieCard },
  data () {
    return {
      movies: [],
      categories: [],
      total: 0,
      search: '',
      statusFilter: '',
      categoryFilter: '',
      page: 1,
      wantedIds: [],
      recommendations: []
    }
  },
  mounted () {
    this.fetchCategories()
    this.fetchMovies()
    this.fetchWanted()
    this.fetchRecommendations()
  },
  methods: {
    async fetchCategories () {
      const res = await getCategories()
      this.categories = res.data.results
    },
    async fetchMovies () {
      const params = { page: this.page }
      if (this.search) params.search = this.search
      if (this.statusFilter) params.status = this.statusFilter
      if (this.categoryFilter) params.category = this.categoryFilter
      const res = await getMovies(params)
      this.movies = res.data.results
      this.total = res.data.count
    },
    async fetchWanted () {
      try {
        const res = await getWantedMovies()
        this.wantedIds = (res.data.results || res.data).map(m => m.id)
      } catch (e) { /* 未登录忽略 */ }
    },
    async fetchRecommendations () {
      try {
        const res = await getRecommendations()
        this.recommendations = res.data.results || res.data
        if (!this.recommendations.length) throw new Error('empty')
      } catch (e) {
        // 失败时取热映 top4 兜底
        try {
          const res = await getMovies({ status: 'hot', ordering: '-score' })
          this.recommendations = (res.data.results || res.data).slice(0, 4)
        } catch (_) { /* 最终兜底 */ }
      }
    },
    onSearch () {
      this.page = 1
      this.fetchMovies()
    },
    onPageChange (page) {
      this.page = page
      this.fetchMovies()
      window.scrollTo(0, 0)
    }
  }
}
</script>
