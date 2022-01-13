<template>
	<v-navigation-drawer
		:value="$route.path != '/Iniciar'"
		color="primary"
		expand-on-hover
		app
		dark
	>
		<v-list dense nav class="py-0">
			<v-list-item @click="$router.push('/')">
				<v-list-item-avatar>
					<img :src="'https://www.ofimania.com/img/miniLogo.webp'" />
				</v-list-item-avatar>
				<v-list-item-content>
					<v-list-item-title>OfiPanel</v-list-item-title>
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
				{ title: "Blog", icon: "mdi-account-card-details", url: "/Blog" },
				{
					title: "Banners",
					icon: "mdi-camera-metering-partial",
					url: "/Banners",
				},
				{ title: "Usuarios", icon: "mdi-account-circle", url: "/Usuarios" },
				{ title: "Descargas", icon: "mdi-download", url: "/Descargas" },
				{ title: "Productos", icon: "mdi-book-multiple", url: "/Productos" },
				{ title: "Hazlo tu Mismo", icon: "mdi-view-dashboard", url: "/HTM" },
				{ title: "Tiendas al Detal", icon: "mdi-cart-outline", url: "/Detal" },
				{
					title: "Tiendas al Mayor",
					icon: "mdi-package-variant-closed",
					url: "/Mayor",
				},
				{
					title: "Preguntas Frecuentes",
					icon: "mdi-help-rhombus-outline",
					url: "/Preguntas",
				},
			],
		};
	},
};
</script>
