<template>
  <div class="p-3">
    <div v-for="message in messages" :key="message.id" class="p-3">
      <div class="border-bottom pb-3">
        {{ message.text }}
      </div>

      <div class="d-flex pt-1 small text-black-50">
        <div class="flex-grow-1">
          {{ message.sender.email }}
        </div>

        <div>
          {{ message.created_at | date('%Y-%m-%d %H:%M:%S') }}
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