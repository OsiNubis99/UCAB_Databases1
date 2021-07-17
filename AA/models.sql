CREATE Table "AA_Pais"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nacionalidad VARCHAR(50) Not null
);
CREATE Table "AA_Divisa" (
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	pais integer not null,
	FOREIGN KEY (pais) REFERENCES "AA_Pais"(id) ON DELETE CASCADE
);
Create Table "AA_Artista"(
	id serial Primary KEY,
	nombre VARCHAR(100) Not null,
	apellido VARCHAR(100) NOT NULL
);
CREATE Table "AA_Moneda"(
	id serial Primary KEY,
	artista integer not null,
	FOREIGN KEY (artista) REFERENCES "AA_Artista"(id) ON DELETE CASCADE,
	divisa integer not null,
	FOREIGN KEY (divisa) REFERENCES "AA_Divisa"(id) ON DELETE CASCADE,
	creada_en integer not null,
	FOREIGN KEY (creada_en) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	nombre VARCHAR(100) Not null,
	tamano DECIMAL NOT NULL,
	metal VARCHAR (100) not null,
	forma VARCHAR (100) not null,
	motivo VARCHAR (100) not null,
	peso DECIMAL not null,
	anverso VARCHAR (100) not null,
	reverso VARCHAR (100) not null,
	denominacion VARCHAR (100) not null
);
CREATE Table "AA_Tienda" (
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	fecha_fundacion DATE not null,
	pagina VARCHAR(50),
	proposito VARCHAR(100) Not null,
	alcance VARCHAR(50) Not null,
	tipo VARCHAR(15) not NULL CONSTRAINT store_type CHECK (
		tipo = 'Antiguedades'
		OR tipo = 'antiguedades'
		OR tipo = 'Galeria'
		OR tipo = 'galeria'
		OR tipo = 'Numismatica'
		OR tipo = 'numismatica'
	)
);
CREATE Table "AA_Contacto_Tienda" (
	id serial PRIMARY KEY,
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	email VARCHAR (50) not null,
	telefono VARCHAR (50) not null,
	cargo VARCHAR (50) not null,
	nombre VARCHAR (50) not null,
	apellido VARCHAR (50) not null
);
CREATE Table "AA_Coleccionista"(
	id serial Primary KEY,
	nombre VARCHAR(100) Not null,
	telefono VARCHAR(20) not null,
	email VARCHAR(100) not null,
	nacio integer not null,
	FOREIGN KEY (nacio) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	vive integer not null,
	FOREIGN KEY (vive) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	fecha_nacimiento DATE not null
);
CREATE TABLE "AA_Cliente"(
	id serial PRIMARY KEY,
	coleccionista integer not null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista" (id),
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id),
	fecha DATE NOT NULL
);
CREATE TABLE "AA_Catalogo_Pintura"(
	id serial Primary KEY,
	nombre VARCHAR (50) Not null,
	fecha VARCHAR (10) NOT NULL,
	estilo VARCHAR(50) Not null,
	size VARCHAR(50) Not null,
	artista integer not null,
	FOREIGN KEY (artista) REFERENCES "AA_Artista"(id) ON DELETE CASCADE,
	tienda integer default null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	coleccionista integer default null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista"(id) ON DELETE CASCADE,
	CONSTRAINT paint_owner CHECK (
		tienda IS NULL
		OR coleccionista IS NULL
	)
);
CREATE TABLE "AA_Catalogo_Moneda" (
	id serial PRIMARY KEY,
	moneda integer,
	FOREIGN KEY (moneda) REFERENCES "AA_Moneda"(id),
	tienda integer default null,
	FOREIGN KEY(tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	coleccionista integer default null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista"(id) ON DELETE CASCADE,
	CONSTRAINT coin_owner CHECK (
		tienda IS NULL
		OR coleccionista IS NULL
	)
);
CREATE TABLE "AA_Subasta_Evento"(
	id serial PRIMARY KEY,
	fecha DATE NOT null,
	duracion DECIMAL NOT NULL,
	costo_inscrip DECIMAL,
	Costo_inscrip_cliente DECIMAL NOT NULL,
	pais_lugar integer,
	FOREIGN KEY (pais_lugar) REFERENCES "AA_Pais"(id),
	tipo VARCHAR(15) not NULL CONSTRAINT subasta_type CHECK (
		tipo = 'cerrada'
		OR tipo = 'dinamica'
	)
);



CREATE TABLE "AA_Tienda_Subasta"(
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	subasta integer not null,
	FOREIGN KEY (subasta) REFERENCES "AA_Subasta_Evento"(id) ON DELETE CASCADE



)

CREATE TABLE "AA_Costo_Envio"(
	id serial PRiMARY KEY,
	costo DECIMAl NOT NULL,
	embalaje DECIMAL,
	seguro DECIMAL,
	extra DECIMAL,
	pais integer not null,
	FOREIGN KEY (pais) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	evento integer not null,
	FOREIGN KEY (evento) REFERENCES "AA_Subasta_Evento"(id) ON DELETE CASCADE
);


CREATE TABLE "AA_Participante" (
	id serial PRIMARY KEY,
	Subasta integer not null,
	FOREIGN KEY (subasta) REFERENCES "AA_Subasta_Evento"(id) ON DELETE CASCADE,
	coleccionista integer not null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista"(id) ON DELETE CASCADE,
	factura integer
);
CREATE TABLE "AA_Factura"(
	id serial PRIMARY KEY,
	total Decimal not null,
	fecha DATE not null,
	participante integer not null,
	FOREIGN KEY (participante) REFERENCES "AA_Participante"(id) ON DELETE CASCADE
);
CREATE TABLE "AA_Reglon_Factura"(
	id serial PRIMARY KEY,
	precio DECIMAL,
	factura integer not null,
	FOREIGN KEY (factura) REFERENCES "AA_Factura"(id)
);
CREATE TABLE "AA_Articulo_Subasta"(
	id SERIAL PRIMARY KEY,
	por_min_ganancia DECIMAL not null,
	precio_alcanzado DECIMAL,
	duracion DECIMAL NOT NULL,
	subasta integer NOT NULL,
	FOREIGN KEY (subasta) REFERENCES "AA_Subasta_Evento"(id),
	comprador integer,
	FOREIGN KEY (comprador) REFERENCES "AA_Participante"(id),
	reglon_factura integer,
	FOREIGN KEY (reglon_factura) REFERENCES "AA_Reglon_Factura"(id),
	moneda integer default null,
	FOREIGN KEY(moneda) REFERENCES "AA_Catalogo_Moneda"(id) ON DELETE CASCADE,
	pintura integer default null,
	FOREIGN KEY (pintura) REFERENCES "AA_Catalogo_Pintura"(id) ON DELETE CASCADE,
	CONSTRAINT coin_owner CHECK (
		moneda IS NULL
		OR pintura IS NULL
	)
);