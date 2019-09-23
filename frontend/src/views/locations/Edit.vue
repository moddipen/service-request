<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update location" />
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
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Update</b-button>
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
        id: 0,
        street: "",
        city: "",
        postal_code: "",
        email: "",
        phone_number: ""
      }
    };
  },
  created() {
    this.form.id = this.$route.params.id;
    let location = this.$store.getters.getLocationById(this.$route.params.id);
    if (!location.email) {
      this.$router.push("/404");
    }
    this.form.email = location.email;
    this.form.street = location.street;
    this.form.city = location.city;
    this.form.postal_code = location.postal_code;
    this.form.phone_number = location.phone_number;
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
      this.$store
        .dispatch("updateLocationRequest", { ...this.form })
        .then(() => {
          this.$router.push("/app/locations");
        });
    }
  }
};
</script>