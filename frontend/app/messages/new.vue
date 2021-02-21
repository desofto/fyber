<template>
  <div>
    <div>
      <textarea v-model="text" />
    </div>

    <div>
      <select v-model="userId">
        <option :value="null">
          no user selected
        </option>

        <option v-for="user in users" :key="user.id" :value="user.id">
          {{ user.email }}
        </option>
      </select>
    </div>

    <div>
      <select v-model="groupId">
        <option :value="null">
          no group selected
        </option>

        <option v-for="group in groups" :key="group.id" :value="group.id">
          {{ group.name }}
        </option>
      </select>
    </div>

    <div>
      <button @click="post()">
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
        alert(response.body)
      })

      this.$http.get(`/api/v1/users?token=${this.$globals.currentUser.token}`)
      .then(response => {
        this.users = response.body
      }, response => {
        alert(response.body)
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
          alert('sent')
        }, response => {
          alert(response.body)
        })
      }
    }
  }
</script>

<style scoped>

</style>