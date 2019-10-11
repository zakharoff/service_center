<template lang="pug">
  #staff-block
    form-staff(@push-staff="pushStaff")
    list-staffs(:staff="staff")
</template>

<script>
  import FormStaff from './form.vue'
  import ListStaffs from './list.vue'

  export default {
    data: function () {
      return {
        staff: {}
      }
    },
    methods: {
      pushStaff(staff) {
        this.staff = staff
      }
    },
    components: {
      FormStaff,
      ListStaffs
    }
  }
</script>

<style lang="stylus">

</style>
