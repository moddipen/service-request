<template>
  <nav class="navbar fixed-top">
    <a
      href="#"
      class="menu-button d-none d-md-block"
      @click.prevent="changeSideMenuStatus({step :menuClickCount+1,classNames:menuType})"
    >
      <menu-icon />
    </a>
    <a
      href="#"
      class="menu-button-mobile d-xs-block d-sm-block d-md-none"
      @click.prevent="changeSideMenuForMobile(menuType)"
    >
      <mobile-menu-icon />
    </a>
    <div
      :class="{'search':true, 'mobile-view':isMobileSearch}"
      ref="searchContainer"
      @mouseenter="isSearchOver=true"
      @mouseleave="isSearchOver=false"
    >
      <b-input
        :placeholder="$t('menu.search')"
        @keypress.native.enter="search"
        v-model="searchKeyword"
      />
      <span class="search-icon">
        <i class="simple-icon-magnifier"></i>
      </span>
    </div>
    <router-link class="navbar-logo" tag="a" to="/">
      <h2>ServiceRequest</h2>
      <!-- <span class="logo d-none d-xs-block"></span>
      <span class="logo-mobile d-block d-xs-none"></span>-->
    </router-link>
    <div class="ml-auto">
      <div class="header-icons d-inline-block align-middle">
        <b-button
          variant="empty"
          class="header-icon d-none d-sm-inline-block"
          @click="toggleFullScreen"
        >
          <i
            :class="{'d-block':true,'simple-icon-size-actual':fullScreen,'simple-icon-size-fullscreen':!fullScreen }"
          />
        </b-button>
      </div>
      <div class="user d-inline-block">
        <b-dropdown
          class="dropdown-menu-right"
          right
          variant="empty"
          toggle-class="p-0"
          menu-class="mt-3"
          no-caret
        >
          <template slot="button-content">
            <span class="name mr-1">{{ this.$store.getters.getProfile.name }}</span>
            <span>
              <img v-if="this.$isSuperAdmin()" alt="Admin" src="/assets/img/profile-pic-l-4.jpg" />
              <img
                v-else-if="this.$store.getters.getProfile.photo == ''"
                alt="User"
                src="/assets/img/profile-pic-l-4.jpg"
              />
              <img v-else alt="User" :src="this.$store.getters.getProfile.photo" />
            </span>
          </template>
          <b-dropdown-item v-if="this.$isNotSuperAdmin()">
            <router-link tag="span" to="/app/account/profile">Profile</router-link>
          </b-dropdown-item>
          <b-dropdown-item>
            <router-link tag="span" to="/app/account/change-password">Change Password</router-link>
          </b-dropdown-item>
          <b-dropdown-divider />
          <b-dropdown-item @click="logout">Sign out</b-dropdown-item>
        </b-dropdown>
      </div>
    </div>
  </nav>
</template>
<script>
import { mapGetters, mapMutations, mapActions } from "vuex";
import { MenuIcon, MobileMenuIcon } from "@/components/Svg";
import notifications from "@/data/notifications";
import {
  searchPath,
  menuHiddenBreakpoint,
  localeOptions,
  buyUrl
} from "@/constants/config";

export default {
  components: {
    MenuIcon,
    MobileMenuIcon
  },
  data() {
    return {
      selectedParentMenu: "",
      searchKeyword: "",
      isMobileSearch: false,
      isSearchOver: false,
      fullScreen: false,
      menuHiddenBreakpoint,
      searchPath,
      localeOptions,
      buyUrl,
      notifications
    };
  },
  methods: {
    ...mapMutations(["changeSideMenuStatus", "changeSideMenuForMobile"]),
    ...mapActions(["setLang", "signOut"]),
    search() {
      this.$router.push(`${this.searchPath}?search=${this.searchKeyword}`);
      this.searchKeyword = "";
    },
    searchClick() {
      if (window.innerWidth < this.menuHiddenBreakpoint) {
        if (!this.isMobileSearch) {
          this.isMobileSearch = true;
        } else {
          this.search();
          this.isMobileSearch = false;
        }
      } else {
        this.search();
      }
    },
    handleDocumentforMobileSearch() {
      if (!this.isSearchOver) {
        this.isMobileSearch = false;
        this.searchKeyword = "";
      }
    },
    changeLocale(locale) {
      this.setLang(locale);
    },
    logout() {
      this.$store.dispatch("authLogout", {}).then(() => {
        this.$router.push("/user");
        // location.reload();
      });
    },
    toggleFullScreen() {
      const isInFullScreen = this.isInFullScreen();

      var docElm = document.documentElement;
      if (!isInFullScreen) {
        if (docElm.requestFullscreen) {
          docElm.requestFullscreen();
        } else if (docElm.mozRequestFullScreen) {
          docElm.mozRequestFullScreen();
        } else if (docElm.webkitRequestFullScreen) {
          docElm.webkitRequestFullScreen();
        } else if (docElm.msRequestFullscreen) {
          docElm.msRequestFullscreen();
        }
      } else {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
          document.webkitExitFullscreen();
        } else if (document.mozCancelFullScreen) {
          document.mozCancelFullScreen();
        } else if (document.msExitFullscreen) {
          document.msExitFullscreen();
        }
      }
      this.fullScreen = !isInFullScreen;
    },
    isInFullScreen() {
      return (
        (document.fullscreenElement && document.fullscreenElement !== null) ||
        (document.webkitFullscreenElement &&
          document.webkitFullscreenElement !== null) ||
        (document.mozFullScreenElement &&
          document.mozFullScreenElement !== null) ||
        (document.msFullscreenElement && document.msFullscreenElement !== null)
      );
    }
  },
  computed: {
    ...mapGetters({
      menuType: "getMenuType",
      menuClickCount: "getMenuClickCount"
    })
  },
  beforeDestroy() {
    document.removeEventListener("click", this.handleDocumentforMobileSearch);
  },
  watch: {
    "$i18n.locale"(to, from) {
      if (from !== to) {
        this.$router.go(this.$route.path);
      }
    },
    isMobileSearch(val) {
      if (val) {
        document.addEventListener("click", this.handleDocumentforMobileSearch);
      } else {
        document.removeEventListener(
          "click",
          this.handleDocumentforMobileSearch
        );
      }
    }
  }
};
</script>
