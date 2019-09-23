import Vue from "vue";

export const ShowLoader = () => {
  return Vue.$loading.show({ loader: "dots", color: "#f18024" });
};

export const HideLoader = loading => {
  loading.hide();
};
