<template lang="pug">
  #edit-staff
    h4.text-bold.q-my-md Edit staff
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-md-12
            q-input(
              filled
              v-model.trim="staff.email"
              label="Email"
              hint="Staff email"
              type="email"
              lazy-rules
              :rules="[val => !!val || 'Please press email']"
              ref="email"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="updateStaff"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
    h5.text-bold.q-my-md Reset password
    q-form
      .row.q-col-gutter-lg
        .col-xs-12.col-sm-6.col-md-5
          q-input(
            filled
            :type="isPwd ? 'password' : 'text'"
            v-model.trim="newPassword"
            label="New password"
            hint="Staff password (minimum 8 char)"
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
    data() {
      return {
        submitting: false,
        staff: {},
        isPwd: true,
        newPassword: ''
      }
    },
    computed: {
      id() {
        return this.$route.params.id
      }
    },
    created() {
      this.fetchStaff()
    },
    methods: {
      fetchStaff() {
        backend.staff.showStaff(this.id)
          .then(({data}) => this.staff = data)
      },
      updateStaff() {
        this.submitting = true

        this.$refs.email.validate()

        if (this.$refs.email.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updateStaff({
            id: this.id,
            fullname: this.staff.fullname,
            email: this.staff.email,
            phone: this.staff.phone,
          })
            .then(response => {
              this.fetchStaff()
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      },
      updatePassword() {
        this.submitting = true

        this.$refs.newPassword.validate()

        if (this.$refs.newPassword.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updatePasswordStaff({
            id: this.id,
            newPassword: this.newPassword
          })
            .then(response => {
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
