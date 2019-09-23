import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  profile: {},
  role: "",
  permissions: [],
  loading: ""
};

function initialState() {
  return {
    status: "",
    profile: {},
    role: "",
    permissions: [],
    loading: ""
  };
}

const getters = {
  getProfile: state => state.profile,
  getAuthRole: state => state.role,
  getAuthPermissions: state => state.permissions,
  isProfileLoaded: state => !!state.profile.name
};

const actions = {
  userRequest: ({ commit, dispatch }) => {
    commit("userRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/profile`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("userSuccess", resp.data);
      })
      .catch(err => {
        commit("userError");
        // if resp is unauthorized, logout, to
        dispatch("authLogout");
      });
  },
  changePasswordRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/${store.getters.authType}/change-password`;
    let data = {
      password: payload.password
    };
    return new Promise((resolve, reject) => {
      commit("changePasswordRequest");
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("changePasswordError", resp.data.message);
          } else {
            commit("changePasswordSuccess", resp.data);
            resolve(data.data);
          }
        })
        .catch(err => {
          commit("changePasswordError", err);
          reject(err);
        });
    });
  },
  updateProfileRequest: ({ commit, dispatch }, payload) => {
    let actionUrl = `${apiUrl}/${store.getters.authType}/update-profile`;
    const formData = new FormData();
    formData.append("name", payload.name);
    formData.append("address", payload.address);
    formData.append("phone", payload.phone);
    formData.append("website", payload.website);
    formData.append("photo", payload.photo);
    formData.append("company_name", payload.company_name);
    const config = {
      headers: {
        "content-type": "multipart/form-data"
      }
    };
    return new Promise((resolve, reject) => {
      commit("updateProfileRequest");
      axios
        .post(actionUrl, formData, config)
        .then(resp => {
          if (resp.data.code !== 201) {
            commit("updateProfileError", resp.data.message);
          } else {
            commit("updateProfileSuccess", resp.data);
            resolve(resp.data);
          }
        })
        .catch(err => {
          commit("updateProfileError", err);
          reject(err);
        });
    });
  }
};

const mutations = {
  userRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  userSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "profile", resp.data.profile);
    Vue.set(state, "permissions", resp.data.permissions);
    Vue.set(state, "role", resp.data.role);
  },
  userError: state => {
    HideLoader(state.loading);
    ErrorMessage("Unauthorised !");
    state.status = "error";
  },
  changePasswordRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  changePasswordSuccess: (state, resp) => {
    HideLoader(state.loading);
    SuccessMessage(resp.message);
  },
  changePasswordError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  updateProfileRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateProfileSuccess: (state, resp) => {
    Vue.set(state, "profile", resp.data.profile);
    HideLoader(state.loading);
    SuccessMessage(resp.message);
  },
  updateProfileError: (state, err) => {
    HideLoader(state.loading);
    ErrorMessage(err);
    state.status = "error";
  },
  resetAuthUser: state => {
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
