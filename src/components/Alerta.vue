<template>
  <v-snackbar
    v-model="alerta.estado"
    top
    :color="
      alerta.tipo == 'alerta'
        ? 'warning'
        : alerta.tipo == 'error'
        ? 'error'
        : 'success'
    "
  >
    <div class="text-center mx-auto">
      <h2>{{ alerta.titulo }}</h2>
      <span>
        {{ alerta.info }}
      </span>
    </div>
    <template v-slot:action="{ attrs }">
      <v-btn color="black" icon v-bind="attrs" @click="alerta.estado = false">
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </template>
  </v-snackbar>
</template>

<script>
import { mapState } from "vuex";

export default {
  computed: {
    ...mapState(["alerta"]),
  },
};
</script>
