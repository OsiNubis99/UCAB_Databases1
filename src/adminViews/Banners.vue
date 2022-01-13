<template>
	<v-data-table
		:headers="headers"
		:items="Imagen"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Imagen</v-toolbar-title>
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
											label="Titulo de la Imagen"
										></v-text-field>
									</v-flex>
									<v-flex xs6>
										<v-select
											:items="tipos"
											v-model="editedItem.tipo"
											label="Ubicación"
										></v-select>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="imagen"
											append-icon="mdi-camera"
											@click:append="limpiarImagen"
											label="Link de la Imagen"
										></v-text-field>
									</v-flex>
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
		<template v-slot:item.action="{ item }">
			<v-icon small class="mx-2" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
		</template>
	</v-data-table>
</template>

<script>
import EditorBlog from "@/adminComponents/EditorBlog.vue";
import EntradaBlog from "@/components/EntradaBlog.vue";
export default {
	created() {
		this.iniciar();
	},
	components: {
		EditorBlog,
		EntradaBlog,
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
		imagen: "",
		tipos: ["Banner-Blog", "Banner-Detal", "Banner-Mayor", "Banner-Movil"],
		headers: [
			{
				text: "Id",
				value: "id",
			},
			{
				text: "Titulo de la Imagen",
				value: "nombre",
			},
			{
				text: "Ubicación",
				value: "tipo",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Imagen: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1
				? "Subir Imagen"
				: this.editedIndex === -2
				? "Vista Previa"
				: "Editar Imagen";
		},
	},
	watch: {
		dialog(val) {
			val || this.close();
		},
	},
	methods: {
		limpiarImagen() {
			if (this.imagen != "") {
				this.editedItem.imagen =
					"https://drive.google.com/uc?export=view&id=" +
					this.imagen.split("/")[5];
				this.imagen = "";
			}
		},

		viewItem(item) {
			this.editedIndex = -2;
			this.editedItem = Object.assign({}, item);
			this.$store.state.contenidoEditor = item.contenido;
			this.dialog = true;
		},

		editItem(item) {
			this.editedIndex = this.Imagen.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.$store.state.contenidoEditor = item.contenido;
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar esta Tienda?") &&
				this.axios
					.get("https://www.ofimania.com/API/Imagen/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Banner Eliminado",
							info: "El Banner se eliminó Correctamente",
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
				.get("https://www.ofimania.com/API/Imagen/Get")
				.then((response) => {
					this.Imagen = response.data;
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
			this.limpiarImagen();
			this.close();
			this.cargando = true;
			this.editedItem.contenido = this.$store.state.contenidoEditor;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Imagen/Update/" + this.editedItem.id,
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
								titulo: "Banner Actualizado",
								info: "El Banner se actualizó correctamente",
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
						"https://www.ofimania.com/API/Imagen/Add",
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
								titulo: "Banner Creado",
								info: "El Banner se ha creado correctamente",
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
