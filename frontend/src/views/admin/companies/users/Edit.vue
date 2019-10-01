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
        <b-card class="mb-4">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.name" :v="$v.form.name" label="Name" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.phone" :v="$v.form.phone" label="Phone" />
            </label>
            <label class="form-group has-float-label mb-4">
              <label for="company_name">Company Name</label>
              <input
                type="text"
                v-model="form.company_name"
                :v="$v.form.company_name"
                class="form-control"
                autocomplete="off"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <label for="company_name">Website</label>
              <input
                type="text"
                v-model="form.website"
                :v="$v.form.website"
                class="form-control"
                autocomplete="off"
              />
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
import InputComponent from "../../../partials/forms/InputComponent";
import TextAreaComponent from "../../../partials/forms/TextAreaComponent";
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
        pid: 0,
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
    this.user = this.$store.getters.getChildById(
      this.$route.params.id,
      this.$route.params.type
    );
    if (!this.user.profile) {
      this.$router.push("/404");
    }
    this.form.email = this.user.email;
    this.form.name = this.user.profile.name;
    this.form.address = this.user.profile.address;
    this.form.company_name = this.user.profile.company_name;
    this.form.website = this.user.profile.website;
    this.form.phone = this.user.profile.phone;
    this.form.pid = this.user.pid;
    this.form.status =
      this.user.status === 1 || this.user.status === "1" ? true : false;
  },
  validations: {
    form: {
      name: { required },
      phone: { required, numeric },
      address: { required },
      company_name: {},
      website: {}
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("updateCompanyRequest", { ...this.form })
        .then(() => {
          this.$router.push(
            "/app/users/companies/" + this.form.pid + "/" + this.form.type
          );
        });
    }
  }
};
</script>