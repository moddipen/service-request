<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Add category" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.name" :v="$v.form.name" label="Name" />
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
import { required } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent },
  data() {
    return {
      form: {
        id: 0,
        name: ""
      }
    };
  },
  created() {
    this.form.id = this.$route.params.id;
    let category = this.$store.getters.getCategoryById(this.$route.params.id);
    this.form.name = category.name;
  },
  validations: {
    form: {
      name: { required }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      this.$store
        .dispatch("updateCategoryRequest", { ...this.form })
        .then(() => {
          this.$router.push("/app/categories");
        });
    }
  }
};
</script>