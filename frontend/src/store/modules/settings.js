import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  constants: [],
  settings: [],
  priority: [],
  plans: [],
  isLoaded: false,
  loading: "",
  popupOptions: {
    clicksCount: 1,
    okText: "Yes",
    cancelText: "Cancel",
    reverse: true,
    animation: "bounce",
    backdropClose: true
  }
};

const getters = {
  getSettings: state => state.settings,
  getPriority: state => state.priority,
  getPlans: state => state.plans,
  getContants: state => state.constants,
  isSettingLoaded: state => state.isLoaded,
  getSettingByName: state => name => {
    let settings = state.settings;
    return _.find(settings, setting => {
      return setting.name == name;
    });
  },
  getConstantByName: state => name => {
    let settings = state.constants;
    return settings[name] || "";
  },
  popupOptions: state => state.popupOptions
};

const actions = {
  settingsRequest: ({ commit, dispatch }) => {
    commit("settingsRequest");
    let actionUrl = `${apiUrl}/settings`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("settingsSuccess", resp.data);
      })
      .catch(err => {
        commit("settingsError");
        // if resp is unauthorized, logout, to
        dispatch("authLogout");
      });
  },
  updateSettingRequest: ({ commit, dispatch }, payload) => {
    commit("updateSettingRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/update-settings`;
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, ...payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateSettingSuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("updateSettingError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateSettingError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  }
};

const mutations = {
  settingsRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  settingsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "settings", resp.data.settings);
    Vue.set(state, "plans", resp.data.plans);
    Vue.set(state, "priority", resp.data.priority);
    Vue.set(state, "constants", resp.data.constants);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  settingsError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateSettingRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateSettingSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "settings", resp.data.settings);
    HideLoader(state.loading);
  },
  updateSettingError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
