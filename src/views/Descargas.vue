<template>
	<v-layout
		wrap
		fill-height
		align-center
		justify-center
		class="secondary lighten-1"
	>
		<v-flex xs8>
			<v-card class="pa-5">
				<h1 class="text-center">Bienvenido al Apartado de Descargas</h1>
				<v-form v-model="valid" ref="form" lazy-validation>
					<p>
						El archivo "{{ nombreArchivo }}" sera enviado a la bandeja de su
						Correo
					</p>
					<p>Por favor indique su Correo Electrónico</p>

					<v-text-field
						label="Nombre y Apellido"
						v-model="nombre"
						required
					></v-text-field>

					<v-text-field
						label="Correo Electrónico"
						v-model="correo"
						:rules="emailRules"
						required
					></v-text-field>

					<v-btn color="primary" class="mt-5" @click="enviarCorreo"
						>Enviar</v-btn
					>
				</v-form>
			</v-card>
		</v-flex>
	</v-layout>
</template>

<script>
export default {
	data: () => ({
		nombreArchivo: "",
		link: "",
		valid: true,
		nombre: "",
		correo: "",
		emailRules: [
			(v) => !!v || "La dirección de Correo Electrónico es requerida",
			(v) =>
				/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(v) ||
				"Correo Electrónico Inválido",
		],
	}),

	created() {
		this.cargando = true;
		this.axios
			.get("https://www.ofimania.com/API/Descarga/" + this.hash)
			.then((response) => {
				this.nombreArchivo = response.data.nombre;
				this.link = response.data.archivo;
			})
			.catch((error) => {
				this.cargando = false;
				this.$store.state.alerta = {
					estado: true,
					tipo: "error",
					titulo: "Error de Conexion",
					info: "Verifique su Conexion a Internet",
				};
			});
	},

	methods: {
		enviarCorreo() {
			this.$store.state.alerta = {
				estado: true,
				tipo: "Bien",
				titulo: "Enviando Archivo",
			};
			let datos = {
				correo: this.correo,
				nombre: this.nombre,
				nombreArchivo: this.nombreArchivo,
				link: this.link,
			};
			var qs = require("qs");
			this.axios
				.post(
					"https://www.ofimania.com/API/Formulario/Descarga/",
					qs.stringify(datos),
					{
						headers: {
							"Content-Type": "application/x-www-form-urlencoded",
						},
					}
				)
				.then((response) => {
					this.$store.state.alerta.estado = false;
					if (response.data.error != null) {
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error",
							info: "Verifique su Conexion a Internet",
						};
					} else {
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Correo enviado!",
							info: "Verifique su carpeta de Span si no encuentra nuestro correo.",
						};
					}
				})
				.catch((error) => {
					this.$store.state.alerta.estado = false;
					this.$store.state.alerta = {
						estado: true,
						tipo: "error",
						titulo: "Error de Conexion",
						info: error + "Verifique su Conexion a Internet",
					};
				});
		},
	},

	props: {
		hash: {
			type: String,
			default: "",
		},
	},
};
</script>
