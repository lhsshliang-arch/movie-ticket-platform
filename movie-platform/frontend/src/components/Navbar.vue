<template>
  <el-menu mode="horizontal" router>
    <el-menu-item index="/">
      <h3>电影平台</h3>
    </el-menu-item>

    <el-menu-item style="float:right" v-if="loggedIn">
      <el-dropdown @command="handleCommand">
        <span>{{ user?.username }}</span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="profile">个人中心</el-dropdown-item>
          <el-dropdown-item command="orders">我的订单</el-dropdown-item>
          <el-dropdown-item v-if="user?.is_staff" command="admin" divided>管理后台</el-dropdown-item>
          <el-dropdown-item command="logout" divided>退出</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-menu-item>

    <el-menu-item v-else index="/login" style="float:right">登录</el-menu-item>
  </el-menu>
</template>

<script>
import { mapState } from 'vuex'

export default {
  name: 'AppNavbar',
  computed: {
    ...mapState('user', { user: 'user', loggedIn: 'isLoggedIn' })
  },
  methods: {
    handleCommand (cmd) {
      if (cmd === 'logout') {
        this.$store.dispatch('user/logout')
        this.$router.push('/login')
      } else if (cmd === 'admin') {
        this.$router.push('/admin/dashboard')
      } else {
        this.$router.push(`/${cmd}`)
      }
    }
  }
}
</script>
