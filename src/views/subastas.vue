<template>
	<v-container fluid ma-3>
		<v-layout row wrap align-center justify-center>
			<v-flex xs11>
				<v-data-table
					:headers="headers"
					:items="subastas"
					:items-per-page="15"
					class="elevation-1"
				>
					<template v-slot:item.actions="{ item }">
						<v-btn color="black" text :to="'/Subasta/' + item.id">
							Ver mas
						</v-btn>
					</template>
					<template v-slot:item.fecha="{ item }">
						{{ item.fecha.slice(0, 10) }}
					</template>
				</v-data-table>
			</v-flex>
		</v-layout>
	</v-container>
</template>

<script>
export default {
	data: () => ({
		headers: [
			{
				text: "Fecha",
				align: "center",
				value: "fecha",
			},
			{ text: "Duración", value: "duracion", align: "center" },
			{ text: "Costo inscripción", value: "costo_inscrip", align: "center" },
			{
				text: "Costo inscripción Cliente ",
				value: "costo_inscrip_cliente",
				align: "center",
			},
			{ text: "Tipo", value: "tipo", align: "center" },
			{ text: "País", value: "pais", align: "center" },
			{ text: "Actions", value: "actions", sortable: false },
		],
		subastas: [],
	}),
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/getAll")
			.then((response) => {
				console.log(response.data);
				this.subastas = response.data;
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
};
</script>
