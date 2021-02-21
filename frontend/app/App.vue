<template>
  <div>
    <div v-if="!currentUser.token">
      <Login />
      <Signup />
    </div>

    <Logout v-else />

    <Messages />
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
