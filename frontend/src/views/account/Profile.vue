<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Update Profile" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title="Update Profile">
          <b-form @submit.prevent="formSubmit">
            <picture-input
              ref="pictureInput"
              @change="onChanged"
              @remove="onRemoved"
              :width="150"
              :removable="true"
              removeButtonClass="btn btn-shadow btn-secondary"
              :height="150"
              :prefill="form.photo"
              accept="image/jpeg, image/png, image/gif"
              buttonClass="btn btn-shadow btn-primary"
              :customStrings="{
                upload: '<h1>Upload it!</h1>',
                drag: 'Upload company logo'}"
            ></picture-input>
            <br />
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.name" :v="$v.form.name" label="Name" />
            </label>
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.phone" :v="$v.form.phone" label="Phone" />
            </label>
            <label class="form-group has-float-label mb-4">
              <label for="company_name">Company Name</label>
              <input
                type="text"
                v-model="form.company_name"
                :v="$v.form.company_name"
                class="form-control"
                autocomplete="off"
              />
            </label>

            <label class="form-group has-float-label mb-4">
              <label for="Website">Website</label>
              <input type="text" v-model="form.website" class="form-control" autocomplete="off" />
            </label>
            <label class="form-group has-float-label mb-4">
              <text-area-component v-model="form.address" :v="$v.form.address" label="Address" />
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
import PictureInput from "vue-picture-input";
import { required, sameAs, minLength, numeric } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
import TextAreaComponent from "../partials/forms/TextAreaComponent";
export default {
  components: { InputComponent, TextAreaComponent, PictureInput },
  data() {
    return {
      form: {
        email: "",
        name: "",
        address: "",
        company_name: "",
        website: "",
        phone: "",
        photo: ""
      }
    };
  },
  created() {
    let profile = this.$store.getters.getProfile;
    this.form.name = profile.name;
    this.form.address = profile.address;
    this.form.company_name =
      profile.company_name == null ? "" : profile.company_name;
    this.form.website = profile.website == null ? "" : profile.website;
    this.form.phone = profile.phone;
    this.form.photo = profile.photo;
  },
  validations: {
    form: {
      name: { required },
      phone: { required, numeric },
      address: { required },
      company_name: {}
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("updateProfileRequest", { ...this.form })
        .then(() => {
          // this.$router.push("/");
        });
    },
    onChanged() {
      if (this.$refs.pictureInput.file) {
        this.form.photo = this.$refs.pictureInput.file;
      } else {
        console.log("Old browser. No support for Filereader API");
      }
    },
    onRemoved() {
      this.form.photo = "";
    }
  }
};
</script>