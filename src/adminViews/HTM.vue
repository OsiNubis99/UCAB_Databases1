<template>
	<v-data-table
		:headers="headers"
		:items="HazloTuMismo"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>HazloTuMismo</v-toolbar-title>
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
											v-model="editedItem.titulo"
											label="Titulo"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="video"
											append-icon="mdi-youtube"
											@click:append="limpiarVideo"
											label="Link del Video"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="imagen"
											append-icon="mdi-camera"
											@click:append="limpiarImagen"
											label="Link de la Imagen"
										></v-text-field>
									</v-flex>
									<EditorBlog />
								</v-layout>
								<v-layout wrap justify-center v-else>
									<EntradaHTM
										:titulo="editedItem.titulo"
										:video="editedItem.video"
										:img="editedItem.imagen"
										:contenido="$store.state.contenidoEditor"
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
		<template v-slot:item.action="{ item }">
			<v-icon small @click="viewItem(item)">mdi-eye</v-icon>
			<v-icon small class="mx-2" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small class="mr-2" @click="deleteItem(item)">mdi-delete</v-icon>
			<v-menu offset-y>
				<template v-slot:activator="{ on }">
					<v-icon small v-on="on">mdi-home</v-icon>
				</template>
				<v-list>
					<v-list-item @click="ordenar(1, item.id)">
						<v-list-item-title>Home Derecha</v-list-item-title>
					</v-list-item>
					<v-list-item @click="ordenar(2, item.id)">
						<v-list-item-title>Home Izquierda</v-list-item-title>
					</v-list-item>
				</v-list>
			</v-menu>
		</template>
		<template v-slot:item.home="{ item }">
			<span v-if="item.home == 0">No Home</span>
			<span v-if="item.home == 1">Home Derecha</span>
			<span v-if="item.home == 2">Home Izquierda</span>
		</template>
	</v-data-table>
</template>

<script>
import EditorBlog from "@/adminComponents/EditorBlog.vue";
import EntradaHTM from "@/components/EntradaHTM.vue";
export default {
	created() {
		this.iniciar();
	},
	components: {
		EditorBlog,
		EntradaHTM,
	},
	props: {
		titulo: {
			type: String,
			default: "Titulo",
		},
	},
	data: () => ({
		dialog: false,
		imagen: "",
		video: "",
		cargando: false,
		headers: [
			{
				text: "Id",
				value: "id",
			},
			{
				text: "Titulo",
				value: "titulo",
			},
			{
				text: "Esta en Home",
				value: "home",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		HazloTuMismo: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1
				? "Crear una Entrada"
				: this.editedIndex === -2
				? "Vista Previa"
				: "Editar Entrada";
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

		limpiarVideo() {
			this.editedItem.video = this.video.split("/")[3];
		},

		viewItem(item) {
			this.editedIndex = -2;
			this.editedItem = Object.assign({}, item);
			this.$store.state.contenidoEditor = item.contenido;
			this.dialog = true;
		},

		editItem(item) {
			this.editedIndex = this.HazloTuMismo.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.$store.state.contenidoEditor = item.contenido;
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar esta Tienda?") &&
				this.axios
					.get("https://www.ofimania.com/API/HazloTuMismo/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Entrada Eliminada",
							info: "La Entrada se eliminó Correctamente",
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
				.get("https://www.ofimania.com/API/HazloTuMismo/Get")
				.then((response) => {
					this.HazloTuMismo = response.data;
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

		ordenar(position, index) {
			this.cargando = true;
			this.axios
				.get(
					"https://www.ofimania.com/API/HazloTuMismo/" + position + "/" + index
				)
				.then((response) => {
					this.cargando = false;
					this.$store.state.alerta = {
						estado: true,
						tipo: "bien",
						titulo: "Entrada Asignada",
						info: "Entrada asignada a la posición: " + position,
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

		async save() {
			var qs = require("qs");
			this.close();
			this.limpiarImagen();
			this.limpiarVideo();
			this.cargando = true;
			this.editedItem.contenido = this.$store.state.contenidoEditor;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/HazloTuMismo/Update/" +
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
								titulo: "Entrada Actualizada",
								info: "La Entrada se actualizó correctamente",
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
						"https://www.ofimania.com/API/HazloTuMismo/Add",
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
								titulo: "Entrada Creada",
								info: "La Entrada se ha creado correctamente",
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
