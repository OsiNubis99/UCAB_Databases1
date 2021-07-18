import Vue from "vue";
import Vuetify from "vuetify/lib";
import es from "vuetify/es5/locale/es";

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    options: {
      customProperties: true,
    },
    themes: {
      light: {
        primary: "#2969B0",
        secondary: "#eeff00",
        accent: "#201ec0",
        info: "#5BC0E6",
        success: "#00ff37",
        error: "#FD0B0B",
        warning: "#Fac51c",
      },
    },
  },
  lang: {
    locales: { es },
    current: "es",
  },
  icons: {
    iconfont: "mdi",
  },
});
