<template>
  <div>
    <h2>影厅管理</h2>

    <el-button type="primary" @click="showDialog(null)">新增影厅</el-button>

    <el-table :data="halls">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="name" label="名称" />
      <el-table-column label="所属影院">
        <template slot-scope="scope">
          {{ scope.row.cinema_info?.name || '-' }}
        </template>
      </el-table-column>
      <el-table-column prop="capacity" label="座位数" />
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="small" @click="showDialog(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :visible.sync="dialogVisible" :title="editingId ? '编辑影厅' : '新增影厅'">
      <el-form :model="form" label-width="80px">
        <el-form-item label="所属影院">
          <el-select v-model="form.cinema" placeholder="选择影院">
            <el-option
              v-for="c in cinemas"
              :key="c.id"
              :label="c.name"
              :value="c.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="名称">
          <el-input v-model="form.name" placeholder="如1号厅、IMAX厅" />
        </el-form-item>
        <el-form-item label="座位数">
          <el-input-number v-model="form.capacity" :min="1" />
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
import { getHalls, createHall, updateHall, deleteHall, getCinemas } from '../../api/admin'

export default {
  data () {
    return {
      halls: [],
      cinemas: [],
      dialogVisible: false,
      editingId: null,
      saving: false,
      form: { name: '', cinema: null, capacity: 100 }
    }
  },
  mounted () {
    this.fetchData()
  },
  methods: {
    async fetchData () {
      const [h, c] = await Promise.all([getHalls({ page_size: 999 }), getCinemas({ page_size: 999 })])
      this.halls = h.data.results
      this.cinemas = c.data.results
    },
    showDialog (row) {
      this.editingId = row ? row.id : null
      this.form = row
        ? { name: row.name, cinema: row.cinema, capacity: row.capacity }
        : { name: '', cinema: null, capacity: 100 }
      this.dialogVisible = true
    },
    async handleSave () {
      this.saving = true
      try {
        if (this.editingId) {
          await updateHall(this.editingId, this.form)
        } else {
          await createHall(this.form)
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
        await deleteHall(id)
        this.$message.success('删除成功')
        this.fetchData()
      } catch (e) { /* cancelled */ }
    }
  }
}
</script>
