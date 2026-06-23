<template>
  <el-card :body-style="{ padding: '0px' }" style="cursor:pointer;height:100%">
    <img :src="movie.poster" style="width:100%;aspect-ratio:2/3;object-fit:cover;background:#eee" @click="$router.push(`/movie/${movie.id}`)" />
    <div style="padding:14px">
      <h3 @click="$router.push(`/movie/${movie.id}`)">{{ movie.name }}</h3>
      <p v-if="movie.status === 'coming'">上映: {{ movie.release_time }}</p>
      <p v-else>评分: {{ movie.score | formatScore }}</p>
      <div style="margin-bottom:8px">
        <el-tag
          v-for="cat in movie.categories"
          :key="cat.id"
          size="mini"
          style="margin-right:4px;margin-bottom:2px"
        >{{ cat.name }}</el-tag>
      </div>
      <div style="display:flex;align-items:center;justify-content:space-between">
        <el-tag :type="movie.status === 'hot' ? 'danger' : 'info'" size="small">
          {{ statusMap[movie.status] }}
        </el-tag>
        <el-button
          v-if="$store.state.user.isLoggedIn"
          :type="localWanted ? 'warning' : ''"
          :plain="localWanted"
          size="mini"
          :icon="localWanted ? 'el-icon-star-on' : 'el-icon-star-off'"
          @click.stop="toggle"
          :loading="loading"
        >
          {{ localWanted ? '已想看' : '想看' }}
        </el-button>
      </div>
    </div>
  </el-card>
</template>

<script>
import { toggleWant } from '../api/movies'

export default {
  props: { movie: Object, wanted: { type: Boolean, default: false } },
  data () {
    return {
      statusMap: { hot: '热映', coming: '即将上映', offline: '已下架' },
      loading: false,
      localWanted: this.wanted
    }
  },
  methods: {
    async toggle () {
      this.loading = true
      try {
        const res = await toggleWant(this.movie.id)
        this.localWanted = res.data.wanted
      } catch (e) {
        this.$message.error('操作失败')
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
