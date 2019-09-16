<template lang="pug">
  section(class="dashboard")
    h2 Create new client
    form
      .group
        input(v-model="fullname" placeholder="Client full name")
        input(v-model="phone" placeholder="Client phone")
        input(v-model="email" placeholder="Client email" type="email")
      .action
        button(v-if="showFields" @click="sendForm") Submit
</template>

<script>
  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data: function () {
      return {
        fullname: '',
        phone: '',
        email: ''
      }
    },
    computed: {
      showFields (){
        return !!(this.checkFullName() && this.checkPhone() && this.checkEmail());
      }
    },
    methods: {
      checkFullName (handler = this.fullname) {
        return !(handler === "" || handler.length < 5);
      },
      checkPhone (handler = this.phone) {
        return !(handler === "" || !isFinite(handler) || handler.length < 6);
      },
      checkEmail (handler = this.email) {
        return reg.test(handler) !== false;
      },
      sendForm() {
      }
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
    font-size: 15px;
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
    margin: 0;
  }
</style>
