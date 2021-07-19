<template>
	<v-container fluid ma-3>
		<v-layout row wrap align-center justify-center>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">Tiendas:</h2>
				<v-data-table
					:headers="headers_tiendas"
					:items="tiendas"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">Coleccionistas:</h2>
				<v-data-table
					:headers="headers_coleccionistas"
					:items="coleccionistas"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">paises:</h2>
				<v-data-table
					:headers="headers_paises"
					:items="paises"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">Clientes:</h2>
				<v-data-table
					:headers="headers_clientes"
					:items="clientes"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">pinturas:</h2>
				<v-data-table
					:headers="headers_pinturas"
					:items="pinturas"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
			<v-flex xs11 ma-3>
				<h2 class="ma-3">monedas:</h2>
				<v-data-table
					:headers="headers_monedas"
					:items="monedas"
					:items-per-page="15"
					class="elevation-1"
				>
				</v-data-table>
			</v-flex>
		</v-layout>
	</v-container>
</template>

<script>
export default {
	data: () => ({
		headers_tiendas: [
			{ text: "Id", value: "id" },
			{ text: "Nombre", value: "nombre", align: "center" },
			{ text: "Pagina", value: "pagina", align: "center" },
			{ text: "Proposito", value: "proposito", align: "center" },
			{ text: "Tipo", value: "tipo", align: "center" },
			{ text: "Alcance", value: "alcance", align: "center" },
		],
		headers_coleccionistas: [
			{ text: "Id", value: "id" },
			{ text: "Nombre", value: "nombre", align: "center" },
			{ text: "Nombre 2", value: "nombre2", align: "center" },
			{ text: "Apellido", value: "apellido", align: "center" },
			{ text: "Apellido 2", value: "apellido2", align: "center" },
			{ text: "Email", value: "email", align: "center" },
			{ text: "Id Nacio", value: "nacio", align: "center" },
			{ text: "Id Vive", value: "vive", align: "center" },
		],
		headers_clientes: [
			{ text: "Id", value: "id" },
			{ text: "Id Coleccionista", value: "coleccionista", align: "center" },
			{ text: "Id Tienda", value: "tienda", align: "center" },
		],
		headers_paises: [
			{ text: "Id", value: "id" },
			{ text: "Nombre", value: "nombre", align: "center" },
			{ text: "Nacionalidad", value: "nacionalidad", align: "center" },
		],
		headers_pinturas: [
			{ text: "Id", value: "id" },
			{ text: "Nombre", value: "nombre", align: "center" },
			{ text: "Id Coleccionista", value: "coleccionista", align: "center" },
			{ text: "Id Tienda", value: "tienda", align: "center" },
		],
		headers_monedas: [
			{ text: "Id", value: "id_moneda" },
			{ text: "Nombre", value: "nombre", align: "center" },
			{ text: "Id Coleccionista", value: "coleccionista", align: "center" },
			{ text: "Id Tienda", value: "tienda", align: "center" },
		],
		tiendas: [],
		coleccionistas: [],
		clientes: [],
		paises: [],
		pinturas: [],
		monedas: [],
	}),
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/get-deps")
			.then((response) => {
				this.tiendas = response.data.tiendas || [];
				this.coleccionistas = response.data.coleccionistas || [];
				this.clientes = response.data.clientes || [];
				this.paises = response.data.pais || [];
				this.pinturas = response.data.pinturas || [];
				this.monedas = response.data.monedas || [];
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
};
</script>
