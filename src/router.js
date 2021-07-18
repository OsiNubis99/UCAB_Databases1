import Vue from "vue";
import Meta from "vue-meta";
import Router from "vue-router";

Vue.use(Meta);
Vue.use(Router);

export default new Router({
	mode: "history",
	base: process.env.BASE_URL,
	routes: [
		{
			name: "Crear-subasta",
			path: "/Crear-subasta",
			component: () => import("./views/crear-subasta.vue"),
		},
	],
});
