<template>
	<v-app-bar color="primary" dark app>
		Logo
		<v-spacer></v-spacer>
		<v-toolbar-items>
			<v-btn
				active-class="secondary--text"
				color="white"
				text
				to="/Crear-subasta"
			>
				Crear Subasta
			</v-btn>
			<v-btn active-class="secondary--text" color="white" text to="/Subasta">
				Subasta
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
