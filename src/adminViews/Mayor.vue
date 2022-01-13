<template>
	<v-data-table
		:headers="headers"
		:items="Mayor"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Tiendas al Mayor</v-toolbar-title>
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
										<v-text-field
											v-model="editedItem.nombre"
											label="Nombre"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.direccion"
											label="Direccion"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.horario"
											label="Horario"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.telefono"
											label="Telefono"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.correo"
											label="Correo"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.whatsapp"
											label="Whatsapp"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.maps"
											label="Maps"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.imagen"
											label="Alt de la Imagen"
										></v-text-field>
									</v-flex>
									<v-layout>
										<v-file-input
											v-model="imagen"
											accept="image/webp"
											label="Imagen"
										></v-file-input>
										<v-btn
											color="primary"
											@click="cargarFoto('Mayores/' + editedItem.id)"
										>
											<v-icon class="mr-2">mdi-camera</v-icon>Subir Foto
										</v-btn>
									</v-layout>
								</v-layout>
								<v-layout wrap justify-center>
									<Tienda
										:id="editedItem.id"
										:nombre="editedItem.nombre"
										:direccion="editedItem.direccion"
										:horario="editedItem.horario"
										:telefono="editedItem.telefono"
										:correo="editedItem.whatsapp"
										:maps="editedItem.maps"
										:imagen="editedItem.imagen"
										:detales="false"
									/>
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
			item.tipo ? "Mayor" : "Mayor"
		}}</template>
		<template v-slot:item.action="{ item }">
			<v-icon small @click="viewItem(item)">mdi-eye</v-icon>
			<v-icon small class="mx-4" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
		</template>
	</v-data-table>
</template>

<script>
import Tienda from "@/components/Tienda.vue";
export default {
	created() {
		this.iniciar();
	},
	components: {
		Tienda,
	},
	data: () => ({
		imagen: null,
		dialog: false,
		cargando: false,
		headers: [
			{
				text: "Id",
				value: "id",
			},
			{
				text: "Nombre",
				value: "nombre",
			},
			{
				text: "Telefono",
				value: "telefono",
			},
			{
				text: "Correo",
				value: "correo",
			},
			{
				text: "Whatsapp",
				value: "whatsapp",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Mayor: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Tienda" : "Editar Tienda";
		},
	},
	watch: {
		dialog(val) {
			val || this.close();
		},
	},
	methods: {
		cargarFoto(rutaNombre) {
			if (this.imagen.type == "image/webp") {
				var data = new FormData();
				data.append("imagen", this.imagen);
				data.append("_method", "PUT");
				this.$store.state.alerta = {
					estado: true,
					tipo: "bien",
					titulo: "Cargando",
					info: "Verifique su Conexion a Internet",
				};
				this.axios
					.post("https://www.ofimania.com/API/Subir/" + rutaNombre, data, {
						headers: {
							"Content-Type": "application/x-prueba-form-urlencoded",
						},
					})
					.then((response) => {
						this.imagen = null;
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Foto actualizada",
							info: "No es necesario guardar",
						};
					})
					.catch((error) => {
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error de Conexion",
							info: "Verifique su Conexion a Internet",
						};
					});
			} else {
				this.$store.state.alerta = {
					estado: true,
					tipo: "error",
					titulo: "Error de Tipo",
					info: "La imagen debe ser formato WEBP",
				};
			}
		},

		viewItem(item) {
			this.editedIndex = -2;
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		editItem(item) {
			this.editedIndex = this.Mayor.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar esta Tienda?") &&
				this.axios
					.get("https://www.ofimania.com/API/Tienda/Mayor/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Tienda Eliminada",
							info: "La Tienda se eliminó Correctamente",
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
				.get("https://www.ofimania.com/API/Tienda/Mayor/Get")
				.then((response) => {
					this.Mayor = response.data;
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
						"https://www.ofimania.com/API/Tienda/Mayor/Update/" +
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
						"https://www.ofimania.com/API/Tienda/Mayor/Add",
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
								titulo: "Tienda Creada",
								info: "La Tienda se ha creado correctamente",
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
