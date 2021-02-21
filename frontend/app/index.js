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

function filterDate(date, format = "") {
  if (!date) return ""
  let dateStruc = new Date(isNaN(date) ? date : (date * 1000))
  if (!dateStruc.getTime()) return (date)

  let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  let monthsShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

  function pad(value, size = 2, prepend = "0") {
    value = String(value)

    while (value.length < size) value = prepend + value

    return value
  }

  format = format.replace(/%Y/, dateStruc.getFullYear())
  format = format.replace(/%y/, dateStruc.getFullYear() % 100)
  format = format.replace(/%B/, months[dateStruc.getMonth()])
  format = format.replace(/%b/, monthsShort[dateStruc.getMonth()])
  format = format.replace(/%m/, pad(dateStruc.getMonth() + 1, 2))
  format = format.replace(/%_m/, pad(dateStruc.getMonth() + 1, 2, " "))
  format = format.replace(/%-m/, dateStruc.getMonth() + 1)
  format = format.replace(/%d/, pad(dateStruc.getDate(), 2))
  format = format.replace(/%e/, pad(dateStruc.getDate(), 2, " "))
  format = format.replace(/%-d/, dateStruc.getDate())

  format = format.replace(/%H/, pad(dateStruc.getHours(), 2))
  format = format.replace(/%k/, pad(dateStruc.getHours(), 2, " "))
  format = format.replace(/%M/, pad(dateStruc.getMinutes(), 2))
  format = format.replace(/%S/, pad(dateStruc.getSeconds(), 2))

  return format
}

Vue.filter("date", filterDate)