import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		logo: "https://www.ofimania.com/img/logo.webp",
		HTM: null,
		Blog: null,
		alerta: {},
		perfil: {},
		Home: null,
		Detal: null,
		Mayor: null,
		movil: false,
		windowS: {},
		headerHome: "https://www.ofimania.com/img/Header/Home.webp",
		cargando: false,
		Productos: null,
		headerMovil: "https://www.ofimania.com/img/Header/Movil.webp",
		headerOtras: "https://www.ofimania.com/img/Header/Otros.webp",
		contenidoEditor: "",
		navigationDrawer: false,
	},
	mutations: {
		onResize(state) {
			state.windowS.x = window.innerWidth;
			state.windowS.y = window.innerHeight;
			state.movil = window.innerWidth < 960;
		},
	},
	actions: {},
});
