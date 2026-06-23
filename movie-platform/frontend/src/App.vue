<template>
  <div>
    <!-- 管理后台: 左侧菜单 + 右侧内容 -->
    <el-container v-if="isAdminRoute">
      <el-aside width="200px">
        <el-menu router :default-active="$route.path">
          <el-menu-item index="/admin/dashboard">概览</el-menu-item>
          <el-menu-item index="/admin/movies">电影管理</el-menu-item>
          <el-menu-item index="/admin/cinemas">影院管理</el-menu-item>
          <el-menu-item index="/admin/halls">影厅管理</el-menu-item>
          <el-menu-item index="/admin/sessions">场次管理</el-menu-item>
          <el-menu-item index="/admin/orders">订单管理</el-menu-item>
          <el-menu-item index="/admin/stats">数据统计</el-menu-item>
          <el-menu-item index="/">← 返回前台</el-menu-item>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view />
      </el-main>
    </el-container>

    <!-- 用户端: 顶部导航 + 内容 -->
    <div v-else>
      <Navbar />
      <div style="padding:20px;max-width:1200px;margin:0 auto">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue'

export default {
  components: { Navbar },
  computed: {
    isAdminRoute () {
      return this.$route.path.startsWith('/admin')
    }
  }
}
</script>
