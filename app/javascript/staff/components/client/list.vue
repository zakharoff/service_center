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
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(
            flat
            fab-mini
            icon="fas fa-pen-square"
            @click="$router.push({name: 'client', params: { id: props.row.id }})"
            :ripple="false"
          )
    modal(v-if="showModal")
      template(#header)
        | Edit client
      template(#content)
        router-view(name="client")
</template>

<script>
  import Modal from '../modal.vue'
  import { backend } from '../../../api/index'

  export default {
    props: ['client'],
    data: function () {
      return {
        columnsClients: [
          { name: 'fullname', align: 'center', label: 'Full name', field: 'fullname' },
          { name: 'phone', align: 'center', label: 'Number phone', field: 'phone' },
          { name: 'email', align: 'center', label: 'Email', field: 'email' },
          { name: 'action', align: 'center', label: 'Action' }
        ],
        clientsPagination: {
          rowsPerPage: 10
        },
        clients: [],
        showModal: this.$route.meta.showModal
      }
    },
    created() {
      this.fetchClients()
    },
    watch: {
      client(val) {
        this.clients.push(val)
      },
      '$route.meta' ({showModal}) {
        this.showModal = showModal
      }
    },
    methods: {
      fetchClients() {
        backend.staff.clients()
          .then(({ data }) => this.clients = data)
          .catch(error => console.log(error))
      }
    },
    components: {
      Modal
    }
  }
</script>

<style lang="stylus">

</style>
