<template>
  <div class="d-flex text-nowrap align-items-center" v-if="me">
    <label class="mr-2 mb-0">Time zone:</label>
    <select v-model="me.time_zone" class="form-control" @change="update()">
      <option v-for="(title, timeZone) in timeZones" :key="timeZone" :value="timeZone">
        {{ title }}
      </option>
    </select>
  </div>
</template>

<script>
  import { TimeZones } from './signup'

  export default {
    data: () => ({
      timeZones: TimeZones,
      me: null
    }),

    mounted() {
      this.$http.get(`/api/v1/users/me?token=${this.$globals.currentUser.token}`)
      .then(response => {
        this.me = response.body
      }, response => {
        alert(response.body.errors)
      })
    },

    methods: {
      update() {
        this.$http.post(`/api/v1/users/me?token=${this.$globals.currentUser.token}`, {
          time_zone: this.me.time_zone
        })
        .then(() => {
        }, response => {
          alert(response.body.errors)
        })
      }
    }
  }
</script>

<style scoped>

</style>