import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  isLoaded: false,
  loading: "",
  editors: [],
  editorsStatus: "",
  isEditorLoaded: false,
  contractors: [],
  contractorStatus: "",
  isContractorLoaded: false,
  siteAdmins: [],
  siteAdminStatus: "",
  isSiteAdminLoaded: false,
  siteStaff: [],
  siteStaffStatus: "",
  isSiteStaffLoaded: false,
  contractorStaff: [],
  contractorStaffStatus: "",
  isContractorStaffLoaded: false
};

function initialState() {
  return {
    status: "",
    isLoaded: false,
    loading: "",
    editors: [],
    editorsStatus: "",
    isEditorLoaded: false,
    contractors: [],
    contractorStatus: "",
    isContractorLoaded: false,
    siteAdmins: [],
    siteAdminStatus: "",
    isSiteAdminLoaded: false,
    siteStaff: [],
    siteStaffStatus: "",
    isSiteStaffLoaded: false,
    contractorStaff: [],
    contractorStaffStatus: "",
    isContractorStaffLoaded: false
  };
}

const getters = {
  isEditorLoaded: state => state.isEditorLoaded,
  isContractorLoaded: state => state.isContractorLoaded,
  isSiteAdminLoaded: state => state.isSiteAdminLoaded,
  isSiteStaffLoaded: state => state.isSiteStaffLoaded,
  isContractorStaffLoaded: state => state.isContractorStaffLoaded,
  isUsersStatus: state => state.status,
  editorsStatus: state => state.editorsStatus,
  siteStaffStatus: state => state.siteStaffStatus,
  contractorStaffStatus: state => state.contractorStaffStatus,
  contractorStatus: state => state.contractorStatus,
  siteAdminStatus: state => state.siteAdminStatus,
  getEditors: state => state.editors,
  getContractorAdmins: state => state.contractors,
  getContractorStaff: state => state.contractorStaff,
  getSiteStaff: state => state.siteStaff,
  getSiteAdmins: state => state.siteAdmins,
  getEditorById: state => id => {
    let editor = state.editors.filter(editor => {
      return editor.id == id;
    });
    if (editor.length) {
      return editor[0];
    } else {
      return {};
    }
  },
  getContractorById: state => id => {
    let contractor = state.contractors.filter(contractor => {
      return contractor.id == id;
    });
    if (contractor.length) {
      return contractor[0];
    } else {
      return {};
    }
  },
  getSiteAdminById: state => id => {
    let siteAdmin = state.siteAdmins.filter(siteAdmin => {
      return siteAdmin.id == id;
    });
    if (siteAdmin.length) {
      return siteAdmin[0];
    } else {
      return {};
    }
  },
  getSiteStaffById: state => id => {
    let users = state.siteStaff.filter(user => {
      return user.id == id;
    });
    if (users.length) {
      return users[0];
    } else {
      return {};
    }
  },
  getContractorStaffById: state => id => {
    let users = state.contractorStaff.filter(user => {
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
  inviteUserRequest: ({ commit, dispatch }, payload) => {
    commit("inviteUserRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/invite-users`;
    let data = {
      email: payload.email,
      type: payload.type.value
    };
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("inviteUserSuccess", resp.data);
            resolve(resp.data.roles);
          } else {
            commit("inviteUserError", resp.data.message);
          }
        })
        .catch(err => {
          commit("inviteUserError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  editorsRequest: ({ commit, dispatch }) => {
    commit("editorsRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/editors`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("editorsSuccess", resp.data);
      })
      .catch(err => {
        commit("editorsError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  contractorsRequest: ({ commit, dispatch }) => {
    commit("contractorsRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/contractors`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("contractorsSuccess", resp.data);
      })
      .catch(err => {
        commit("contractorsError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  contractorStaffRequest: ({ commit, dispatch }) => {
    commit("contractorStaffRequest");
    let actionUrl = `${apiUrl}/${
      store.getters.authType
    }/users/contractor-staff`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("contractorStaffSuccess", resp.data);
      })
      .catch(err => {
        commit("contractorStaffError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  siteStaffRequest: ({ commit, dispatch }) => {
    commit("siteStaffRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/site-staff`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("siteStaffSuccess", resp.data);
      })
      .catch(err => {
        commit("siteStaffError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  siteAdminsRequest: ({ commit, dispatch }) => {
    commit("siteAdminsRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/site-admins`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("siteAdminsSuccess", resp.data);
      })
      .catch(err => {
        commit("siteAdminsError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  updateUserPermissionsRequest: ({ commit, dispatch }, payload) => {
    commit("updateUserPermissionsRequest");
    let actionUrl = `${apiUrl}/${
      store.getters.authType
    }/users/permission/update/${payload.id}`;
    let data = {
      type: payload.type,
      permissions: payload.permissions
    };
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateUserPermissionsSuccess", resp.data);
            commit("setAllUsers", resp.data);
            resolve(resp.data.users);
          } else {
            commit("updateUserPermissionsError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateUserPermissionsError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch('authLogout')
          reject(err);
        });
    });
  },
  updateUserRequest: ({ commit, dispatch }, payload) => {
    commit("updateUserRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/update/${
      payload.id
    }`;
    let data = {
      type: payload.type,
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
            commit("updateUserSuccess", resp.data);
            commit("setAllUsers", resp.data);
            resolve(resp.data.users);
          } else {
            commit("updateUserError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateUserError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch('authLogout')
          reject(err);
        });
    });
  },
  deleteUserRequest: ({ commit, dispatch }, payload) => {
    commit("deleteUserRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/users/delete/${
      payload.id
    }`;
    let data = {
      type: payload.type
    };
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("deleteUserSuccess", resp.data);
            commit("setAllUsers", resp.data);
            resolve(resp.data.users);
          } else {
            commit("deleteUserError", resp.data.message);
          }
        })
        .catch(err => {
          commit("deleteUserError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch('authLogout')
          reject(err);
        });
    });
  }
};

const mutations = {
  inviteUserRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  inviteUserSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  inviteUserError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  editorsRequest: state => {
    state.loading = ShowLoader();
    state.editorsStatus = "loading";
  },
  editorsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.editorsStatus = "success";
    Vue.set(state, "editors", resp.data.users);
    Vue.set(state, "isEditorLoaded", true);
    HideLoader(state.loading);
  },
  editorsError: (state, err) => {
    ErrorMessage(err);
    state.editorsStatus = "error";
    HideLoader(state.loading);
  },
  contractorsRequest: state => {
    state.loading = ShowLoader();
    state.contractorStatus = "loading";
  },
  contractorsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.contractorStatus = "success";
    Vue.set(state, "contractors", resp.data.users);
    Vue.set(state, "isContractorLoaded", true);
    HideLoader(state.loading);
  },
  contractorsError: (state, err) => {
    ErrorMessage(err);
    state.contractorStatus = "error";
    HideLoader(state.loading);
  },
  siteAdminsRequest: state => {
    state.loading = ShowLoader();
    state.siteAdminStatus = "loading";
  },
  siteAdminsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.siteAdminStatus = "success";
    Vue.set(state, "siteAdmins", resp.data.users);
    Vue.set(state, "isSiteAdminLoaded", true);
    HideLoader(state.loading);
  },
  siteAdminsError: (state, err) => {
    ErrorMessage(err);
    state.siteAdminStatus = "error";
    HideLoader(state.loading);
  },
  siteStaffRequest: state => {
    state.loading = ShowLoader();
    state.siteStaffStatus = "loading";
  },
  siteStaffSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.siteStaffStatus = "success";
    Vue.set(state, "siteStaff", resp.data.users);
    Vue.set(state, "isSiteStaffLoaded", true);
    HideLoader(state.loading);
  },
  siteStaffError: (state, err) => {
    ErrorMessage(err);
    state.siteStaffStatus = "error";
    HideLoader(state.loading);
  },
  contractorStaffRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  contractorStaffSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "contractorStaff", resp.data.users);
    Vue.set(state, "isContractorStaffLoaded", true);
    HideLoader(state.loading);
  },
  contractorStaffError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateUserPermissionsRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateUserPermissionsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  updateUserPermissionsError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateUserRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateUserSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  updateUserError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  deleteUserRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  deleteUserSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    HideLoader(state.loading);
  },
  deleteUserError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  setAllUsers: (state, resp) => {
    let type = resp.data.type;
    if (type == "editor") {
      Vue.set(state, "editors", resp.data.users);
    } else if (type == "contractor") {
      Vue.set(state, "contractors", resp.data.users);
    } else if (type == "site-admin") {
      Vue.set(state, "siteAdmins", resp.data.users);
    } else if (type == "site-staff") {
      Vue.set(state, "siteStaff", resp.data.users);
    } else if (type == "contractor-staff") {
      Vue.set(state, "contractorStaff", resp.data.users);
    }
  },
  resetUsers: state => {
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
