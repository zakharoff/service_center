<template lang="pug">
  #relations
    h5.q-my-md Add relations
    q-form
      .row.q-col-gutter-lg
        .col-xs-12.col-sm-6.col-md-6
          q-select(
            filled
            multiple
            v-model="organizationsSelected"
            label="Organization"
            hint="Select organization"
            :options="organizations"
            option-value="id"
            option-label="name"
            lazy-rules
            :rules="[ val => val !== null && val !== '' && val.length > 0 || 'Please choose organization' ]"
            ref="organizationsSelected"
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
    props: ['id', 'clientOrganizations'],
    data() {
      return {
        submitting: false,
        organizationsSelected: [],
        organizations: []
      }
    },
    created() {
      this.fetchOrganizations()
    },
    watch: {
      clientOrganizations() {
        this.organizationsSelected = this.clientOrganizations
      }
    },
    methods: {
      fetchOrganizations() {
        backend.staff.organizations()
          .then(({ data }) => this.organizations = data)
          .catch(error => console.log(error))
      },
      updateClientOrganization() {
        this.submitting = true
        this.$refs.organizationsSelected.validate()

        if (this.$refs.organizationsSelected.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          this.organizationsSelected.forEach(
            (organization) => {
              backend.staff.createClientsOrganizations({
                client_id: this.id,
                organization_id: organization.id
              })
                .catch(error => console.log(error))
            }
          )
          this.submitting = false
        }
      }
    }
  }
</script>

<style lang="stylus">

</style>
