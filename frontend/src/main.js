import Vue from "vue";
import App from "./App";
import lodash from "lodash";
import VueLodash from "vue-lodash";
import VuejsDialog from "vuejs-dialog";
import "vuejs-dialog/dist/vuejs-dialog.min.css";

window.Cookies = require("js-cookie");
window._ = require("lodash");
window.$ = require("jquery");
window.moment = require("moment");
window.axios = require("axios");

// BootstrapVue add
import BootstrapVue from "bootstrap-vue";

// Router & Store add
import router from "./router";

import { store } from "./store";

// Multi Language Add
import en from "./locales/en.json";
import es from "./locales/es.json";
import VueI18n from "vue-i18n";
import {
  defaultLocale,
  localeOptions,
  firebaseConfig
} from "@/constants/config";

// Notification Component Add
import Notifications from "@/components/Common/Notification";

// Breadcrumb Component Add
import Breadcrumb from "@/components/Common/Breadcrumb";

// RefreshButton Component Add
import RefreshButton from "@/components/Common/RefreshButton";

// Colxx Component Add
import Colxx from "@/components/Common/Colxx";

// Perfect Scrollbar Add
import vuePerfectScrollbar from "vue-perfect-scrollbar";

import contentmenu from "v-contextmenu";
import lineClamp from "vue-line-clamp";
import VCalendar from "v-calendar";
import "v-calendar/lib/v-calendar.min.css";
import VueScrollTo from "vue-scrollto";
import firebase from "firebase/app";
import "firebase/auth";
import ViewPermission from "@/utils/ViewPermission";
import Vuelidate from "vuelidate";
import VuelidateErrorExtractor, { templates } from "vuelidate-error-extractor";
import Loading from "vue-loading-overlay";
import "vue-loading-overlay/dist/vue-loading.css";
Vue.use(Loading);
Vue.use(Vuelidate);
Vue.use(VuelidateErrorExtractor, {
  i18n: false,
  messages: {
    numeric: "Only numeric value allowed in {attribute}.",
    required: "{attribute} is required!",
    email: "{attribute} is not a valid email address.",
    minLength: "{attribute} must be at least 6 characters long.",
    sameAsPassword: "{attribute} does't match with password."
  }
});
// Tell Vue to install the plugin.
Vue.use(VuejsDialog);
Vue.use(VueLodash, lodash);
Vue.mixin(ViewPermission);
Vue.use(BootstrapVue);
Vue.use(VueI18n);

let bearer = Cookies.get("access_token");
if (bearer) {
  window.axios.defaults.headers.common["Authorization"] = bearer;
}

const messages = { en: en, es: es };
const locale =
  localStorage.getItem("currentLanguage") &&
  localeOptions.filter(x => x.id === localStorage.getItem("currentLanguage"))
    .length > 0
    ? localStorage.getItem("currentLanguage")
    : defaultLocale;
const i18n = new VueI18n({
  locale: locale,
  fallbackLocale: "en",
  messages
});

Vue.use(Notifications);
Vue.component("piaf-breadcrumb", Breadcrumb);
Vue.component("b-refresh-button", RefreshButton);
Vue.component("b-colxx", Colxx);
Vue.component("vue-perfect-scrollbar", vuePerfectScrollbar);
Vue.use(require("vue-shortkey"));
Vue.use(contentmenu);
Vue.use(lineClamp, {
  /* plugin options */
});
Vue.use(VCalendar, {
  firstDayOfWeek: 2, // ...other defaults,
  formats: {
    title: "MMM YY",
    weekdays: "WW",
    navMonths: "MMMM",
    input: ["L", "YYYY-MM-DD", "YYYY/MM/DD"],
    dayPopover: "L"
  },
  datePickerShowDayPopover: false,
  popoverExpanded: true,
  popoverDirection: "bottom"
});
Vue.use(VueScrollTo);
firebase.initializeApp(firebaseConfig);

Vue.component("form-group", templates.singleErrorExtractor.foundation6);

export default new Vue({
  el: "#app",
  i18n,
  created() {
    if (this.$store.getters.isAuthenticated) {
      this.$store.dispatch("userRequest");
    }
    this.$store.dispatch("settingsRequest");
  },
  router,
  store,
  render: h => h(App)
});
