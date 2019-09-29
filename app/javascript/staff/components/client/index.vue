<template lang="pug">
  #client-block
    form-client(@push-client="pushClient")
    list-clients(:client="client")
</template>

<script>
  import FormClient from './form.vue'
  import ListClients from './list.vue'

  export default {
    data: function () {
      return {
        client: {}
      }
    },
    methods: {
      pushClient(client) {
        this.client = client
      }
    },
    components: {
      FormClient,
      ListClients
    }
  }
</script>

<style lang="stylus">

</style>
