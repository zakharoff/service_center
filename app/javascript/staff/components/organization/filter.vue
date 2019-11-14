<template lang="pug">
  q-input(
    v-model="filter"
    debounce="500"
    label="Search"
    filled
  )
</template>

<script>
  export default {
    computed: {
      filter: {
        get() {
          return this.$store.state.filter
        },
        set(value) {
          this.$store.commit('updateFilter', value)
        }
      }
    }
  }
</script>

<style lang="stylus">

</style>
