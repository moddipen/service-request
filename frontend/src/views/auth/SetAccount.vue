<template>
  <b-row class="h-100">
    <b-colxx xxs="12" md="10" class="mx-auto my-auto">
      <b-card class="auth-card" no-body>
        <div class="position-relative image-side">
          <p class="text-white h2">Set your account details</p>
          <p class="white mb-0"></p>
        </div>
        <div class="form-side">
          <router-link tag="a" to="/">
            <h2 class="logo-text">Service Request</h2>
            <!-- <span class="logo-single" /> -->
          </router-link>
          <h6 class="mb-4">Create Account</h6>
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.name" :v="$v.form.name" label="Name" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.phone" :v="$v.form.phone" label="Phone" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="password"
                v-model="form.password"
                :v="$v.form.password"
                label="Password"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="password"
                v-model="form.confirmPassword"
                :v="$v.form.confirmPassword"
                label="Confirm Password"
              />
            </label>
            <div class="d-flex justify-content-end align-items-center">
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Save</b-button>
            </div>
          </b-form>
        </div>
      </b-card>
    </b-colxx>
  </b-row>
</template>
<script>
import { required, sameAs, minLength, numeric } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        token: "",
        name: "",
        phone: "",
        password: "",
        confirmPassword: ""
      }
    };
  },
  created() {
    this.form.token = this.$route.params.token;
  },
  validations: {
    form: {
      name: { required },
      phone: { required, numeric },
      password: { required, minLength: minLength(6) },
      confirmPassword: { sameAsPassword: sameAs("password") }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;

      this.$store.dispatch("setAccountRequest", { ...this.form }).then(() => {
        this.$router.push("/user");
      });
    }
  }
};
</script>