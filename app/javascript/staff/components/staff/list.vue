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
            fab-mini
            icon="fas fa-pen-square"
            @click="$router.push({name: 'staff', params: { id: props.row.id }})"
            :ripple="false"
          )
    modal(v-if="showModal")
      template(#header)
        | Edit staff
      template(#content)
        router-view(name="staff")
</template>

<script>
  import Modal from '../modal.vue'
  import { backend } from '../../../api/index'

  export default {
    props: ['staff'],
    data: function () {
      return {
        columnsStaffs: [
          { name: 'email', align: 'center', label: 'Email', field: 'email' },
          { name: 'action', align: 'center', label: 'Action' }
        ],
        staffs: [],
        showModal: this.$route.meta.showModal
      }
    },
    created() {
      this.fetchStaffs()
    },
    watch: {
      staff(val) {
        this.staffs.push(val)
      },
      '$route.meta' ({showModal}) {
        this.showModal = showModal
      }
    },
    methods: {
      fetchStaffs() {
        backend.staff.staffs()
          .then(({ data }) => this.staffs = data)
          .catch(error => console.log(error))
      }
    },
    components: {
      Modal
    }
  }
</script>

<style lang="stylus">
  td button i
    color #BBBBBB
  td button:hover
    i
      color black
</style>
