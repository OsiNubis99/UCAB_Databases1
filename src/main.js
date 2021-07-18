import Vue from "vue";
import App from "./App";
import axios from "axios";
import store from "./store";
import router from "./router";
import VueMeta from "vue-meta";
import VueAxios from "vue-axios";
import vuetify from "./plugins/vuetify";

Vue.config.productionTip = false;

Vue.use(VueMeta);
Vue.use(VueAxios, axios);

new Vue({
  router,
  store,
  vuetify,
  render: (h) => h(App),
}).$mount("#app");
