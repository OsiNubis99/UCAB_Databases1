<template>
  <v-data-table
	  :headers="headers"
		:items="Agentes"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id_agente"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Agentes</v-toolbar-title>
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
											v-model="editedItem.id_agente"
											:items="agentes_names"
											label="Secciona el Agente"
										>
											<template v-slot:selection="{ item }">
												<v-chip>
													<span>{{ item[1] }}</span>
												</v-chip>
											</template>
										</v-select>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.nombre_agente"
											label="Nomnre"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.num_telagente"
											label="Numero de Telefono"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-select
											:items="tipos"
											label="Tipo"
											v-model="editedItem.tipo_agente"
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
		headers: [
			{
				text: "Id",
				value: "id_agente",
			},
			{
				text: "Tipo",
				value: "tipo_agente",
			},
			{
				text: "Direccion",
				value: "direc_agente",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Agentes: [],
		Personas: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Agente" : "Editar Agente";
		},
		personas_names() {
			return this.Personas.map(function(item) {
				return [item.id_persona, item.nombre_persona];
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
			this.editedIndex = this.Agentes.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		iniciar() {
			this.cargando = true;
			this.axios
				.get("http://localhost:4000/personas")
				.then((response) => {
					this.Personas = response.data;
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
				.get("http://localhost:4000/agentes")
				.then((response) => {
					this.Agentes = response.data;
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
			console.log('test')
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
						"http://localhost:4000/agente",
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
								titulo: "Agente Creado",
								info: "La agente se ha creado correctamente",
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
