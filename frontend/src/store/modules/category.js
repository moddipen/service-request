import Vue from "vue";
import { apiUrl } from "@/constants/config";
import { store } from "..";
import { ErrorMessage, SuccessMessage } from "@/utils/Alert";
import { ShowLoader, HideLoader } from "@/utils/Loader";

const state = {
  status: "",
  categories: [],
  isLoaded: false,
  loading: ""
};

function initialState() {
  return {
    status: "",
    categories: [],
    isLoaded: false,
    loading: ""
  };
}

const getters = {
  getCategories: state => state.categories,
  categoryStatus: state => state.status,
  isCategoryLoaded: state => state.isLoaded,
  getCategoryById: state => id => {
    let category = state.categories.filter(category => {
      return category.id == id;
    });
    if (category.length) {
      return category[0];
    } else {
      return {};
    }
  }
};

const actions = {
  categoriesRequest: ({ commit, dispatch }) => {
    commit("categoriesRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/categories`;
    axios
      .get(actionUrl)
      .then(resp => {
        commit("categoriesSuccess", resp.data);
      })
      .catch(err => {
        commit("categoriesError");
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      });
  },
  addCategoryRequest: ({ commit, dispatch }, payload) => {
    commit("addCategoryRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/categories`;
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addCategorySuccess", resp.data);
            resolve(resp.data.categories);
          } else {
            commit("addCategoryError", resp.data.message);
          }
        })
        .catch(err => {
          commit("addCategoryError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  updateCategoryRequest: ({ commit, dispatch }, payload) => {
    commit("updateCategoryRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/categories/${
      payload.id
    }`;
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateCategorySuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("updateCategoryError", resp.data.message);
          }
        })
        .catch(err => {
          commit("updateCategoryError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  },
  deleteCategoryRequest: ({ commit, dispatch }, payload) => {
    commit("deleteCategoryRequest");
    let actionUrl = `${apiUrl}/${store.getters.authType}/categories/${
      payload.id
    }`;
    return new Promise((resolve, reject) => {
      axios
        .delete(actionUrl)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("deleteCategorySuccess", resp.data);
            resolve(resp.data.locations);
          } else {
            commit("deleteCategoryError", resp.data.message);
          }
        })
        .catch(err => {
          commit("deleteCategoryError", "Unauthorised !");
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err);
        });
    });
  }
};

const mutations = {
  categoriesRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  categoriesSuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "categories", resp.data.categories);
    Vue.set(state, "isLoaded", true);
    HideLoader(state.loading);
  },
  categoriesError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  addCategoryRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  addCategorySuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "categories", resp.data.categories);
    HideLoader(state.loading);
  },
  addCategoryError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  updateCategoryRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  updateCategorySuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "categories", resp.data.categories);
    HideLoader(state.loading);
  },
  updateCategoryError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  deleteCategoryRequest: state => {
    state.loading = ShowLoader();
    state.status = "loading";
  },
  deleteCategorySuccess: (state, resp) => {
    SuccessMessage(resp.message);
    state.status = "success";
    Vue.set(state, "categories", resp.data.categories);
    HideLoader(state.loading);
  },
  deleteCategoryError: (state, err) => {
    ErrorMessage(err);
    state.status = "error";
    HideLoader(state.loading);
  },
  resetCategories: state => {
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
