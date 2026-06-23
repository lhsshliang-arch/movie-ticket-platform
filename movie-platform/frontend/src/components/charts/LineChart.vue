<template>
  <div ref="chart" style="width:100%;height:300px"></div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  props: { data: Array }, // [{date, value}]
  watch: {
    data () { this.render() }
  },
  mounted () {
    this.chart = echarts.init(this.$refs.chart)
    this.render()
  },
  methods: {
    render () {
      if (!this.chart) return
      this.chart.setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: this.data.map(d => d.date) },
        yAxis: { type: 'value' },
        series: [{
          type: 'line',
          data: this.data.map(d => d.value),
          smooth: true
        }]
      })
    }
  },
  beforeDestroy () {
    this.chart?.dispose()
  }
}
</script>
