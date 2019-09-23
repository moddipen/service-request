<template>
  <b-card class="d-flex flex-row">
    <div class="card-body align-self-center d-flex flex-column flex-lg-row justify-content-between">
      <p v-for="(field,index) in fields" :key="index" class="list-item-heading mb-1 truncate"><b>{{camelCase(field)}}</b></p>
    </div>
  </b-card>
</template>
<script>
export default {
  props: ["fields"],
  methods: {
    camelCase: (str) => {
      let frags = str.split('_');
      for (let i=0; i<frags.length; i++) {
        frags[i] = frags[i].charAt(0).toUpperCase() + frags[i].slice(1);
      }
      return frags.join(' ');
    }
  }
};
</script>
