<template>
  <div>
    <h2>影院管理</h2>

    <el-button type="primary" @click="showDialog(null)">新增影院</el-button>

    <el-table :data="cinemas">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="name" label="名称" />
      <el-table-column prop="address" label="地址" />
      <el-table-column prop="phone" label="电话" />
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="small" @click="showDialog(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :visible.sync="dialogVisible" :title="editingId ? '编辑影院' : '新增影院'">
      <el-form :model="form" label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" />
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" />
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
import { getCinemas, createCinema, updateCinema, deleteCinema } from '../../api/admin'

export default {
  data () {
    return {
      cinemas: [],
      dialogVisible: false,
      editingId: null,
      saving: false,
      form: { name: '', address: '', phone: '' }
    }
  },
  mounted () {
    this.fetchCinemas()
  },
  methods: {
    async fetchCinemas () {
      const res = await getCinemas()
      this.cinemas = res.data.results
    },
    showDialog (row) {
      this.editingId = row ? row.id : null
      this.form = row ? { ...row } : { name: '', address: '', phone: '' }
      this.dialogVisible = true
    },
    async handleSave () {
      this.saving = true
      try {
        if (this.editingId) {
          await updateCinema(this.editingId, this.form)
        } else {
          await createCinema(this.form)
        }
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.fetchCinemas()
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
        await deleteCinema(id)
        this.$message.success('删除成功')
        this.fetchCinemas()
      } catch (e) { /* cancelled */ }
    }
  }
}
</script>
