<template>
  <v-data-table
	  :headers="headers"
		:items="Clientes"
		:loading="cargando"
		loading-text="Cargando lo datos..."
		sort-by="id_cliente"
		class="elevation-1 ma-3"
	>
		<template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Clientes</v-toolbar-title>
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
											v-model="editedItem.id_cliente"
											:items="personas_names"
											label="Secciona la Persona"
										>
											<template v-slot:selection="{ item }">
												<v-chip>
													<span>{{ item[1] }}</span>
												</v-chip>
											</template>
										</v-select>
									</v-flex>
									<v-flex xs12 lg6>
										<v-select
											v-model="editedItem.id_sucursal"
											:items="sucursales_names"
											label="Secciona la Sucursal"
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
											v-model="editedItem.apellido_cliente"
											label="Apellido"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.direc_cliente"
											label="Direccion"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.calle"
											label="Calle"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.ciudad"
											label="Ciudad"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-select
											:items="generos"
											label="Genero"
											v-model="editedItem.genero"
											dense
										></v-select>
									</v-flex>
                  										<v-menu
        ref="menu"
        v-model="menu"
        :close-on-content-click="false"
        :return-value.sync="date"
        transition="scale-transition"
        offset-y
        min-width="auto"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-text-field
            v-model="editedItem.fecha_nac"
            label="Fecha de nacimiento"
            prepend-icon="mdi-calendar"
            readonly
            v-bind="attrs"
            v-on="on"
          ></v-text-field>
        </template>
        <v-date-picker
          v-model="editedItem.fecha_nac"
          no-title
          scrollable
        >
          <v-spacer></v-spacer>
          <v-btn
            text
            color="primary"
            @click="menu = false"
          >
            Cancel
          </v-btn>
          <v-btn
            text
            color="primary"
            @click="$refs.menu.save(editedItem.fecha_nac)"
          >
            OK
          </v-btn>
        </v-date-picker>
      </v-menu>

									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.profesion"
											label="Profesion"
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
generos:["M","H","N/A"],
		headers: [
			{
				text: "Id",
				value: "id_cliente",
			},
			{
				text: "Nnombre",
				value: "nombre_persona",
			},
			{
				text: "Apellido",
				value: "apellido_cliente",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Clientes: [],
		Personas: [],
		Sucursales: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		formTitle() {
			return this.editedIndex === -1 ? "Crear una Cliente" : "Editar Cliente";
		},
		personas_names() {
			return this.Personas.map(function(item) {
				return [item.id_persona, item.nombre_persona];
			});
		},
		sucursales_names() {
			return this.Sucursales.map(function(item) {
				return [item.id_sucursal, item.nb_sucursal];
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
			this.editedIndex = this.Clientes.indexOf(item);
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
				.get("http://localhost:4000/sucursales")
				.then((response) => {
					this.Sucursales = response.data;
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
				.get("http://localhost:4000/clientes")
				.then((response) => {
					this.Clientes = response.data;
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
			this.editedItem.id_cliente = this.editedItem.id_cliente[0];
			this.editedItem.id_sucursal = this.editedItem.id_sucursal[0];
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
						"http://localhost:4000/cliente",
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
								titulo: "Cliente Creado",
								info: "La cliente se ha creado correctamente",
							};
						}
					})
					.catch((error) => {
							console.log(error);
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
