<template lang="pug">
  #app
    q-layout(view='hHh lpR fFf')
      navbar(:user="user")
      q-page-container
        .doc-page
          dashboard
</template>

<script>
  import Navbar from 'components/navbar.vue'
  import Dashboard from 'staff/components/dashboard.vue'
  import { backend } from 'api/index.js'

  export default {
    data: function () {
      return {
        left: false,
        user: {}
      }
    },
    created() {
      this.fetchUser()
    },
    methods: {
      fetchUser() {
        backend.staff.current()
          .then(response => this.user = response.data.user)
          .catch(error => console.log(error))
      }
    },
    components: {
      Navbar,
      Dashboard
    }
  }
</script>

<style lang="stylus">
  .doc-page
    padding 10px 180px
    font-weight 300
    max-width 1500px
    margin-left auto
    margin-right auto
</style>
