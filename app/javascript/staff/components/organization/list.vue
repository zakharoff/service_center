<template lang="pug">
  #organizations
    h5.text-bold.q-my-md List of organizations
    organization-filter
    q-table.q-mt-sm(
      flat
      separator="none"
      :data="organizations"
      :columns="columnsOrganizations"
      @request="onRequest"
      ref="table"
    )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(
            flat
            icon="fas fa-pen-square"
            @click="$router.push({name: 'organization', params: { id: props.row.id }})"
            :ripple="false"
          )
    modal(v-if="showModal")
      template(#header)
        | Edit organization
      template(#content)
        router-view(name="organization")
</template>

<script>
  import OrganizationFilter from './filter.vue'
  import Modal from '../modal.vue'
  import { backend } from '../../../api/index'

  export default {
    props: ['organization'],
    data: function () {
      return {
        columnsOrganizations: [
          { name: 'name', align: 'center', label: 'Name', field: 'name', sortable: true },
          { name: 'form', align: 'center', label: 'Type of organization', field: 'form', sortable: true },
          { name: 'inn', align: 'center', label: 'INN', field: 'inn', sortable: true },
          { name: 'ogrn', align: 'center', label: 'OGRN', field: 'ogrn', sortable: true },
          { name: 'action', align: 'center', label: 'Action' }
        ],
        organizations: [],
        showModal: this.$route.meta.showModal
      }
    },
    computed: {
      filter() {
        return this.$store.state.filter
      }
    },
    created() {
      this.fetchOrganizations('')
    },
    watch: {
      organization(val) {
        this.organizations.push(val)
      },
      '$route.meta' ({showModal}) {
        this.showModal = showModal
      },
      filter() {
        this.refresh()
      }
    },
    methods: {
      fetchOrganizations(filter) {
        backend.staff.organizations(filter)
          .then(response => this.organizations = response.data)
          .catch(error => console.log(error))
      },
      onRequest() {
        this.fetchOrganizations(this.filter)
      },
      refresh() {
        this.$refs.table.requestServerInteraction()
      }
    },
    components: {
      OrganizationFilter,
      Modal
    }
  }
</script>

<style lang="stylus">

</style>
