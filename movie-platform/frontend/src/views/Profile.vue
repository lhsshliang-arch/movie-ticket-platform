<template>
  <div>
    <h1>个人中心</h1>

    <el-row :gutter="20">
      <!-- 左侧：基本资料 -->
      <el-col :span="12">
        <el-card>
          <h3>基本资料</h3>
          <p>用户名: {{ user.username }}</p>
          <p>邮箱: {{ user.email || '未设置' }}</p>
          <p>手机号: {{ user.phone || '未设置' }}</p>
          <img v-if="user.avatar" :src="user.avatar" style="width:80px;border-radius:50%;margin:10px 0" />
          <div style="margin-top:10px">
            <el-upload
              action=""
              :http-request="uploadAvatar"
              :show-file-list="false"
              :before-upload="beforeUpload"
            >
              <el-button type="primary" size="small">更换头像</el-button>
            </el-upload>
          </div>
          <el-divider />
          <el-button type="primary" @click="showEditDialog">编辑资料</el-button>
        </el-card>
      </el-col>

      <!-- 右侧：修改密码 -->
      <el-col :span="12">
        <el-card>
          <h3>修改密码</h3>
          <el-form :model="passwordForm" label-width="80px">
            <el-form-item label="旧密码">
              <el-input v-model="passwordForm.old_password" type="password" />
            </el-form-item>
            <el-form-item label="新密码">
              <el-input v-model="passwordForm.new_password" type="password" />
            </el-form-item>
            <el-form-item label="确认密码">
              <el-input v-model="passwordForm.confirm_password" type="password" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="changePassword" :loading="changing">修改密码</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>

    <!-- 想看列表 -->
    <el-card style="margin-top:20px" v-loading="wantedLoading">
      <h3 slot="header">想看列表</h3>
      <el-row :gutter="16">
        <el-col v-for="m in wantedMovies" :key="m.id" :span="6" style="margin-bottom:12px">
          <MovieCard :movie="m" :wanted="true" />
        </el-col>
      </el-row>
      <p v-if="!wantedLoading && wantedMovies.length === 0" style="color:#999">暂无想看的电影</p>
    </el-card>

    <!-- 编辑资料对话框 -->
    <el-dialog title="编辑资料" :visible.sync="editDialogVisible" width="400px">
      <el-form :model="editForm" label-width="80px">
        <el-form-item label="邮箱">
          <el-input v-model="editForm.email" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="editForm.phone" maxlength="11" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveProfile" :loading="saving">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import { updateProfile } from '../api/auth'
import { getWantedMovies } from '../api/movies'
import MovieCard from '../components/MovieCard.vue'
import api from '../api/index'

export default {
  name: 'ProfilePage',
  components: { MovieCard },
  data () {
    return {
      passwordForm: { old_password: '', new_password: '', confirm_password: '' },
      changing: false,
      editDialogVisible: false,
      editForm: { email: '', phone: '' },
      saving: false,
      wantedMovies: [],
      wantedLoading: false
    }
  },
  computed: {
    ...mapState('user', { user: 'user' })
  },
  mounted () {
    this.fetchWanted()
  },
  methods: {
    async fetchWanted () {
      this.wantedLoading = true
      try {
        const res = await getWantedMovies()
        this.wantedMovies = res.data.results || res.data
      } catch (e) {
        this.wantedMovies = []
      } finally {
        this.wantedLoading = false
      }
    },
    beforeUpload (file) {
      const isImage = file.type.startsWith('image/')
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isImage) { this.$message.error('只能上传图片'); return false }
      if (!isLt2M) { this.$message.error('不超过2MB'); return false }
      return true
    },
    async uploadAvatar ({ file }) {
      const fd = new FormData()
      fd.append('avatar', file)
      try {
        await this.$store.dispatch('user/updateProfile', fd)
        this.$message.success('头像更新成功')
      } catch (e) {
        this.$message.error('上传失败')
      }
    },
    showEditDialog () {
      this.editForm.email = this.user.email || ''
      this.editForm.phone = this.user.phone || ''
      this.editDialogVisible = true
    },
    async saveProfile () {
      this.saving = true
      try {
        await this.$store.dispatch('user/updateProfile', this.editForm)
        this.$message.success('资料更新成功')
        this.editDialogVisible = false
      } catch (e) {
        this.$message.error('更新失败')
      } finally {
        this.saving = false
      }
    },
    async changePassword () {
      const { old_password, new_password, confirm_password } = this.passwordForm
      if (!old_password || !new_password) {
        this.$message.error('请填写密码')
        return
      }
      if (new_password !== confirm_password) {
        this.$message.error('两次密码不一致')
        return
      }
      if (new_password.length < 6) {
        this.$message.error('新密码至少6位')
        return
      }
      this.changing = true
      try {
        await api.post('/auth/change-password/', { old_password, new_password })
        this.$message.success('密码修改成功，请重新登录')
        this.passwordForm = { old_password: '', new_password: '', confirm_password: '' }
        this.$store.dispatch('user/logout')
        this.$router.push('/login')
      } catch (e) {
        this.$message.error(e.response?.data?.error || '修改失败')
      } finally {
        this.changing = false
      }
    }
  }
}
</script>
