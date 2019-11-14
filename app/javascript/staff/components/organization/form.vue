<template lang="pug">
  #new-organization
    h5.text-bold.q-my-md Create new organization
    .form-wrapper.q-my-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="name"
              label="Name"
              hint="Name of organization"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Please press something']"
              ref="name"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-select(
              filled
              v-model="type"
              label="Type"
              hint="Type of organizations"
              :options="forms"
              lazy-rules
              :rules="[ val => val !== null && val !== '' || 'Please choose type' ]"
              ref="type"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-input(
              filled
              v-model.trim="inn"
              label="INN"
              hint="INN of organization"
              type="number"
              lazy-rules
              :rules="[ val => val.length == 6 || 'Press 6 integers']"
              ref="inn"
            )
          .col-xs-12.col-sm-6.col-md-3
            q-input(filled
              v-model.trim="ogrn"
              label="OGRN"
              hint="OGRN of organization"
              type="number" lazy-rules
              :rules="[ val => val.length == 13 || 'Press 13 integers']"
              ref="ogrn"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="sendOrganization"
            :loading="submitting"
            :ripple="false"
            label="Submit"
          )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    data: function () {
      return {
        name: '',
        type: '',
        inn: '',
        ogrn: '',
        forms: [],
        submitting: false
      }
    },
    created() {
      this.fetchForms()
    },
    methods: {
      fetchForms() {
        backend.staff.forms()
          .then(response => this.forms = response.data)
          .catch(error => console.log(error))
      },
      sendOrganization() {
        this.submitting = true

        this.$refs.name.validate()
        this.$refs.type.validate()
        this.$refs.inn.validate()
        this.$refs.ogrn.validate()

        if (this.$refs.name.hasError || this.$refs.type.hasError || this.$refs.inn.hasError || this.$refs.ogrn.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.createOrganization({
            name: this.name,
            form_id: this.type.value,
            inn: this.inn,
            ogrn: this.ogrn
          })
            .then(response => {
              this.$emit('push-organization', response.data)
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
