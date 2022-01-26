<template>
  <v-navigation-drawer color="primary" app dark>
    <v-list dense nav class="py-0">
      <v-list-item @click="$router.push('/')">
        <v-list-item-avatar>
          <img src="../assets/logo.jpg" />
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>Panel Administrador</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-divider></v-divider>
      <v-list-item
        v-for="(item, id) in items"
        :key="id"
        link
        @click="$router.push(item.url)"
      >
        <v-list-item-icon>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data() {
    return {
      items: [
        { title: "Inmueble", icon: "mdi-home", url: "/Inmueble" },
        { title: "Persona", icon: "mdi-account-circle", url: "/Persona" },
        { title: "Agente", icon: "mdi-account", url: "/Agente" },
        { title: "Contrato Inmueble", icon: "mdi-file", url: "/Contrato/Inmueble" },
        { title: "Contrato Vehiculo", icon: "mdi-file", url: "/Contrato/Vehiculo" },
        { title: "Contrato Vida", icon: "mdi-file", url: "/Contrato/Vida" },
      ]
    };
  }
};
</script>
