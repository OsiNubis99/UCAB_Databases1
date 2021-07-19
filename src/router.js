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
			name: "Home",
			path: "/",
			component: () => import("./views/home.vue"),
		},
		{
			name: "Crear-subasta",
			path: "/Crear-subasta",
			component: () => import("./views/crear-subasta.vue"),
		},
		{
			name: "Subastas",
			path: "/Subastas",
			component: () => import("./views/subastas.vue"),
		},
		{
			name: "Subasta",
			path: "/Subasta/:id",
			props: true,
			component: (id) => import("./views/subasta.vue"),
		},
	],
});
