<template lang="pug">
  q-dialog(
    :value="true"
    @hide="$router.go(-1)"
    full-width
    full-height
    transition-show="scale"
    transition-hide="fade"
  )
    q-card.column.full-height.full-width
      q-card-section.row.items-center
        h1.text-h4.text-bold.q-gutter-none.q-mb-none
          slot(name="header")
        .q-space
        q-btn(
          icon="fas fa-times"
          flat
          fab
          :ripple="false"
          v-close-popup
        )
      q-card-section.col
        slot(name="content")
</template>

<script>
  export default {
  }
</script>

<style lang="stylus">

</style>
