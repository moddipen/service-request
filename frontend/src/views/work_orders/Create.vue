<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Create service request" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component v-model="form.title" :v="$v.form.title" label="Title" />
            </label>
            <label class="form-group has-float-label mb-4">
              <text-area-component
                v-model="form.description"
                :v="$v.form.description"
                label="Descriptions"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component
                v-model="form.purchase_order"
                :v="$v.form.purchase_order"
                label="Purchase order"
              />
            </label>
            <label class="form-group has-float-label mb-4">
              <select-component
                :options="locations"
                v-model="form.location"
                :v="$v.form.location"
                label="Location"
              />
            </label>
            <b-row>
              <b-colxx xxs="12">
                <label>Quote required</label>
              </b-colxx>
              <b-colxx xxs="12">
                <switches v-model="form.quote_required" theme="custom" color="primary"></switches>
              </b-colxx>
            </b-row>
            <br />
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
import { required } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
import TextAreaComponent from "../partials/forms/TextAreaComponent";
import SelectComponent from "../partials/forms/SelectComponent";
import Switches from "vue-switches";
export default {
  components: { InputComponent, TextAreaComponent, SelectComponent, Switches },
  data() {
    return {
      locations: [],
      form: {
        title: "",
        purchase_order: "",
        description: "",
        quote_required: true,
        location: {}
      }
    };
  },
  created() {
    let locations = this.$store.getters.getLocations.map(location => {
      return {
        label:
          location.street + ", " + location.city + "-" + location.postal_code,
        value: location.id
      };
    });
    this.locations = locations;
  },
  validations: {
    form: {
      title: { required },
      description: { required },
      purchase_order: {},
      location: { required }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store.dispatch("addWorkOrderRequest", { ...this.form }).then(() => {
        this.$router.push("/app/work-orders");
      });
    }
  }
};
</script>