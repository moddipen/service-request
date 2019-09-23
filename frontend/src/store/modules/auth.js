import Cookies from "js-cookie";
import { apiUrl } from "@/constants/config";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";
import { store } from "..";

const state = {
  access_token: Cookies.get("access_token") || "",
  status: "",
  type: Cookies.get("type") || "",
  hasLoadedOnce: false,
  loading: ""
};

const getters = {
  isAuthenticated: state => !!state.access_token,
  authStatus: state => state.status,
  authType: state => atob(state.type)
};

const actions = {
  authRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/login`;
    let remember = payload.remember ? payload.remember : false;
    let data = {
      email: payload.email,
      password: payload.password
    };
    if (payload.action == "admin") {
      actionUrl = `${apiUrl}/admin/login`;
    }
    return new Promise((resolve, reject) => {
      commit("authRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("authError", resp.data.message);
            Cookies.remove("access_token");
          } else {
            let access_token = "Bearer " + resp.data.data.access_token;
            Cookies.set("access_token", access_token, {
              expires: remember ? 365 : 1
            });
            Cookies.set("type", btoa(resp.data.data.type), {
              expires: remember ? 365 : 1
            });
            axios.defaults.headers.common["Authorization"] = access_token;
            commit("authSuccess", resp.data);
            dispatch("userRequest");
            resolve(access_token);
          }
        })
        .catch(err => {
          commit("authError", err);
          Cookies.remove("access_token");
          reject(err);
        });
    });
  },
  signupRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/sign-up`;
    let data = { ...payload };
    return new Promise((resolve, reject) => {
      commit("signupRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("signupError", resp.data.message);
          } else {
            commit("signupSuccess", resp.data);
            resolve(resp);
          }
        })
        .catch(err => {
          commit("signupError", err);
          reject(err);
        });
    });
  },
  forgetPasswordRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/forget-password`;
    let data = { ...payload };
    return new Promise((resolve, reject) => {
      commit("forgetPasswordRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("forgetPasswordError", resp.data.message);
          } else {
            commit("forgetPasswordSuccess", resp.data);
            resolve(resp);
          }
        })
        .catch(err => {
          commit("forgetPasswordError", err);
          reject(err);
        });
    });
  },
  resetPasswordRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/reset-password`;
    let data = { ...payload };
    return new Promise((resolve, reject) => {
      commit("resetPasswordRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("resetPasswordError", resp.data.message);
          } else {
            commit("resetPasswordSuccess", resp.data);
            resolve(resp);
          }
        })
        .catch(err => {
          commit("resetPasswordError", err);
          reject(err);
        });
    });
  },
  setAccountRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/set-account`;
    let data = { ...payload };
    return new Promise((resolve, reject) => {
      commit("setAccountRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("setAccountError", resp.data.message);
          } else {
            commit("setAccountSuccess", resp.data);
            resolve(resp);
          }
        })
        .catch(err => {
          commit("setAccountError", err);
          reject(err);
        });
    });
  },
  authLogout: ({ commit, dispatch }) => {
    Cookies.remove("access_token");
    Cookies.remove("type");
    commit("authLogout");
    commit("resetWorkOrders");
    commit("resetSubscription");
    commit("resetUsers");
    commit("resetCategories");
    commit("resetCompanies");
    commit("resetLocations");
  }
};

const mutations = {
  authRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  authSuccess: (state, data) => {
    HideLoader(state.loading);
    SuccessMessage(data.message);
    state.status = "success";
    state.access_token = data.data.access_token;
    state.type = btoa(data.data.type);
    state.hasLoadedOnce = true;
  },
  authError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  signupRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  signupSuccess: (state, data) => {
    HideLoader(state.loading);
    SuccessMessage(data.message);
    state.status = "success";
    state.hasLoadedOnce = true;
  },
  signupError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  forgetPasswordRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  forgetPasswordSuccess: (state, data) => {
    HideLoader(state.loading);
    SuccessMessage(data.message);
    state.status = "success";
    state.hasLoadedOnce = true;
  },
  forgetPasswordError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  resetPasswordRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  resetPasswordSuccess: (state, data) => {
    HideLoader(state.loading);
    SuccessMessage(data.message);
    state.status = "success";
    state.hasLoadedOnce = true;
  },
  resetPasswordError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  setAccountRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  setAccountSuccess: (state, data) => {
    HideLoader(state.loading);
    SuccessMessage(data.message);
    state.status = "success";
  },
  setAccountError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  authLogout: state => {
    state.access_token = "";
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
