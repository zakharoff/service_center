<template lang="pug">
  section(class="dashboard")
    h2 Create new client
    form
      .group
        input(v-model.trim="fullname" placeholder="Client full name")
        input(v-model.trim="phone" placeholder="Client phone")
        input(v-model.trim="email" placeholder="Client email" type="email")
        input(v-model.trim="password" placeholder="Client password (minimum 8 char)")
      .action
        button(v-if="showFields" @click="sendForm" type="button") Submit
    hr
    section(class="clients")
      h2 List of clients
      table
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
      showFields (){
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
      },
      sendForm() {
      }
    },
    components: {
      Client
    }
  }
</script>

<style lang="scss">
  h2 {
    text-align: center;
  }
  input {
    display: block;
    padding: 10px;
    font-size: 18px;
    width: 250px;
    margin-left: auto;
    margin-right: auto;
  }
  .action {
    text-align: center;
  }
  button {
    margin:22px 22px;
    font-weight: bold;
    text-transform: uppercase;
    text-decoration: none;
    background: #ffffff;
    padding: 10px 30px;
    border: 1px solid;
    display: inline-block;
    transition: all 0.4s ease 0s;
  }
  button:hover {
    color: #ffffff !important;
    background: #517AA3;
    border-color: #517AA3 !important;
    transition: all 0.4s ease 0s;
  }
  hr {
    margin: 10px 10px;
  }
  section.clients {
    margin-right: 20%;
    margin-left: 20%;
  }
  table {
    width: 100%;
  }
  tr {
    line-height: 40px;
    text-align: center;
  }
  th {
    font-size: 20px;
  }
  td {
    font-size: 18px;
  }
</style>
