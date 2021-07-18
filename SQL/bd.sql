CREATE Table "AA_Pais"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nacionalidad VARCHAR(50) Not null
);

INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('DE', 'Alemania');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('AQ', 'Antártida');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('AR', 'Argentina');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('AU', 'Australia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('US', 'Estados Unidos');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('GB', 'Inglaterra');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('IT', 'Italia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('RU', 'Rusia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('VE', 'Venezuela');

CREATE Table "AA_Divisa" (
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	pais integer not null,
	FOREIGN KEY (pais) REFERENCES "AA_Pais"(id) ON DELETE CASCADE
);

INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Euro', 1);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Dolar', 2);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Pesos', 3);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Dolar', 4);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Dolar',5);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Euro', 6);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Euro', 7);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Roblo', 8);
INSERT INTO "AA_Divisa"(nombre, pais) VALUES ( 'Bolivar', 9);

Create Table "AA_Artista"(
	id serial Primary KEY,
	nombre VARCHAR(100) Not null,
	apellido VARCHAR(100) NOT NULL
);

INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Leonardo','da Vinci');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Jan','van Eyck');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Francisco','de Goya');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Jean-François','Millet');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Johannes','Vermeer');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Arturo','Michelena');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Miguel','Ángel');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Vicent','Vangogh');
INSERT INTO "AA_Artista"(nombre, apellido) VALUES ( 'Johannes','Vermeer.');

CREATE Table "AA_Moneda"(
	id_moneda serial Primary KEY,
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
-- TODO
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 1, 1, 'franco', 2, 'hierro', 'circular','aniversario', 10, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 2, 2, 'Denario', 2, 'hierro', 'circular','aniversario', 10, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 3, 3, 'Quater', 2, 'hierro', 'circular', 'aniversario',10, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 4, 4, 'puya', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 5, 5, 'reales', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 6, 6, 'puya2', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 7, 7, 'RealesFelipe', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 8, 8, 'Dolar', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');
INSERT INTO "AA_Moneda"(divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion) VALUES ( 9, 9, 'Denario2', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10');

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

insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Neurotian', 'Neurotian.com', 'distribuir', 'Galeria');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'el marchante', 'Elmachante.com', 'coleccionar', 'Galeria');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Numisfila', 'Numisfila.com', 'distribuir', 'Antiguedades');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Sothebys', 'Sothebys.com', 'distribuir', 'Antiguedades');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Dorotheum', 'Dorotheum.com', 'distribuir', 'Antiguedades');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Bonhams', 'Bonhams.com', 'distribuir', 'Antiguedades');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'NYEvents', 'NYEvents.com', 'distribuir', 'Galeria');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'ArtWild', 'ArtWild.com', 'distribuir', 'Galeria');
insert into "AA_Tienda" ("alcance", "fecha_fundacion", "nombre", "pagina", "proposito", "tipo") values ('mundial', '2021-07-17', 'Almo', 'Almo.com', 'distribuir', 'Galeria');

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

-- TODO

CREATE Table "AA_Coleccionista"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nombre2 VARCHAR(50) Not null,sql/
	apellido VARCHAR(50) Not null,
	apellido2 VARCHAR(50) Not null,
	telefono VARCHAR(20) not null,
	email VARCHAR(50) not null,
	nacio integer not null,
	FOREIGN KEY (nacio) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	vive integer not null,
	FOREIGN KEY (vive) REFERENCES "AA_Pais"(id) ON DELETE CASCADE,
	fecha_nacimiento DATE not null
);

INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Andres','David','Hurtado','fernandez', '4120242258', 'adhurtado.17@est.ucab.edu.ve', 1, 1, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Alexis','Quiros','a1','a2', '0000000000', 'correo@example.com', 2, 2, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','3','a1','a2', '00000000000', 'correo@example.com', 3, 3, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','4','a1','a2', '00000000000', 'correo@example.com', 4, 4, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','5','a1','a2', '00000000000', 'correo@example.com', 5, 5, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','6','a1','a2', '00000000000', 'correo@example.com', 6, 6, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','7','a1','a2', '00000000000', 'correo@example.com', 7, 7, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','8','a1','a2', '00000000000', 'correo@example.com', 8, 8, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Test','9','a1','a2', '00000000000', 'correo@example.com', 9, 9, '2021-07-17');

CREATE TABLE "AA_Cliente"(
	id serial PRIMARY KEY,
	coleccionista integer not null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista" (id),
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id),
	fecha DATE NOT NULL
);

INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 1, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (2, 2, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (3, 3, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (4, 4, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (5, 5, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (6, 6, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (7, 7, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (8, 8, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (9, 9, '2021-07-17');

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

INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre1','2021-07-17','oleo','12cmx35cm',1, 1, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre2','2021-07-17','oleo','12cmx35cm',2, 2, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre3','2021-07-17','oleo','12cmx35cm',3, 3, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre4','2021-07-17','oleo','12cmx35cm',4, 4, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre5','2021-07-17','oleo','12cmx35cm',5, 5, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre6','2021-07-17','oleo','12cmx35cm',6, 6, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre7','2021-07-17','oleo','12cmx35cm',7, 7, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre8','2021-07-17','oleo','12cmx35cm',8, 8, null);
INSERT INTO "AA_Catalogo_Pintura"(nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES ('nombre9','2021-07-17','oleo','12cmx35cm',9, 9, null);

CREATE TABLE "AA_Catalogo_Moneda" (
	id serial PRIMARY KEY,
	moneda integer,
	FOREIGN KEY (moneda) REFERENCES "AA_Moneda"(id_moneda),
	tienda integer default null,
	FOREIGN KEY(tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	coleccionista integer default null,
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista"(id) ON DELETE CASCADE,
	CONSTRAINT coin_owner CHECK (
		tienda IS NULL
		OR coleccionista IS NULL
	)
);

INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (1, 1, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (2, 2, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (3, 3, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (4, 4, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (5, 5, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (6, 6, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (7, 7, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (8, 8, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (9, 9, null);

CREATE TABLE "AA_Subasta_Evento"(
	id serial PRIMARY KEY,
	fecha DATE NOT null,
	duracion DECIMAL NOT NULL,
	costo_inscrip DECIMAL,
	Costo_inscrip_cliente DECIMAL NOT NULL,
	pais_lugar integer,
	FOREIGN KEY (pais_lugar) REFERENCES "AA_Pais"(id),
	tipo VARCHAR(15) not NULL CONSTRAINT subasta_type CHECK (
		tipo = 'Cerrada'
		OR tipo = 'Dinamica'
	)
);
CREATE TABLE "AA_Tienda_Subasta"(
	id serial PRIMARY KEY,
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	subasta integer not null,
	FOREIGN KEY (subasta) REFERENCES "AA_Subasta_Evento"(id) ON DELETE CASCADE
);

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