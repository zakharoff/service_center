<template lang="pug">
  #client
    p {{ client.fullname }}
    p {{ client.phone }}
    p {{ client.email }}
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    data() {
      return {
        client: {}
      }
    },
    computed: {
      id() {
        return this.$route.params.id
      }
    },
    created() {
      this.fetchClient()
    },
    methods: {
      fetchClient() {
        backend.staff.showClient(this.id)
          .then(({ data }) => this.client = data)
      }
    }
  }
</script>

<style lang="stylus">

</style>
