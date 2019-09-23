import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  roles: [],
  permissions: [],
  isLoaded: false,
  loading: ""
};

const getters = {
  getRoles: state => state.roles,
  getPermissions: state => state.permissions,
  isRoleLoaded: state => state.isLoaded,
  roleStatus: state => state.status,
  getRoleById: state => id => {
    let role = state.roles.filter(role => {
      return role.id == id;
    });
    if (role.length) {
      return role[0];
    } else {
      return {};
    }
  }
};

const actions = {
  rolesRequest: ({ commit, dispatch }) => {
    commit("rolesRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/roles`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("rolesSuccess", resp.data);
      })
      .catch(err => {
        commit("rolesError");
        // if resp is unauthorized, logout, to
        // dispatch('authLogout')
      });
  },
  getRoleRequest: ({ commit, dispatch }, payload) => {
    commit("getRoleRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/roles/${payload.id}`;
    axios
      .get(actionUrl)
      .then(resp => {
        if (resp.data.code != 200) {
          commit("getRoleError", resp.data.message);
        } else {
          commit("getRoleSuccess", resp.data);
        }
      })
      .catch(err => {
        commit("getRoleError", "Unauthorised !");
        // if resp is unauthorized, logout, to
        dispatch("authLogout");
      });
  },
  updateRoleRequest: ({ commit, dispatch }, payload) => {
    commit("upadteRoleRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/roles/${payload.id}`;
    let data = {
      permissions: payload.permissions
    };
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("upadteRoleSuccess", resp.data);
            resolve(resp.data.roles);
          } else {
            commit("upadteRoleError", resp.data.message);
          }
        })
        .catch(err => {
          commit("upadteRoleError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch('authLogout')
          reject(err);
        });
    });
  }
};

const mutations = {
  rolesRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  rolesSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "roles", resp.data.roles);
    Vue.set(state, "permissions", resp.data.permissions);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  rolesError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  getRoleRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  getRoleSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  getRoleError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  upadteRoleRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  upadteRoleSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "roles", resp.data.roles);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  upadteRoleError: (state, err) => {
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
