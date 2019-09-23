import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  childStatus: "",
  companies: [],
  loadedUsers: [],
  editors: [],
  contractors: [],
  siteAdmins: [],
  siteStaff: [],
  contractorStaff: [],
  isLoaded: false,
  loading: ""
};

function initialState() {
  return {
    status: "",
    childStatus: "",
    companies: [],
    loadedUsers: [],
    editors: [],
    contractors: [],
    siteAdmins: [],
    siteStaff: [],
    contractorStaff: [],
    isLoaded: false,
    loading: ""
  };
}

const getters = {
  getCompanies: state => state.companies,
  getCompanyStatus: state => state.status,
  getChildStatus: state => state.childStatus,
  isCompanyLoaded: state => state.isLoaded,
  getCompanyById: state => id => {
    let company = state.companies.filter(company => {
      return company.id == id;
    });
    if (company.length) {
      return company[0];
    } else {
      return {};
    }
  },
  isChildLoaded: state => (id, type) => {
    let user = state[_.camelCase(type)].filter(user => {
      return user.pid == id;
    });
    let checkLoaded = _.camelCase(type) + id;
    if (user.length || state.loadedUsers.indexOf(checkLoaded) !== -1) {
      return true;
    } else {
      return false;
    }
  },
  getChildsByParentId: state => (id, type) => {
    let users = state[_.camelCase(type)].filter(user => {
      return user.pid == id;
    });
    if (users.length) {
      return users;
    } else {
      return [];
    }
  },
  getChildById: state => (id, type) => {
    let users = state[_.camelCase(type)].filter(user => {
      return user.id == id;
    });
    if (users.length) {
      return users[0];
    } else {
      return {};
    }
  }
};

const actions = {
  companiesRequest: ({ commit, dispatch }) => {
    commit("companiesRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/companies`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("companiesSuccess", resp.data);
      })
      .catch(err => {
        commit("companiesError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  childsRequest: ({ commit, dispatch }, payload) => {
    commit("childsRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/companies/users`;
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, payload)
        .then(resp => {
          commit("childsSuccess", resp.data);
          resolve(resp.data.locations);
        })
        .catch(err => {
          commit("childsError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  updateCompanyRequest: ({ commit, dispatch }, payload) => {
    commit("updateCompanyRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/update/${
      payload.id
    }`;
    let data = {
      type: payload.type,
      pid: payload.pid,
      name: payload.name,
      address: payload.address,
      status: payload.status ? 1 : 0,
      phone: payload.phone,
      website: payload.website,
      company_name: payload.company_name
    };
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateCompanySuccess", resp.data);
            commit("setChildUsers", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("updateCompanyError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateCompanyError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  updateCompanyPermissionsRequest: ({ commit, dispatch }, payload) => {
    commit("updateCompanyPermissionsRequest");
    let actionUrl = `${apiUrl}/${
      store.getters.authType
    }/users/permission/update/${payload.id}`;
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateCompanyPermissionsSuccess", resp.data);
            commit("setChildUsers", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("updateCompanyPermissionsError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateCompanyPermissionsError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  deleteCompanyRequest: ({ commit, dispatch }, payload) => {
    commit("deleteCompanyRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/delete/${
      payload.id
    }`;
    let data = {
      type: payload.type,
      pid: payload.pid
    };
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("deleteCompanySuccess", resp.data);
            commit("setChildUsers", resp.data);
            resolve(resp.data.users);
          } else {
            commit("deleteCompanyError", resp.data.message);
          }
        })
        .catch(err => {
          commit("deleteCompanyError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch('authLogout')
          reject(err);
        });
    });
  }
};

const mutations = {
  companiesRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  companiesSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "companies", resp.data.companies);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  companiesError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  childsRequest: state => {
    state.loading = ShowLoader();
    state.childStatus = "loading";
  },
  childsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.childStatus = "success";
    let type = resp.data.type;
    let id = resp.data.id;
    let users = state[_.camelCase(type)].filter(user => {
      return user.pid != id;
    });
    Vue.set(state, _.camelCase(type), [...users, ...resp.data.users]);
    let loadedUsers = state.loadedUsers;
    loadedUsers.indexOf(_.camelCase(type) + id) === -1
      ? loadedUsers.push(_.camelCase(type) + id)
      : console.log("Already loaded");
    Vue.set(state, "loadedUsers", loadedUsers);
    setTimeout(() => {
      state.childStatus = "";
    }, 5000);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  childsError: (state, err) => {
    ErrorMessage(err);
    state.childStatus = "error";
    setTimeout(() => {
      state.childStatus = "";
    }, 5000);
    HideLoader(state.loading);
  },
  updateCompanyRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateCompanySuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  updateCompanyError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateCompanyPermissionsRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateCompanyPermissionsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  updateCompanyPermissionsError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  deleteCompanyRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  deleteCompanySuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  deleteCompanyError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  setChildUsers: (state, resp) => {
    let type = resp.data.type;
    let id = resp.data.pid;
    if (type === "companies") {
      Vue.set(state, "companies", resp.data.users);
    } else {
      let users = state[_.camelCase(type)].filter(user => {
        return user.pid != id;
      });
      Vue.set(state, _.camelCase(type), [...users, ...resp.data.users]);
    }
  },
  resetCompanies: state => {
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
