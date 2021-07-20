<template>
	<v-container fluid ma-3>
		<v-layout row wrap align-center justify-center>
			<v-flex xs11>
				<v-text-field
					v-model="dateRangeText"
					label="Date range"
					prepend-icon="mdi-calendar"
					readonly
				></v-text-field>
				<v-data-table
					:headers="headers"
					:items="filtersubastas"
					sort-by="fecha"
					:items-per-page="15"
					class="elevation-1 mb-5"
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
				<v-date-picker
					v-model="dates"
					range
					full-width
					:min="
						new Date(Date.now() + new Date().getTimezoneOffset() * 60000 * 5)
							.toISOString()
							.substr(0, 10)
					"
				></v-date-picker>
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
		dates: [],
	}),
	computed: {
		dateRangeText() {
			return this.dates.join(" ~ ");
		},
		filtersubastas() {
			if (this.dates.length == 2)
				return this.subastas.filter((subasta) => {
					var l1 = new Date(this.dates[0]);
					var l2 = new Date(this.dates[1]);
					if (l1 > l2) {
						var l3 = l1;
						l1 = l2;
						l2 = l3;
					}
					var t = new Date(subasta.fecha.slice(0, 10));
					return l1 <= t && t <= l2;
				});
			return this.subastas;
		},
	},
	created() {
		this.axios
			.get("http://localhost:4000/api/subasta/getAll")
			.then((response) => {
				this.subastas = response.data;
			})
			.catch((error) => {
				console.log("Error " + error);
			});
	},
};
</script>
