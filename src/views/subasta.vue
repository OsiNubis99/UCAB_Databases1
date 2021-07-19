<template>
	<v-container fluid ma-3>
		<v-layout row wrap align-center justify-center>
			<v-flex xs9 justify-center align-center>
				<h2>Pinturas</h2>
				<!-- {{ pinturas }} -->
				<v-expansion-panels accordion>
					<v-expansion-panel v-for="(pintura, i) in pinturas" :key="i">
						<v-expansion-panel-header v-text="pintura.nombre" />
						<v-expansion-panel-content>
							NUR {{ pintura.id_pintura }}
							<br />
							{{ pintura.artista_nombre }} {{ pintura.artista_apellido }},
							{{ pintura.fecha }}
							<br />
							{{ pintura.estilo }}
							<br />
							{{ pintura.size }}
						</v-expansion-panel-content>
					</v-expansion-panel>
				</v-expansion-panels>
				<h2>Monedas</h2>
				<v-expansion-panels accordion>
					<v-expansion-panel v-for="(moneda, i) in monedas" :key="i">
						<v-expansion-panel-header v-text="moneda.nombre" />
						<v-expansion-panel-content>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
							eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
							enim ad minim veniam, quis nostrud exercitation ullamco laboris
							nisi ut aliquip ex ea commodo consequat.
						</v-expansion-panel-content>
					</v-expansion-panel>
				</v-expansion-panels>
				<!-- {{ info }} -->
			</v-flex>
		</v-layout>
	</v-container>
</template>

<script>
export default {
	data: () => ({
		info: {},
		subasta: {},
		clientes: [],
		pinturas: [],
		monedas: [],
	}),
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/get/" + this.id)
			.then((response) => {
				this.info = response.data;
				this.subasta = response.data.subasta;
				this.clientes = response.data.clientes;
				this.pinturas = response.data.pinturas;
				this.monedas = response.data.monedas;
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
	props: {
		id: {
			type: String,
			default: "",
		},
	},
};
</script>
