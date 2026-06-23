import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.use(ElementUI)
Vue.config.productionTip = false

Vue.filter('formatScore', v => (v != null ? Number(v).toFixed(1) : '0.0'))

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
