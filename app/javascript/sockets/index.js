import Vue from 'vue'
import ActionCableVue from 'actioncable-vue'

Vue.use(ActionCableVue, {
  connectionUrl: 'ws://localhost:3000/cable',
  connectImmediately: true
})
