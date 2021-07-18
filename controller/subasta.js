const pool = require("../db/db");
const { put } = require("../routes/subasta");

module.exports = {
	async get_deps(request, response) {
		var tiendas = await pool.query('SELECT * FROM "AA_Tienda"');
		var coleccionistas = await pool.query('SELECT * FROM "AA_Coleccionista"');
		var clientes = await pool.query('SELECT * FROM "AA_Cliente"');
		var pais = await pool.query('SELECT * FROM  "AA_Pais"');
		var catalogoPintura = await pool.query(
			'SELECT * FROM  "AA_Catalogo_Pintura"'
		);
		var catalogoMoneda = await pool.query(
			'SELECT * FROM  "AA_Catalogo_Moneda" inner join "AA_Moneda" on "AA_Catalogo_Moneda".moneda="AA_Moneda".id_moneda'
		);
		response.status(200).json({
			tiendas: tiendas.rows,
			coleccionistas: coleccionistas.rows,
			clientes: clientes.rows,
			pais: pais.rows,
			pinturas: catalogoPintura.rows,
			monedas: catalogoMoneda.rows,
		});
	},
	async put(request, response) {
		var {
			duracion,
			costo_inscrip,
			costo_inscrip_cliente,
			tipo,
			fecha,
			pais_lugar,
			tiendas,
			coleccionistas,
			monedas,
			pinturas,
		} = request.body;

		// await pool.query(
		// 	'INSERT INTO "AA_Subasta_Evento"(fecha, duracion, costo_inscrip, costo_inscrip_cliente, pais_lugar, tipo) VALUES ($1, $2, $3, $4, $5, $6)',
		// 	[fecha, duracion, costo_inscrip, costo_inscrip_cliente, pais_lugar, tipo]
		// );

		// for (const id of tiendas) {
		// 	console.log(id);
		// 	parseInt(id);
		// 	const response1 = await pool.query(
		// 		'INSERT INTO "AA_Tienda_Subasta" (tienda,subasta) values ($1,(SELECT  id as subasta FROM "AA_Subasta_Evento"ORDER BY id DESC limit 1))',
		// 		[id]
		// 	);
		// }
		// for (const coleccionista of coleccionistas) {
		// 	const response2 = await pool.query(
		// 		'INSERT INTO "AA_Participante"(subasta,coleccionista,fatura) values ((SELECT  id as subasta FROM "AA_Subasta_Evento"ORDER BY id DESC limit 1),$1,null)',
		// 		[coleccionista]
		// 	);
		// }

		for (const pintura of pinturas) {
			const { id, aks } = pintura;
			await pool.query(
				'INSERT INTO "AA_Articulo_Subasta(subasta,por_min_alcanzado,duracion,comprador,reglon_factura,catalogo_pintura) VALUES ((SELECT  id as subasta FROM "AA_Subasta_Evento"ORDER BY id DESC limit 1),$1,0,null,null,$2)',
				[ask, id]
			);
		}
		for (const monedas of monedas) {
			const { id, aks } = pintura;
			await pool.query(
				'INSERT INTO "AA_Articulo_Subasta(subasta,por_min_alcanzado,duracion,comprador,reglon_factura,catalogo_moneda) VALUES ((SELECT  id as subasta FROM "AA_Subasta_Evento"ORDER BY id DESC limit 1),$1,0,null,null,$2)',
				[ask, id]
			);
		}

		console.log(request.body);
		response.status(200).json("Good");
	},
	async get(request, response) {
		await pool.query(
			'SELECT  * FROM "AA_Subasta_Evento" where id = ' + request.subastaId,
			(error, results) => {
				if (error) {
					throw error;
				}
				response.status(200).json(results.rows);
			}
		);
	},
	// async post(request, response) {},

	// async subastas(request,response){
	// 	await pool.query(
	// 		'SELECT * FROM "AA_Subasta_Evento"',
	// 		(error, results) => {
	// 			if (error) {
	// 				throw error;
	// 			}
	// 			response.status(200).json(results.rows);

	// 	)
	// },
};
