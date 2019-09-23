<template>
  <form-group :validator="v" :label="label">
    <textarea
      class="form-control"
      autocomplete="off"
      v-model="name"
      @input="v.$touch()"
      cols="3"
      rows="3"
    ></textarea>
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
