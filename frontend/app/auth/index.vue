<template>
  <div>
    <div v-if="currentUser.token">
      <div class="d-flex justify-content-end align-items-center pt-3 pr-3">
        <div class="mr-3">
          <Timezone />
        </div>
        <div>
          <Logout  />
        </div>
      </div>
    </div>

    <div v-else>
      <div class="d-flex">
        <div class="d-flex" style="width: 50%;">
          <Login class="m-auto" />
        </div>

        <div class="d-flex" style="width: 50%;">
          <Signup class="m-auto" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Login from './login'
  import Signup from './signup'
  import Timezone from './timezone'
  import Logout from './logout'

  export default {
    data: () => ({
    }),

    computed: {
      currentUser() {
        return this.$globals.currentUser
      }
    },

    methods: {
      logout() {
        this.$http.post('/api/v1/users/logout', { token: this.$globals.currentUser.token })
        .then(() => {
          this.$globals.currentUser.token = ''
          localStorage.setItem('current-user-token', '')
        }, response => {
          alert(response.body.errors)
        })
      }
    },

    components: {
      Login,
      Signup,
      Timezone,
      Logout
    }
  }
</script>

<style scoped>

</style>