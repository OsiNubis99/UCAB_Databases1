<template>
	<v-app id="app">
		<NavBar />
		<v-main>
			<Alerta />
			<router-view />
		</v-main>
	</v-app>
</template>

<script>
import Alerta from "./components/Alerta";
import NavBar from "./components/NavBar";
export default {
	data() {
		return {};
	},
	components: {
		Alerta,
		NavBar,
	},
};
</script>

<style>
* {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
