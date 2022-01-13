<template>
	<v-data-table
		:headers="headers"
		:items="Usuario"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="fecha"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Usuarios Registrados</v-toolbar-title>
				<v-divider class="mx-4" inset vertical></v-divider>
				<v-spacer></v-spacer>
				<v-dialog v-model="dialog">
					<template v-slot:activator="{ on }">
						<v-btn color="primary" dark class="mb-2" v-on="on">
							<v-icon>mdi-at</v-icon>
						</v-btn>
					</template>
					<v-card>
						<v-card-title>
							<span class="headline">Correos Registrados</span>
						</v-card-title>
						<v-card-text>
							<span v-for="persona in Usuario" :key="persona.id"
								>{{ persona.correo }},</span
							>
						</v-card-text>
						<v-card-actions>
							<v-spacer></v-spacer>
							<v-btn color="green" text @click="arrayObjToCsv(Usuario)"
								>Guardar CSV</v-btn
							>
							<v-btn color="primary" text @click="close">Cerrar</v-btn>
						</v-card-actions>
					</v-card>
				</v-dialog>
			</v-toolbar>
		</template>
		<template v-slot:item.juridico="{ item }">
			<span v-if="item.juridico != 0">Jurídica</span>
			<span v-else>Natural</span>
		</template>
		<template v-slot:item.action="{ item }">
			<v-icon small class="mr-2" @click="editItem(item)"> mdi-pencil </v-icon>
			<v-icon small @click="deleteItem(item)"> mdi-delete </v-icon>
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
		dialogo: false,
		cargando: false,
		headers: [
			{
				text: "J/N",
				value: "juridico",
			},
			{
				text: "Rif",
				value: "rif",
			},
			{
				text: "Nombre O Razon social",
				value: "nombre",
			},
			{
				text: "Correo Electrónico",
				value: "correo",
			},
			{
				text: "Telefono",
				value: "telefono",
			},
			{
				text: "Estado",
				value: "estado",
			},
			{
				text: "Fecha",
				value: "fecha",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Usuario: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear Usuario" : "Editar Usuario";
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
			this.editedIndex = this.Usuario.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},

		deleteItem(item) {
			this.cargando = true;
			confirm("Esta seguro que desea eliminar este Usuario?") &&
				this.axios
					.get("https://www.ofimania.com/API/Usuario/Delete/" + item.id)
					.then((response) => {
						this.cargando = false;
						this.iniciar();
						this.$store.state.alerta = {
							estado: true,
							tipo: "bien",
							titulo: "Usuario Eliminado",
							info: "El Usuario se eliminó Correctamente",
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
				.get("https://www.ofimania.com/API/Usuario/Get")
				.then((response) => {
					this.Usuario = response.data;
					console.log(response.data);
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
		arrayObjToCsv(ar) {
			if (window.Blob && (window.URL || window.webkitURL)) {
				var contenido = "",
					d = new Date(),
					blob,
					reader,
					save,
					clicEvent;
				for (var i = 0; i < ar.length; i++) {
					if (i == 0) contenido += "Nombre,Correo\n";
					contenido += '"' + ar[i].nombre + '","' + ar[i].correo + '"\n';
				}
				blob = new Blob(["\ufeff", contenido], {
					type: "text/csv",
				});
				var reader = new FileReader();
				reader.onload = function (event) {
					save = document.createElement("a");
					save.href = event.target.result;
					save.target = "_blank";
					save.download =
						"Usuarios-" +
						d.getDate() +
						"-" +
						(d.getMonth() + 1) +
						"-" +
						d.getFullYear() +
						".csv";
					try {
						clicEvent = new MouseEvent("click", {
							view: window,
							bubbles: true,
							cancelable: true,
						});
					} catch (e) {
						clicEvent = document.createEvent("MouseEvent");
						clicEvent.initEvent("click", true, true);
					}
					save.dispatchEvent(clicEvent);
					(window.URL || window.webkitURL).revokeObjectURL(save.href);
				};
				reader.readAsDataURL(blob);
			} else {
				alert("Su navegador no permite esta acción");
			}
		},

		async save() {
			var qs = require("qs");
			this.close();
			this.cargando = true;
			if (this.editedIndex > -1) {
				await this.axios
					.post(
						"https://www.ofimania.com/API/Usuario/Update/" + this.editedItem.id,
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
								titulo: "Usuario Actualizado",
								info: "El Usuario se actualizó correctamente",
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
						"https://www.ofimania.com/API/Usuario/Add",
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
								titulo: "Usuario Creado",
								info: "El Usuario se ha creado correctamente",
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
