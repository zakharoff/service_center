<template lang="pug">
  #loading(v-if="loading")
    q-spinner-cube.fixed-center(color="brand" size="6em")
  section#dashboard(v-else)
    h1 Dashboard
</template>

<script>
  import FormOrganization from './organization/form.vue'
  import ListOrganizations from './organization/list.vue'
  import { backend } from '../../api/index'


  export default {
    data: function () {
      return {
        loading: false
      }
    },
    components: {
      FormOrganization,
      ListOrganizations
    }
  }
</script>

<style lang="stylus">
  .text-brand
    color: rgb(20, 40, 160)
</style>
