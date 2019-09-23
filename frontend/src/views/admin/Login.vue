<template>
  <b-row class="h-100">
    <b-colxx xxs="12" md="10" class="mx-auto my-auto">
      <b-card class="auth-card" no-body>
        <div class="position-relative image-side">
          <p class="text-white h2">Admin Login</p>
        </div>
        <div class="form-side">
          <router-link tag="a" to="/">
            <!-- <span class="logo-single" /> -->
            <h2 class="logo-text">Service Request</h2>
          </router-link>
          <h6 class="mb-4">{{ $t('user.login-title')}}</h6>
          <b-form @submit.prevent="login">
            <label class="form-group has-float-label mb-4">
              <input-component v-model="form.email" :v="$v.form.email" label="Email" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="password"
                v-model="form.password"
                :v="$v.form.password"
                label="Password"
              />
            </label>
            <div class="d-flex justify-content-between align-items-center">
              <b-button
                type="submit"
                variant="primary"
                size="lg"
                class="btn-shadow"
              >{{ $t('user.login-button')}}</b-button>
            </div>
          </b-form>
        </div>
      </b-card>
    </b-colxx>
  </b-row>
</template>
<script>
import { required, email, minLength } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      action: "admin",
      form: {
        email: "",
        password: ""
      }
    };
  },
  computed: {
    authErrors() {
      return this.$store.getters.authErrors;
    }
  },
  validations: {
    form: {
      email: { required, email },
      password: { required, minLength: minLength(6) }
    }
  },
  methods: {
    login: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;

      this.$store
        .dispatch("authRequest", { action: this.action, ...this.form })
        .then(() => {
          this.$router.push("/app/work-orders");
        });
    }
  }
};
</script>
