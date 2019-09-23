<template>
  <b-row class="h-100">
    <b-colxx xxs="12" md="10" class="mx-auto my-auto">
      <b-card class="auth-card" no-body>
        <div class="position-relative image-side">
          <!-- <p class="text-white h2">{{ $t('dashboards.magic-is-in-the-details') }}</p> -->
          <p class="white mb-0">
            Please use your email to reset your password.
            <br />If you are not a member, please
            <router-link tag="a" to="/user/register" class="white">REGISTER</router-link>.
          </p>
        </div>
        <div class="form-side">
          <router-link tag="a" to="/">
            <h2 class="logo-text">Service Request</h2>
            <!-- <span class="logo-single" /> -->
          </router-link>
          <h6 class="mb-4">{{ $t('user.forgot-password')}}</h6>
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-8">
              <input-component v-model="form.email" :v="$v.form.email" label="Email" />
            </label>
            <div class="d-flex align-items-center">
              <router-link tag="a" to="/user/login">Already have login and password?</router-link>
            </div>
            <div class="d-flex justify-content-end align-items-center">
              <b-button
                type="submit"
                variant="primary"
                size="lg"
                class="btn-shadow"
              >{{ $t('user.reset-password-button')}}</b-button>
            </div>
          </b-form>
        </div>
      </b-card>
    </b-colxx>
  </b-row>
</template>
<script>
import { required, email } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        email: ""
      }
    };
  },
  validations: {
    form: {
      email: { required, email }
    }
  },
  methods: {
    formSubmit() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("forgetPasswordRequest", { ...this.form })
        .then(() => {
          this.$router.push("/");
        });
    }
  }
};
</script>
