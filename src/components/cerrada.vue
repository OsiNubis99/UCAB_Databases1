<template>
	<div>
		<v-btn color="primary" dark @click="run()">Run </v-btn>
		<v-dialog v-model="dialog" persistent>
			<v-card justify-center>
				<v-card-title class="text-h5">
					{{ rest_timer }}
					<v-spacer></v-spacer>
					{{ cerrada ? "Cerrada" : "Dinamica" }}
				</v-card-title>
				<v-select
					v-if="running"
					:items="participantes"
					label="Participante"
					v-model="participante"
					dense
					solo
				>
					<template v-slot:selection="{ item }">
						{{ item.nombre }} {{ item.apellido }}
					</template>
					<template v-slot:item="{ item }">
						{{ item.nombre }} {{ item.apellido }}
					</template>
				</v-select>
				<h4 class="ml-12">{{ msg }}</h4>

				<v-container pa-5 v-if="participante && running">
					<h2>Pinturas:</h2>
					<v-layout
						align-center
						ma-3
						wrap
						v-for="(pintura, index) in pinturas"
						:key="'pinturas' + index"
					>
						<v-flex xs2>
							{{ pintura.nombre }}
						</v-flex>
						<v-spacer></v-spacer>
						<v-flex v-if="cerrada">
							{{
								participante["pinturas" + index]
									? "Tu puja es de: " + participante["pinturas" + index]
									: "No has enviado nada"
							}}
						</v-flex>
						<v-flex v-else>
							{{
								pinturas[index].bid
									? "Bid: " +
									  pinturas[index].bid +
									  " por " +
									  pinturas[index].bid_by.nombre
									: "Nadie ha pujado por este articulo"
							}}
						</v-flex>
						<v-spacer></v-spacer>
						<v-flex xs4>
							<v-text-field
								v-model="puja['pinturas' + participante.id + pintura.id]"
								append-outer-icon="mdi-send"
								filled
								clear-icon="mdi-close-circle"
								clearable
								:label="'Pujar por ' + pintura.nombre"
								@click:append-outer="pujar('pinturas', pintura.id, index)"
							></v-text-field>
						</v-flex>
					</v-layout>
					<h2>Monedas:</h2>
					<v-layout
						align-center
						ma-3
						wrap
						v-for="(moneda, index) in monedas"
						:key="'monedas' + index"
					>
						<v-flex xs2>
							{{ moneda.nombre }}
						</v-flex>
						<v-spacer></v-spacer>
						<v-flex v-if="cerrada">
							{{
								participante["monedas" + index]
									? "Tu puja es de: " + participante["monedas" + index]
									: "No has enviado nada"
							}}
						</v-flex>
						<v-flex v-else>
							{{
								monedas[index].bid
									? "Bid: " +
									  monedas[index].bid +
									  " por " +
									  monedas[index].bid_by.nombre
									: "Nadie ha pujado por este articulo"
							}}
						</v-flex>
						<v-spacer></v-spacer>
						<v-flex xs4>
							<v-text-field
								v-model="puja['monedas' + participante.id + moneda.id]"
								append-outer-icon="mdi-send"
								filled
								clear-icon="mdi-close-circle"
								clearable
								:label="'Pujar por ' + moneda.nombre"
								@click:append-outer="pujar('monedas', moneda.id, index)"
							></v-text-field>
						</v-flex>
					</v-layout>
				</v-container>
				<v-container pa-5 v-if="!running && info">
					<h4>Los articulos Vendidos fueron</h4>
					<v-data-table
						:headers="headers"
						:items="info.vendidos"
						:items-per-page="15"
						class="elevation-1"
					>
					</v-data-table>
					<v-list dense
						><h4 class="ma-3">Los Articulos No Vendidos Fueron</h4>
						<v-list-item-group disabled>
							<v-list-item v-for="(art, index) in no_vendidos()" :key="index">
								<v-list-item-icon>
									<v-icon>mdi-close-circle</v-icon>
								</v-list-item-icon>
								<v-list-item-content>
									<v-list-item-title v-text="art.nombre"></v-list-item-title>
								</v-list-item-content>
							</v-list-item>
						</v-list-item-group>
					</v-list>
				</v-container>
				<v-card-actions>
					<v-spacer></v-spacer>
					<v-btn color="red darken-1" text @click="finish()">
						{{ running ? "Finalizar" : "Cerrar" }}
					</v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>
	</div>
</template>

<script>
export default {
	data: () => ({
		headers: [
			{
				text: "Nombre del producto",
				value: "articulo_nombre",
				align: "center",
			},
			{ text: "Vendido A", value: "coleccionista_nombre", align: "center" },
			{ text: "$", value: "bid", align: "center" },
		],
		rest_timer: "0h 0m 0s",
		msg: "",
		puja: {},
		running: false,
		interval: null,
		dialog: false,
		info: null,
		subasta: null,
		participante: null,
	}),
	methods: {
		no_vendidos() {
			var articulos = [];
			return articulos
				.concat(
					this.monedas.map((articulo) => {
						return { id: articulo.id, nombre: articulo.nombre };
					}),
					this.pinturas.map((articulo) => {
						return { id: articulo.id, nombre: articulo.nombre };
					})
				)
				.filter((articulo) => {
					var ok = false;
					this.info.no_vendidos.forEach((id) => {
						ok = articulo.id == id || ok;
					});
					return ok;
				});
		},
		run() {
			var max_time = new Date().getTime() + this.duracion * (1000 * 60);
			this.interval = setInterval(() => {
				this.running = true;
				var distance = max_time - new Date().getTime();
				var hours = Math.floor(
					(distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
				);
				var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
				var seconds = Math.floor((distance % (1000 * 60)) / 1000);
				this.rest_timer = hours + "h " + minutes + "m " + seconds + "s ";
				if (distance < 0) {
					this.finish();
				}
			}, 1000);
			this.dialog = true;
		},
		pujar(articulo, id, index) {
			var monto = Number.parseFloat(
				this.puja[articulo + this.participante.id + id]
			);
			if (monto > 0) {
				this.msg = "";
				this.puja[articulo + this.participante.id + id] = null;
				if (this.cerrada) {
					this.participante[articulo + index] = monto;
				}
				if (monto > (this[articulo][index].bid || 0)) {
					this[articulo][index].bid = monto;
					this[articulo][index].bid_by = this.participante;
				} else
					this.msg = this.cerrada
						? ""
						: "El monto debe ser mayor que el Bid actual";
			} else {
				this.msg =
					"Este monto no esta permitido: " +
					this.puja[articulo + this.participante.id + id];
			}
		},
		finish() {
			this.msg = "";
			if (this.running) {
				clearInterval(this.interval);
				this.rest_timer = "Terminada";
				this.running = false;
				var vendidos = [];
				var no_vendidos = [];
				this.monedas.forEach((articulo) => {
					if (articulo.bid > articulo.por_min_ganancia) {
						vendidos.push({
							id: articulo.id,
							bid: articulo.bid,
							moneda: true,
							id_moneda: articulo.id_moneda,
							id_coleccionista: articulo.bid_by.id,
							id_participante: articulo.bid_by.id_participante,
							coleccionista_nombre: articulo.bid_by.nombre,
							articulo_nombre: articulo.nombre,
						});
					} else {
						no_vendidos.push(articulo.id);
					}
				});
				this.pinturas.forEach((articulo) => {
					if (articulo.bid > articulo.por_min_ganancia) {
						vendidos.push({
							id: articulo.id,
							bid: articulo.bid,
							pintura: true,
							id_pintura: articulo.id_pintura,
							id_coleccionista: articulo.bid_by.id,
							id_participante: articulo.bid_by.id_participante,
							coleccionista_nombre: articulo.bid_by.nombre,
							articulo_nombre: articulo.nombre,
						});
					} else {
						no_vendidos.push(articulo.id);
					}
				});
				this.info = { vendidos, no_vendidos, subasta_id: this.id };
				this.axios
					.post("http://localhost:4000/api/subasta/run", this.info, {
						headers: {
							"Content-Type": "application/json",
						},
					})
					.then((response) => {
						if (response.status == 200) {
							this.msg = "La subasta termino satisfactoriamente";
						} else {
							this.msg = response.data;
							this.info = null;
						}
					})
					.catch((error) => {
						console.log(error);
					});
			} else {
				this.dialog = false;
				this.$router.push("/Subastas");
			}
		},
	},
	props: {
		id: {
			type: Number,
		},
		duracion: {
			type: String,
			default: 12,
		},
		cerrada: {
			type: Boolean,
			default: true,
		},
		participantes: {
			type: Array,
		},
		monedas: {
			type: Array,
		},
		pinturas: {
			type: Array,
		},
	},
};
</script>
