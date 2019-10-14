<template lang="pug">
  #loading(v-if="loading")
    q-spinner-cube.fixed-center(color="brand" size="6em")
  section#dashboard(v-else)
    h1.text-h4.text-bold.q-my-md Dashboard
</template>

<script>
  import { backend } from '../../api/index'

  export default {
    data: function () {
      return {
        loading: false
      }
    },
    components: {
    }
  }
</script>

<style lang="stylus">
  .text-brand
    color: rgb(20, 40, 160)
</style>
