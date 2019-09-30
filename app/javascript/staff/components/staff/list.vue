<template lang="pug">
  #staffs
    h5.text-bold.q-my-md List of staffs
    q-table(
      flat
      separator="none"
      :data="staffs"
      :columns="columnsStaffs"
    )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(
            flat
            icon="fas fa-pen-square"
            @click="show(props.row.id)"
            :ripple="false"
          )
</template>

<script>
  import { backend } from '../../../api/index'

  export default {
    props: ['staff'],
    data: function () {
      return {
        columnsStaffs: [
          { name: 'email', align: 'center', label: 'Email', field: 'email' },
          { name: 'action', align: 'center', label: 'Action' }
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
      show(id) {
        this.$router.push({ name: 'staff', params: { id: id } })
      }
    }
  }
</script>

<style lang="stylus">

</style>
