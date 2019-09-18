<template lang="pug">
  header
    ul(class="no-gutter")
      li
        .logo
          img(src="../assets/settings.png" alt="logo" width="50px")
      li
        .user
          span {{ user.email }}
      li
        .exit
          a(:href="user.exit_link" data-method="delete" style="text-decoration:none;color:black;") Log out
    hr
</template>

<script>
  export default {
    props: ['user']
  }
</script>

<style lang="scss">
  header {
    font-size: 30px;
    background-color: #f8f9fa!important;
  }
  ul li {
    display:inline-block;
    width:33%;
  }
  .user {
    text-align: center;
  }
  .exit {
    text-align: right;
  }
  .no-gutter {
    padding: 0;
    margin: 0;
  }
</style>
