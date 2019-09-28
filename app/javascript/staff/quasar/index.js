import Vue from 'vue'

import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'

import '../../assets/styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'

import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QToolbar,
  QToolbarTitle,
  QBtn,
  QForm,
  QInput,
  QTable,
  QTr,
  QTd,
  QSpinnerCube,
  QToggle,
  QSelect
} from 'quasar'

Vue.use(Quasar, {
  config: {},
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QToolbar,
    QToolbarTitle,
    QBtn,
    QForm,
    QInput,
    QTable,
    QTr,
    QTd,
    QSpinnerCube,
    QToggle,
    QSelect
  },
  directives: {
  },
  iconSet: iconSet,
  plugins: {
  }
})
