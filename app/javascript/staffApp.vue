<template lang="pug">
  #app
    q-layout(view='hHh lpR fFf')
      navbar(:user="user")
      q-page-container
        q-page
          .doc-page
            router-view
</template>

<script>
  import Navbar from 'staff/components/navbar.vue'
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
    padding 10px 30px
    font-weight 400
    max-width 1500px
    margin-left auto
    margin-right auto

  @media (max-width: 1100px)
    .doc-page
      padding 10px


</style>
