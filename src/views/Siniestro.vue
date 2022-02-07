<template>
  <v-data-table
	  :headers="headers"
		:items="Siniestros"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="nro_siniestro"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Siniestros</v-toolbar-title>
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
											v-model="editedItem.id_poliza"
											:items="polizas_names"
											label="Secciona la Poliza"
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
													v-model="editedItem.fecha_siniestro"
													label="Fecha del siniestro"
													prepend-icon="mdi-calendar"
													readonly
													v-bind="attrs"
													v-on="on"
													></v-text-field>
											</template>
											<v-date-picker
												v-model="editedItem.fecha_siniestro"
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
													@click="$refs.menu1.save(editedItem.fecha_siniestro)"
													>
													OK
												</v-btn>
											</v-date-picker>
										</v-menu>
									</v-flex>
									<v-flex xs12 lg6>
										<v-menu
											ref="menu2"
											v-model="menu2"
											:close-on-content-click="false"
											:return-value.sync="date"
											transition="scale-transition"
											offset-y
											min-width="auto"
											>
											<template v-slot:activator="{ on, attrs }">
												<v-text-field
													v-model="editedItem.fecha_respuesta"
													label="Fecha de la respuesta"
													prepend-icon="mdi-calendar"
													readonly
													v-bind="attrs"
													v-on="on"
													></v-text-field>
											</template>
											<v-date-picker
												v-model="editedItem.fecha_respuesta"
												no-title
												scrollable
												>
												<v-spacer></v-spacer>
												<v-btn
													text
													color="primary"
													@click="menu2 = false"
													>
													Cancel
												</v-btn>
												<v-btn
													text
													color="primary"
													@click="$refs.menu2.save(editedItem.fecha_respuesta)"
													>
													OK
												</v-btn>
											</v-date-picker>
										</v-menu>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.nro_siniestro"
											label="Numero siniestro"
											></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.descripcion"
											label="Descripcion del siniestro"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.monto_reconocido"
											label="Monto Reconocido"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.monto_solicitado"
											label="Monto Solicitado"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-select
											:items="tipos"
											label="Fue rechazado?"
											v-model="editedItem.id_rechazo"
											dense
										></v-select>
									</v-flex>
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
				value: "nro_siniestro",
			},
			{
				text: "Fecha",
				value: "fecha_siniestro",
			},
			{
				text: "Descripcion",
				value: "descripcion",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Siniestros: [],
		Polizas: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Siniestro" : "Editar Siniestro";
		},
		polizas_names() {
			return this.Polizas.map(function(item) {
				return [item.id_poliza, item.descripcion_poliza];
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
			this.editedIndex = this.Siniestros.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		iniciar() {
			this.cargando = true;
			this.axios
				.get("http://localhost:4000/polizas")
				.then((response) => {
					this.Polizas = response.data;
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
				.get("http://localhost:4000/siniestros")
				.then((response) => {
					this.Siniestros = response.data;
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
			this.editedItem.id_poliza = this.editedItem.id_poliza[0];
			console.log(this.editedItem.id_poliza)
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
						"http://localhost:4000/siniestro",
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
								titulo: "Siniestro Creado",
								info: "La siniestro se ha creado correctamente",
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
