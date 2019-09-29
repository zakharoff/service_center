<template lang="pug">
  #clients
    h5.text-bold.q-my-md List of clients
    q-table(
      flat
      separator="none"
      :pagination.sync="clientsPagination"
      :data="clients"
      :columns="columnsClients"
    )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    props: ['client'],
    data: function () {
      return {
        columnsClients: [
          { name: 'fullname', align: 'center', label: 'Full name', field: 'fullname' },
          { name: 'phone', align: 'center', label: 'Number phone', field: 'phone' },
          { name: 'email', align: 'center', label: 'Email', field: 'email' }
        ],
        clientsPagination: {
          rowsPerPage: 10
        },
        clients: []
      }
    },
    created() {
      this.fetchClients()
    },
    watch: {
      client(val) {
        this.clients.push(val)
      }
    },
    methods: {
      fetchClients() {
        backend.staff.clients()
          .then(response => this.clients = response.data)
          .catch(error => console.log(error))
      },
    }
  }
</script>

<style lang="stylus">

</style>
