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
              <label for="company_name">Purchase Order</label>
              <input
                type="text"
                v-model="form.purchase_order"
                :v="$v.form.purchase_order"
                class="form-control"
                autocomplete="off"
              />
            </label>

            <div class="form-group has-float-label">
              <select-component
                :options="locations"
                v-model="form.location"
                :v="$v.form.location"
                label="Location"
              />
            </div>

            <div class="form-group has-float-label">
              <select-component
                :options="priorities"
                v-model="form.priority"
                :v="$v.form.priority"
                label="Priority"
              />
            </div>

            <label>Images:</label>
            <vue-upload-multiple-image
              @upload-success="uploadImageSuccess"
              @before-remove="beforeRemove"
              @edit-image="editImage"
              :data-images="images"
              idUpload="myIdUpload"
              editUpload="myIdEdit"
              dragText="Drag or browse"
              dropText="Drop here"
              popupText="Upload service request photos"
              browseText
              primaryText
              :maxImage="maxImage"
              markIsPrimaryText
            ></vue-upload-multiple-image>

            <!-- <b-row>
              <b-colxx xxs="12">
                <label>Quote required</label>
              </b-colxx>
              <b-colxx xxs="12">
                <switches v-model="form.quote_required" theme="custom" color="primary"></switches>
              </b-colxx>
            </b-row>-->
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
import InputTag from "@/components/Form/InputTag";
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import VueGallery from "vue-gallery";
import VueUploadMultipleImage from "vue-upload-multiple-image";

export default {
  components: {
    gallery: VueGallery,
    VueUploadMultipleImage,
    InputComponent,
    TextAreaComponent,
    SelectComponent,
    Switches,
    InputTag,
    vSelect
  },
  data() {
    return {
      photosForm: {
        images: []
      },
      maxImage: 20,
      workOrder: {},
      locations: [],
      priorities: [],
      images: [],
      form: {
        id: 0,
        service_request_id: "",
        purchase_order: "",
        title: "",
        description: "",
        quote_required: true,
        location: {},
        images: this.images
      }
    };
  },
  created() {
    this.priorities = this.$store.getters.getPriority.map(priority => {
      return {
        label: priority.name + " ( " + priority.description + " ) ",
        value: priority.id
      };
    });

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

    //  console.log("images", this.workOrder.images);
    this.images = this.workOrder.images.map(photo => {
      return {
        path: photo.path
      };
    });

    this.form.title = this.workOrder.title;
    this.form.purchase_order = this.workOrder.purchase_order_number;
    this.form.description = this.workOrder.description;
    this.form.priority = {
      label: this.workOrder.priority.name,
      value: this.workOrder.priority.id
    };
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
      purchase_order: {},
      priority: { required }
    }
  },
  methods: {
    uploadImageSuccess(formData, index, fileList) {
      this.form.images = fileList;
    },
    beforeRemove(index, done, fileList) {
      this.form.images = fileList;
      done();
    },
    editImage(formData, index, fileList) {
      this.form.images = fileList;
    },
    uploadNewImageSuccess(formData, index, fileList) {
      this.photosForm.images = fileList;
    },
    beforeNewRemove(index, done, fileList) {
      this.photosForm.images = fileList;
      done();
    },
    editNewImage(formData, index, fileList) {
      this.photosForm.images = fileList;
    },
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