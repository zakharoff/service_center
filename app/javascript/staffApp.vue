<template lang="pug">
  #app
    navbar(:user="user")
    h1 {{ message }}
    dashboard
</template>

<script>
  import Navbar from 'components/navbar.vue'
  import Dashboard from 'staff/components/dashboard.vue'
  import { axiosUser } from 'api/index.js'

  export default {
    data: function () {
      return {
        user: {},
        message: "Service center"
      }
    },
    created() {
      this.fetchUser()
    },
    methods: {
      fetchUser() {
        axiosUser('/staffs/home/user')
          .then(response => {
            this.user = response.data.user
          })
          .catch(error => {
            console.log(error)
          })
      }
    },
    components: {
      Navbar,
      Dashboard
    }
  }
</script>

<style lang="scss">
  body {
    margin: 0;
    padding: 0;
  }
  h1 {
    font-size: 2em;
    text-align: center;
  }
</style>
