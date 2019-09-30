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
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    data() {
      return {
        submitting: false,
        client: {},
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
          backend.staff.updateCLient({
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
      }
    }
  }
</script>

<style lang="stylus">

</style>
