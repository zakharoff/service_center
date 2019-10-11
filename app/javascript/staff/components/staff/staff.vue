<template lang="pug">
  #edit-staff
    h5.q-my-md Main info
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
              :rules="[emailRule]"
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
    password(:id="id")
</template>

<script>
  import Password from "./password.vue"
  import { backend } from '../../../api/index'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data() {
      return {
        submitting: false,
        staff: {}
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
      emailRule(val) {
        return new Promise((resolve, reject) => {
          resolve((reg.test(val) !== false) || 'Please press email')
        })
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
      }
    },
    components: {
      Password
    }
  }
</script>

<style lang="stylus">

</style>
