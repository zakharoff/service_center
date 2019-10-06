<template lang="pug">
  #relations
    h5.q-my-md Add relations
    q-form
      .row.q-col-gutter-lg
        .col-xs-12.col-sm-6.col-md-6
          q-select(
            filled
            v-model="organization"
            label="Organization"
            hint="Select organization"
            :options="organizations"
            option-value="id"
            option-label="name"
            :rules="[ val => val !== null && val !== '' || 'Please choose organization' ]"
            ref="organization"
          )
      .row.q-pt-lg
        .col-xs-12.col-sm-6.col-md-5.text-center
          q-btn(
            outline
            @click="updateClientOrganization"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    props: ['id'],
    data() {
      return {
        submitting: false,
        organization: '',
        organizations: []
      }
    },
    created() {
      this.fetchOrganizations()
    },
    methods: {
      fetchOrganizations() {
        backend.staff.organizations()
          .then(({ data }) => this.organizations = data)
          .catch(error => console.log(error))
      },
      updateClientOrganization() {}
    }
  }
</script>

<style lang="stylus">

</style>
