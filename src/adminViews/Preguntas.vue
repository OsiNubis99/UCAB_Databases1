<template>
	<v-data-table
		:headers="headers"
		:items="Pregunta"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Preguntas Frecuentes</v-toolbar-title>
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
									<v-flex xs12>
										<v-text-field
											v-model="editedItem.pregunta"
											label="Pregunta"
										></v-text-field>
									</v-flex>
									<v-flex xs12>
										<v-text-field
											v-model="editedItem.respuesta"
											label="Respuesta"
										></v-text-field>
									</v-flex>
								</v-layout>
								<v-layout wrap justify-center>
									<v-expansion-panels popout>
										<v-expansion-panel>
											<v-expansion-panel-header
												>## -
												{{ editedItem.pregunta }}</v-expansion-panel-header
											>
											<v-expansion-panel-content>{{
												editedItem.respuesta
											}}</v-expansion-panel-content>
										</v-expansion-panel>
									</v-expansion-panels>
								</v-layout>
							</v-container>
						</v-card-text>
						<v-card-actions>
							<v-spacer></v-spacer>
							<v-btn color="error" text @click="close">Cerrar</v-btn>
							<v-btn color="success" text @click="save" v-if="editedIndex != -2"
								>Guardar</v-btn
							>
						</v-card-actions>
					</v-card>
				</v-dialog>
			</v-toolbar>
		</template>
		<template v-slot:item.tipo="{ item }">{{
			item.tipo ? "Pregunta" : "Pregunta"
		}}</template>
		<template v-slot:item.action="{ item }">
			<v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
		</template>
	</v-data-table>
</template>

<script>
export default {
	created() {
		this.iniciar();
	},
	props: {
		titulo: {
			type: String,
			default: "Titulo",
		},
	},
	data: () => ({
		dialog: false,
		cargando: false,
		headers: [
			{
				text: "Id",
				value: "id",
			},
			{
				text: "Pregunta",
				value: "pregunta",
			},
			{
				text: "Respuesta",
				value: "respuesta",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Pregunta: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Pregunta" : "Editar Pregunta";
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
			this.editedIndex = this.Pregunta.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar esta Tienda?") &&
				this.axios
					.get("https://www.ofimania.com/API/Pregunta/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Pregunta Eliminada",
							info: "La Pregunta se eliminó Correctamente",
						};
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

		iniciar() {
			this.cargando = true;
			this.axios
				.get("https://www.ofimania.com/API/Pregunta/Get")
				.then((response) => {
					this.Pregunta = response.data;
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
			setTimeout(() => {
				this.editedItem = Object.assign({}, this.defaultItem);
				this.editedIndex = -1;
			}, 300);
		},

		async save() {
			var qs = require("qs");
			this.close();
			this.cargando = true;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Pregunta/Update/" +
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
								titulo: "Pregunta Actualizada",
								info: "La Pregunta se actualizó correctamente",
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
						"https://www.ofimania.com/API/Pregunta/Add",
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
								titulo: "Pregunta Creada",
								info: "La Pregunta se ha creado correctamente",
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
