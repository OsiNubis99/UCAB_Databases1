<template>
	<div>
		<v-btn color="primary" dark @click="run()">Run </v-btn>
		<v-dialog v-model="dialog" persistent>
			<v-card justify-center>
				<v-card-title class="text-h5">
					{{ rest_timer }}
				</v-card-title>
				<v-select
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

				<v-container pa-5 v-if="participante">
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
								participante["pinturas" + pintura.id]
									? "Tu puja es de: " + participante["pinturas" + pintura.id]
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
								participante["monedas" + moneda.id]
									? "Tu puja es de: " + participante["monedas" + moneda.id]
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
				<v-card-actions>
					<v-spacer></v-spacer>
					<v-btn color="red darken-1" text @click="finish()">
						Finalizar
					</v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>
	</div>
</template>

<script>
export default {
	data: () => ({
		rest_timer: "0h 0m 0s",
		msg: "",
		puja: {},
		running: false,
		interval: null,
		dialog: false,
		info: {},
		subasta: null,
		participante: null,
	}),
	methods: {
		run() {
			this.dialog = true;
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
		},
		pujar(articulo, id, index) {
			var monto = Number.parseFloat(
				this.puja[articulo + this.participante.id + id]
			);
			if (monto > 0) {
				this.puja[articulo + this.participante.id + id] = null;
				this.msg = "";
				if (this.cerrada) {
					this.participante[articulo + id] = monto;
				} else {
					if (monto > (this[articulo][index].bid || 0)) {
						this[articulo][index].bid = monto;
						this[articulo][index].bid_by = this.participante;
					} else this.msg = "El monto debe ser mayor que el Bid actual";
				}
			} else {
				this.msg =
					"Este monto no esta permitido: " +
					this.puja[articulo + this.participante.id + id];
			}
		},
		finish() {
			if (this.running) {
				clearInterval(this.interval);
				this.rest_timer = "Terminada";
			} else {
				this.dialog = false;
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
