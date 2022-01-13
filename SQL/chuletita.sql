INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('DE', 'Alemania');
SELECT 
		p.id as id_participante
		,c.*
	FROM "AA_Participante" p  
		inner join "AA_Coleccionista" c on c.id = p.coleccionista
		inner join "AA_Pais" n on n.id = c.nacio
		inner join "AA_Pais" v on v.id = c.vive
	where p.subasta = $1
UPDATE "AA_Factura" SET total = total + $1
	where id = $2
SELECT * 
	FROM  "AA_Catalogo_Moneda" 
		inner join "AA_Moneda" on "AA_Catalogo_Moneda".moneda="AA_Moneda".id_moneda

CREATE Table "AA_Pais"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nacionalidad VARCHAR(50) Not null
);
CREATE Table "AA_Divisa" (
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	pais integer not null,
);
Create Table "AA_Artista"(
	id serial Primary KEY,
	nombre VARCHAR(100) Not null,
	apellido VARCHAR(100) NOT NULL
);
CREATE Table "AA_Moneda"(
	id_moneda serial Primary KEY,
	artista integer not null,
	divisa integer not null,
	creada_en integer not null,
	nombre VARCHAR(100) Not null,
	tamano DECIMAL NOT NULL,
	metal VARCHAR (100) not null,
	forma VARCHAR (100) not null,
	motivo VARCHAR (100) not null,
	peso DECIMAL not null,
	anverso VARCHAR (100) not null,
	reverso VARCHAR (100) not null,
	denominacion VARCHAR (100) not null,
	foto VARCHAR(100) default null,
	canto VARCHAR(100) default null
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
		OR tipo = 'Galeria'
		OR tipo = 'Numismatica'
	)
);
CREATE Table "AA_Contacto_Tienda" (
	id serial PRIMARY KEY,
	tienda integer not null,
	email VARCHAR (50) not null,
	telefono VARCHAR (50) not null,
	cargo VARCHAR (50) not null,
	nombre VARCHAR (50) not null,
	apellido VARCHAR (50) not null
);
CREATE Table "AA_Coleccionista"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nombre2 VARCHAR(50) Not null,
	apellido VARCHAR(50) Not null,
	apellido2 VARCHAR(50) Not null,
	telefono VARCHAR(20) not null,
	email VARCHAR(50) not null,
	nacio integer not null,
	vive integer not null,
	fecha_nacimiento DATE not null
);
CREATE TABLE "AA_Cliente"(
	id serial PRIMARY KEY,
	coleccionista integer not null,
	tienda integer not null,
	fecha DATE NOT NULL
);
CREATE TABLE "AA_Catalogo_Pintura"(
	id serial Primary KEY,
	nombre VARCHAR (50) Not null,
	fecha VARCHAR (10) NOT NULL,
	estilo VARCHAR(50) Not null,
	size VARCHAR(50) Not null,
	artista integer not null,
	tienda integer default null,
	coleccionista integer default null,
	foto VARCHAR(100) default null
);
CREATE TABLE "AA_Catalogo_Moneda" (
	id serial PRIMARY KEY,
	moneda integer,
	tienda integer default null,
	FOREIGN KEY(tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	coleccionista integer default null,
);
CREATE TABLE "AA_Subasta_Evento"(
	id serial PRIMARY KEY,
	fecha DATE NOT null,
	duracion DECIMAL NOT NULL,
	costo_inscrip DECIMAL,
	costo_inscrip_cliente DECIMAL NOT NULL,
	pais_lugar integer,
	tipo VARCHAR(15) not NULL CONSTRAINT subasta_type CHECK (
		tipo = 'Cerrada'
		OR tipo = 'Dinamica'
	),
	disponible Boolean not null
);
CREATE TABLE "AA_Tienda_Subasta"(
	id serial PRIMARY KEY,
	tienda integer not null,
	subasta integer not null,
);
CREATE TABLE "AA_Costo_Envio"(
	id serial PRiMARY KEY,
	costo DECIMAl NOT NULL,
	embalaje DECIMAL,
	seguro DECIMAL,
	extra DECIMAL,
	pais integer not null,
	evento integer not null,
);
CREATE TABLE "AA_Participante" (
	id serial PRIMARY KEY,
	Subasta integer not null,
	coleccionista integer not null,
);
CREATE TABLE "AA_Factura"(
	id serial PRIMARY KEY,
	total Decimal not null,
	fecha DATE not null,
	participante integer not null,
);
CREATE TABLE "AA_Articulo_Subasta"(
	id SERIAL PRIMARY KEY,
	por_min_ganancia DECIMAL not null,
	precio_alcanzado DECIMAL,
	duracion DECIMAL NOT NULL,
	subasta integer NOT NULL,
	comprador integer,
	moneda integer default null,
	pintura integer default null,
);
CREATE TABLE "AA_Reglon_Factura"(
	id serial PRIMARY KEY,
	precio DECIMAL,
	factura integer not null,
	articulo integer,
);

