<template>
	<v-app id="app">
		<NavDrawer />
		<v-main>
			<Alerta />
			<router-view />
		</v-main>
	</v-app>
</template>

<script>
import Alerta from "./components/Alerta";
import NavDrawer from "./components/NavDrawer";
export default {
	data() {
		return {};
	},
	components: {
		Alerta,
		NavDrawer,
	},
};
</script>

<style>
* {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
