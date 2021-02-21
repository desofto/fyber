<template>
  <div>
    <div v-for="message in messages" :key="message.id">
      <div>
        {{ message.text }}
      </div>

      <div class="d-flex">
        <div class="flex-grow-1">
          From: {{ message.sender.email }}
        </div>

        <div>
          {{ message.created_at }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data: () => ({
      messages: []
    }),

    mounted() {
      this.$http.get(`/api/v1/messages?token=${this.$globals.currentUser.token}`)
      .then(response => {
        this.messages = response.body
      }, response => {
        alert(response.body)
      })
    },
  }
</script>

<style scoped>

</style>