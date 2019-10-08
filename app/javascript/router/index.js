import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Dashboard from '../staff/components/dashboard'
import Staffs from '../staff/components/staff/index'
import Staff from '../staff/components/staff/staff'
import Clients from '../staff/components/client/index'
import Client from '../staff/components/client/client'
import Organizations from '../staff/components/organization/index'
import Organization from '../staff/components/organization/organization'

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
      path: '/staffs',
      name: 'staffs',
      component: Staffs,
      meta: { showModal: false },
      children: [
        {
          path: '/staffs/:id/edit',
          name: 'staff',
          components: { staff: Staff },
          meta: { showModal: true }
        }
      ]
    },
    {
      path: '/clients',
      name: 'clients',
      component: Clients,
      meta: { showModal: false },
      children: [
        {
          path: '/clients/:id/edit',
          name: 'client',
          components: { client: Client },
          meta: { showModal: true }
        }
      ]
    },
    {
      path: '/organizations',
      name: 'organizations',
      component: Organizations,
      meta: { showModal: false },
      children: [
        {
          path: '/organizations/:id/edit',
          name: 'organization',
          components: { organization: Organization },
          meta: { showModal: true }
        }
      ]
    }
  ]
})
