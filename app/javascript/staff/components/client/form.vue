<template lang="pug">
  #new-client
    h5.text-bold.q-my-md Create new client
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="fullname"
              label="Full name"
              hint="Client name and surname"
              lazy-rules
              :rules="[ val => val && val.length >= 5 || 'Please press something']"
              ref="fullname"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="phone"
              label="Phone"
              hint="Client phone"
              lazy-rules
              :rules="[ val => val && val.length >= 6 && isFinite(val) || 'Please press number']"
              ref="phone"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="email"
              label="Email"
              hint="Client email"
              type="email"
              lazy-rules
              :rules="[emailRule]"
              ref="email"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="password"
              label="Password"
              hint="Client password (minimum 8 char)"
              lazy-rules
              :rules="[ val => val && val.length >= 8 || 'Please press password']"
              ref="password"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="sendClient"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
</template>

<script>
  import { backend } from '../../../api/index'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data: function () {
      return {
        submitting: false,
        fullname: '',
        phone: '',
        email: '',
        password: ''
      }
    },
    methods: {
      emailRule(val) {
        return new Promise((resolve, reject) => {
          resolve((reg.test(val) !== false) || 'Please press email')
        })
      },
      sendClient() {
        this.submitting = true

        this.$refs.fullname.validate()
        this.$refs.phone.validate()
        this.$refs.email.validate()
        this.$refs.password.validate()

        if (this.$refs.fullname.hasError || this.$refs.phone.hasError || this.$refs.email.hasError || this.$refs.password.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.createClient({
            fullname: this.fullname,
            email: this.email,
            phone: this.phone,
            password: this.password
          })
            .then(response => {
              this.$emit('push-client', response.data)
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      }
    }
  }
</script>

<style lang="stylus">

</style>
