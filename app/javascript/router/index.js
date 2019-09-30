import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Dashboard from '../staff/components/dashboard'
import Staffs from '../staff/components/staff/index'
import Staff from '../staff/components/staff/staff'
import Clients from '../staff/components/client/index'
import Client from '../staff/components/client/client'
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
      path: '/staffs', name: 'staffs', component: Staffs
    },
    {
      path: '/staffs/:id', name: 'staff', component: Staff
    },
    {
      path: '/clients', name: 'clients', component: Clients
    },
    {
      path: '/clients/:id', name: 'client', component: Client
    },
    {
      path: '/organizations', name: 'organizations', component: Organizations
    }
  ]
})
