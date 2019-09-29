import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Dashboard from '../staff/components/dashboard'
import Clients from '../staff/components/client/index'
import Organizations from '../staff/components/organization/index'

export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    {
      path: '*', redirect: '/dashboard'
    },
    {
      path: '/dashboard', component: Dashboard
    },
    {
      path: '/clients', component: Clients
    },
    {
      path: '/organizations', component: Organizations
    }
  ]
})
