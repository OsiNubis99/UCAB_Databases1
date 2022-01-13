<template>
	<v-app-bar color="primary" dark app>
		<router-link to="/">
			<v-img max-height="40px" max-width="40px" src="/logo.png"></v-img>
		</router-link>

		<v-spacer></v-spacer>
		<v-toolbar-items>
			<v-btn
				active-class="secondary--text"
				color="white"
				text
				to="/Contrato/Inmueble"
			>
				Crear Contrato Inmueble
			</v-btn>
			<v-btn
				active-class="secondary--text"
				color="white"
				text
				to="/Contrato/Vehiculo"
			>
				Crear Contrato Vehiculo
			</v-btn>
			<v-btn
				active-class="secondary--text"
				color="white"
				text
				to="/Contrato/Vida"
			>
				Crear Contrato Vida
			</v-btn>
		</v-toolbar-items>
	</v-app-bar>
</template>

<script>
export default {
	data() {
		return {};
	},
};
</script>
