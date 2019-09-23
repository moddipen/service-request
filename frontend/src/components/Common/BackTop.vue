<template>
  <div :class="{'back-top':true, 'shown' : isOpen}" @mouseleave="isMenuOver=false">
    <a
      href="#"
      class="theme-button"
      @click.prevent="backTop"
      data-toggle="tooltip"
      title="Back to Top"
    >
      <i class="simple-icon-arrow-up"></i>
    </a>
  </div>
</template>

<script>
import { colors } from "@/constants/config";
export default {
  data() {
    return {
      isOpen: false,
      isMenuOver: false,
      selectedColor: ""
    };
  },
  methods: {
    addEvents() {},
    removeEvents() {},

    backTop() {
      $("html,body")
        .stop()
        .animate(
          {
            scrollTop: 0
          },
          "slow",
          "swing"
        );
    }
  },
  watch: {},
  beforeDestroy() {},
  mounted() {}
};
</script>
