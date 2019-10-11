<template lang="pug">
  #organizations
    h5.text-bold.q-my-md List of organizations
    q-table(
      flat
      separator="none"
      :data="organizations"
      :columns="columnsOrganizations"
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
  import Modal from '../modal.vue'
  import { backend } from '../../../api/index'

  export default {
    props: ['organization'],
    data: function () {
      return {
        columnsOrganizations: [
          { name: 'name', align: 'center', label: 'Name', field: 'name' },
          { name: 'form', align: 'center', label: 'Type of organization', field: 'form' },
          { name: 'inn', align: 'center', label: 'INN', field: 'inn' },
          { name: 'ogrn', align: 'center', label: 'OGRN', field: 'ogrn' },
          { name: 'action', align: 'center', label: 'Action' }
        ],
        organizations: [],
        showModal: this.$route.meta.showModal
      }
    },
    created() {
      this.fetchOrganizations()
    },
    watch: {
      organization(val) {
        this.organizations.push(val)
      },
      '$route.meta' ({showModal}) {
        this.showModal = showModal
      }
    },
    methods: {
      fetchOrganizations() {
        backend.staff.organizations()
          .then(response => this.organizations = response.data)
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
