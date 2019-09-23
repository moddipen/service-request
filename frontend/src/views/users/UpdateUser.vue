<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update user details" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title="Update Profile">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.name" :v="$v.form.name" label="Name" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.phone" :v="$v.form.phone" label="Phone" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="text"
                v-model="form.company_name"
                :v="$v.form.company_name"
                label="Company name"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <label for="Website">Website</label>
              <input type="text" v-model="form.website" class="form-control" autocomplete="off" />
            </label>
            <label class="form-group has-float-label mb-4">
              <text-area-component v-model="form.address" :v="$v.form.address" label="Address" />
            </label>
            <b-row>
              <b-colxx xxs="12">
                <label>Active status</label>
              </b-colxx>
              <b-colxx xxs="12">
                <switches v-model="form.status" theme="custom" color="primary"></switches>
              </b-colxx>
            </b-row>
            <br />
            <div class="d-flex align-items-center">
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Update</b-button>
            </div>
          </b-form>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import Switches from "vue-switches";
import { required, minLength, numeric } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
import TextAreaComponent from "../partials/forms/TextAreaComponent";
export default {
  components: {
    Switches,
    InputComponent,
    TextAreaComponent
  },
  data() {
    return {
      user: {},
      form: {
        type: "",
        id: 0,
        email: "",
        name: "",
        address: "",
        company_name: "",
        website: "",
        phone: "",
        status: false
      }
    };
  },
  created() {
    this.form.id = this.$route.params.id;
    this.form.type = this.$route.params.type;
    if (this.form.type === "editor") {
      this.user = this.$store.getters.getEditorById(this.$route.params.id);
    } else if (this.form.type === "contractor") {
      this.user = this.$store.getters.getContractorById(this.$route.params.id);
    } else if (this.form.type === "site-admin") {
      this.user = this.$store.getters.getSiteAdminById(this.$route.params.id);
    } else if (this.form.type === "site-staff") {
      this.user = this.$store.getters.getSiteStaffById(this.$route.params.id);
    } else if (this.form.type === "contractor-staff") {
      this.user = this.$store.getters.getContractorStaffById(
        this.$route.params.id
      );
    } else {
      this.$router.push("/404");
    }
    if (!this.user.profile) {
      this.$router.push("/404");
    }
    this.form.email = this.user.email;
    this.form.name = this.user.profile.name;
    this.form.address = this.user.profile.address;
    this.form.company_name = this.user.profile.company_name;
    this.form.website = this.user.profile.website;
    this.form.phone = this.user.profile.phone;
    this.form.status =
      this.user.status === 1 || this.user.status === "1" ? true : false;
  },
  validations: {
    form: {
      name: { required },
      phone: { required, numeric },
      address: { required },
      company_name: {}
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store.dispatch("updateUserRequest", { ...this.form }).then(() => {
        if (
          this.form.type == "site-staff" ||
          this.form.type == "contractor-staff"
        ) {
          this.$router.push("/app/users/" + this.form.type);
        } else {
          this.$router.push("/app/users/" + this.form.type + "s");
        }
      });
    }
  }
};
</script>