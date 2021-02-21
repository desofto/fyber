<template>
  <div class="d-flex justify-content-end pt-3 pr-3">
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
          alert(response.body)
        })
      }
    }
  }
</script>

<style scoped>

</style>