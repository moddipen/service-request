<template>
  <b-card
    @click.prevent="toggleItem($event,data.id)"
    :class="{'d-flex flex-row':true,'active' : selectedItems.includes(data.id)}"
    no-body
  >
    <div title="Right click" class="pl-2 d-flex flex-grow-1 min-width-zero">
      <div class="card-body align-self-center d-flex flex-column flex-lg-row justify-content-between min-width-zero align-items-lg-center">
        <p v-for="(field,index) in fields" :key="index" class="list-item-heading mb-1 truncate">{{data[field]}}</p>
      </div>
    </div>
  </b-card>
</template>
<script>
export default {
  props: ["fields", "data", "selectedItems"],
  methods: {
    toggleItem(event, itemId) {
      this.$emit("toggle-item", event, itemId);
    }
  }
};
</script>
