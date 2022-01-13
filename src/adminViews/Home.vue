<template>
	<v-layout wrap fill-height justify-center>
		<v-card
			style="position: fixed; z-index: 2000; width: 50vw; margin-left: auto"
			class="white px-3 py-1"
		>
			<v-layout>
				<v-flex xs6 px-1>
					<v-file-input
						v-model="imagen"
						accept="image/webp"
						label="Imagen"
					></v-file-input>
				</v-flex>
			</v-layout>
		</v-card>
		<v-layout align-center mt-12 pt-5 justify-center>
			<v-img
				src="https://www.ofimania.com/img/logo.webp"
				class="mx-3 mt-5"
				max-width="400px"
			></v-img>
			<v-btn class="mr-5" color="primary" @click="cargarFoto('/logo')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Logo
			</v-btn>
		</v-layout>
		<v-layout align-center mt-12 pt-5 justify-center>
			<v-img
				src="https://www.ofimania.com/img/miniLogo.webp"
				class="mx-3 mt-5"
				max-width="400px"
			></v-img>
			<v-btn class="mr-5" color="primary" @click="cargarFoto('/miniLogo')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Mini Logo
			</v-btn>
		</v-layout>
		<v-flex xs12>
			<v-img
				src="https://www.ofimania.com/img/Header/Home.webp"
				height="100vh"
			></v-img>
			<v-layout wrap justify-center>
				<v-flex shrink>
					<v-btn
						class="mt-3"
						color="primary"
						@click="cargarFoto('Header/Home')"
					>
						<v-icon class="mr-2">mdi-camera</v-icon>Subir Header Home
					</v-btn>
				</v-flex>
			</v-layout>
		</v-flex>
		<v-flex xs4 mt-3>
			<v-img
				src="https://www.ofimania.com/img/Header/Movil.webp"
				height="80vh"
			></v-img>
			<v-layout wrap justify-center>
				<v-flex shrink>
					<v-btn
						class="mt-3"
						color="primary"
						@click="cargarFoto('Header/Movil')"
					>
						<v-icon class="mr-2">mdi-camera</v-icon>Subir Header Movil
					</v-btn>
				</v-flex>
			</v-layout>
		</v-flex>
		<v-flex xs12 mt-3>
			<v-img
				src="https://www.ofimania.com/img/Header/Otros.webp"
				height="35vh"
			></v-img>
			<v-layout wrap justify-center>
				<v-flex shrink>
					<v-btn
						class="mt-3"
						color="primary"
						@click="cargarFoto('Header/Otros')"
					>
						<v-icon class="mr-2">mdi-camera</v-icon>Subir Otros Headers
					</v-btn>
				</v-flex>
			</v-layout>
		</v-flex>
		<v-flex wrap sm6 pa-3>
			<v-hover v-slot:default="{ hover }">
				<v-card :elevation="hover ? 12 : 2" class="mx-auto">
					<v-img
						src="https://www.ofimania.com/img/Home/Mayor.webp"
						aspect-ratio="1.8"
					>
						<template v-slot:placeholder>
							<v-layout fill-height align-center justify-center ma-0>
								<v-progress-circular
									indeterminate
									color="primary lighten-2"
								></v-progress-circular>
							</v-layout>
						</template>
					</v-img>
					<v-card-text class="text-center display-1"
						>Ventas al Mayor</v-card-text
					>
				</v-card>
			</v-hover>
			<v-layout wrap justify-center>
				<v-flex shrink>
					<v-btn class="mt-3" color="primary" @click="cargarFoto('Home/Mayor')">
						<v-icon class="mr-2">mdi-camera</v-icon>Subir Ventas al Mayor
					</v-btn>
				</v-flex>
			</v-layout>
		</v-flex>
		<v-flex wrap sm6 pa-3>
			<v-hover v-slot:default="{ hover }">
				<v-card :elevation="hover ? 12 : 2" class="mx-auto">
					<v-img
						src="https://www.ofimania.com/img/Home/Detal.webp"
						aspect-ratio="1.8"
					>
						<template v-slot:placeholder>
							<v-layout fill-height align-center justify-center ma-0>
								<v-progress-circular
									indeterminate
									color="primary lighten-2"
								></v-progress-circular>
							</v-layout>
						</template>
					</v-img>
					<v-card-text class="text-center display-1"
						>Tiendas al Detal</v-card-text
					>
				</v-card>
			</v-hover>
			<v-layout wrap justify-center>
				<v-flex shrink>
					<v-btn class="mt-3" color="primary" @click="cargarFoto('Home/Detal')">
						<v-icon class="mr-2">mdi-camera</v-icon>Subir Tiendas al Detal
					</v-btn>
				</v-flex>
			</v-layout>
		</v-flex>
		<v-layout column justify-center align-center>
			<h2>Banner de Detal 1</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Detal1.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Detal1')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Detal 1
			</v-btn>
		</v-layout>
		<v-layout column justify-center align-center>
			<h2>Banner de Detal 2</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Detal2.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Detal2')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Detal 2
			</v-btn>
		</v-layout>
		<v-layout column justify-center align-center>
			<h2>Banner de Detal 3</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Detal3.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Detal3')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Detal 3
			</v-btn>
		</v-layout>
		<v-layout column justify-center align-center>
			<h2>Banner de Detal 4</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Detal4.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Detal4')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Detal 4
			</v-btn>
		</v-layout>
		<v-layout column justify-center align-center>
			<h2>Banner de Mayor 1</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Mayor1.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Mayor1')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Mayor 1
			</v-btn>
		</v-layout>
		<v-layout column justify-center align-center>
			<h2>Banner de Mayor 2</h2>
			<v-img src="https://www.ofimania.com/img/Banners/Mayor2.webp" />
			<v-btn class="mt-3" color="primary" @click="cargarFoto('Banners/Mayor2')">
				<v-icon class="mr-2">mdi-camera</v-icon>Subir Banner de Mayor 2
			</v-btn>
		</v-layout>
	</v-layout>
</template>

<script>
export default {
	data() {
		return {
			imagen: null,
			altImagen: "",
			instagram: null,
			tiendas: null,
			tituloPublicacion: "",
		};
	},
	methods: {
		cargarFoto(rutaNombre) {
			if (this.imagen.type == "image/webp") {
				var data = new FormData();
				data.append("imagen", this.imagen);
				data.append("_method", "PUT");
				this.$store.state.alerta = {
					estado: true,
					tipo: "bien",
					titulo: "Cargando",
					info: "Verifique su Conexion a Internet",
				};
				this.axios
					.post("https://www.ofimania.com/API/Subir/" + rutaNombre, data, {
						headers: {
							"Content-Type": "application/x-prueba-form-urlencoded",
						},
					})
					.then((response) => {
						this.imagen = null;
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Foto actualizada",
							info: "No es necesario guardar",
						};
					})
					.catch((error) => {
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error de Conexion",
							info: "Verifique su Conexion a Internet",
						};
					});
			} else {
				this.$store.state.alerta = {
					estado: true,
					tipo: "error",
					titulo: "Error de Tipo",
					info: "La imagen debe ser formato WEBP",
				};
			}
		},
	},
};
</script>

<style></style>
