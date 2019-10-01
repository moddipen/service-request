<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Invite" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title="Invite users">
          <b-form @submit.prevent="formSubmit">
            <label class="form-group has-float-label mb-4">
              <input-component type="text" v-model="form.email" :v="$v.form.email" label="Email" />
            </label>

            <div class="form-group has-float-label">
              <select-component
                :options="options"
                v-model="form.type"
                :v="$v.form.type"
                label="Invite as"
              />
            </div>

            <div class="d-flex align-items-center">
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Invite</b-button>
            </div>
          </b-form>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import InputTag from "@/components/Form/InputTag";
import { required, email } from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
import SelectComponent from "../partials/forms/SelectComponent";
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";

export default {
  components: { InputComponent, SelectComponent, InputTag, vSelect },
  data() {
    return {
      form: {
        email: "",
        type: {}
      },
      options: [
        { label: "Company editor", value: "0" },
        { label: "Contractor admin", value: "1" },
        { label: "Customer admin", value: "3" }
      ]
    };
  },
  created() {
    let role = this.$store.getters.getAuthRole;
    if (role === "Contractor admin") {
      this.options = [{ label: "Contractor staff", value: "2" }];
    } else if (role === "Site admin") {
      this.options = [{ label: "Site staff", value: "4" }];
    }
  },
  validations: {
    form: {
      email: { required, email },
      type: { required }
    }
  },
  methods: {
    formSubmit: function() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error) return;
      console.log(this.form);
      this.$store.dispatch("inviteUserRequest", { ...this.form }).then(() => {
        this.form.email = "";
        this.form.type = "";
        this.$v.$reset();
        console.log("Invited...");
      });
    }
  }
};
</script>