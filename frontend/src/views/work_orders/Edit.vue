<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update service request" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component
                v-model="form.service_request_id"
                :v="$v.form.service_request_id"
                disabled="true"
                label="Service Request"
              />
            </label>
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
import TextAreaComponent from "../partials/forms/TextAreaComponent";
import SelectComponent from "../partials/forms/SelectComponent";
import Switches from "vue-switches";
export default {
  components: { InputComponent, TextAreaComponent, SelectComponent, Switches },
  data() {
    return {
      workOrder: {},
      locations: [],
      form: {
        id: 0,
        service_request_id: "",
        purchase_order: "",
        title: "",
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
    this.form.id = this.$route.params.id;
    this.workOrder = this.$store.getters.getWorkOrderById(this.form.id);
    this.form.title = this.workOrder.title;
    this.form.purchase_order = this.workOrder.purchase_order_number;
    this.form.description = this.workOrder.description;
    this.form.location = {
      label:
        this.workOrder.location.street +
        ", " +
        this.workOrder.location.city +
        "-" +
        this.workOrder.location.postal_code,
      value: this.workOrder.location.id
    };
    this.form.service_request_id = this.workOrder.service_request_id;
    this.form.quote_required =
      this.workOrder.quote_required === 1 ||
      this.workOrder.quote_required === "1"
        ? true
        : false;
  },
  validations: {
    form: {
      title: { required },
      description: { required },
      location: { required },
      service_request_id: {},
      purchase_order: {}
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("updateWorkOrderRequest", { ...this.form })
        .then(() => {
          this.$router.push("/app/work-orders");
        });
    }
  }
};
</script>