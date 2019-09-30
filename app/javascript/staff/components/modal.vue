<template lang="pug">
  q-dialog(v-model="alert")
    q-card
      q-card-section
        .text-h6 Alert
      q-card-section
        slot
      q-card-actions(align="right")
        q-btn(flat label="OK" color="primary" v-close-popup @click="$router.go(-1)")
</template>

<script>
  export default {
    data() {
      return {
        alert: true
      }
    }
  }
</script>

<style lang="stylus">

</style>
