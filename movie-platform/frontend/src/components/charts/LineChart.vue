<template>
  <div ref="chart" style="width:100%;height:300px"></div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  props: { data: Array },
  watch: {
    data: {
      handler () { this.$nextTick(() => this.render()) },
      deep: true
    }
  },
  mounted () {
    this.$nextTick(() => {
      this.chart = echarts.init(this.$refs.chart)
      this.render()
      window.addEventListener('resize', this.resize)
    })
  },
  methods: {
    resize () {
      this.chart?.resize()
    },
    render () {
      if (!this.chart) return
      this.chart.setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: (this.data || []).map(d => d.date) },
        yAxis: { type: 'value' },
        series: [{
          type: 'line',
          data: (this.data || []).map(d => d.value),
          smooth: true
        }]
      })
    }
  },
  beforeDestroy () {
    window.removeEventListener('resize', this.resize)
    this.chart?.dispose()
  }
}
</script>
