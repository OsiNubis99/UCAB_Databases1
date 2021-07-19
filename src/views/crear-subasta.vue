<template>
	<v-container fluid ma-3 v-if="tiendas.length > 0">
		<v-layout row wrap>
			<v-flex xs5 mx-3 justify="center">
				<v-date-picker
					v-model="fecha"
					:min="
						new Date(Date.now() + new Date().getTimezoneOffset() * 60000 * 5)
							.toISOString()
							.substr(0, 10)
					"
				></v-date-picker>
			</v-flex>
			<v-flex xs5 mx-3>
				<v-text-field v-model="duracion" label="Duracion"></v-text-field>
				<v-text-field
					v-model="inscrip"
					label="Costo inscripcion"
				></v-text-field>
				<v-text-field
					v-model="inscrip_cliente"
					label="Costo cliente"
				></v-text-field>
				<v-select v-model="tipo" :items="tipos" label="Secciona un tipo" pa-5>
					<template v-slot:selection="{ item }">
						<v-chip>
							<span>{{ item }}</span>
						</v-chip>
					</template>
				</v-select>
			</v-flex>
		</v-layout>
		<v-layout row wrap justify="center">
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
				<div v-for="(item, index) in moneda" :key="index">
					<v-text-field
						:label="'Ask para ' + item[1]"
						v-model="item[3]"
						outlined
						color
					></v-text-field>
				</div>
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
				<div v-for="(item, index) in pintura" :key="index">
					<v-text-field
						:label="'Ask para ' + item[1]"
						v-model="item[3]"
						outlined
						color
					></v-text-field>
				</div>
			</v-flex>
			<v-flex xs11 mx-3 v-if="tienda.length > 0">
				<v-select
					v-model="coleccionista"
					:items="coleccionistas_name"
					label="Registro automatico"
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
		<v-layout row wrap align-center>
			<v-flex xs5>
				<v-btn @click="generate" color="primary" mx-5>Save</v-btn>
			</v-flex>
		</v-layout>
		<v-layout row wrap ma-5>
			<v-textarea
				outlined
				color="priamry"
				placeholder="Mensajes"
				name="Mensajes"
				label="Mensajes"
				v-html="msg"
				disabled
			></v-textarea>
		</v-layout>
	</v-container>
</template>

<script>
export default {
	data: () => ({
		duracion: 0.0,
		inscrip: 0.0,
		inscrip_cliente: 0.0,
		fecha: new Date(Date.now() + new Date().getTimezoneOffset() * 60000 * 5)
			.toISOString()
			.substr(0, 10),
		tipo: "",
		msg: "",
		tipos: ["Dinamica", "Cerrada"],
		moneda: [],
		monedas: [],
		pintura: [],
		pinturas: [],
		coleccionistas: [],
		coleccionista: [],
		clientes: [],
		cliente: [],
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
				this.clientes = response.data.clientes || [];
				this.paises = response.data.pais || [];
				this.pinturas = response.data.pinturas || [];
				this.monedas = response.data.monedas || [];
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
	methods: {
		async generate() {
			if (
				Number.parseFloat(this.duracion) > 0 &&
				Number.parseFloat(this.inscrip) > 0 &&
				Number.parseFloat(this.inscrip_cliente) > 0 &&
				this.tipo != "" &&
				this.moneda != [] &&
				this.pintura != [] &&
				this.tienda != [] &&
				this.pais != [] &&
				this.asks
			) {
				await this.axios
					.post(
						"http://localhost:4000/api/subasta/put",
						{
							fecha: this.fecha,
							duracion: Number.parseFloat(this.duracion) || 0,
							costo_inscrip: Number.parseFloat(this.inscrip) || 0,
							costo_inscrip_cliente:
								Number.parseFloat(this.inscrip_cliente) || 0,
							pais_lugar: this.pais[0],
							tipo: this.tipo,
							tiendas: this.tienda.map((value) => {
								return value[0];
							}),
							monedas: this.moneda.map((value) => {
								return { id: value[0], ask: Number.parseFloat(value[3]) || 0 };
							}),
							pinturas: this.pintura.map((value) => {
								return { id: value[0], ask: Number.parseFloat(value[3]) || 0 };
							}),
							coleccionistas: this.coleccionista.map((value) => {
								return value[0];
							}),
						},
						{
							headers: {
								"Content-Type": "application/json",
							},
						}
					)
					.then((response) => {
						console.log(response);
						if (response.status == 200) {
							this.msg = "Agregado. Fue enviado un Email a: ";
							this.cliente.forEach((value) => {
								this.msg += "<br> " + value[1] + " -> " + value[2];
							});
							this.duracion = 0.0;
							this.inscrip = 0.0;
							this.inscrip_cliente = 0.0;
							this.tipo = "";
							this.moneda = [];
							this.pintura = [];
							this.coleccionista = [];
							this.tienda = [];
							this.pais = [];
						} else {
							this.msg = response.data;
						}
					})
					.catch((error) => {
						console.log(error);
					});
			} else {
				this.msg = "Error: Formulario incompleto";
			}
		},
	},
	computed: {
		coleccionistas_name() {
			var tienda = this.tienda.map((value) => {
				return value[0];
			});
			var cliente = this.clientes
				.filter((value) => {
					return tienda.indexOf(value.tienda) >= 0;
				})
				.map((value) => {
					return value.coleccionista;
				});
			this.cliente = this.coleccionistas
				.filter((value) => {
					return cliente.indexOf(value.id) >= 0;
				})
				.map(function(item) {
					return [item.id, item.nombre, item.email];
				});
			return this.cliente;
		},
		asks() {
			var asks = true;
			this.moneda.forEach((element) => {
				asks = asks && Number.parseFloat(element[3]) > 0;
			});
			this.pintura.forEach((element) => {
				asks = asks && Number.parseFloat(element[3]) > 0;
			});
			return asks;
		},
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
					return [item.id, item.nombre, item.tienda, 0];
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
					return [item.id, item.nombre, item.tienda, 0];
				});
		},
	},
};
</script>
