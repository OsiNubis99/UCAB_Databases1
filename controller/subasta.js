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
	async get_facturas(request, response) {
		var facturas = await pool.query(`SELECT f.*,p.subasta,c.nombre,c.apellido,c.id as id_coleccionista from "AA_Factura" f 
		INNER JOIN "AA_Participante" p ON p.id = f.participante
		INNER JOIN "AA_Coleccionista" c ON c.id = p.coleccionista`);
		var renglones_pinturas = await pool.query(`SELECT r.*, p.nombre 
		 FROM "AA_Reglon_Factura" r 
			inner join "AA_Articulo_Subasta" a on a.id = r.articulo
			inner join "AA_Catalogo_Pintura" p on p.id = a.pintura`);
		var renglones_monedas = await pool.query(`SELECT r.*, m.nombre 
			FROM "AA_Reglon_Factura" r 
			 inner join "AA_Articulo_Subasta" a on a.id = r.articulo
			 inner join "AA_Catalogo_Moneda" c on c.id = a.moneda
			 inner join "AA_Moneda" m on m.id_moneda = c.moneda`);
		response.status(200).json({
			facturas: facturas.rows,
			renglones: [].concat(renglones_pinturas.rows, renglones_monedas.rows),
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
		subasta = await pool.query(
			'INSERT INTO "AA_Subasta_Evento" (fecha, duracion, costo_inscrip, costo_inscrip_cliente, pais_lugar, tipo, disponible) VALUES ($1, $2, $3, $4, $5, $6, true) RETURNING id',
			[fecha, duracion, costo_inscrip, costo_inscrip_cliente, pais_lugar, tipo]
		);
		for (var id of tiendas) {
			await pool.query(
				'INSERT INTO "AA_Tienda_Subasta" (tienda,subasta) values ($1,$2)',
				[id, subasta.rows[0].id]
			);
		}
		for (var coleccionista of coleccionistas) {
			await pool.query(
				'INSERT INTO "AA_Participante"(subasta,coleccionista) values ($2,$1)',
				[coleccionista, subasta.rows[0].id]
			);
		}
		for (var pintura of pinturas) {
			var { id, ask } = pintura;
			await pool.query(
				'INSERT INTO "AA_Articulo_Subasta" (subasta,por_min_ganancia,duracion,comprador,pintura) VALUES ($3,$1,$4,null,$2)',
				[ask, id, subasta.rows[0].id, duracion]
			);
		}
		for (var moneda of monedas) {
			var { id, ask } = moneda;
			await pool.query(
				'INSERT INTO "AA_Articulo_Subasta" (subasta,por_min_ganancia,duracion,comprador,moneda) VALUES ($3,$1,0,null,$2)',
				[ask, id, subasta.rows[0].id]
			);
		}
		console.log(request.body);
		response.status(200).json("Good");
	},
	async getAll(request, response) {
		await pool.query(
			`SELECT s.*,p.nombre as pais FROM "AA_Subasta_Evento" s 
			inner join "AA_Pais" p on p.id = s.pais_lugar
			order by fecha`,
			(error, results) => {
				if (error) {
					throw error;
				}
				response.status(200).json(results.rows);
			}
		);
	},
	async get(request, response) {
		var subasta = await pool.query(
			`SELECT s.*,p.nombre as pais FROM "AA_Subasta_Evento" s 
			inner join "AA_Pais" p on p.id = s.pais_lugar
			where s.id = $1`,
			[request.params.subastaId]
		);
		subasta = subasta.rows[0];
		if (subasta) {
			var tiendas = await pool.query(
				'SELECT * FROM "AA_Tienda_Subasta" t where t.subasta = $1',
				[subasta.id]
			);
			var pinturas = await pool.query(
				`SELECT 
				a.id,a.por_min_ganancia
				,a.duracion
				,p.id as id_pintura
				,p.nombre
				,p.fecha
				,p.estilo
				,p.size
				,p.artista
				,p.tienda
				,p.coleccionista
				,t.nombre as artista_nombre
				,t.apellido as artista_apellido
			FROM "AA_Articulo_Subasta" a  
				inner join "AA_Catalogo_Pintura" p on p.id = a.pintura
				inner join "AA_Artista" t on t.id = p.artista
			where a.subasta = $1`,
				[subasta.id]
			);
			var monedas = await pool.query(
				`SELECT 
				a.id,a.por_min_ganancia
				,a.duracion
				,c.tienda
				,m.id_moneda
				,m.nombre
				,m.tamano
				,m.metal
				,m.forma
				,m.canto
				,m.foto
				,m.motivo
				,m.peso
				,m.anverso
				,m.reverso
				,m.denominacion
				,d.nombre as divisa_nombre
				,p.nombre as pais
				,t.nombre as artista_nombre
				,t.apellido as artista_apellido
			FROM "AA_Articulo_Subasta" a  
				inner join "AA_Catalogo_Moneda" c on c.id = a.moneda
				inner join "AA_Moneda" m on m.id_moneda = c.moneda
				inner join "AA_Artista" t on t.id = m.artista
				inner join "AA_Divisa" d on d.id = m.divisa
				inner join "AA_Pais" p on p.id = m.creada_en
			where a.subasta = $1`,
				[subasta.id]
			);
			var participante = await pool.query(
				`SELECT 
				p.id as id_participante
				,c.*
				,n.nombre as pais_nacio
				,v.nombre as pais_vive
			FROM "AA_Participante" p  
				inner join "AA_Coleccionista" c on c.id = p.coleccionista
				inner join "AA_Pais" n on n.id = c.nacio
				inner join "AA_Pais" v on v.id = c.vive
			where p.subasta = $1`,
				[subasta.id]
			);
			console.log(request.body);
			response.status(200).json({
				subasta,
				tiendas: tiendas.rows,
				pinturas: pinturas.rows,
				monedas: monedas.rows,
				participante: participante.rows,
			});
		} else {
			response.status(500);
		}
	},
	async run(request, response) {
		var { vendidos, no_vendidos, subasta_id } = request.body;
		let factura_id = null;
		coleccionistas = [];
		vendidos.forEach(async (item) => {
			if (!coleccionistas[item.id_participante])
				coleccionistas[item.id_participante] = [];
			coleccionistas[item.id_participante].push({
				precio: item.bid,
				id: item.id,
				moneda: item.moneda,
				pintura: item.pintura,
				id_coleccionista: item.id_coleccionista,
				id_moneda: item.id_moneda,
				id_pintura: item.id_pintura,
			});
		});
		await pool.query(
			`UPDATE "AA_Subasta_Evento" set disponible = false where id = $1`,
			[subasta_id]
		);
		coleccionistas.forEach(async (coleccionista, index) => {
			var result = await pool.query(
				`INSERT INTO "AA_Factura" (total, fecha, participante)
					VALUES (0,NOW(),$1) RETURNING id ;`,
				[index]
			);
			factura_id = result.rows[0].id;
			await coleccionista.forEach(async (item) => {
				await pool.query(
					`INSERT INTO "AA_Reglon_Factura" (precio,factura,articulo)
						VALUES ($1,$2,$3);`,
					[item.precio, factura_id, item.id]
				);
				await pool.query(
					`
					UPDATE "AA_Factura" SET total = total + $1
						where id = $2;
					`,
					[item.precio, factura_id]
				);
				if (item.moneda) {
					await pool.query(
						`UPDATE "AA_Catalogo_Moneda" set tienda = null, coleccionista = $1 where moneda = $2`,
						[item.id_coleccionista, item.id_moneda]
					);
				}
				if (item.pintura) {
					await pool.query(
						`UPDATE "AA_Catalogo_Pintura" set tienda = null, coleccionista = $1 where id = $2`,
						[item.id_coleccionista, item.id_pintura]
					);
				}
			});
		});
		console.log(request.body);
		response.status(200).json("Good");
	},
};
