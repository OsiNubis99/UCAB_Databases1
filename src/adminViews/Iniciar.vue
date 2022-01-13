<script>
import { mapState, mapMutations } from "vuex";
export default {
	data() {
		return {
			nombreUsuario: "",
			verClave: true,
			error: {},
			clave: "",
		};
	},
	methods: {
		limpiar() {
			this.nombreUsuario = "";
			this.clave = "";
			this.$store.state.alerta = {};
		},
		async enviar() {
			if (this.nombreUsuario.trim() == "") {
				this.$store.state.alerta = {
					estado: true,
					tipo: "alerta",
					titulo: "Nombre de usuario es un campo obligatorio",
					info: "",
				};
			} else if (this.clave.length < 8) {
				this.$store.state.alerta = {
					estado: true,
					tipo: "alerta",
					titulo: "La clave es un campo obligatorio",
					info: "Debe poseer un minimo de 8 caracteres",
				};
			} else {
				this.$store.state.alerta = {
					estado: true,
					tipo: "bien",
					titulo: "Cargando...",
					info: "Esto puede tomar unos minutos",
				};
				let Ruta =
					"https://www.ofimania.com/API/Admin/" +
					this.nombreUsuario +
					"/" +
					this.clave;
				await this.axios
					.post(Ruta)
					.then((response) => {
						return response.data;
					})
					.then((data) => {
						if (data.error != null) {
							this.$store.state.alerta.tipo = "error";
							this.$store.state.alerta.titulo = data.error;
						} else {
							this.$store.state.alerta.tipo = "bien";
							this.$store.state.alerta.titulo = "Usuario Verificado";
							this.$store.state.alerta.info = "";
							this.$router.push("/");
						}
					})
					.catch((error) => {
						this.$store.state.alerta.tipo = "error";
						this.$store.state.alerta.titulo = "Error del Servidor";
						this.$store.state.alerta.info = error;
					});
			}
		},
	},
};
</script>

<template>
	<v-container fluid fill-height>
		<v-layout fill-height justify-center align-center wrap>
			<v-flex sm12 md8 lg6>
				<v-card class="pa-4 ma-4" width="auto">
					<v-card-title primary-title class="headline"
						>Inicia Sesion</v-card-title
					>
					<v-card-text>
						<v-text-field
							v-model="nombreUsuario"
							label="Nombre de Usuario"
							:color="error.estado ? 'red lighten-1' : 'green lighten-1'"
							autofocus
						></v-text-field>
						<v-text-field
							@keypress.enter="enviar"
							id="clave"
							label="Introduce tu Clave"
							:append-icon="
								verClave ? 'mdi-eye-outline' : 'mdi-eye-off-outline'
							"
							:color="
								error.estado
									? 'red lighten-1'
									: verClave
									? 'green lighten-1'
									: 'orange lighten-1'
							"
							@click:append="() => (verClave = !verClave)"
							:type="verClave ? 'password' : 'text'"
							v-model="clave"
						></v-text-field>
					</v-card-text>
					<v-card-actions>
						<v-btn color="clay" @click="limpiar">Limpiar</v-btn>
						<v-spacer></v-spacer>
						<v-btn color="green lighten-1" @click="enviar">Enviar</v-btn>
					</v-card-actions>
				</v-card>
			</v-flex>
		</v-layout>
	</v-container>
</template>

<style>
.alerta {
	z-index: 100;
	position: fixed;
	top: 70px;
	right: 25px;
}
</style>
