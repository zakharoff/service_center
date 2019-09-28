<template lang="pug">
  #organization-block
    form-organization(@push-organization="pushOrganization")
    list-organizations(:organization="organization")
</template>

<script>
  import FormOrganization from './form.vue'
  import ListOrganizations from './list.vue'

  export default {
    data: function () {
      return {
        organization: {}
      }
    },
    methods: {
      pushOrganization(organization) {
        this.organization = organization
      },
    },
    components: {
        FormOrganization,
        ListOrganizations
    }
  }
</script>

<style lang="stylus">

</style>
