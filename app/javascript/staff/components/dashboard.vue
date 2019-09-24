<template lang="pug">
  #loading(v-if="loading")
    q-spinner-cube.fixed-center(color="brand" size="6em")
  section#dashboard(v-else)
    q-toggle(v-model="visibleOrganization" keep-color color="black" label="Organizations" left-label)
    #organization-block(v-if="visibleOrganization")
      #new-organization
        h4.text-bold.q-my-md Create new organization
        .form-wrapper.q-my-md
          q-form
            .row.q-col-gutter-lg
              .col-xs-12.col-sm-6.col-md-3
                q-input(filled v-model.trim="name" label="Name" hint="Name of organization" lazy-rules
                  :rules="[ val => val && val.length > 0 || 'Please press something']" ref="name")
              .col-xs-12.col-sm-6.col-md-3
                q-select(filled v-model="type" label="Type" hint="Type of organizations" :options="forms" lazy-rules
                  :rules="[ val => val !== null && val !== '' || 'Please choose type' ]" ref="type")
              .col-xs-12.col-sm-6.col-md-3
                q-input(filled v-model.trim="inn" label="INN" hint="INN of organization" type="number" lazy-rules
                  :rules="[ val => val.length == 6 || 'Press 6 integers']" ref="inn")
              .col-xs-12.col-sm-6.col-md-3
                q-input(filled v-model.trim="ogrn" label="OGRN" hint="OGRN of organization" type="number" lazy-rules
                  :rules="[ val => val.length == 13 || 'Press 13 integers']" ref="ogrn")
            .row.justify-center.q-pt-lg
              q-btn(outline @click="sendOrganization" :loading="submitting" :ripple="false" label="Submit")
      #organizations
        h5.text-bold.q-my-md List of organizations
        q-table(flat dense separator="none" :data="organizations" :columns="columnsOrganizations")
          template(v-slot:body-cell-action="props")
            q-td(:props="props")
              q-btn(flat icon="far fa-trash-alt" @click="deleteOrganization(props.row)" :ripple="false")
    #client-block(v-else)
      #new-client
        h4.text-bold.q-my-md Create new client
        .form-wrapper.q-py-md
          q-form
            .row.justify-center.q-col-gutter-lg
              q-input(filled v-model.trim="fullname" label="Full name" hint="Client name and surname")
              q-input(filled v-model.trim="phone" label="Phone" hint="Client phone")
              q-input(filled v-model.trim="email" label="Email" hint="Client email" type="email")
              q-input(filled v-model.trim="password" label="Password" hint="Client password (minimum 8 char)")
            .row.justify-center.q-pt-lg
              q-btn(:disable="!showBtn" outline @click="sendClient" :loading="submitting" :ripple="false" label="Submit")
      #clients
        h5.text-bold.q-my-md List of clients
        q-table(flat dense separator="none" :pagination.sync="clientsPagination" :data="clients" :columns="columnsClients"
          row-key="name")
        //table
          tr
            th Full name
            th Number phone
            th Email
          client(v-for="client in clients" :client="client" :key="client.id")
</template>

<script>
  import Client from './client.vue'
  import { backend } from 'api/index.js'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data: function () {
      return {
        loading: true,
        visibleOrganization: true,
        submitting: false,
        columnsClients: [
          { name: 'fullname', align: 'center', label: 'Full name', field: 'fullname' },
          { name: 'phone', align: 'center', label: 'Number phone', field: 'phone' },
          { name: 'email', align: 'center', label: 'Email', field: 'email' }
        ],
        columnsOrganizations: [
          { name: 'name', align: 'center', label: 'Name', field: 'name' },
          { name: 'form', align: 'center', label: 'Type of organization', field: 'form' },
          { name: 'inn', align: 'center', label: 'INN', field: 'inn' },
          { name: 'ogrn', align: 'center', label: 'OGRN', field: 'ogrn' },
          { name: 'action', align: 'center', label: 'Action' }
        ],
        clientsPagination: {
          rowsPerPage: 10
        },
        fullname: '',
        phone: '',
        email: '',
        password: '',
        clients: [],
        forms: [],
        name: '',
        type: '',
        inn: '',
        ogrn: '',
        organizations: []
      }
    },
    created() {
      this.fetchClients()
      this.fetchForms()
      this.fetchOrganizations()
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
          .then(response => {
            this.clients = response.data
          })
          .catch(error => {
            console.log(error)
          })
          .finally(() => this.loading = false)
      },
      fetchForms() {
        backend.staff.forms()
          .then(response => {
            this.forms = response.data
          })
          .catch(error => {
            console.log(error)
          })
      },
      fetchOrganizations() {
        backend.staff.organizations()
          .then(response => {
            this.organizations = response.data
          })
          .catch(error => {
            console.log(error)
          })
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
      sendOrganization() {
        this.$refs.name.validate()
        this.$refs.type.validate()
        this.$refs.inn.validate()
        this.$refs.ogrn.validate()

        if (this.$refs.name.hasError || this.$refs.type.hasError || this.$refs.inn.hasError || this.$refs.ogrn.hasError) {
          this.formHasError = true
        } else {
          backend.staff.createOrganizations({
            name: this.name,
            form_id: this.type.value,
            inn: this.inn,
            ogrn: this.ogrn
          })
            .then(response => {
              this.organizations.push(response.data)
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      },
      deleteOrganization(row) {
        backend.staff.deleteOrganizations(row.id)
          .then(() => {
            this.organizations.splice(row.__index, 1)
          })
          .catch(error => {
            console.log(error)
          })
      }
    },
    components: {
      Client
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
