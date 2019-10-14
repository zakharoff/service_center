<template lang="pug">
  #navbar
    q-header.bg-white.text-black(bordered)
      q-toolbar.h-100
        q-btn.hov-col(
          flat
          fab
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
            fab
            icon="fas fa-sign-out-alt fa-2x"
            :ripple="false"
          )
    q-drawer(
      v-model="drawer"
      show-if-above
      :width="250"
      :breakpoint="1100"
      bordered
    )
      q-scroll-area.fit
        .text-center.q-pt-lg
          i.fas.fa-user-circle.fa-4x
          .q-py-md {{ user.email }}
        hr
        q-list(padding)
          q-item(
            clickable
            :to="{ name: 'dashboard' }"
            active-class="my-menu-link"
          )
            q-item-section(avatar)
              q-icon(name="fas fa-tachometer-alt")
            q-item-section Dashboard
          q-item(
            clickable
            :to="{ name: 'clients' }"
            active-class="my-menu-link"
          )
            q-item-section(avatar)
                q-icon(name="fas fa-users")
            q-item-section Clients
          q-item(
            clickable
            :to="{ name: 'organizations' }"
            active-class="my-menu-link"
          )
            q-item-section(avatar)
              q-icon(name="fas fa-briefcase")
            q-item-section Organizations
          q-item(
            clickable
            :to="{ name: 'staffs' }"
            active-class="my-menu-link"
          )
            q-item-section(avatar)
              q-icon(name="fas fa-users-cog")
            q-item-section Staffs
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
    color rgb(20, 40, 160)
  hr
    border 0.5px solid rgba(0,0,0,0.12)
  .my-menu-link
    background #eee!important
</style>
