<template>
	<v-container fluid ma-3 v-if="subasta">
		<v-layout row wrap align-center justify-center>
			<v-flex xs3>
				<v-card>
					<v-card-title>
						<h2>
							{{ subasta.fecha.slice(0, 10) }}
						</h2>
					</v-card-title>
					<hr />
					<v-card-text>
						Duración: {{ subasta.duracion }}min
						<br />
						Inscripción: {{ subasta.costo_inscrip }}
						<br />
						participantes: {{ subasta.costo_inscrip_cliente }}
						<br />
						Tipo: '{{ subasta.tipo }}'
						<br />
						Lugar: {{ subasta.pais }}
					</v-card-text>
					<v-card-actions>
						<v-spacer></v-spacer>
						<Cerrada
							:id="subasta.id"
							:duracion="subasta.duracion"
							:cerrada="subasta.tipo == 'Cerrada'"
							:monedas="monedas"
							:pinturas="pinturas"
							:participantes="participantes"
						/>
						<v-spacer></v-spacer>
					</v-card-actions>
				</v-card>
			</v-flex>
			<v-flex xs9 justify-center align-center pa-8>
				<h2>Pinturas</h2>
				<v-expansion-panels accordion>
					<v-expansion-panel v-for="(pintura, i) in pinturas" :key="i">
						<v-expansion-panel-header v-text="pintura.nombre" />
						<v-expansion-panel-content>
							<v-layout row wrap>
								<v-flex xs4 align-self-center>
									NUR: {{ pintura.id_pintura }}
									<br />
									Por: {{ pintura.artista_nombre }}
									{{ pintura.artista_apellido }},
									{{ pintura.fecha }}
									<br />
									Estilo: {{ pintura.estilo }}
									<br />
									Dimensiones: {{ pintura.size }}
								</v-flex>
								<v-flex xs8 pa-5>
									<v-img
										:src="
											pintura.img ||
												'https://www.inviaggiodasoli.com/wp-content/uploads/2017/10/Lofoten18-1620x1080.jpg'
										"
									></v-img>
								</v-flex>
							</v-layout>
						</v-expansion-panel-content>
					</v-expansion-panel>
				</v-expansion-panels>
				<h2>Monedas</h2>
				<v-expansion-panels accordion>
					<v-expansion-panel v-for="(moneda, i) in monedas" :key="i">
						<v-expansion-panel-header v-text="moneda.nombre" />
						<v-expansion-panel-content>
							NUR: {{ moneda.id_moneda }} <br />
							Denominación: {{ moneda.denominacion }} <br />
							Divisa: {{ moneda.divisa_nombre }}<br />
							Material: {{ moneda.metal }} <br />
							Diámetro: {{ moneda.tamano }} <br />
							Canto: {{ moneda.canto }} <br />
							Peso: {{ moneda.peso }} <br />
							Año: {{ moneda.fecha }} <br />
							Acuñación: {{ moneda.pais }} <br />
							Motivo: {{ moneda.motivo }} <br />
							Artista: {{ moneda.artista_nombre }}
							{{ moneda.artista_apellido }} <br />
							Foto: {{ moneda.img }}<br />
							Anverso {{ moneda.anverso }} <br />
							Reverso {{ moneda.reverso }}
						</v-expansion-panel-content>
					</v-expansion-panel>
				</v-expansion-panels>
			</v-flex>
		</v-layout>
		<v-layout row wrap>
			<v-flex xs12>
				<v-data-table
					:headers="headers"
					:items="participantes"
					:items-per-page="15"
				>
				</v-data-table>
			</v-flex>
		</v-layout>
	</v-container>
</template>

<script>
import Cerrada from "../components/cerrada";
export default {
	data: () => ({
		info: {},
		subasta: null,
		participantes: [],
		pinturas: [],
		monedas: [],
		headers: [
			{
				text: "Nombre",
				align: "start",
				value: "nombre",
			},
			{ text: "Apellido", value: "apellido" },
			{ text: "Nacio", value: "pais_nacio" },
			{ text: "Vive", value: "pais_vive" },
			{ text: "Email", value: "email" },
			{ text: "Telefono", value: "telefono" },
		],
	}),
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/get/" + this.id)
			.then((response) => {
				this.info = response.data;
				this.subasta = response.data.subasta;
				this.participantes = response.data.participante;
				this.pinturas = response.data.pinturas;
				this.monedas = response.data.monedas;
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
	components: {
		Cerrada,
	},
	props: {
		id: {
			type: String,
			default: "",
		},
	},
};
</script>
