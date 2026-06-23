<template>
  <div>
    <h1>登录 / 注册</h1>
    <el-tabs v-model="activeTab">
      <!-- 登录 -->
      <el-tab-pane label="登录" name="login">
        <el-form :model="loginForm">
          <el-form-item>
            <el-input v-model="loginForm.username" placeholder="用户名" />
          </el-form-item>
          <el-form-item>
            <el-input v-model="loginForm.password" type="password" placeholder="密码" @keyup.enter.native="handleLogin" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleLogin" :loading="loading">登录</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <!-- 注册 -->
      <el-tab-pane label="注册" name="register">
        <el-form :model="registerForm">
          <el-form-item>
            <el-input v-model="registerForm.username" placeholder="用户名" />
          </el-form-item>
          <el-form-item>
            <el-input v-model="registerForm.password" type="password" placeholder="密码（至少6位）" />
          </el-form-item>
          <el-form-item>
            <el-input v-model="registerForm.confirmPassword" type="password" placeholder="确认密码" />
          </el-form-item>
          <el-form-item>
            <el-row>
              <el-col :span="14">
                <el-input v-model="registerForm.captchaCode" placeholder="验证码（不区分大小写）" />
              </el-col>
              <el-col :span="10" style="padding-left:10px">
                <img :src="captchaUrl" @click="refreshCaptcha" style="height:40px;cursor:pointer" title="点击刷新" />
              </el-col>
            </el-row>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleRegister" :loading="loading">注册</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
  name: 'LoginPage',
  data () {
    return {
      activeTab: 'login',
      loading: false,
      loginForm: { username: '', password: '' },
      registerForm: { username: '', password: '', confirmPassword: '', captchaCode: '' },
      captchaKey: '',
      captchaUrl: ''
    }
  },
  mounted () {
    this.refreshCaptcha()
  },
  methods: {
    async handleLogin () {
      if (!this.loginForm.username || !this.loginForm.password) {
        this.$message.error('请填写用户名和密码')
        return
      }
      this.loading = true
      try {
        await this.$store.dispatch('user/login', this.loginForm)
        this.$message.success('登录成功')
        this.$router.push('/')
      } catch (e) {
        const detail = e.response?.data?.detail
        this.$message.error(typeof detail === 'string' ? detail : '登录失败')
      } finally {
        this.loading = false
      }
    },
    async handleRegister () {
      const { username, password, confirmPassword, captchaCode } = this.registerForm
      if (!username || !password) {
        this.$message.error('请填写完整信息')
        return
      }
      if (password.length < 6) {
        this.$message.error('密码至少6位')
        return
      }
      if (password !== confirmPassword) {
        this.$message.error('两次密码不一致')
        return
      }
      if (!captchaCode) {
        this.$message.error('请输入验证码')
        return
      }
      this.loading = true
      try {
        await this.$store.dispatch('user/register', {
          username, password,
          captcha_key: this.captchaKey,
          captcha_code: captchaCode
        })
        this.$message.success('注册成功，已自动登录')
        this.$router.push('/')
      } catch (e) {
        const data = e.response?.data
        const msg = typeof data === 'object' ? Object.values(data).flat().join('; ') : '注册失败'
        this.$message.error(msg)
      } finally {
        this.loading = false
      }
    },
    refreshCaptcha () {
      this.captchaKey = Date.now().toString(36) + Math.random().toString(36).slice(2, 8)
      this.captchaUrl = `/api/auth/captcha/?key=${this.captchaKey}`
    }
  }
}
</script>
