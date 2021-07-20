CREATE Table "AA_Pais"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nacionalidad VARCHAR(50) Not null
);

INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Aleman', 'Alemania');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Antartida', 'Antártida');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Argentino', 'Argentina');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Australiano', 'Australia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Estado Unidense', 'Estados Unidos');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Ingles', 'Inglaterra');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Italiano', 'Italia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Ruso', 'Rusia');
INSERT INTO "AA_Pais" ( nacionalidad,nombre) VALUES('Venezolano', 'Venezuela');
INSERT INTO "AA_Pais" ( id,nacionalidad,nombre) VALUES(0,'Online', 'ONLINE');


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
	denominacion VARCHAR (100) not null,
	foto VARCHAR(100) default null,
	canto VARCHAR(100) default null
);

INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10000', 1, 1, 1, 'franco', 2, 'hierro', 'circular','aniversario', 10, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10001', 2, 2, 2, 'Denario', 2, 'hierro', 'circular','aniversario', 10, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10002', 3, 3, 3, 'Quater', 2, 'hierro', 'circular', 'aniversario',10, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10003', 4, 4, 4, 'puya', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10004', 5, 5, 5, 'reales', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10005', 6, 6, 6, 'puya2', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10006', 7, 7, 7, 'RealesFelipe', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10007', 8, 8, 8, 'Dolar', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');
INSERT INTO "AA_Moneda"(id_moneda, artista, divisa, creada_en, nombre, tamano, metal, forma, motivo, peso, anverso, reverso, denominacion,canto) VALUES ('10008', 9, 9, 9, 'Denario2', 2, 'hierro', 'circular','aniversario', 9, 'anverso', 'reverso', '10','estriado');

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


CREATE Table "AA_Coleccionista"(
	id serial Primary KEY,
	nombre VARCHAR(50) Not null,
	nombre2 VARCHAR(50) Not null,
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
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Alexis','Quiros','Fernando','Artigas', '0000000000', 'correo@example.com', 2, 2, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Davi','Fernandez','castillo','a2', '00000000000', 'correo@example.com', 3, 3, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Ana','Maria','a1','a2', '00000000000', 'correo@example.com', 4, 4, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Maria','Ana','Velazque','a2', '00000000000', 'correo@example.com', 5, 5, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('luis','Fernando','a1','a2', '00000000000', 'correo@example.com', 6, 6, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Teresa','Carmen','a1','a2', '00000000000', 'correo@example.com', 7, 7, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Lucia','Isabell','Castro','a2', '00000000000', 'correo@example.com', 8, 8, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('francis','Valeria','Farrera','a2', '00000000000', 'correo@example.com', 9, 9, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('Gabriela','Carmen','fagundez','a2', '00000000000', 'correo@example.com', 7, 7, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('stefany','Isabell','Castro','Mendez', '00000000000', 'correo@example.com', 8, 8, '2021-07-17');
INSERT INTO "AA_Coleccionista"( nombre,nombre2,apellido,apellido2, telefono, email, nacio, vive, fecha_nacimiento) VALUES ('alejandroa','Valeria','Farrera','a2', '00000000000', 'correo@example.com', 9, 9, '2021-07-17');

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
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 2, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 3, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 4, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 5, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 6, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 7, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 8, '2021-07-17');
INSERT INTO "AA_Cliente"(coleccionista,tienda,fecha) VALUES (1, 9, '2021-07-17');

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
	),
	foto VARCHAR(100) default null
);

INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10000,'Mona Lisa','2021','oleo','12cmx35cm',1, 1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Leonardo_da_Vinci_-_Mona_Lisa_%28Louvre%2C_Paris%29.jpg/800px-Leonardo_da_Vinci_-_Mona_Lisa_%28Louvre%2C_Paris%29.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10002,'VirgenCanciller','2021','oleo','12cmx35cm',2, 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Jan_van_Eyck_070.jpg/800px-Jan_van_Eyck_070.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10003,'La Maja desnuda','2021','oleo','12cmx35cm',3, 3, 'https://es.wikipedia.org/wiki/La_maja_desnuda#/media/Archivo:Maja_desnuda_(museo_del_Prado).jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10004,'Las espigadoras','2021','oleo','12cmx35cm',4, 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Jean-Fran%C3%A7ois_Millet_-_Gleaners_-_Google_Art_Project_2.jpg/800px-Jean-Fran%C3%A7ois_Millet_-_Gleaners_-_Google_Art_Project_2.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10005,'las lecheras','2021','oleo','12cmx35cm',5, 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Johannes_Vermeer_-_Het_melkmeisje_-_Google_Art_Project.jpg/800px-Johannes_Vermeer_-_Het_melkmeisje_-_Google_Art_Project.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10006,'Miranda La Carraca','2021','oleo','12cmx35cm',6, 6, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Miranda_en_la_Carraca_by_Arturo_Michelena.jpg/800px-Miranda_en_la_Carraca_by_Arturo_Michelena.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10007,'La creacion de Adan','2021','oleo','12cmx35cm',7, 7, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Michelangelo_-_Creation_of_Adam_%28cropped%29.jpg/800px-Michelangelo_-_Creation_of_Adam_%28cropped%29.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10008,'Almendro en flor','2021','oleo','12cmx35cm',8, 8, '	https://upload.wikimedia.org/wikipedia/commons/thu…an_Gogh_-_Almond_blossom_-_Google_Art_Project.jpg');
INSERT INTO "AA_Catalogo_Pintura"(id, nombre, fecha, estilo, size, artista, tienda, coleccionista) VALUES (10009,'Ritmo de oto','2021','oleo','12cmx35cm',9, 9, 'https://historia-arte.com/_/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbSI6WyJcL2FydHdvcmtcL2ltYWdlRmlsZVwvYXV0dW1uLXJoeXRobS1udW1iZXItMzAuanBnIiwicmVzaXplLDgwMCJdfQ.tBhyV_Kq5HQaHmP17bixnSuyV7SLRW3-qa7XUryV32c.jpg');


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

INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10000, 1, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10001, 2, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10002, 3, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10003, 4, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10004, 5, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10005, 6, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10006, 7, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10007, 8, null);
INSERT INTO "AA_Catalogo_Moneda"(moneda, tienda, coleccionista) VALUES (10008, 9, null);

CREATE TABLE "AA_Subasta_Evento"(
	id serial PRIMARY KEY,
	fecha DATE NOT null,
	duracion DECIMAL NOT NULL,
	costo_inscrip DECIMAL,
	costo_inscrip_cliente DECIMAL NOT NULL,
	pais_lugar integer,
	FOREIGN KEY (pais_lugar) REFERENCES "AA_Pais"(id),
	tipo VARCHAR(15) not NULL CONSTRAINT subasta_type CHECK (
		tipo = 'Cerrada'
		OR tipo = 'Dinamica'
	),
	disponible Boolean not null
);

-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',2,100,50,1,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',3,100,50,2,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',4,100,50,3,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',5,100,50,4,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',5,100,50,5,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',2,100,50,1,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',3,100,50,2,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',4,100,50,3,'Cerrada',True);
-- insert into "AA_Subasta_Evento" ( fecha,duracion,costo_inscrip,costo_inscrip_cliente,pais_lugar,tipo,disponible) values ('2021-07-17',2,100,50,4,'Cerrada',True);

CREATE TABLE "AA_Tienda_Subasta"(
	id serial PRIMARY KEY,
	tienda integer not null,
	FOREIGN KEY (tienda) REFERENCES "AA_Tienda"(id) ON DELETE CASCADE,
	subasta integer not null,
	FOREIGN KEY (subasta) REFERENCES "AA_Subasta_Evento"(id) ON DELETE CASCADE
);

-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (1,2);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (2,3);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (3,4);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (4,5);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (6,6);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (7,7);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (8,8);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (9,9);
-- insert into "AA_Tienda_Subasta" (tienda,subasta) VALUES (1,1);


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
	FOREIGN KEY (coleccionista) REFERENCES "AA_Coleccionista"(id) ON DELETE CASCADE
);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (1,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (2,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (3,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (4,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (5,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (6,9);

-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (7,9);


-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,4);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,6);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,7);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,8);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (8,9);


-- insert into "AA_Participante" (subasta,coleccionista) VALUES (9,1);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (9,2);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (9,3);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (9,5);
-- insert into "AA_Participante" (subasta,coleccionista) VALUES (9,9);

CREATE TABLE "AA_Factura"(
	id serial PRIMARY KEY,
	total Decimal not null,
	fecha DATE not null,
	participante integer not null,
	FOREIGN KEY (participante) REFERENCES "AA_Participante"(id) ON DELETE CASCADE
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
	moneda integer default null,
	FOREIGN KEY(moneda) REFERENCES "AA_Catalogo_Moneda"(id) ON DELETE CASCADE,
	pintura integer default null,
	FOREIGN KEY (pintura) REFERENCES "AA_Catalogo_Pintura"(id) ON DELETE CASCADE,
	CONSTRAINT coin_owner CHECK (
		moneda IS NULL
		OR pintura IS NULL
	)
);

-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura)  VALUES (10,0,2,2,null,1);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (5,0,2,3,null,2);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,4,null,3);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,5,null,4);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,6,null,6);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,7,null,7);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,8,null,8);
-- insert into "AA_Articulo_Subasta" (por_min_ganancia,precio_alcanzado,duracion,subasta,comprador,pintura) VALUES (23,0,3,9,null,9);

CREATE TABLE "AA_Reglon_Factura"(
	id serial PRIMARY KEY,
	precio DECIMAL,
	factura integer not null,
	FOREIGN KEY (factura) REFERENCES "AA_Factura"(id),
	articulo integer,
	FOREIGN KEY (articulo) REFERENCES  "AA_Articulo_Subasta"(id)
);

