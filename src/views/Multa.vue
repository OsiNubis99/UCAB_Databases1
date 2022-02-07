<template>
  <v-data-table
	  :headers="headers"
		:items="Multas"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="nro_multa"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Multas</v-toolbar-title>
				<v-divider class="mx-4" inset vertical></v-divider>
				<v-spacer></v-spacer>
				<v-dialog v-model="dialog">
					<template v-slot:activator="{ on }">
						<v-btn color="primary" dark class="mb-2" v-on="on">
							<v-icon>mdi-plus</v-icon>
						</v-btn>
					</template>
					<v-card>
						<v-card-title>
							<span class="headline">{{ formTitle }}</span>
						</v-card-title>
						<v-card-text>
							<v-container grid-list-md>
								<v-layout wrap v-if="editedIndex != -2" justify-center>
									<v-flex xs12 lg6>
										<v-select
											v-model="editedItem.matricula"
											:items="vehiculos_names"
											label="Secciona la Vehiculo"
										>
											<template v-slot:selection="{ item }">
												<v-chip>
													<span>{{ item[1] }}</span>
												</v-chip>
											</template>
										</v-select>
									</v-flex>
									<v-flex xs12 lg6>
										<v-menu
											ref="menu1"
											v-model="menu1"
											:close-on-content-click="false"
											:return-value.sync="date"
											transition="scale-transition"
											offset-y
											min-width="auto"
											>
											<template v-slot:activator="{ on, attrs }">
												<v-text-field
													v-model="editedItem.fecha"
													label="Fecha de la multa"
													prepend-icon="mdi-calendar"
													readonly
													v-bind="attrs"
													v-on="on"
													></v-text-field>
											</template>
											<v-date-picker
												v-model="editedItem.fecha"
												no-title
												scrollable
												>
												<v-spacer></v-spacer>
												<v-btn
													text
													color="primary"
													@click="menu1 = false"
													>
													Cancel
												</v-btn>
												<v-btn
													text
													color="primary"
													@click="$refs.menu1.save(editedItem.fecha)"
													>
													OK
												</v-btn>
											</v-date-picker>
										</v-menu>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.lugar"
											label="Lugar de la multa"
											></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.hora"
											label="Hora de la Multa"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.importe"
											label="Importe de la multa"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-slider
											thumb-label
											step="1"
											ticks
											min="1"
											max="10"
											v-model="editedItem.puntaje"
											label="Puntaje Multa"
										></v-slider>
									</v-flex>
									{{editedItem.puntaje}}
								</v-layout>
							</v-container>
						</v-card-text>
						<v-card-actions>
							<v-spacer></v-spacer>
							<v-btn color="error" text @click="close">Cerrar</v-btn>
							<v-btn color="success" text @click="save" v-if="editedIndex == -1">
								Guardar
							</v-btn>
						</v-card-actions>
					</v-card>
				</v-dialog>
			</v-toolbar>
		</template>
		<template v-slot:item.action="{ item }">
			<v-icon small @click="viewItem(item)">mdi-eye</v-icon>
			<v-icon small class="mx-4" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
		</template>
	</v-data-table>
</template>

<script>
export default {
	created() {
		this.iniciar();
	},
	data: () => ({
		imagen: null,
		dialog: false,
		dialogo: false,
		cargando: false,
		tipos:[
			"SI","NO"
		],
		headers: [
			{
				text: "Id",
				value: "nro_referencia",
			},
			{
				text: "Fecha",
				value: "fecha",
			},
			{
				text: "Lugar",
				value: "lugar_multa",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Multas: [],
		Vehiculos: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Multa" : "Editar Multa";
		},
		vehiculos_names() {
			return this.Vehiculos.map(function(item) {
				return [item.matricula, item.marca+" "+item.modelo+" "+item.annio];
			});
		},
	},
	watch: {
		dialog(val) {
			val || this.close();
		},
	},
	methods: {
		viewItem(item) {
			this.editedIndex = -2;
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		editItem(item) {
			this.editedIndex = this.Multas.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		iniciar() {
			this.cargando = true;
			this.axios
				.get("http://localhost:4000/vehiculos")
				.then((response) => {
					this.Vehiculos = response.data;
				})
				.catch((error) => {
					this.cargando = false;
					this.$store.state.alerta = {
						estado: true,
						tipo: "error",
						titulo: "Error de Conexion",
						info: "Verifique su Conexion a Internet",
					};
				});
			this.axios
				.get("http://localhost:4000/multas")
				.then((response) => {
					this.Multas = response.data;
					this.cargando = false;
				})
				.catch((error) => {
					this.cargando = false;
					this.$store.state.alerta = {
						estado: true,
						tipo: "error",
						titulo: "Error de Conexion",
						info: "Verifique su Conexion a Internet",
					};
				});
		},
		close() {
			this.dialog = false;
			this.imagen = null;
			setTimeout(() => {
				this.editedItem = Object.assign({}, this.defaultItem);
				this.editedIndex = -1;
			}, 300);
		},
		async save() {
			this.editedItem.matricula = this.editedItem.matricula[0];
			console.log(this.editedItem.matricula)
			var qs = require("qs");
			this.cargando = true;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"" +
							this.editedItem.id,
						qs.stringify(this.editedItem),
						{
							headers: {
								"Content-Type": "application/x-www-form-urlencoded",
							},
						}
					)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						if (response.data.error != null) {
							this.$store.state.alerta = {
								estado: true,
								tipo: "error",
								titulo: "Error",
								info: "Verifique su Conexion a Internet",
							};
						} else {
							this.$store.state.alerta = {
								estado: true,
								tipo: "bien",
								titulo: "Tienda Actualizada",
								info: "La Tienda se actualizó correctamente",
							};
						}
					})
					.catch((error) => {
						this.cargando = false;
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error de Conexion",
							info: "Verifique su Conexion a Internet",
						};
					});
			} else {
				await this.axios
					.post(
						"http://localhost:4000/multa",
						qs.stringify(this.editedItem),
						{
							headers: {
								"Content-Type": "application/x-www-form-urlencoded",
							},
						}
					)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.close();
						if (response.data.error != null) {
							this.$store.state.alerta = {
								estado: true,
								tipo: "error",
								titulo: "Error",
								info: "Verifique su Conexion a Internet",
							};
						} else {
							this.$store.state.alerta = {
								estado: true,
								tipo: "bien",
								titulo: "Multa Creado",
								info: "La multa se ha creado correctamente",
							};
						}
					})
					.catch((error) => {
						this.cargando = false;
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error de Conexion",
							info: "Verifique su Conexion a Internet",
						};
					});
			}
		},
	},
};
</script>
