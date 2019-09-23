<template>
  <form-group :validator="v" :label="label">
    <input
      v-if="disabled"
      :type="type"
      disabled
      class="form-control"
      autocomplete="off"
      v-model="name"
      @input="v.$touch()"
    />
    <input
      v-else
      :type="type"
      class="form-control"
      autocomplete="off"
      v-model="name"
      @input="v.$touch()"
    />
  </form-group>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: ""
    },
    v: {
      type: Object
    },
    label: {
      type: String,
      default: ""
    },
    type: {
      type: String,
      default: "text"
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    name: {
      get() {
        return this.value;
      },
      set(value) {
        this.$emit("input", value);
      }
    }
  }
};
</script>
