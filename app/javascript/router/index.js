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
      path: '/dashboard', name: 'dashboard', component: Dashboard
    },
    {
      path: '/clients', name: 'clients', component: Clients
    },
    {
      path: '/organizations', name: 'organizations', component: Organizations
    }
  ]
})
