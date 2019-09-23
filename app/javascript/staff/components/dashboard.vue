<template lang="pug">
  #loading(v-if="loading")
    q-spinner-cube.fixed-center(color="brand" size="6em")
  section#dashboard(v-else)
    #new-client
      h4.text-bold.q-my-md Create new client
      .form-wrapper.q-py-md
        q-form
          .row.justify-center.q-col-gutter-lg
            q-input(filled v-model.trim="fullname" label="Full name" hint="Client name and surname")
            q-input(filled v-model.trim="phone" label="Phone" hint="Client phone")
            q-input(filled v-model.trim="email" label="Email" type="email" hint="Client email")
            q-input(filled v-model.trim="password" label="Password" hint="Client password (minimum 8 char)")
          .row.justify-center.q-pt-lg
            q-btn(:disable="!showBtn" outline @click="sendForm" :loading="submitting" :ripple="false" label="Submit")
    #clients
      h5.text-bold.q-my-md List of clients
      q-table(flat dense separator="none" :pagination.sync="clientsPagination" :data="clients" :columns="columns"
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
        submitting: false,
        columns: [
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
          .then(response => {
            this.clients = response.data
          })
          .catch(error => {
            console.log(error)
          })
          .finally(() => this.loading = false)
      },
      sendForm() {
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
