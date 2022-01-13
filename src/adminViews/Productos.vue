<template>
	<v-data-table
		:headers="headers"
		:items="Producto"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Productos Destacados</v-toolbar-title>
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
											v-model="editedItem.imagen"
											label="Alt de la Imagen"
										></v-text-field>
									</v-flex>
									<v-flex xs6>
										<v-select
											:items="categorias"
											v-model="editedItem.categoria"
											label="Categoría"
										></v-select>
									</v-flex>
									<v-flex xs6>
										<v-select
											:items="etiquetas"
											v-model="editedItem.etiqueta"
											label="Etiqueta"
										></v-select>
									</v-flex>
									<v-flex xs12>
										<v-text-field
											v-model="editedItem.descripcion"
											label="Descripción"
										></v-text-field>
									</v-flex>
									<v-layout>
										<v-flex xs6>
											<v-file-input
												v-model="imagen"
												accept="image/webp"
												label="Imagen"
											></v-file-input>
											<v-btn
												color="primary"
												@click="cargarFoto('Productos/' + editedItem.id)"
											>
												<v-icon class="mr-2">mdi-camera</v-icon>Subir Imagen
											</v-btn>
										</v-flex>
										<v-flex xs6>
											<v-text-field
												v-model="editedItem.precio"
												label="Precio"
											></v-text-field>
										</v-flex>
									</v-layout>
								</v-layout>
								<v-layout wrap justify-center>
									<Articulo
										:id="editedItem.id"
										:nombre="editedItem.nombre"
										:imagen="editedItem.imagen"
										:precio="editedItem.precio"
										:etiqueta="editedItem.etiqueta"
										:descripcion="editedItem.descripcion"
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
		<template v-slot:item.home="{ item }">
			<span v-if="item.home == 1">Si</span>
			<span v-else>No</span>
		</template>
		<template v-slot:item.action="{ item }">
			<v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
			<v-icon small @click="toHomeItem(item)" class="ml-2">mdi-home</v-icon>
		</template>
	</v-data-table>
</template>

<script>
import Articulo from "@/components/Articulo.vue";
import { mapMutations } from "vuex";
export default {
	created() {
		this.iniciar();
	},
	components: {
		Articulo,
	},
	data: () => ({
		dialog: false,
		imagen: null,
		cargando: false,
		categorias: [
			"Arte y Dibujo",
			"Boutique",
			"Escolar",
			"Hogar",
			"Novedades",
			"Oficina",
			"Tecnología",
		],
		etiquetas: ["DETAL", "MAYOR"],
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
				text: "Categoría",
				value: "categoria",
			},
			{
				text: "Etiqueta",
				value: "etiqueta",
			},
			{
				text: "Home",
				value: "home",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Producto: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear Producto" : "Editar Producto";
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
			this.editedIndex = this.Producto.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar este Producto?") &&
				this.axios
					.get("https://www.ofimania.com/API/Producto/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Producto Eliminado",
							info: "El Producto se eliminó Correctamente",
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

		toHomeItem(item) {
			this.cargando = true;
			if (item.home == 1) item.home = 0;
			else item.home = 1;
			this.axios
				.get(
					"https://www.ofimania.com/API/Producto/Home/" +
						item.id +
						"/" +
						item.home
				)
				.then((response) => {
					this.cargando = false;
					this.iniciar();
					this.$store.state.alerta = {
						estado: true,
						tipo: "bien",
						titulo: "Cambio aplicado",
						info: "Todos los cambios se aplicaron correctamente",
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
				.get("https://www.ofimania.com/API/Producto/GetAdmin")
				.then((response) => {
					this.Producto = response.data;
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
			var qs = require("qs");
			this.close();
			this.cargando = true;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Producto/Update/" +
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
						if (response.data.error != null) {
							this.$store.state.alerta = {
								estado: true,
								tipo: "error",
								titulo: "Error",
								info: "Verifique su Conexion a Internet",
							};
						} else {
							this.iniciar();
							this.$store.state.alerta = {
								estado: true,
								tipo: "bien",
								titulo: "Producto Actualizado",
								info: "El Producto se actualizó correctamente",
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
						"https://www.ofimania.com/API/Producto/Add",
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
								titulo: "Producto Creado",
								info: "El Producto se ha creado correctamente",
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
