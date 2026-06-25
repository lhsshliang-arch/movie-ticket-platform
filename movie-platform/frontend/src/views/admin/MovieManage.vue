<template>
  <div>
    <h2>电影管理</h2>

    <el-button type="primary" @click="showDialog(null)">新增电影</el-button>

    <el-table :data="movies">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="name" label="片名" />
      <el-table-column label="评分">
        <template slot-scope="scope">
          {{ scope.row.score | formatScore }}
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 'hot' ? 'danger' : scope.row.status === 'coming' ? 'warning' : 'info'">
            {{ { hot: '热映', coming: '即将上映', offline: '已下架' }[scope.row.status] }}
          </el-tag>
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
      v-if="total > 8"
      style="margin-top:20px;text-align:right"
      background
      layout="total, prev, pager, next"
      :total="total"
      :page-size="8"
      :current-page.sync="page"
      @current-change="onPageChange"
    />

    <!-- 新增/编辑对话框 -->
    <el-dialog :visible.sync="dialogVisible" :title="editingId ? '编辑电影' : '新增电影'">
      <el-form :model="form" label-width="80px">
        <el-form-item label="片名">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="简介">
          <el-input v-model="form.description" type="textarea" />
        </el-form-item>
        <el-form-item label="海报">
          <input type="file" @change="onFileChange" />
        </el-form-item>
        <el-form-item label="评分">
          <el-input-number v-model="form.score" :min="0" :max="10" :step="0.1" />
        </el-form-item>
        <el-form-item label="时长">
          <el-input-number v-model="form.duration" :min="1" />
        </el-form-item>
        <el-form-item label="上映日">
          <el-date-picker v-model="form.release_time" type="date" value-format="yyyy-MM-dd" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="form.status">
            <el-option label="热映" value="hot" />
            <el-option label="即将上映" value="coming" />
            <el-option label="已下架" value="offline" />
          </el-select>
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="form.categories" placeholder="选择分类" multiple filterable>
            <el-option
              v-for="c in categories"
              :key="c.id"
              :label="c.name"
              :value="c.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="国家">
          <el-input v-model="form.country" placeholder="如中国大陆" />
        </el-form-item>
        <el-form-item label="语言">
          <el-input v-model="form.language" placeholder="如汉语普通话" />
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
import { getMovies, createMovie, updateMovie, deleteMovie } from '../../api/movies'
import { getCategories } from '../../api/admin'

export default {
  data () {
    return {
      movies: [],
      categories: [],
      total: 0,
      page: 1,
      dialogVisible: false,
      editingId: null,
      saving: false,
      form: this.emptyForm(),
      posterFile: null
    }
  },
  mounted () {
    this.fetchMovies()
    this.fetchCategories()
  },
  methods: {
    emptyForm () {
      return {
        name: '',
        description: '',
        score: 0,
        duration: 90,
        release_time: '',
        status: 'coming',
        categories: [],
        country: '',
        language: ''
      }
    },
    async fetchMovies () {
      const res = await getMovies({ page: this.page })
      this.movies = res.data.results
      this.total = res.data.count
    },
    onPageChange (page) {
      this.page = page
      this.fetchMovies()
    },
    showDialog (row) {
      this.editingId = row ? row.id : null
      if (row) {
        this.form = {
          name: row.name,
          description: row.description,
          score: row.score,
          duration: row.duration,
          release_time: row.release_time,
          status: row.status,
          categories: (row.categories || []).map(c => c.id),
          country: row.country,
          language: row.language
        }
      } else {
        this.form = this.emptyForm()
      }
      this.posterFile = null
      this.dialogVisible = true
    },
    onFileChange (e) {
      this.posterFile = e.target.files[0]
    },
    async handleSave () {
      this.saving = true
      try {
        const fd = new FormData()
        Object.keys(this.form).forEach(key => {
          if (key === 'categories') {
            this.form.categories.forEach(id => fd.append('categories', id))
          } else if (key !== 'poster') {
            fd.append(key, this.form[key])
          }
        })
        if (this.posterFile) {
          fd.append('poster', this.posterFile)
        }

        if (this.editingId) {
          await updateMovie(this.editingId, fd)
        } else {
          await createMovie(fd)
        }
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.fetchMovies()
      } catch (e) {
        const data = e.response?.data
        const msg = typeof data === 'object' ? Object.values(data).flat().join('; ') : '保存失败'
        this.$message.error(msg)
      } finally {
        this.saving = false
      }
    },
    async fetchCategories () {
      try {
        const res = await getCategories()
        this.categories = res.data.results
      } catch (e) {
        this.$message.error('获取分类失败')
      }
    },
    async handleDelete (id) {
      try {
        await this.$confirm('确定删除？')
        await deleteMovie(id)
        this.$message.success('删除成功')
        this.fetchMovies()
      } catch (e) {
        // cancelled
      }
    }
  }
}
</script>
