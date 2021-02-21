<template>
  <div>
    <div v-if="currentUser.token">
      <div>
        <Logout  />
      </div>

      <Messages />
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
  import Login from './auth/login'
  import Signup from './auth/signup'
  import Logout from './auth/logout'
  import Messages from './messages/'

  export default {
    data: () => ({
    }),

    computed: {
      currentUser() {
        return this.$globals.currentUser
      }
    },

    components: {
      Login,
      Signup,
      Logout,
      Messages,
    }
  }
</script>

<style>
</style>
