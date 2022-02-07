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
      component: () => import("./views/home.vue")
    },
    {
      name: "Persona",
      path: "/Persona",
      component: () => import("./views/Persona.vue")
    },
    {
      name: "Empleado",
      path: "/Empleado",
      component: () => import("./views/Empleado.vue")
    },
    {
      name: "Agente",
      path: "/Agente",
      component: () => import("./views/Agente.vue")
    },
    {
      name: "Cliente",
      path: "/Cliente",
      component: () => import("./views/Cliente.vue")
    },
    {
      name: "Siniestro",
      path: "/Siniestro",
      component: () => import("./views/Siniestro.vue")
    },
    {
      name: "Accidente",
      path: "/Accidente",
      component: () => import("./views/Accidente.vue")
    },
    {
      name: "Multa",
      path: "/Multa",
      component: () => import("./views/Multa.vue")
    },
    {
      name: "Inmueble",
      path: "/Inmueble",
      component: () => import("./views/Inmueble.vue")
    },
    {
      name: "Vehiculo",
      path: "/vehiculo",
      component: () => import("./views/Vehiculo.vue")
    },
    {
      name: "Contrata_Inmueble",
      path: "/Contrato/Inmueble",
      component: () => import("./views/Cont_Inmueble.vue")
    },
    {
      name: "Contrata_Vehiculo",
      path: "/Contrato/Vehiculo",
      component: () => import("./views/Cont_Vehiculo.vue")
    },
    {
      name: "Contrata_Vida",
      path: "/Contrato/Vida",
      component: () => import("./views/Cont_Vida.vue")
    }
  ]
});
