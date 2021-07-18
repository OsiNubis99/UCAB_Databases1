<template>
	<v-app id="app">
		<NavBar />
		<v-main>
			<router-view />
		</v-main>
	</v-app>
</template>

<script>
import NavBar from "./components/NavBar";
export default {
	data() {
		return {};
	},
	components: {
		NavBar,
	},
};
</script>

<style>
* {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
