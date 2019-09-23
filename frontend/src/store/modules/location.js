import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  locations: [],
  isLoaded: false,
  loading: ""
};

function initialState() {
  return {
    status: "",
    contractors: [],
    isLoaded: false,
    loading: ""
  };
}

const getters = {
  getLocations: state => state.locations,
  isLocationLoaded: state => state.isLoaded,
  locationStatus: state => state.status,
  getLocationById: state => id => {
    let location = state.locations.filter(location => {
      return location.id == id;
    });
    if (location.length) {
      return location[0];
    } else {
      return {};
    }
  }
};

const actions = {
  locationsRequest: ({ commit, dispatch }) => {
    commit("locationsRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/locations`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("locationsSuccess", resp.data);
      })
      .catch(err => {
        commit("locationsError");
        // if resp is unauthorized, logout, to
        dispatch("authLogout");
      });
  },
  addLocationRequest: ({ commit, dispatch }, payload) => {
    commit("addLocationRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/locations`;
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addLocationSuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("addLocationError", resp.data.message);
          }
        })
        .catch(err => {
          commit("addLocationError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  },
  updateLocationRequest: ({ commit, dispatch }, payload) => {
    commit("updateLocationRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/locations/${
      payload.id
    }`;
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateLocationSuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("updateLocationError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateLocationError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  },
  deleteLocationRequest: ({ commit, dispatch }, payload) => {
    commit("deleteLocationRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/locations/${
      payload.id
    }`;
    return new Promise((resolve, reject) => {
      axios
        .delete(actionUrl)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("deleteLocationSuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("deleteLocationError", resp.data.message);
          }
        })
        .catch(err => {
          commit("deleteLocationError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          dispatch("authLogout");
          reject(err);
        });
    });
  }
};

const mutations = {
  locationsRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  locationsSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "locations", resp.data.locations);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  locationsError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  addLocationRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  addLocationSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "locations", resp.data.locations);
    HideLoader(state.loading);
  },
  addLocationError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateLocationRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateLocationSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "locations", resp.data.locations);
    HideLoader(state.loading);
  },
  updateLocationError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  deleteLocationRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  deleteLocationSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "locations", resp.data.locations);
    HideLoader(state.loading);
  },
  deleteLocationError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  resetLocations: state => {
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
