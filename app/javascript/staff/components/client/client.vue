<template lang="pug">
  #edit-client
    h4.text-bold.q-my-md Edit client
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.fullname"
              label="Full name"
              hint="Client name and surname"
              lazy-rules
              :rules="[ val => val && val.length >= 5 || 'Please press something']"
              ref="fullname"
            )
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.phone"
              label="Phone"
              hint="Client phone"
              lazy-rules
              :rules="[ val => val && val.length >= 6 && isFinite(val) || 'Please press number']"
              ref="phone"
            )
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.email"
              label="Email"
              hint="Client email"
              type="email"
              lazy-rules
              :rules="[val => !!val || 'Please press email']"
              ref="email"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="updateClient"
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
    data() {
      return {
        submitting: false,
        client: {},
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
      this.fetchClient()
    },
    methods: {
      fetchClient() {
        backend.staff.showClient(this.id)
          .then(({ data }) => this.client = data)
      },
      updateClient() {
        this.submitting = true

        this.$refs.fullname.validate()
        this.$refs.phone.validate()
        this.$refs.email.validate()

        if (this.$refs.fullname.hasError || this.$refs.phone.hasError || this.$refs.email.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updateClient({
              id: this.id,
              fullname: this.client.fullname,
              email: this.client.email,
              phone: this.client.phone,
            })
            .then(response => {
              this.fetchClient()
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
          backend.staff.updatePasswordClient({
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
