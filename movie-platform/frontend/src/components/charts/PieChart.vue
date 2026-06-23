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
        tooltip: { trigger: 'item' },
        series: [{
          type: 'pie',
          radius: ['40%', '70%'],
          data: this.data.map(d => ({ name: d.name, value: d.value }))
        }]
      })
    }
  },
  beforeDestroy () {
    this.chart?.dispose()
  }
}
</script>
