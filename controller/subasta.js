const pool = require("../db/db");

module.exports = {
	async get_deps(request, response) {
		var tiendas = await pool.query('SELECT * FROM "AA_Tienda"');
		var coleccionistas = await pool.query('SELECT * FROM "AA_Coleccionista"');
		var pais = await pool.query('SELECT * FROM  "AA_Pais"');
		var catalocoPintura = await pool.query(
			'SELECT * FROM  "AA_Catalogo_Pintura"'
		);
		var catalogoMoneda = await pool.query(
			'SELECT * FROM  "AA_Catalogo_Moneda" inner join "AA_Moneda" on "AA_Catalogo_Moneda".moneda="AA_Moneda".id_moneda'
		);
		var res = {
			tiendas: tiendas.rows,
			coleccionistas: coleccionistas.rows,
			pais: pais.rows,
			pinturas: catalocoPintura.rows,
			monedas: catalogoMoneda.rows,
		};
		// console.log(res);
		response.status(200).json(res);
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
};
