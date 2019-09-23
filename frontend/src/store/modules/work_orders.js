import Vue from "vue"
import { apiUrl } from "@/constants/config"
import { store } from ".."
import { ErrorMessage, SuccessMessage } from "@/utils/Alert"
import { ShowLoader, HideLoader } from "@/utils/Loader"

const state = {
  status: "",
  workOrders: [],
  isLoaded: false,
  workOrderStatus: "",
  loading: ""
}

function initialState() {
  return {
    status: "",
    workOrders: [],
    isLoaded: false,
    workOrderStatus: "",
    loading: ""
  }
}

const getters = {
  getWorkOrders: state => state.workOrders,
  isWorkOrderLoaded: state => state.isLoaded,
  workOrderStatus: state => state.status,
  workOrderDetailsStatus: state => state.workOrderStatus,
  getWorkOrderById: state => id => {
    let workOrder = state.workOrders.filter(workOrder => {
      return workOrder.id == id
    })
    if (workOrder.length) {
      return workOrder[0]
    } else {
      return {}
    }
  },
  isWorkOrderTaskLoaded: state => id => {
    let workOrder = state.workOrders.filter(workOrder => {
      return workOrder.id == id
    })
    if (workOrder.length) {
      if (workOrder[0].tasks) {
        return true
      } else {
        return false
      }
    } else {
      return false
    }
  }
}

const actions = {
  workOrdersRequest: ({ commit, dispatch }) => {
    commit("workOrdersRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders`
    axios
      .get(actionUrl)
      .then(resp => {
        commit("workOrdersSuccess", resp.data)
      })
      .catch(err => {
        commit("workOrdersError")
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      })
  },
  addWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("addWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders`
    let data = {
      site_location_id: payload.location.value,
      title: payload.title,
      description: payload.description,
      purchase_order_number: payload.purchase_order,
      quote_required: payload.quote_required,
      order_priority_id: payload.priority.value,
      images: payload.images
    }

    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data, "create")
            resolve(resp.data.work_order)
          } else {
            commit("addWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("addWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  updateWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      site_location_id: payload.location.value,
      title: payload.title,
      description: payload.description,
      purchase_order_number: payload.purchase_order,
      quote_required: payload.quote_required
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  assignWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      assign_to: payload.contractor,
      contractor_quote_required: payload.contractor_quote_required
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  addPartsToWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      parts: payload.parts
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  addCostToWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      contractor_cost: payload.contractor_cost
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  addCompanyCostToWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      company_cost: payload.company_cost
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  updateWorkOrderStatusRequest: ({ commit, dispatch }, payload) => {
    commit("updateWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    let data = {
      status: payload.status
    }
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("updateWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("updateWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("updateWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  deleteWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("deleteWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    return new Promise((resolve, reject) => {
      axios
        .delete(actionUrl)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("deleteWorkOrderSuccess", resp.data)
            commit("removeWorkOrder", resp.data)
            resolve(resp.data.id)
          } else {
            commit("deleteWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("deleteWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  workOrderDetailsRequest: ({ commit, dispatch }, payload) => {
    commit("workOrderDetailsRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/${payload.id}`
    axios
      .get(actionUrl)
      .then(resp => {
        commit("workOrderDetailsSuccess", resp.data)
        commit("setWorkOrderDetails", resp.data)
      })
      .catch(err => {
        commit("workOrderDetailsError")
        // if resp is unauthorized, logout, to
        // dispatch("authLogout");
      })
  },
  addTaskToWorkOrderRequest: ({ commit, dispatch }, payload) => {
    commit("addTaskToWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/tasks`
    let data = {
      work_order_id: payload.work_order_id,
      work_category_id: payload.category.value,
      work_priority_id: payload.priority.value,
      title: payload.title,
      description: payload.description,
      images: payload.images
    }
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addTaskToWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("addTaskToWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("addTaskToWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  updateWorkOrderTaskRequest: ({ commit, dispatch }, payload) => {
    commit("addTaskToWorkOrderRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/tasks/${payload.id}`
    return new Promise((resolve, reject) => {
      axios
        .put(actionUrl, payload)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addTaskToWorkOrderSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("addTaskToWorkOrderError", resp.data.message)
          }
        })
        .catch(err => {
          commit("addTaskToWorkOrderError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  addCommentToTaskRequest: ({ commit, dispatch }, payload) => {
    commit("addCommentToTaskRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/tasks/comments`
    let data = {
      work_task_id: payload.work_task_id,
      work_order_id: payload.work_order_id,
      message: payload.message
    }
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addCommentToTaskSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("addCommentToTaskError", resp.data.message)
          }
        })
        .catch(err => {
          commit("addCommentToTaskError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  },
  addPhotosToTaskRequest: ({ commit, dispatch }, payload) => {
    commit("addCommentToTaskRequest")
    let actionUrl = `${apiUrl}/${store.getters.authType}/work-orders/tasks/comments`
    let data = {
      work_task_id: payload.work_task_id,
      work_order_id: payload.work_order_id,
      images: payload.images
    }
    return new Promise((resolve, reject) => {
      axios
        .post(actionUrl, data)
        .then(resp => {
          if (resp.data.code == 201) {
            commit("addCommentToTaskSuccess", resp.data)
            commit("setWorkOrderDetails", resp.data)
            resolve(resp.data.work_order)
          } else {
            commit("addCommentToTaskError", resp.data.message)
          }
        })
        .catch(err => {
          commit("addCommentToTaskError", "Unauthorised !")
          // if resp is unauthorized, logout, to
          // dispatch("authLogout");
          reject(err)
        })
    })
  }
}

const mutations = {
  workOrdersRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  workOrdersSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    Vue.set(state, "workOrders", resp.data.work_orders)
    Vue.set(state, "isLoaded", true)
    HideLoader(state.loading)
  },
  workOrdersError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  addWorkOrderRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  addWorkOrderSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    HideLoader(state.loading)
  },
  addWorkOrderError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  updateWorkOrderRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  updateWorkOrderSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    HideLoader(state.loading)
  },
  updateWorkOrderError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  deleteWorkOrderRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  deleteWorkOrderSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    HideLoader(state.loading)
  },
  deleteWorkOrderError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  workOrderDetailsRequest: state => {
    state.loading = ShowLoader()
    state.workOrderStatus = "loading"
  },
  workOrderDetailsSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.workOrderStatus = "success"
    HideLoader(state.loading)
  },
  workOrderDetailsError: (state, err) => {
    ErrorMessage(err)
    state.workOrderStatus = "error"
    HideLoader(state.loading)
  },
  addTaskToWorkOrderRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  addTaskToWorkOrderSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    HideLoader(state.loading)
  },
  addTaskToWorkOrderError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  addCommentToTaskRequest: state => {
    state.loading = ShowLoader()
    state.status = "loading"
  },
  addCommentToTaskSuccess: (state, resp) => {
    SuccessMessage(resp.message)
    state.status = "success"
    HideLoader(state.loading)
  },
  addCommentToTaskError: (state, err) => {
    ErrorMessage(err)
    state.status = "error"
    HideLoader(state.loading)
  },
  setWorkOrderDetails: (state, resp, type = "other") => {
    let workOrders
    if (type === "create") {
      workOrders = state.workOrders
    } else {
      workOrders = state.workOrders.filter(workOrder => {
        return workOrder.id != resp.data.work_order.id
      })
    }
    Vue.set(state, "workOrders", [...workOrders, resp.data.work_order])
    setTimeout(() => {
      state.workOrderStatus = ""
    }, 5000)
  },
  removeWorkOrder: (state, resp) => {
    let workOrders = state.workOrders.filter(workOrder => {
      return workOrder.id != resp.data.id
    })
    Vue.set(state, "workOrders", workOrders)
  },
  resetWorkOrders: state => {
    const s = initialState()
    Object.keys(s).forEach(key => {
      state[key] = s[key]
    })
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
