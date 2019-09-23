import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  subscriptions: {},
  loading: ""
};

function initialState() {
  return {
    status: "",
    subscriptions: {},
    loading: ""
  };
}

const getters = {
  getSubscriptions: state => state.subscriptions,
  isSubscriptionLoaded: state => !!state.subscriptions.id,
  subscriptionStatus: state => state.status
};

const actions = {
  subscriptionRequest: ({ commit, dispatch }) => {
    commit("subscriptionRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/subscriptions/current`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("subscriptionSuccess", resp.data);
      })
      .catch(err => {
        commit("subscriptionError");
        // if resp is unauthorized, logout, to
        dispatch("authLogout");
      });
  },
  updateSubscriptionRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/${store.getters.authType}/subscriptions/update`;
    let data = {
      plan_id: payload.plan
    };
    return new Promise((resolve, reject) => {
      commit("updateSubscriptionRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("updateSubscriptionError", resp.data.message);
          } else {
            commit("updateSubscriptionSuccess", resp.data);
            resolve(data.data);
          }
        })
        .catch(err => {
          commit("updateSubscriptionError", err);
          reject(err);
        });
    });
  },
  updateCradRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/${
      store.getters.authType
    }/subscriptions/card/update`;
    let data = {
      token: payload.token
    };
    return new Promise((resolve, reject) => {
      commit("updateCradRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("updateCradError", resp.data.message);
          } else {
            commit("updateCradSuccess", resp.data);
            resolve(data.data);
          }
        })
        .catch(err => {
          commit("updateCradError", err);
          reject(err);
        });
    });
  },
  cancelSubscriptionRequest: ({ commit, dispatch }) => {
    commit("cancelSubscriptionRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/subscriptions/cancel`;
    return new Promise((resolve, reject) => {
      axios
        .get(actionUrl)
        .then(resp => {
          commit("cancelSubscriptionSuccess", resp.data);
          resolve(resp);
        })
        .catch(err => {
          commit("cancelSubscriptionError");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  },
  resumeSubscriptionRequest: ({ commit, dispatch }) => {
    commit("resumeSubscriptionRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/subscriptions/resume`;
    return new Promise((resolve, reject) => {
      axios
        .get(actionUrl)
        .then(resp => {
          commit("resumeSubscriptionSuccess", resp.data);
          resolve(resp);
        })
        .catch(err => {
          commit("resumeSubscriptionError");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  }
};

const mutations = {
  subscriptionRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  subscriptionSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "subscriptions", resp.data.subscriptions);
  },
  subscriptionError: state => {
    HideLoader(state.loading);
    ErrorMessage("Unauthorised !");
    state.status = "error";
  },
  updateSubscriptionRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateSubscriptionSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "subscriptions", resp.data.subscriptions);
  },
  updateSubscriptionError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  updateCradRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateCradSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "subscriptions", resp.data.subscriptions);
  },
  updateCradError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  cancelSubscriptionRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  cancelSubscriptionSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "subscriptions", resp.data.subscriptions);
  },
  cancelSubscriptionError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  resumeSubscriptionRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  resumeSubscriptionSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "subscriptions", resp.data.subscriptions);
  },
  resumeSubscriptionError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  resetSubscription: state => {
    const s = initialState();
    Object.keys(s).forEach(key => {
      state[key] = s[key];
    });
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
