<template>
  <form-group :validator="v" :label="label">
    <v-select v-if="isMultiple" multiple v-model="name" :options="options" @input="v.$touch()" />
    <v-select v-else v-model="name" :options="options" @input="v.$touch()" />
  </form-group>
</template>

<script>
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
export default {
  components: {
    vSelect
  },
  props: {
    value: {
      type: Object,
      default: {
        label: "",
        value: ""
      }
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
    options: {
      type: Array,
      default: []
    },
    isMultiple: {
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
