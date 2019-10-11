<template lang="pug">
  #reset-password
    h5.q-my-md Reset password
    q-form
      .row.q-col-gutter-lg
        .col-xs-12.col-sm-6.col-md-6
          q-input(
            filled
            :type="isPwd ? 'password' : 'text'"
            v-model.trim="newPassword"
            label="New password"
            hint="Client password (minimum 8 char)"
            :rules="[ val => val && val.length >= 8 || 'Please press minimum 8 char']"
            ref="newPassword"
          )
            template(v-slot:append)
              q-icon(
                :name="isPwd ? 'fas fa-eye-slash' : 'fas fa-eye'"
                class="cursor-pointer"
                @click="isPwd = !isPwd"
              )
      .row.q-pt-lg
        .col-xs-12.col-sm-6.col-md-5.text-center
          q-btn(
            outline
            @click="updatePassword"
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
        isPwd: true,
        newPassword: ''
      }
    },
    methods: {
      updatePassword() {
        this.submitting = true

        this.$refs.newPassword.validate()

        if (this.$refs.newPassword.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updatePasswordClient({
            id: this.id,
            newPassword: this.newPassword
          })
            .then(() => this.submitting = false)
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
