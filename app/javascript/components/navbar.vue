<template lang="pug">
  #navbar
    q-header.bg-white.text-black(bordered)
      q-toolbar.h-100
        q-btn.hov-col(
          flat
          @click="drawer = !drawer"
          icon="fas fa-bars fa-2x"
          :ripple="false"
        )
        q-toolbar-title.text-center.text-bold.brand Best service
        a.text-black(
          :href="user.exit_link"
          data-method="delete"
        )
          q-btn.hov-col(
            flat
            icon="fas fa-sign-out-alt fa-2x"
            :ripple="false"
          )
    q-drawer(
      v-model="drawer"
      overlay
      bordered
    )
      .text-center.q-pt-lg
        i.fas.fa-user.fa-4x
        .q-py-md {{ user.email }}
</template>

<script>
  export default {
    data: function() {
      return {
        drawer: false
      }
    },
    props: ['user']
  }
</script>

<style lang="stylus">
  header
    height 60px
  .h-100
    height 100%
  .hov-col:hover
    background rgb(189, 189, 189)
    i
      color black
  .brand
    color: rgb(20, 40, 160)
</style>
