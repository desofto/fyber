<template>
  <div>
    <List class="mb-4" />
    <New />
  </div>
</template>

<script>
  import List from './list'
  import New from './new'

  export default {
    data: () => ({
    }),

    components: {
      List,
      New,
    }
  }
</script>

<style scoped>

</style>