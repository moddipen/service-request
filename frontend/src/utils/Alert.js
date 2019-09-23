import Vue from "vue";

export const ErrorMessage = message => {
  if (message !== "") {
    Vue.$notify("error filled", "", message, {
      duration: 4000,
      permanent: false
    });
  }
};

export const SuccessMessage = message => {
  if (message !== "") {
    Vue.$notify("success filled", "", message, {
      duration: 4000,
      permanent: false
    });
  }
};

export const WarningMessage = message => {
  if (message !== "") {
    Vue.$notify("warning filled", "", message, {
      duration: 4000,
      permanent: false
    });
  }
};

export const InfoMessage = message => {
  if (message !== "") {
    Vue.$notify("info filled", "", message, {
      duration: 4000,
      permanent: false
    });
  }
};
