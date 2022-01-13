<template>
	<v-data-table
		:headers="headers"
		:items="Descarga"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="hash"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Descargas</v-toolbar-title>
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
											v-model="editedItem.nombre"
											label="Nombre del Archivo"
										></v-text-field>
									</v-flex>
									<v-flex xs6>
										<v-text-field
											v-model="editedItem.archivo"
											label="Link del Archivo"
										></v-text-field>
									</v-flex>
									<v-flex xs6>
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
		<template v-slot:item.hash="{ item }"
			>https://www.ofimania.com/Descarga/{{ item.hash }}</template
		>
		<template v-slot:item.action="{ item }">
			<v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
			<v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
			<v-menu offset-y v-if="item.id != 1">
				<template v-slot:activator="{ on }">
					<v-icon class="ml-2" small v-on="on">mdi-home</v-icon>
				</template>
				<v-list>
					<v-list-item @click="ordenar(item.hash, 1)">
						<v-list-item-title>Home Primero</v-list-item-title>
					</v-list-item>
					<v-list-item @click="ordenar(item.hash, 2)">
						<v-list-item-title>Home Segundo</v-list-item-title>
					</v-list-item>
					<v-list-item @click="ordenar(item.hash, 3)">
						<v-list-item-title>Home Tercero</v-list-item-title>
					</v-list-item>
				</v-list>
			</v-menu>
		</template>
		<template v-slot:item.home="{ item }">
			<span v-if="item.home == 0">No Home</span>
			<span v-if="item.home == 1">Home Primero</span>
			<span v-if="item.home == 2">Home Segundo</span>
			<span v-if="item.home == 3">Home Tercero</span>
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
				text: "Nombre del Archivo",
				value: "nombre",
			},
			{
				text: "Link",
				value: "hash",
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
		Descarga: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Descarga" : "Editar Descarga";
		},
	},
	watch: {
		dialog(val) {
			val || this.close();
		},
	},
	methods: {
		ordenar(hash, posición) {
			this.cargando = true;
			this.axios
				.get(
					"https://www.ofimania.com/API/Descarga/Home/" + hash + "/" + posición
				)
				.then((response) => {
					this.cargando = false;
					console.log(response);
					this.$store.state.alerta = {
						estado: true,
						tipo: "bien",
						titulo: "Entrada Asignada",
						info: "Entrada asignada a la posición: " + posición,
					};
					this.iniciar();
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
			this.dialog = true;
		},

		editItem(item) {
			this.editedIndex = this.Descarga.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar esta Tienda?") &&
				this.axios
					.get("https://www.ofimania.com/API/Descarga/Delete/" + item.hash)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Descarga Eliminada",
							info: "La Descarga se eliminó Correctamente",
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
				.get("https://www.ofimania.com/API/Descarga/Get")
				.then((response) => {
					this.Descarga = response.data;
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
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Descarga/Update/" +
							this.editedItem.hash,
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
								titulo: "Descarga Actualizada",
								info: "La Descarga se actualizó correctamente",
							};
						}
					})
					.catch((error) => {
						this.cargando = false;
						this.$store.state.alerta = {
							estado: true,
							tipo: "error",
							titulo: "Error de Conexion",
							info: error + "Verifique su Conexion a Internet",
						};
					});
			} else {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Descarga/Add",
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
								titulo: "Descarga Creada",
								info: "La Descarga se ha creado correctamente",
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
