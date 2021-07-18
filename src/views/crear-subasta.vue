<template>
	<v-container fluid ma-3 v-if="tiendas.length > 0">
		<v-layout row wrap>
			<v-flex xs5 mx-3 justify="center">
				<v-date-picker
					v-model="fecha"
					:min="
						new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
							.toISOString()
							.substr(0, 10)
					"
				></v-date-picker>
			</v-flex>
			<v-flex xs5 mx-3>
				<v-text-field
					v-model="duracion"
					type="decimal"
					label="Duracion"
				></v-text-field>
				<v-text-field
					v-model="inscrip"
					type="decimal"
					label="Costo inscripcion"
				></v-text-field>
				<v-text-field
					v-model="inscrip_cliente"
					type="decimal"
					label="Costo cliente"
				></v-text-field>
			</v-flex>
		</v-layout>
		<v-layout row wrap justify="center">
			<v-flex xs11 mx-3>
				<v-select v-model="tipo" :items="tipos" label="Secciona un tipo" pa-5>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>

			<v-flex xs11 mx-3>
				<v-select
					v-model="tienda"
					:items="tiendas_names"
					label="Secciona 1 o + tienda(s)"
					pa-5
					multiple
				>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item[1] }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>
			<v-flex xs11 mx-3>
				<v-select
					v-model="pais"
					:items="paises_names"
					label="Secciona un pais"
					pa-5
				>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item[1] }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>
			<v-flex xs11 mx-3 v-if="tienda.length > 0">
				<v-select
					v-model="moneda"
					:items="monedas_names"
					label="Secciona algunas Monedas"
					pa-5
					multiple
				>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item[1] }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>
			<v-flex xs11 mx-3 v-if="tienda.length > 0">
				<v-select
					v-model="pintura"
					:items="pinturas_names"
					label="Secciona algunas Pinturas"
					pa-5
					multiple
				>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item[1] }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>
		</v-layout>
		<v-layout row wrap align-end>
			<v-btn @click="generate" small color="primary">Save</v-btn>
		</v-layout>
	</v-container>
</template>

<script>
export default {
	data: () => ({
		duracion: 0.0,
		inscrip: 0.0,
		inscrip_cliente: 0.0,
		fecha: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
			.toISOString()
			.substr(0, 10),
		tipo: "",
		tipos: ["Dinamica", "Cerrada"],
		moneda: [],
		monedas: [],
		pintura: [],
		pinturas: [],
		coleccionista: [],
		coleccionistas: [],
		tienda: [],
		tiendas: [],
		pais: [],
		paises: [],
	}),
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/get-deps")
			.then((response) => {
				this.tiendas = response.data.tiendas || [];
				this.coleccionistas = response.data.coleccionistas || [];
				this.paises = response.data.pais || [];
				this.pinturas = response.data.pinturas || [];
				this.monedas = response.data.monedas || [];
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
	methods: {
		generate() {
			console.log(
				JSON.stringify({
					duracion: this.duracion,
					costo_inscrip: this.inscrip,
					costo_inscrip_cliente: this.inscrip_cliente,
					pais_lugar: this.pais[0],
					tipo: this.tipo,
					tiendas: this.tienda.map((value) => {
						return value[0];
					}),
					monedas: this.moneda.map((value) => {
						return value[0];
					}),
					pinturas: this.pintura.map((value) => {
						return value[0];
					}),
				})
			);
		},
	},
	computed: {
		tiendas_names() {
			return this.tiendas.map(function(item) {
				return [item.id, item.nombre];
			});
		},
		paises_names() {
			return this.paises.map(function(item) {
				return [item.id, item.nombre];
			});
		},
		pinturas_names() {
			var tienda = this.tienda.map((value) => {
				return value[0];
			});
			return this.pinturas
				.filter((value) => {
					return tienda.indexOf(value.tienda) >= 0;
				})
				.map(function(item) {
					return [item.id, item.nombre, item.tienda];
				});
		},
		monedas_names() {
			var tienda = this.tienda.map((value) => {
				return value[0];
			});
			return this.monedas
				.filter((value) => {
					return tienda.indexOf(value.tienda) >= 0;
				})
				.map(function(item) {
					return [item.id, item.nombre, item.tienda];
				});
		},
	},
};
</script>
