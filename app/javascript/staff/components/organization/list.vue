<template lang="pug">
  #organizations
    h5.text-bold.q-my-md List of organizations
    q-table(
      flat
      dense
      separator="none"
      :data="organizations"
      :columns="columnsOrganizations"
    )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(
            flat
            icon="far fa-times-circle"
            @click="deleteOrganization(props.row)"
            :ripple="false"
          )
</template>

<script>
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
        organizations: []
      }
    },
    created() {
      this.fetchOrganizations()
    },
    watch: {
      organization(val) {
        this.organizations.push(val)
      }
    },
    methods: {
      fetchOrganizations() {
        backend.staff.organizations()
          .then(response => this.organizations = response.data)
          .catch(error => console.log(error))
      },
      deleteOrganization(row) {
        backend.staff.deleteOrganizations(row.id)
          .then(() => this.organizations.splice(row.__index, 1))
          .catch(error => console.log(error))
      }
    }
  }
</script>

<style lang="stylus">

</style>
