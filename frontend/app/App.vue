<template>
  <div>
    <Auth />
    <Messages v-if="currentUser.token" />
  </div>
</template>

<script>
  import Auth from './auth/'
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
      Auth,
      Messages,
    }
  }
</script>

<style>
</style>
