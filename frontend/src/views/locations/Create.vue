<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Add Location" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component
                type="text"
                v-model="form.street"
                :v="$v.form.street"
                label="Street"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.city" :v="$v.form.city" label="City" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="text"
                v-model="form.postal_code"
                :v="$v.form.postal_code"
                label="Postal code / ZIP code"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.email" :v="$v.form.email" label="Email" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                type="text"
                v-model="form.phone_number"
                :v="$v.form.phone_number"
                label="Phone number"
              />
            </label>
            <div class="d-flex align-items-center">
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Add</b-button>
            </div>
          </b-form>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import { required, numeric, email } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        street: "",
        city: "",
        postal_code: "",
        email: "",
        phone_number: ""
      }
    };
  },
  created() {
    let profile = this.$store.getters.getProfile;
    this.form.email = profile.email;
    this.form.phone_number = profile.phone;
  },
  validations: {
    form: {
      street: { required },
      phone_number: { required, numeric },
      postal_code: { required },
      city: { required },
      email: { required, email }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store.dispatch("addLocationRequest", { ...this.form }).then(() => {
        this.$router.push("/app/locations");
      });
    }
  }
};
</script>