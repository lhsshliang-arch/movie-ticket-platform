<template>
  <div v-if="movie">
    <el-row :gutter="20">
      <el-col :span="8">
        <img :src="movie.poster" style="width:100%;background:#eee" />
      </el-col>
      <el-col :span="16">
        <h1>
          {{ movie.name }}
          <el-button
            v-if="$store.state.user.isLoggedIn"
            :type="wanted ? 'warning' : 'default'"
            size="small"
            icon="el-icon-star-off"
            @click="toggleWant"
            :loading="wantLoading"
          >
            {{ wanted ? '已想看' : '想看' }}
          </el-button>
        </h1>
        <p>评分: {{ movie.score | formatScore }} / 时长: {{ movie.duration }} 分钟</p>
        <p>上映: {{ movie.release_time }}</p>
        <p>类型: <el-tag v-for="c in movie.categories" :key="c.id" size="small" style="margin-right:4px">{{ c.name }}</el-tag></p>
        <p>国家: {{ movie.country }}</p>
        <p>语言: {{ movie.language }}</p>
        <el-divider />
        <p>{{ movie.description }}</p>
      </el-col>
    </el-row>

    <h2 style="margin-top:30px">全部场次</h2>
    <el-table :data="sessions" v-loading="sessionsLoading">
      <el-table-column label="影院">
        <template slot-scope="scope">
          {{ scope.row.hall.cinema_info?.name || '-' }}
        </template>
      </el-table-column>
      <el-table-column prop="hall.name" label="影厅" />
      <el-table-column label="时间">
        <template slot-scope="scope">
          {{ formatTime(scope.row.start_time) }}
        </template>
      </el-table-column>
      <el-table-column prop="price" label="票价" />
      <el-table-column prop="remaining_tickets" label="余票" />
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            type="primary"
            :disabled="scope.row.remaining_tickets <= 0"
            @click="goOrder(scope.row)"
          >
            {{ scope.row.remaining_tickets > 0 ? '购票' : '售罄' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <p v-if="!sessionsLoading && sessions.length === 0" style="color:#999">暂无场次</p>
  </div>
</template>

<script>
import { getMovieDetail, getMovieSessions, toggleWant, getWantedMovies } from '../api/movies'

export default {
  data () {
    return {
      movie: null,
      sessions: [],
      sessionsLoading: false,
      wanted: false,
      wantLoading: false
    }
  },
  async mounted () {
    const id = this.$route.params.id
    const [movieRes] = await Promise.all([getMovieDetail(id)])
    this.movie = movieRes.data
    this.fetchSessions(id)
    this.checkWanted()
  },
  methods: {
    async fetchSessions (movieId) {
      this.sessionsLoading = true
      try {
        const res = await getMovieSessions(movieId)
        this.sessions = res.data.results || []
      } catch (e) {
        this.sessions = []
      } finally {
        this.sessionsLoading = false
      }
    },
    formatTime (time) {
      if (!time) return ''
      return new Date(time).toLocaleString('zh-CN')
    },
    goOrder (session) {
      if (!this.$store.state.user.isLoggedIn) {
        this.$message.warning('请先登录')
        this.$router.push('/login')
        return
      }
      this.$router.push(`/order/${session.id}`)
    },
    async checkWanted () {
      try {
        const res = await getWantedMovies()
        const ids = (res.data.results || res.data).map(m => m.id)
        this.wanted = ids.includes(this.movie.id)
      } catch (e) { /* 未登录忽略 */ }
    },
    async toggleWant () {
      this.wantLoading = true
      try {
        const res = await toggleWant(this.movie.id)
        this.wanted = res.data.wanted
        this.$message.success(this.wanted ? '已添加想看' : '已取消想看')
      } catch (e) {
        this.$message.error('操作失败')
      } finally {
        this.wantLoading = false
      }
    }
  }
}
</script>
