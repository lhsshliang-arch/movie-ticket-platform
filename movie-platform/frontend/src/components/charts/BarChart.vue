<template>
  <div ref="chart" style="width:100%;height:300px"></div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  props: { data: Array }, // [{name, value}]
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
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
        xAxis: { type: 'value' },
        yAxis: {
          type: 'category',
          data: this.data.map(d => d.name).reverse()
        },
        series: [{
          type: 'bar',
          data: this.data.map(d => d.value).reverse(),
          itemStyle: { color: '#409EFF' }
        }]
      })
    }
  },
  beforeDestroy () {
    this.chart?.dispose()
  }
}
</script>
