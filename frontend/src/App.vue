<template>
  <div class="h-100">
    <router-view />
    <color-switcher />
    <back-top />
  </div>
</template>
<script>
import ColorSwitcher from "@/components/Common/ColorSwitcher";
import BackTop from "@/components/Common/BackTop";
export default {
  components: {
    ColorSwitcher,
    BackTop
  }
};
</script>
