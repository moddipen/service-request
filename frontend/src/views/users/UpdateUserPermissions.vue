<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update user permissions" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title>
          <b-row>
            <b-colxx xxs="8">
              <h5>
                <b>{{ user.profile.name }}</b>
              </h5>
            </b-colxx>
            <b-colxx xxs="3">
              <b-button class="mb-1" variant="success" v-on:click="updatePermissions()">Update</b-button>
            </b-colxx>
          </b-row>
          <br />
          <b-form>
            <b-row class="mb-3">
              <b-colxx xxs="6">
                <b-row v-for="(permi, index) in permissions" :key="index">
                  <b-colxx xxs="6">
                    <h6>{{ _.capitalize(permi.name) }}</h6>
                  </b-colxx>
                  <b-colxx xxs="4">
                    <switches
                      v-model="permission[permi.id]"
                      :id="permi.id"
                      :value="permi.id"
                      theme="custom"
                      color="primary"
                    ></switches>
                  </b-colxx>
                </b-row>
              </b-colxx>
            </b-row>
          </b-form>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import Switches from "vue-switches";
export default {
  components: {
    Switches
  },
  data() {
    return {
      permissions: [],
      permission: [],
      id: 0,
      type: "",
      user: {}
    };
  },
  created() {
    this.id = this.$route.params.id;
    this.type = this.$route.params.type;
    if (this.type === "editor") {
      this.user = this.$store.getters.getEditorById(this.$route.params.id);
    } else if (this.type === "contractor") {
      this.user = this.$store.getters.getContractorById(this.$route.params.id);
    } else if (this.type === "site-admin") {
      this.user = this.$store.getters.getSiteAdminById(this.$route.params.id);
    } else if (this.type === "site-staff") {
      this.user = this.$store.getters.getSiteStaffById(this.$route.params.id);
    } else if (this.type === "contractor-staff") {
      this.user = this.$store.getters.getContractorStaffById(
        this.$route.params.id
      );
    } else {
      this.$router.push("/404");
    }
    if (!this.user.profile) {
      this.$router.push("/404");
    }
    this.permissions = this.$store.getters.getPermissions;
    this.setPermissions();
  },
  methods: {
    setPermissions() {
      this.permissions.map(perm => {
        this.permission[perm.id] =
          this.user.permission.indexOf(perm.name) !== -1 ? true : false;
      });
    },
    updatePermissions() {
      const check = k => this.permission[k] === true;
      let lastPermissions = [];
      this.permissions.map(perm => {
        if (check(perm.id)) {
          lastPermissions.push(perm.id);
        }
      });

      this.$store
        .dispatch("updateUserPermissionsRequest", {
          id: this.id,
          permissions: lastPermissions,
          type: this.type
        })
        .then(() => {
          if (this.type == "site-staff" || this.type == "contractor-staff") {
            this.$router.push("/app/users/" + this.type);
          } else {
            this.$router.push("/app/users/" + this.type + "s");
          }
        });
    }
  }
};
</script>