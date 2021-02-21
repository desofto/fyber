<template>
  <div class="p-3 bg-light">
    <div class="form-group mb-3">
      <textarea v-model="text" class="form-control" />
    </div>

    <div class="form-group mb-3">
      <select v-model="userId" class="form-control" style="max-width: 20em;">
        <option :value="null">
          no user selected
        </option>

        <option v-for="user in users" :key="user.id" :value="user.id">
          {{ user.email }}
        </option>
      </select>
    </div>

    <div class="form-group mb-3">
      <select v-model="groupId" class="form-control" style="max-width: 20em;">
        <option :value="null">
          no group selected
        </option>

        <option v-for="group in groups" :key="group.id" :value="group.id">
          {{ group.name }}
        </option>
      </select>
    </div>

    <div class="form-group">
      <button @click="post()" class="btn btn-primary">
        Post
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    data: () => ({
      text: '',
      userId: null,
      groupId: null,
      users: [],
      groups: []
    }),

    mounted() {
      this.$http.get(`/api/v1/groups?token=${this.$globals.currentUser.token}`)
      .then(response => {
        this.groups = response.body
      }, response => {
        alert(response.body.errors)
      })

      this.$http.get(`/api/v1/users?token=${this.$globals.currentUser.token}`)
      .then(response => {
        this.users = response.body
      }, response => {
        alert(response.body.errors)
      })
},

    methods: {
      post() {
        this.$http.post(`/api/v1/messages?token=${this.$globals.currentUser.token}`, {
          text: this.text,
          user_id: this.userId,
          group_id: this.groupId
        })
        .then(() => {
          this.text = ''
          alert('sent')
        }, response => {
          alert(response.body.errors)
        })
      }
    }
  }
</script>

<style scoped>

</style>