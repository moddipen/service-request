<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update company permissions" />
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
      pid: 0,
      type: "company",
      user: {}
    };
  },
  created() {
    this.id = this.$route.params.id;
    this.user = this.$store.getters.getCompanyById(this.$route.params.id);
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
        .dispatch("updateCompanyPermissionsRequest", {
          id: this.id,
          pid: this.pid,
          permissions: lastPermissions,
          type: "companies"
        })
        .then(() => {
          this.$router.push("/app/users/companies");
        });
    }
  }
};
</script>