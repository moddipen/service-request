import { store } from "../store";
import { WarningMessage } from "@/utils/Alert";

export const Subscription = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isSubscriptionLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.subscriptionStatus === "") {
      store.dispatch("subscriptionRequest");
    }
  }, 100);
};

export const Location = (to, from, next) => {
  let time = setInterval(() => {
    if (
      store.getters.isLocationLoaded ||
      store.getters.getAuthRole === "Super admin"
    ) {
      clearInterval(time);
      next();
    }
    if (
      store.getters.locationStatus === "" &&
      store.getters.getAuthRole !== "Super admin"
    ) {
      store.dispatch("locationsRequest");
    }
  }, 100);
};

export const WorkOrders = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isWorkOrderLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.workOrderStatus === "") {
      store.dispatch("workOrdersRequest");
    }
  }, 100);
};

export const WorkOrderDetails = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.getAuthRole === "Company admin") {
      if (
        store.getters.isWorkOrderTaskLoaded(to.params.id) &&
        store.getters.isContractorLoaded
      ) {
        clearInterval(time);
        next();
      }
      if (store.getters.workOrderDetailsStatus === "") {
        store.dispatch("workOrderDetailsRequest", { id: to.params.id });
      }
      if (store.getters.contractorStatus === "") {
        store.dispatch("contractorsRequest");
      }
    } else {
      if (store.getters.isWorkOrderTaskLoaded(to.params.id)) {
        clearInterval(time);
        next();
      }
      if (store.getters.workOrderDetailsStatus === "") {
        store.dispatch("workOrderDetailsRequest", { id: to.params.id });
      }
    }
  }, 200);
};

export const GeneralUsers = (to, from, next) => {
  let time = setInterval(() => {
    if (to.params.type == "editor") {
      if (store.getters.isEditorLoaded) {
        clearInterval(time);
        next();
      }
      if (store.getters.editorsStatus === "") {
        store.dispatch("editorsRequest");
      }
    } else if (to.params.type == "contractor") {
      if (store.getters.isContractorLoaded) {
        clearInterval(time);
        next();
      }
      if (store.getters.contractorStatus === "") {
        store.dispatch("contractorsRequest");
      }
    } else if (to.params.type == "site-admin") {
      if (store.getters.isSiteAdminLoaded) {
        clearInterval(time);
        next();
      }
      if (store.getters.siteAdminStatus === "") {
        store.dispatch("siteAdminsRequest");
      }
    } else if (to.params.type == "site-staff") {
      if (store.getters.isSiteStaffLoaded) {
        clearInterval(time);
        next();
      }
      if (store.getters.isUsersStatus === "") {
        store.dispatch("siteStaffRequest");
      }
    } else if (to.params.type == "contractor-staff") {
      if (store.getters.isContractorStaffLoaded) {
        clearInterval(time);
        next();
      }
      if (store.getters.isUsersStatus === "") {
        store.dispatch("contractorStaffRequest");
      }
    } else {
      clearInterval(time);
      next("/404");
    }
  }, 100);
};

export const ChildUsers = (to, from, next) => {
  let payload = {
    id: to.params.id,
    type: to.params.type
  };
  let time = setInterval(() => {
    if (to.params.type == "editors") {
      if (store.getters.isChildLoaded(to.params.id, to.params.type)) {
        clearInterval(time);
        next();
      }
      if (store.getters.getChildStatus === "") {
        store.dispatch("childsRequest", payload);
      }
    } else if (to.params.type == "contractors") {
      if (store.getters.isChildLoaded(to.params.id, to.params.type)) {
        clearInterval(time);
        next();
      }
      if (store.getters.getChildStatus === "") {
        store.dispatch("childsRequest", payload);
      }
    } else if (to.params.type == "site-admins") {
      if (store.getters.isChildLoaded(to.params.id, to.params.type)) {
        clearInterval(time);
        next();
      }
      if (store.getters.getChildStatus === "") {
        store.dispatch("childsRequest", payload);
      }
    } else if (to.params.type == "site-staff") {
      if (store.getters.isChildLoaded(to.params.id, to.params.type)) {
        clearInterval(time);
        next();
      }
      if (store.getters.getChildStatus === "") {
        store.dispatch("childsRequest", payload);
      }
    } else if (to.params.type == "contractor-staff") {
      if (store.getters.isChildLoaded(to.params.id, to.params.type)) {
        clearInterval(time);
        next();
      }
      if (store.getters.getChildStatus === "") {
        store.dispatch("childsRequest", payload);
      }
    } else {
      clearInterval(time);
      next("/404");
    }
  }, 200);
};

export const Company = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isCompanyLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.getCompanyStatus === "") {
      store.dispatch("companiesRequest");
    }
  }, 100);
};

export const Category = (to, from, next) => {
  let time = setInterval(() => {
    if (
      store.getters.isCategoryLoaded ||
      store.getters.getAuthRole === "Super admin"
    ) {
      clearInterval(time);
      next();
    }
    if (
      store.getters.categoryStatus === "" &&
      store.getters.getAuthRole !== "Super admin"
    ) {
      store.dispatch("categoriesRequest");
    }
  }, 100);
};

export const Role = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isRoleLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.roleStatus === "") {
      store.dispatch("rolesRequest");
    }
  }, 100);
};

export const Editors = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isEditorLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.editorsStatus === "") {
      store.dispatch("editorsRequest");
    }
  }, 100);
};

export const Contractors = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isContractorLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.contractorStatus === "") {
      store.dispatch("contractorsRequest");
    }
  }, 100);
};

export const SiteAdmins = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isSiteAdminLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.siteAdminStatus === "") {
      store.dispatch("siteAdminsRequest");
    }
  }, 100);
};

export const SiteStaff = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isSiteStaffLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.siteStaffStatus === "") {
      store.dispatch("siteStaffRequest");
    }
  }, 100);
};

export const ContractorStaff = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isContractorStaffLoaded) {
      clearInterval(time);
      next();
    }
    if (store.getters.isUsersStatus === "") {
      store.dispatch("contractorStaffRequest");
    }
  }, 100);
};

export const Profile = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      next();
    }
  }, 100);
};

export const Setting = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isSettingLoaded) {
      clearInterval(time);
      next();
    }
  }, 100);
};

export const IsCompanyAdmin = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole === "Company admin") {
        next();
        return;
      }
      WarningMessage("Access unauthorised !");
      next("/403");
      return;
    }
  }, 100);
};

export const Authenticate = (to, from, next) => {
  if (store.getters.isAuthenticated) {
    next();
    return;
  }
  next("/user/login");
};

export const IsNotSuperAdmin = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole !== "Super admin") {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};

export const IsSuperAdmin = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole === "Super admin") {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};

export const Permission = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthPermissions.indexOf(to.meta.permission) !== -1) {
        next();
        return;
      }
      WarningMessage("Access unauthorised !");
      next("/403");
    }
  }, 100);
};

export const RedirectIfAuthenticated = (to, from, next) => {
  if (!store.getters.isAuthenticated) {
    next();
    return;
  }
  if (store.getters.authType === "admin") {
    next("/app/users/companies");
  } else {
    next("/app/work-orders");
  }
};

export const IsSiteAdmin = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole === "Site admin") {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};

export const IsContractorAdmin = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole === "Contractor admin") {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};

export const IsNotStaff = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (
        store.getters.getAuthRole !== "Site staff" &&
        store.getters.getAuthRole !== "Contractor staff"
      ) {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};

export const IsNotStaffExceptSiteStaff = (to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isProfileLoaded) {
      clearInterval(time);
      if (store.getters.getAuthRole !== "Contractor staff") {
        next();
        return;
      } else {
        WarningMessage("Access unauthorised !");
        next("/403");
        return;
      }
    }
  }, 100);
};
