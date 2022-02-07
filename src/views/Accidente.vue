<template>
  <v-data-table
	  :headers="headers"
		:items="Accidentes"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="nro_referencia"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Accidentes</v-toolbar-title>
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
											v-model="editedItem.id_categoria_acc"
											:items="categoria_accs_names"
											label="Secciona la Categoria_Acc"
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
													label="Fecha del accidente"
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
											v-model="editedItem.lugar_acc"
											label="Lugar accidente"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.hora_acc"
											label="Hora accidente"
										></v-text-field>
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
				value: "nro_referencia",
			},
			{
				text: "Fecha",
				value: "fecha",
			},
			{
				text: "Lugar",
				value: "lugar_acc",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Accidentes: [],
		Categoria_Accs: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Accidente" : "Editar Accidente";
		},
		categoria_accs_names() {
			return this.Categoria_Accs.map(function(item) {
				return [item.id_categoria_accidente, item.descrip_subcategoria];
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
			this.editedIndex = this.Accidentes.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		iniciar() {
			this.cargando = true;
			this.axios
				.get("http://localhost:4000/categoria_accs")
				.then((response) => {
					this.Categoria_Accs = response.data;
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
				.get("http://localhost:4000/accidentes")
				.then((response) => {
					this.Accidentes = response.data;
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
			this.editedItem.id_categoria_acc = this.editedItem.id_categoria_acc[0];
			console.log(this.editedItem.id_categoria_acc)
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
						"http://localhost:4000/accidente",
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
								titulo: "Accidente Creado",
								info: "La accidente se ha creado correctamente",
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
