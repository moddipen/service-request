<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Change Password" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title="Change Password">
          <b-form @submit.prevent="formSubmit">
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
            <div class="d-flex align-items-center">
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Change</b-button>
            </div>
          </b-form>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import { required, sameAs, minLength } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        password: "",
        confirmPassword: ""
      }
    };
  },
  validations: {
    form: {
      password: { required, minLength: minLength(6) },
      confirmPassword: { sameAsPassword: sameAs("password") }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("changePasswordRequest", { ...this.form })
        .then(() => {
          // this.$router.push("/");
          this.form.confirmPassword = "";
          this.form.password = "";
          this.$v.$reset();
        });
    }
  }
};
</script>