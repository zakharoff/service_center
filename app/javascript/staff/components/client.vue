<template lang="pug">
  tr
    td {{ client.fullname }}
    td {{ client.phone }}
    td {{ client.email }}
</template>

<script>
  export default {
    props: ['client']
  }
</script>

<style lang="stylus">

</style>
