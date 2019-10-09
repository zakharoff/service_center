<template lang="pug">
  #edit-organization
    h5.q-my-md Main info
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-6.col-sm-6.col-md-6
            q-input(
              filled
              v-model.trim="organization.name"
              label="Name"
              hint="Name of organization"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Please press something']"
              ref="name"
            )
          .col-xs-12.col-sm-6.col-md-6
            q-select(
              filled
              multiple
              v-model="devicesSelected"
              label="Devices"
              hint="Select devices"
              :options="devices"
              option-value="id"
              option-label="name"
            )
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-4.col-md-4
            q-input(
              filled
              v-model="organization.form"
              label="Type"
              hint="Type of organizations"
              disable
              readonly
            )
          .col-xs-12.col-sm-4.col-md-4
            q-input(
              filled
              v-model="organization.inn"
              label="INN"
              hint="INN of organization"
              disable
              readonly
            )
          .col-xs-12.col-sm-4.col-md-4
            q-input(filled
              v-model="organization.ogrn"
              label="OGRN"
              hint="OGRN of organization"
              disable
              readonly
            )
        h5.q-my-md Add relations
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-6
            q-select(
              filled
              multiple
              v-model="clientsSelected"
              label="Client"
              hint="Select client"
              :options="clients"
              option-value="id"
              option-label="fullname"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="updateOrganization"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
    .absolute-bottom-left.q-ml-md.q-mb-lg
      h5.q-my-md Options
      q-btn(
        outline
        label="Delete organization"
        icon-right="far fa-times-circle"
        @click="deleteOrganization"
        :ripple="false"
      )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    data() {
      return {
        submitting: false,
        organization: {},
        devices: [],
        devicesSelected: [],
        clients: [],
        clientsSelected: []
      }
    },
    computed: {
      id() {
        return this.$route.params.id
      },
      deviceIds() {
        return this.devicesSelected.map(({ id }) => id)
      },
      clientIds() {
        return this.clientsSelected.map(({ id }) => id)
      }
    },
    watch: {
      organization() {
        this.devicesSelected = this.organization.devices
        this.clientsSelected = this.organization.clients
      }
    },
    created() {
      this.fetchOrganization()
      this.fetchDevices()
      this.fetchClients()
    },
    methods: {
      fetchOrganization() {
        backend.staff.showOrganization(this.id)
          .then(({ data }) => this.organization = data)
      },
      fetchDevices() {
        backend.staff.devices()
          .then(({ data }) => this.devices = data)
      },
      fetchClients() {
        backend.staff.clients()
          .then(({ data }) => this.clients = data)
      },
      updateOrganization() {
        this.submitting = true
        this.$refs.name.validate()

        if (this.$refs.name.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updateOrganization({
            id: this.id,
            name: this.organization.name,
            device_ids: this.deviceIds,
            client_ids: this.clientIds
          })
            .then(response => {
              this.fetchOrganization()
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      },
      deleteOrganization() {
        backend.staff.deleteOrganization(this.id)
          .then(() => this.$router.go(-1))
          .catch(error => console.log(error))
      }
    }
  }
</script>

<style lang="stylus">

</style>
