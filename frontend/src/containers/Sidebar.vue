
<template>
  <div
    class="sidebar"
    @mouseenter="isMenuOver=true"
    @mouseleave="isMenuOver=false"
    @touchstart="isMenuOver=true"
  >
    <div class="main-menu">
      <vue-perfect-scrollbar
        class="scroll"
        :settings="{ suppressScrollX: true, wheelPropagation: false }"
      >
        <ul class="list-unstyled">
          <!-- <li :class="{ active : selectedParentMenu==='dashboards' }">
            <router-link tag="li" to="/app/dashboard">
              <a>
                <i class="simple-icon-pie-chart"></i>Dashboard
              </a>
            </router-link>
          </li>-->
          <li :class="{ active : selectedParentMenu==='account' }">
            <a @click.prevent="openSubMenu($event,'account')" href="#account">
              <i class="simple-icon-lock"></i>Account
            </a>
          </li>
          <li v-if="this.$isSuperAdmin()" :class="{ active : selectedParentMenu==='roles' }">
            <router-link tag="li" to="/admin/roles">
              <a>
                <i class="simple-icon-user"></i>Roles
              </a>
            </router-link>
          </li>
          <li
            v-if="this.$isNotStaff() && !this.$isCompanyEditor()"
            :class="{ active : selectedParentMenu==='users' }"
          >
            <a @click.prevent="openSubMenu($event,'users')" href="#users">
              <i class="simple-icon-people"></i>Users
            </a>
          </li>
          <li v-if="this.$isSiteAdmin()" :class="{ active : selectedParentMenu==='locations' }">
            <router-link tag="li" to="/app/locations">
              <a>
                <i class="iconsminds-location-2"></i>Site locations
              </a>
            </router-link>
          </li>
          <li v-if="this.$isCompanyAdmin()" :class="{ active : selectedParentMenu==='categories' }">
            <router-link tag="li" to="/app/categories">
              <a>
                <i class="simple-icon-grid"></i>Work categories
              </a>
            </router-link>
          </li>
          <li :class="{ active : selectedParentMenu==='work-orders' }">
            <router-link tag="li" to="/app/work-orders">
              <a>
                <i class="iconsminds-posterous"></i>Service Request
              </a>
            </router-link>
          </li>
        </ul>
      </vue-perfect-scrollbar>
    </div>

    <div class="sub-menu">
      <vue-perfect-scrollbar
        class="scroll"
        :settings="{ suppressScrollX: true, wheelPropagation: false }"
      >
        <ul
          class="list-unstyled"
          data-link="account"
          :class="{'d-block':selectedParentMenu==='account' }"
        >
          <router-link tag="li" v-if="this.$isNotSuperAdmin()" to="/app/account/profile">
            <a>
              <i class="simple-icon-user"></i>Profile
            </a>
          </router-link>
          <router-link tag="li" to="/app/account/change-password">
            <a>
              <i class="iconsminds-security-check"></i>Change password
            </a>
          </router-link>
          <router-link tag="li" v-if="this.$isCompanyAdmin()" to="/app/account/subscriptions">
            <a>
              <i class="iconsminds-man-sign"></i>Manage Subscription
            </a>
          </router-link>
        </ul>

        <ul
          class="list-unstyled"
          data-link="users"
          :class="{'d-block':selectedParentMenu==='users' }"
        >
          <router-link v-if="this.$isSuperAdmin()" tag="li" to="/app/users/companies">
            <a>
              <i class="simple-icon-user-follow"></i>Companies
            </a>
          </router-link>
          <router-link
            v-if="this.$isNotSuperAdmin() && this.$isNotStaff()"
            tag="li"
            to="/app/users/invite"
          >
            <a>
              <i class="simple-icon-user-follow"></i>Invite
            </a>
          </router-link>
          <router-link v-if="this.$isCompanyAdmin()" tag="li" to="/app/users/editors">
            <a>
              <i class="simple-icon-user-following"></i>Company editors
            </a>
          </router-link>
          <router-link v-if="this.$isCompanyAdmin()" tag="li" to="/app/users/contractors">
            <a>
              <i class="iconsminds-business-man"></i>Contractors
            </a>
          </router-link>
          <router-link v-if="this.$isCompanyAdmin()" tag="li" to="/app/users/site-admins">
            <a>
              <i class="simple-icon-user"></i>Customer admins
            </a>
          </router-link>
          <router-link v-if="this.$isSiteAdmin()" tag="li" to="/app/users/site-staff">
            <a>
              <i class="simple-icon-user"></i>Site staff
            </a>
          </router-link>
          <router-link v-if="this.$isContractorAdmin()" tag="li" to="/app/users/contractor-staff">
            <a>
              <i class="iconsminds-business-man"></i>Contractor staff
            </a>
          </router-link>
        </ul>
      </vue-perfect-scrollbar>
    </div>
  </div>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";
import { menuHiddenBreakpoint, subHiddenBreakpoint } from "@/constants/config";

export default {
  data() {
    return {
      selectedParentMenu: "",
      isMenuOver: false
    };
  },
  mounted() {
    this.selectMenu();
    window.addEventListener("resize", this.handleWindowResize);
    document.addEventListener("click", this.returnSelectedMenu);
    this.handleWindowResize();
  },
  beforeDestroy() {
    document.removeEventListener("click", this.returnSelectedMenu);
    window.removeEventListener("resize", this.handleWindowResize);
  },

  methods: {
    ...mapMutations([
      "changeSideMenuStatus",
      "addMenuClassname",
      "changeSelectedMenuHasSubItems"
    ]),
    selectMenu() {
      const currentParentUrl = this.$route.path
        .split("/")
        .filter(x => x !== "")[1];
      if (currentParentUrl !== undefined || currentParentUrl !== null) {
        this.selectedParentMenu = currentParentUrl.toLowerCase();
      } else {
        this.selectedParentMenu = "dashboards";
      }
    },
    changeSelectedParentHasNoSubmenu(parentMenu) {
      this.selectedParentMenu = parentMenu;
      this.changeSelectedMenuHasSubItems(false);
      this.changeSideMenuStatus({ step: 0, classNames: this.menuType });
    },
    openSubMenu(e, selectedParent) {
      this.changeSelectedMenuHasSubItems(true);

      const currentClasses = this.menuType
        ? this.menuType.split(" ").filter(x => x !== "")
        : "";

      if (!currentClasses.includes("menu-mobile")) {
        if (
          currentClasses.includes("menu-sub-hidden") &&
          (this.menuClickCount === 2 || this.menuClickCount === 0)
        ) {
          this.changeSideMenuStatus({ step: 3, classNames: this.menuType });
        } else if (
          currentClasses.includes("menu-hidden") &&
          (this.menuClickCount === 1 || this.menuClickCount === 3)
        ) {
          this.changeSideMenuStatus({ step: 2, classNames: this.menuType });
        } else if (
          currentClasses.includes("menu-default") &&
          !currentClasses.includes("menu-sub-hidden") &&
          (this.menuClickCount === 1 || this.menuClickCount === 3)
        ) {
          this.changeSideMenuStatus({ step: 0, classNames: this.menuType });
        }
      } else {
        this.addMenuClassname({
          classname: "sub-show-temporary",
          currentClasses: this.menuType
        });
      }
      this.selectedParentMenu = selectedParent;
    },
    addEvents() {
      document.addEventListener("click", this.handleDocumentClick);
    },
    removeEvents() {
      document.removeEventListener("click", this.handleDocumentClick);
    },
    returnSelectedMenu() {
      if (!this.isMenuOver) {
        this.selectMenu();
      }
    },
    handleDocumentClick(e) {
      if (!this.isMenuOver) {
        let cont = true;
        e.path.map(p => {
          if (
            p.nodeName !== "svg" &&
            p.className !== undefined &&
            p.className.indexOf("menu-button") > -1
          ) {
            cont = false;
          }
        });
        if (cont) {
          this.toggle();
        }
      }
    },
    toggle() {
      const currentClasses = this.menuType.split(" ").filter(x => x !== "");
      if (
        currentClasses.includes("menu-sub-hidden") &&
        this.menuClickCount === 3
      ) {
        this.changeSideMenuStatus({ step: 2, classNames: this.menuType });
      } else if (
        currentClasses.includes("menu-hidden") ||
        currentClasses.includes("menu-mobile")
      ) {
        this.changeSideMenuStatus({ step: 0, classNames: this.menuType });
      }
    },
    // Resize
    handleWindowResize(event) {
      if (event && !event.isTrusted) {
        return;
      }
      let nextClasses = this.getMenuClassesForResize(this.menuType);
      this.changeSideMenuStatus({ step: 0, classNames: nextClasses.join(" ") });
    },
    getMenuClassesForResize(classes) {
      let nextClasses = classes.split(" ").filter(x => x !== "");
      const windowWidth = window.innerWidth;

      if (windowWidth < menuHiddenBreakpoint) {
        nextClasses.push("menu-mobile");
      } else if (windowWidth < subHiddenBreakpoint) {
        nextClasses = nextClasses.filter(x => x !== "menu-mobile");
        if (
          nextClasses.includes("menu-default") &&
          !nextClasses.includes("menu-sub-hidden")
        ) {
          nextClasses.push("menu-sub-hidden");
        }
      } else {
        nextClasses = nextClasses.filter(x => x !== "menu-mobile");
        if (
          nextClasses.includes("menu-default") &&
          nextClasses.includes("menu-sub-hidden")
        ) {
          nextClasses = nextClasses.filter(x => x !== "menu-sub-hidden");
        }
      }
      return nextClasses;
    },
    // Change Default Menu Type
    changeDefaultMenuType(containerClassnames) {
      let nextClasses = this.getMenuClassesForResize(containerClassnames);
      this.changeSideMenuStatus({ step: 0, classNames: nextClasses.join(" ") });
    }
  },
  computed: {
    ...mapGetters({
      menuType: "getMenuType",
      menuClickCount: "getMenuClickCount",
      selectedMenuHasSubItems: "getSelectedMenuHasSubItems"
    })
  },
  watch: {
    menuType: function(val) {
      if (val.indexOf("show-temporary") > -1) {
        this.addEvents();
      } else {
        this.removeEvents();
      }
    },
    $route(to, from) {
      if (to.path !== from.path) {
        this.changeSideMenuStatus({ step: 0, classNames: this.menuType });
        this.selectMenu();
        window.scrollTo(0, top);
      }
    }
  }
};
</script>
