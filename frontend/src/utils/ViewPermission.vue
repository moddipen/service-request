<script>
import { store } from "../store";
export default {
  methods: {
    $can(permissionName) {
      return store.getters.getAuthPermissions.indexOf(permissionName) !== -1;
    },
    $isSuperAdmin() {
      if (store.getters.getAuthRole === "Super admin") {
        return true;
      } else {
        return false;
      }
    },
    $isCompanyAdmin() {
      if (store.getters.getAuthRole === "Company admin") {
        return true;
      } else {
        return false;
      }
    },
    $isCompanyEditor() {
      if (store.getters.getAuthRole === "Company editor") {
        return true;
      } else {
        return false;
      }
    },
    $isNotSuperAdmin() {
      if (store.getters.getAuthRole !== "Super admin") {
        return true;
      } else {
        return false;
      }
    },
    $isContractorAdmin() {
      if (store.getters.getAuthRole === "Contractor admin") {
        return true;
      } else {
        return false;
      }
    },
    $isSiteAdmin() {
      if (store.getters.getAuthRole === "Site admin") {
        return true;
      } else {
        return false;
      }
    },
    $isSiteStaff() {
      if (store.getters.getAuthRole === "Site staff") {
        return true;
      } else {
        return false;
      }
    },
    $isNotStaff() {
      if (
        store.getters.getAuthRole !== "Site staff" &&
        store.getters.getAuthRole !== "Contractor staff"
      ) {
        return true;
      } else {
        return false;
      }
    },
    $isCompanyStaff() {
      if (
        store.getters.getAuthRole === "Company admin" ||
        store.getters.getAuthRole === "Company editor"
      ) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>