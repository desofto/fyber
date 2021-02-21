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

    <div class="form-group mb-3">
      <label>Time zone:</label>
      <select v-model="timeZone" class="form-control">
        <option v-for="(title, timeZone) in timeZones" :key="timeZone" :value="timeZone">
          {{ title }}
        </option>
      </select>
    </div>

    <div class="form-group mb-3">
      <label>Group:</label>
      <select v-model="groupId" class="form-control">
        <option :value="null">
          no group
        </option>
        <option v-for="group in groups" :key="group.id" :value="group.id">
          {{ group.name }}
        </option>
      </select>
    </div>

    <div class="form-group">
      <button @click="signup()" class="btn btn-primary">
        Signup
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    data: () => ({
      email: '',
      password: '',
      timeZone: 0,
      groupId: null,
      groups: [],

      timeZones: {
        '-12': '-12',
        '-11': '-11',
        '-10': '-10',
        '-9': '-9',
        '-8': '-8',
        '-7': '-7',
        '-6': '-6',
        '-5': '-5',
        '-4': '-4',
        '-3': '-3',
        '-2': '-2',
        '-1': '-1',
        '0': '0',
        '1': '1',
        '2': '2',
        '3': '3',
        '4': '4',
        '5': '5',
        '6': '6',
        '7': '7',
        '8': '8',
        '9': '9',
        '10': '10',
        '11': '11',
        '12': '12'
      }
    }),

    mounted() {
      this.$http.get('/api/v1/groups')
      .then(response => {
        this.groups = response.body
      }, response => {
        alert(response.body)
      })
    },

    methods: {
      signup() {
        this.$http.post('/api/v1/users/signup', {
          email: this.email,
          password: this.password,
          time_zone: this.timeZone,
          group_id: this.groupId
        })
        .then(() => {
          alert('Registered. Please login now.')
        }, response => {
          alert(response.body)
        })
      }
    }
  }
</script>

<style scoped>

</style>