<template>
  <div class="p-4">
    <div class="form-group mb-3">
      <label>Email:</label>
      <input type="email" v-model="email" class="form-control" />
    </div>

    <div class="form-group mb-3">
      <label>Password:</label>
      <input type="password" v-model="password" class="form-control" />
    </div>

    <div class="form-group">
      <button @click="login()" class="btn btn-primary">
        Login
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    data: () => ({
      email: '',
      password: '',
    }),

    methods: {
      login() {
        this.$http.post('/api/v1/users', {
          email: this.email,
          password: this.password,
        })
        .then(response => {
          this.$globals.currentUser.token = response.body.token
          localStorage.setItem('current-user-token', response.body.token)
        }, response => {
          alert(response.body.errors)
        })
      }
    }
  }
</script>

<style scoped>

</style>