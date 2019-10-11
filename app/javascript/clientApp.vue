<template lang="pug">
  #app
    q-layout(view='hHh lpR fFf')
      navbar(:user="user")
      q-page-container
</template>

<script>
  import Navbar from 'client/components/navbar.vue'
  import { backend } from 'api/index.js'

  export default {
    data: function () {
      return {
        user: {}
      }
    },
    created() {
      this.fetchUser()
    },
    methods: {
      fetchUser() {
        backend.client.current()
          .then(response => {
            this.user = response.data.user
          })
          .catch(error => {
            console.log(error)
          })
      }
    },
    components: {
      Navbar
    }
  }
</script>

<style lang="stylus">

</style>
