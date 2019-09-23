import Vue from "vue";
import Vuex from "vuex";

import menu from "./modules/menu";
import auth from "./modules/auth";
import authUser from "./modules/auth-user";
import roles from "./modules/role";
import categories from "./modules/category";
import companies from "./modules/companies";
import locations from "./modules/location";
import settings from "./modules/settings";
import subscriptions from "./modules/subscriptions";
import users from "./modules/users";
import workOrders from "./modules/work_orders";

Vue.use(Vuex);

export const store = new Vuex.Store({
  modules: {
    menu,
    auth,
    authUser,
    roles,
    categories,
    companies,
    locations,
    settings,
    subscriptions,
    users,
    workOrders
  }
});
