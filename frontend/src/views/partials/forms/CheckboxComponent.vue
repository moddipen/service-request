<template>
  <form-group :validator="v" :label="label">
    <input type="checkbox" class="form-control" v-model="name" :placeholder="label" @input="v.$touch()">
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
        type: Object,
        required: true
      },
      label: {
        type: String,
        default: ""
      }
    },
    computed: {
      name: {
        get() {
          return this.value
        },
        set(value) {
          this.$emit("input", value)
        }
      }
    }
  }
</script>
