<template lang="pug">
  #staffs
    h5.text-bold.q-my-md List of staffs
    q-table(
      flat
      separator="none"
      :data="staffs"
      :columns="columnsStaffs"
    )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    props: ['staff'],
    data: function () {
      return {
        columnsStaffs: [
          { name: 'email', align: 'center', label: 'Email', field: 'email' }
        ],
        staffs: []
      }
    },
    created() {
      this.fetchStaffs()
    },
    watch: {
      staff(val) {
        this.staffs.push(val)
      }
    },
    methods: {
      fetchStaffs() {
        backend.staff.staffs()
          .then(response => this.staffs = response.data)
          .catch(error => console.log(error))
      },
    }
  }
</script>

<style lang="stylus">

</style>
