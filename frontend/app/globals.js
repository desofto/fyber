import Vue from 'vue'

Vue.prototype.$globals = new Vue({
  data: {
    currentUser: {
      token: localStorage.getItem('current-user-token')
    }
  }
})