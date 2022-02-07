<template>
  <v-data-table
	  :headers="headers"
    :items="Contratos"
	  :loading="cargando"
	  loading-text="Cargando lo datos..."
	  sort-by="fecha_contrato"
	  class="elevation-1 ma-3"
  >
	  <template v-slot:top>
			<v-toolbar flat color="white">
				<v-toolbar-title>Contratos de Vehiculos</v-toolbar-title>
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
											v-model="editedItem.matricula"
											:items="matriculas"
											label="Secciona el Vehiculo"
										>
											<template v-slot:selection="{ item }">
												<v-chip>
													<span>{{ item }}</span>
												</v-chip>
											</template>
										</v-select>
									</v-flex>
									<v-flex xs12 lg6>
										<v-select
											v-model="editedItem.id_cliente"
											:items="clientes_names"
											label="Secciona el Cliente"
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
											v-model="editedItem.monto_com_ag"
											label="Monto"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.tipo"
											label="Tipo"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.recargo"
											label="Recargo"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.descripcion_poliza"
											label="Descripcion"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.prima"
											label="Monto Prima"
										></v-text-field>
									</v-flex>
									<v-flex xs12 lg6>
										<v-text-field
											v-model="editedItem.descuento"
											label="Descuento"
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
				text: "Fecha Creado",
				value: "fecha_contrato",
			},
			{
				text: "ID Vehiculo",
				value: "matricula",
			},
			{
				text: "ID Cliente",
				value: "id_cliente",
			},
			{
				text: "ID Agente",
				value: "id_agente",
			},
			{
				text: "Comision",
				value: "monto_com_ag",
			},
			{
				text: "Tipo",
				value: "tipo",
			},
			{
				text: "Estado",
				value: "estado_contrato",
			},
			{
				text: "Actions",
				value: "action",
				sortable: false,
			},
		],
		Contratos: [],
		Vehiculos: [],
		Clientes: [],
		Agentes: [],
		editedIndex: -1,
		editedItem: {},
	}),
	computed: {
		matriculas() {
			return this.Vehiculos.map(function(item) {
				return item.matricula;
			});
		},
		clientes_names() {
			return this.Clientes.map(function(item) {
				return [item.id_persona, item.nombre_persona + " " + item.apellido_cliente];
			});
		},
		agentes_names() {
			return this.Agentes.map(function(item) {
				return [item.id_persona, item.nombre_persona];
			});
		},
		formTitle() {
			return this.editedIndex === -1 ? "Crear un Vehiculo" : "Editar Vehiculo";
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
			this.editedIndex = this.Vehiculos.indexOf(item);
			this.editedItem = Object.assign({}, item);
			this.dialog = true;
		},
		iniciar() {
			this.cargando = true;
			this.axios
				.get("http://localhost:4000/contratos_Vehiculo")
				.then((response) => {
					this.cargando = false;
					this.Contratos = response.data.Contratos;
					this.Vehiculos = response.data.Vehiculos;
					this.Clientes = response.data.Clientes;
					this.Agentes = response.data.Agentes;
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
			this.editedItem.id_cliente = this.editedItem.id_cliente[0];
			this.editedItem.id_agente = this.editedItem.id_agente[0];
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
						"http://localhost:4000/contrata_Vehiculo",
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
								titulo: "Vehiculo Creado",
								info: "El vehiculo se ha creado correctamente",
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
