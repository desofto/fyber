import Vue from 'vue'

import 'bootstrap/dist/css/bootstrap.min.css'

import VueResource from 'vue-resource'
Vue.use(VueResource)

//Vue.http.headers.common["X-CSRF-Token"] = (typeof document != "undefined") && document.querySelector('meta[name="csrf-token"]').getAttribute("content")

Vue.http.headers.common['Access-Control-Allow-Origin'] = '*'

Vue.config.productionTip = false

import './globals'

import App from './App.vue'

new Vue({
  render: h => h(App),
}).$mount('#app')
