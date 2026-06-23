<template>
  <span>
    <span v-if="remaining > 0" style="color:#e6a23c">{{ displayMinutes }}:{{ displaySeconds }}</span>
    <span v-else style="color:#f56c6c">已超时</span>
  </span>
</template>

<script>
export default {
  name: 'CountdownTimer',
  props: {
    createdAt: { type: String, default: '' },
    minutes: { type: Number, default: 15 }
  },
  data () {
    return { remaining: 0 }
  },
  mounted () {
    if (this.createdAt) {
      const deadline = new Date(this.createdAt).getTime() + this.minutes * 60 * 1000
      this.remaining = Math.max(0, Math.floor((deadline - Date.now()) / 1000))
    }
    this.timer = setInterval(() => {
      if (this.remaining > 0) {
        this.remaining--
      } else {
        clearInterval(this.timer)
        this.$emit('timeout')
      }
    }, 1000)
  },
  computed: {
    m () { return Math.floor(this.remaining / 60) },
    s () { return this.remaining % 60 },
    displayMinutes () { return String(this.m).padStart(2, '0') },
    displaySeconds () { return String(this.s).padStart(2, '0') }
  },
  beforeDestroy () {
    clearInterval(this.timer)
  }
}
</script>
