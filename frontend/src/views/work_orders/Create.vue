<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Create Service Request" />
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
              :data-images="form.images"
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
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import InputTag from "@/components/Form/InputTag";
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
      locations: [],
      form: {
        title: "",
        purchase_order: "",
        description: "",
        quote_required: true,
        location: {},
        priorities: [],
        images: []
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
    this.priorities = this.$store.getters.getPriority.map(priority => {
      return {
        label: priority.name + " ( " + priority.description + " ) ",
        value: priority.id
      };
    });
  },
  validations: {
    form: {
      title: { required },
      description: { required },
      purchase_order: {},
      location: { required },
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
      this.$store.dispatch("addWorkOrderRequest", { ...this.form }).then(() => {
        this.$router.push("/app/work-orders");
      });
    }
  }
};
</script>