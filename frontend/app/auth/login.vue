<template>
  <div>
    <div>
      <div>
        Email:
      </div>
      <div>
        <input type="email" v-model="email" />
      </div>
    </div>

    <div>
      <div>
        Password:
      </div>
      <div>
        <input type="password" v-model="password" />
      </div>
    </div>

    <div>
      <div>
        <button @click="login()">
          Login
        </button>
      </div>
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
          alert(response.body)
        })
      }
    }
  }
</script>

<style scoped>

</style>