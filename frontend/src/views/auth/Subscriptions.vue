<template>
  <div class="subscription-body">
    <br />
    <br />
    <h2 style="text-align:center">Select subscription plan and signup</h2>
    <br />
    <div v-for="plan in plans" :key="plan.id" class="columns-custom">
      <ul class="price">
        <li v-if="plan.id === 2" class="header" style="background-color:#4CAF50">{{ plan.name }}</li>
        <li v-else class="header">{{ plan.name }}</li>
        <li class="grey" v-if="plan.id === 1">$ {{ plan.amount }}</li>
        <li class="grey" v-else-if="plan.id === 2">$ {{ plan.amount }} / month</li>
        <li class="grey" v-else>$ {{ plan.amount }} / year</li>
        <li>{{ plan.users }} Users</li>
        <li>{{ plan.work_orders }} Work order per month</li>
        <li class="grey">
          <b-button
            variant="primary"
            @click="selectPlan(plan.id, plan.name)"
            v-b-modal.modalbasic
            size="lg"
            class="btn-shadow"
          >Select</b-button>
        </li>
      </ul>
    </div>
    <b-modal
      id="modalbasic"
      ref="modalbasic"
      size="lg"
      :title="title"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="signUpForm">
        <label class="form-group has-float-label mb-4">
          <input-component v-model="form.name" :v="$v.form.name" label="Name" />
        </label>
        <label class="form-group has-float-label mb-4">
          <input-component v-model="form.email" :v="$v.form.email" label="Email" />
        </label>
        <label class="form-group has-float-label mb-4">
          <input-component v-model="form.phone" :v="$v.form.phone" label="Phone" />
        </label>
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
        <label class="form-group has-float-label">
          <card
            class="form-control"
            :class="{ complete }"
            :stripe="stripeKey"
            :options="stripeOptions"
            @change="updateCard($event)"
          />
          <span style="color: red;">{{ stripeError }}</span>
          <span>Card details</span>
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="formSubmit()" class="mr-1">Sign Up</b-button>
        <b-button variant="secondary" @click="hideModal('modalbasic')">Cancel</b-button>
      </template>
    </b-modal>
  </div>
</template>
<script>
import { Card, createToken } from "vue-stripe-elements-plus";
import {
  required,
  email,
  minLength,
  sameAs,
  numeric
} from "vuelidate/lib/validators";
import InputComponent from "../partials/forms/InputComponent";
export default {
  components: { InputComponent, Card, createToken },
  data() {
    return {
      plans: this.$store.getters.getPlans,
      selectedBackdrop: "false",
      backdropOptions: ["true", "false", "static"],
      stripeKey: this.$store.getters.getContants.stripe,
      title: "",
      form: {
        plan: "",
        token: "",
        name: "",
        phone: "",
        email: "",
        password: "",
        confirmPassword: ""
      },
      complete: false,
      stripeOptions: {
        // see https://stripe.com/docs/stripe.js#element-options for details
      },
      stripeError: ""
    };
  },
  validations: {
    form: {
      name: { required },
      phone: { required, numeric },
      email: { required, email },
      password: { required, minLength: minLength(6) },
      confirmPassword: { sameAsPassword: sameAs("password") }
    }
  },
  methods: {
    hideModal(refname) {
      this.$refs[refname].hide();
      this.$v.$reset();
    },
    selectPlan(planId, planName) {
      this.title = "Create your account with " + planName + " plan";
      this.form.plan = planId;
    },
    updateCard($event) {
      this.complete = $event.complete;
      if (!this.complete) {
        this.stripeError = "Enter valid card details";
      } else {
        this.stripeError = "";
      }
    },
    formSubmit() {
      this.$v.form.$touch();
      if (this.$v.form.$pending || this.$v.form.$error || !this.complete)
        return;

      createToken().then(data => {
        this.form.token = data.token.id;
        this.$store.dispatch("signupRequest", { ...this.form }).then(() => {
          this.$router.push("/");
        });
      });
    }
  }
};
</script>