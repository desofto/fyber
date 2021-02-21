<template>
  <div class="d-flex justify-content-end">
    <button @click="logout()" class="btn btn-light">
      Logout
    </button>
  </div>
</template>

<script>
  export default {
    data: () => ({
    }),

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
    }
  }
</script>

<style scoped>

</style>