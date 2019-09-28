<template lang="pug">
  #loading(v-if="loading")
    q-spinner-cube.fixed-center(color="brand" size="6em")
  section#dashboard(v-else)
    q-toggle(
      v-model="visibleOrganization"
      keep-color color="black"
      label="Organizations"
      left-label
    )
    #organization-block(v-if="visibleOrganization")
      form-organization(@push-organization="pushOrganization")
      list-organizations
    #client-block(v-else)
      #new-client
        h4.text-bold.q-my-md Create new client
        .form-wrapper.q-py-md
          q-form
            .row.justify-center.q-col-gutter-lg
              q-input(
                filled
                v-model.trim="fullname"
                label="Full name"
                hint="Client name and surname"
              )
              q-input(
                filled
                v-model.trim="phone"
                label="Phone"
                hint="Client phone"
              )
              q-input(
                filled
                v-model.trim="email"
                label="Email"
                hint="Client email"
                type="email"
              )
              q-input(
                filled
                v-model.trim="password"
                label="Password"
                hint="Client password (minimum 8 char)"
              )
            .row.justify-center.q-pt-lg
              q-btn(
                outline
                :ripple="false"
                label="Submit"
                :disable="!showBtn"
                @click="sendClient"
                :loading="submitting"
                )
      #clients
        h5.text-bold.q-my-md List of clients
        q-table(
          flat
          dense
          separator="none"
          :pagination.sync="clientsPagination"
          :data="clients"
          :columns="columnsClients"
        )
        //table
          tr
            th Full name
            th Number phone
            th Email
          client(v-for="client in clients" :client="client" :key="client.id")
</template>

<script>
  import Client from './client.vue'
  import FormOrganization from './organization/form.vue'
  import ListOrganizations from './organization/list.vue'
  import { backend } from '../../api/index'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data: function () {
      return {
        loading: true,
        submitting: false,
        visibleOrganization: true,
        columnsClients: [
          { name: 'fullname', align: 'center', label: 'Full name', field: 'fullname' },
          { name: 'phone', align: 'center', label: 'Number phone', field: 'phone' },
          { name: 'email', align: 'center', label: 'Email', field: 'email' }
        ],
        clientsPagination: {
          rowsPerPage: 10
        },
        fullname: '',
        phone: '',
        email: '',
        password: '',
        clients: []
      }
    },
    created() {
      this.fetchClients()
    },
    computed: {
      showBtn (){
        return !!(this.checkFullName() && this.checkPhone() && this.checkEmail() && this.checkPassword());
      }
    },
    methods: {
      checkFullName (handler = this.fullname) {
        return !(handler === "" || handler.length < 5)
      },
      checkPhone (handler = this.phone) {
        return !(handler === "" || !isFinite(handler) || handler.length < 6)
      },
      checkEmail (handler = this.email) {
        return reg.test(handler) !== false
      },
      checkPassword (handler = this.password) {
        return !(handler.length < 8)
      },
      fetchClients() {
        backend.staff.clients()
          .then(response => this.clients = response.data)
          .catch(error => console.log(error))
          .finally(() => this.loading = false)
      },
      sendClient() {
        this.submitting = true

        backend.staff.createClient({
          fullname: this.fullname,
          email: this.email,
          phone: this.phone,
          password: this.password
        })
          .then(response => {
            this.clients.push(response.data)
            this.submitting = false
          })
          .catch(error => {
            console.log(error)
            this.submitting = false
          })
      },
      pushOrganization(organization) {
        this.organizations.push(organization)
      },
    },
    components: {
      Client,
      FormOrganization,
      ListOrganizations
    }
  }
</script>

<style lang="stylus">
  .clients
    margin-right 20%
    margin-left 20%
  table
    width 100%
  tr
    line-height 40px
    text-align center
  th
    font-size 20px
  td
    font-size 18px
  .text-brand
    color: rgb(20, 40, 160)
</style>
