<template>
  <div>
    <h2>场次管理</h2>

    <el-button type="primary" @click="showDialog(null)">新增场次</el-button>

    <el-table :data="sessions" v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="movie.name" label="电影" />
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
      <el-table-column label="余票">
        <template slot-scope="scope">
          {{ scope.row.total_tickets - scope.row.sold_tickets }} / {{ scope.row.total_tickets }}
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="small" @click="showDialog(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-if="total > 10"
      style="margin-top:20px;text-align:right"
      background
      layout="total, prev, pager, next"
      :total="total"
      :page-size="10"
      :current-page.sync="page"
      @current-change="onPageChange"
    />

    <el-dialog :visible.sync="dialogVisible" :title="editingId ? '编辑场次' : '新增场次'">
      <el-form :model="form" label-width="80px">
        <el-form-item label="电影">
          <el-select v-model="form.movie" placeholder="选择电影">
            <el-option v-for="m in movies" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="影院">
          <el-select v-model="form.cinema" placeholder="选择影院" @change="onCinemaChange">
            <el-option v-for="c in cinemas" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="影厅">
          <el-select v-model="form.hall" placeholder="先选影院">
            <el-option
              v-for="h in filteredHalls"
              :key="h.id"
              :label="h.name"
              :value="h.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="时间">
          <el-date-picker v-model="form.start_time" type="datetime" value-format="yyyy-MM-ddTHH:mm:ssZ" />
        </el-form-item>
        <el-form-item label="票价">
          <el-input-number v-model="form.price" :min="0" :precision="2" />
        </el-form-item>
        <el-form-item label="总票数">
          <el-input-number v-model="form.total_tickets" :min="1" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSave" :loading="saving">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getSessions, createSession, updateSession, deleteSession, getHalls, getCinemas } from '../../api/admin'
import { getMovies as getMoviesList } from '../../api/movies'

export default {
  data () {
    return {
      sessions: [],
      movies: [],
      halls: [],
      cinemas: [],
      total: 0,
      page: 1,
      loading: false,
      dialogVisible: false,
      editingId: null,
      saving: false,
      form: { movie: null, cinema: null, hall: null, start_time: '', price: '49.90', total_tickets: 100 }
    }
  },
  computed: {
    filteredHalls () {
      if (!this.form.cinema) return []
      return this.halls.filter(h => h.cinema === this.form.cinema)
    }
  },
  async mounted () {
    await Promise.all([this.fetchSessions(), this.fetchDropdowns()])
  },
  methods: {
    async fetchDropdowns () {
      const [m, h, c] = await Promise.all([
        getMoviesList({ page_size: 999 }),
        getHalls({ page_size: 999 }),
        getCinemas({ page_size: 999 })
      ])
      this.movies = m.data.results
      this.halls = h.data.results
      this.cinemas = c.data.results
    },
    async fetchSessions () {
      this.loading = true
      try {
        const res = await getSessions({ page: this.page })
        this.sessions = res.data.results
        this.total = res.data.count
      } finally {
        this.loading = false
      }
    },
    onPageChange (page) {
      this.page = page
      this.fetchSessions()
    },
    formatTime (time) {
      if (!time) return ''
      return new Date(time).toLocaleString('zh-CN')
    },
    onCinemaChange () {
      this.form.hall = null
    },
    showDialog (row) {
      this.editingId = row ? row.id : null
      if (row) {
        const cinemaId = row.hall?.cinema_info?.id || row.hall?.cinema
        this.form = {
          movie: row.movie?.id,
          cinema: cinemaId,
          hall: row.hall?.id,
          start_time: row.start_time,
          price: row.price,
          total_tickets: row.total_tickets
        }
      } else {
        this.form = { movie: null, cinema: null, hall: null, start_time: '', price: '49.90', total_tickets: 100 }
      }
      this.dialogVisible = true
    },
    async handleSave () {
      this.saving = true
      try {
        if (this.editingId) {
          await updateSession(this.editingId, this.form)
        } else {
          await createSession(this.form)
        }
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.fetchData()
      } catch (e) {
        const data = e.response?.data
        const msg = typeof data === 'object' ? Object.values(data).flat().join('; ') : '保存失败'
        this.$message.error(msg)
      } finally {
        this.saving = false
      }
    },
    async handleDelete (id) {
      try {
        await this.$confirm('确定删除？')
        await deleteSession(id)
        this.$message.success('删除成功')
        this.fetchData()
      } catch (e) { /* cancelled */ }
    },
    async fetchData () {
      await this.fetchSessions()
    }
  }
}
</script>
