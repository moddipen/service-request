<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Manage subscription" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title="Upgrade plan">
          <div v-for="plan in plans" :key="plan.id" class="columns-custom">
            <ul class="price">
              <li
                v-if="plan.stripe_id === subscription.stripe_plan"
                class="header"
                style="background-color:#4CAF50"
              >{{ plan.name }}</li>
              <li v-else class="header">{{ plan.name }}</li>
              <li class="grey" v-if="plan.id === 1">$ {{ plan.amount }}</li>
              <li class="grey" v-else-if="plan.id === 2">$ {{ plan.amount }} / month</li>
              <li class="grey" v-else>$ {{ plan.amount }} / year</li>
              <li>{{ plan.users }} Users</li>
              <li>{{ plan.work_orders }} Work order per month</li>
              <li v-if="plan.stripe_id !== subscription.stripe_plan" class="grey">
                <b-button
                  variant="primary"
                  @click="upgrade(plan.id)"
                  size="lg"
                  class="btn-shadow white-color"
                >Upgrade</b-button>
              </li>
              <li v-else class="grey">
                <b-button
                  variant="primary"
                  size="lg"
                  class="btn-shadow white-color"
                  disabled
                >Current plan</b-button>
              </li>
            </ul>
          </div>
        </b-card>
        <b-card class="mb-4" title="Manage subscription">
          <div class="columns-manage-custom">
            <p
              v-if="subscription.ends_at !== null"
            >Your plan cancelled on {{subscription.ends_at}}, Click bellow button to resume your subscription.</p>
            <b-button
              size="lg"
              v-if="subscription.ends_at === null"
              class="btn-shadow"
              @click="cancel()"
              variant="secondary"
            >Cancel subscription</b-button>
            <b-button
              size="lg"
              v-else
              class="btn-shadow"
              @click="resume()"
              variant="primary"
            >Resume subscription</b-button>
          </div>
        </b-card>
        <b-card class="mb-8" title="Update card details">
          <div class="columns-card-custom">
            <p>
              Current card is
              <b>{{subscription.card_brand}}</b> and ended with
              <b>{{subscription.card_last_four}}</b>
            </p>
            <br />
            <b-form @submit.prevent="updateCardDetails">
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
              <b-button type="submit" variant="primary" size="lg" class="btn-shadow">Update card</b-button>
            </b-form>
          </div>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
import { Card, createToken } from "vue-stripe-elements-plus";
export default {
  components: { Card, createToken },
  data() {
    return {
      plans: this.$store.getters.getPlans,
      subscription: this.$store.getters.getSubscriptions,
      selectedBackdrop: "false",
      backdropOptions: ["true", "false", "static"],
      stripeKey: this.$store.getters.getContants.stripe,
      token: "",
      plan: "",
      complete: false,
      stripeOptions: {
        // see https://stripe.com/docs/stripe.js#element-options for details
      },
      stripeError: ""
    };
  },
  created() {
    this.subscription = this.$store.getters.getSubscriptions;
  },
  methods: {
    hideModal(refname) {
      this.$refs[refname].hide();
    },
    upgrade(planId) {
      this.plan = planId;
      this.$dialog
        .confirm(
          "Are you sure, want to upgrade plan?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("updateSubscriptionRequest", { plan: this.plan })
            .then(() => {
              this.subscription = this.$store.getters.getSubscriptions;
              console.log("Upgraded...");
            });
        });
    },
    cancel() {
      this.$dialog
        .confirm(
          "Are you sure, want to cancel subscription?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store.dispatch("cancelSubscriptionRequest").then(() => {
            this.subscription = this.$store.getters.getSubscriptions;
          });
        });
    },
    resume() {
      this.$dialog
        .confirm(
          "Are you sure, want to resume subscription?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store.dispatch("resumeSubscriptionRequest").then(() => {
            this.subscription = this.$store.getters.getSubscriptions;
          });
        });
    },
    updateCardDetails() {
      if (!this.complete) return;
      this.$dialog
        .confirm(
          "Are you sure, want to update card details?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          createToken().then(data => {
            this.token = data.token.id;
            this.$store
              .dispatch("updateCradRequest", { token: this.token })
              .then(() => {
                this.subscription = this.$store.getters.getSubscriptions;
                $(".InputElement").val("");
                console.log("Card updated...");
              });
          });
        });
    },
    updateCard($event) {
      this.complete = $event.complete;
      if (!this.complete) {
        this.stripeError = "Enter valid card details";
      } else {
        this.stripeError = "";
      }
    }
  }
};
</script>