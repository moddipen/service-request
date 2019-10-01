<template>
  <b-row class="h-100">
    <b-colxx xxs="12" md="6" class="mx-auto my-auto">
      <b-card class="auth-card" no-body>
        <!-- <div class="position-relative image-side">
          <p class="white mb-0">
            Please use this form to register.
            <br />If you are a member, please
            <router-link tag="a" to="/user/login" class="white">LOGIN</router-link>.
          </p>
        </div>-->
        <div class="form-side">
          <router-link tag="a" to="/">
            <h2 class="logo-text">Service Request</h2>
            <!-- <span class="logo-single" /> -->
          </router-link>
          <h6 class="mb-4">{{ $t('user.register')}}</h6>
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component v-model="form.name" :v="$v.form.name" label="Name" />
            </label>
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
            <label class="form-group has-float-label mb-4">
              <input-component
                type="password"
                v-model="form.confirmPassword"
                :v="$v.form.confirmPassword"
                label="Confirm Password"
              />
            </label>
            <div class="d-flex justify-content-end align-items-center">
              <b-button
                type="submit"
                variant="primary"
                size="lg"
                class="btn-shadow"
              >{{ $t('user.register-button')}}</b-button>
            </div>
          </b-form>
        </div>
      </b-card>
    </b-colxx>
  </b-row>
</template>
<script>
import { required, email, minLength, sameAs } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        name: "",
        email: "",
        password: "",
        confirmPassword: ""
      }
    };
  },
  validations: {
    form: {
      name: { required },
      email: { required, email },
      password: { required, minLength: minLength(6) },
      confirmPassword: { sameAsPassword: sameAs("password") }
    }
  },
  methods: {
    formSubmit() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;

      this.$store.dispatch("signupRequest", { ...this.form }).then(() => {
        this.$router.push("/");
      });
    }
  }
};
</script>
