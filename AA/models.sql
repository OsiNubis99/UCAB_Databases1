--
-- Create model Articulo_Subasta
--
CREATE TABLE "AA_articulo_subasta" ("id" bigserial NOT NULL PRIMARY KEY, "ask" integer NOT NULL, "bid" integer NOT NULL, "por_ganancia" integer NOT NULL, "precio_alcanzado" integer NOT NULL, "duracion_min" integer NOT NULL);
--
-- Create model Artista
--
CREATE TABLE "AA_artista" ("id" serial NOT NULL PRIMARY KEY, "nombre" varchar(50) NOT NULL, "apellido" varchar(50) NOT NULL, "nombreart" varchar(50) NOT NULL);
--
-- Create model Cliente
--
CREATE TABLE "AA_cliente" ("id" bigserial NOT NULL PRIMARY KEY, "date_client" date NULL);
--
-- Create model Coleccionista
--
CREATE TABLE "AA_coleccionista" ("id" serial NOT NULL PRIMARY KEY, "nombre" varchar(50) NOT NULL, "telefonoid" varchar(50) NOT NULL, "email" varchar(13) NOT NULL);
--
-- Create model Factura
--
CREATE TABLE "AA_factura" ("id" serial NOT NULL PRIMARY KEY, "iva" integer NOT NULL);
--
-- Create model Pais
--
CREATE TABLE "AA_pais" ("id" serial NOT NULL PRIMARY KEY, "nombre" varchar(50) NOT NULL, "nacionalidad" varchar(50) NOT NULL);
--
-- Create model Subasta_Evento
--
CREATE TABLE "AA_subasta_evento" ("id" bigserial NOT NULL PRIMARY KEY);
--
-- Create model Subasta_Tienda
--
CREATE TABLE "AA_subasta_tienda" ("id" bigserial NOT NULL PRIMARY KEY);
--
-- Create model Tienda
--
CREATE TABLE "AA_tienda" ("id" serial NOT NULL PRIMARY KEY, "nombre" varchar(50) NOT NULL, "pagina" varchar(50) NOT NULL, "proposito" varchar(100) NOT NULL, "alcance" varchar(50) NOT NULL, "tipo" varchar(70) NOT NULL, "lugar_id" integer NOT NULL);
--
-- Create model Reglonfactura
--
CREATE TABLE "AA_reglonfactura" ("id" bigserial NOT NULL PRIMARY KEY, "precio" integer NOT NULL, "descripcion" varchar(50) NOT NULL, "articulo_id" bigint NOT NULL, "factura_id" integer NOT NULL);
--
-- Create model Pintura
--
CREATE TABLE "AA_pintura" ("id" bigserial NOT NULL PRIMARY KEY);
CREATE TABLE "AA_pintura_Artistas" ("id" bigserial NOT NULL PRIMARY KEY, "pintura_id" bigint NOT NULL, "artista_id" integer NOT NULL);
--
-- Create model Participante
--
CREATE TABLE "AA_participante" ("id" serial NOT NULL PRIMARY KEY, "coleccionista_id" integer NOT NULL, "factura_id" integer NOT NULL, "subasta_id" bigint NOT NULL);
--
-- Create model Moneda
--
CREATE TABLE "AA_moneda" ("id" bigserial NOT NULL PRIMARY KEY);
CREATE TABLE "AA_moneda_Artistas" ("id" bigserial NOT NULL PRIMARY KEY, "moneda_id" bigint NOT NULL, "artista_id" integer NOT NULL);
--
-- Create model Contacto_Organizacion
--
CREATE TABLE "AA_contacto_organizacion" ("id" serial NOT NULL PRIMARY KEY, "cargo" varchar(50) NOT NULL, "nombre" varchar(20) NOT NULL, "apellido" varchar(20) NOT NULL, "email" varchar(50) NOT NULL, "telefonoid" varchar(50) NOT NULL, "lugar_id" integer NOT NULL);
--
-- Add field lugar to coleccionista
--
ALTER TABLE "AA_coleccionista" ADD COLUMN "lugar_id" integer NOT NULL CONSTRAINT "AA_coleccionista_lugar_id_90b851b3_fk_AA_pais_id" REFERENCES "AA_pais"("id") DEFERRABLE INITIALLY DEFERRED; SET CONSTRAINTS "AA_coleccionista_lugar_id_90b851b3_fk_AA_pais_id" IMMEDIATE;
ALTER TABLE "AA_tienda" ADD CONSTRAINT "AA_tienda_lugar_id_e0661db7_fk_AA_pais_id" FOREIGN KEY ("lugar_id") REFERENCES "AA_pais" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_tienda_lugar_id_e0661db7" ON "AA_tienda" ("lugar_id");
ALTER TABLE "AA_reglonfactura" ADD CONSTRAINT "AA_reglonfactura_articulo_id_a2068e26_fk_AA_articulo_subasta_id" FOREIGN KEY ("articulo_id") REFERENCES "AA_articulo_subasta" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AA_reglonfactura" ADD CONSTRAINT "AA_reglonfactura_factura_id_f7a150b9_fk_AA_factura_id" FOREIGN KEY ("factura_id") REFERENCES "AA_factura" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_reglonfactura_articulo_id_a2068e26" ON "AA_reglonfactura" ("articulo_id");
CREATE INDEX "AA_reglonfactura_factura_id_f7a150b9" ON "AA_reglonfactura" ("factura_id");
ALTER TABLE "AA_pintura_Artistas" ADD CONSTRAINT "AA_pintura_Artistas_pintura_id_artista_id_f26af1ef_uniq" UNIQUE ("pintura_id", "artista_id");
ALTER TABLE "AA_pintura_Artistas" ADD CONSTRAINT "AA_pintura_Artistas_pintura_id_cf7d7f9d_fk_AA_pintura_id" FOREIGN KEY ("pintura_id") REFERENCES "AA_pintura" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AA_pintura_Artistas" ADD CONSTRAINT "AA_pintura_Artistas_artista_id_6a1b2be7_fk_AA_artista_id" FOREIGN KEY ("artista_id") REFERENCES "AA_artista" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_pintura_Artistas_pintura_id_cf7d7f9d" ON "AA_pintura_Artistas" ("pintura_id");
CREATE INDEX "AA_pintura_Artistas_artista_id_6a1b2be7" ON "AA_pintura_Artistas" ("artista_id");
ALTER TABLE "AA_participante" ADD CONSTRAINT "AA_participante_coleccionista_id_e6e1d131_fk_AA_colecc" FOREIGN KEY ("coleccionista_id") REFERENCES "AA_coleccionista" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AA_participante" ADD CONSTRAINT "AA_participante_factura_id_3a3ba2a9_fk_AA_factura_id" FOREIGN KEY ("factura_id") REFERENCES "AA_factura" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AA_participante" ADD CONSTRAINT "AA_participante_subasta_id_267f158e_fk_AA_subasta_evento_id" FOREIGN KEY ("subasta_id") REFERENCES "AA_subasta_evento" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_participante_coleccionista_id_e6e1d131" ON "AA_participante" ("coleccionista_id");
CREATE INDEX "AA_participante_factura_id_3a3ba2a9" ON "AA_participante" ("factura_id");
CREATE INDEX "AA_participante_subasta_id_267f158e" ON "AA_participante" ("subasta_id");
ALTER TABLE "AA_moneda_Artistas" ADD CONSTRAINT "AA_moneda_Artistas_moneda_id_artista_id_f970d775_uniq" UNIQUE ("moneda_id", "artista_id");
ALTER TABLE "AA_moneda_Artistas" ADD CONSTRAINT "AA_moneda_Artistas_moneda_id_72667248_fk_AA_moneda_id" FOREIGN KEY ("moneda_id") REFERENCES "AA_moneda" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AA_moneda_Artistas" ADD CONSTRAINT "AA_moneda_Artistas_artista_id_07de1e24_fk_AA_artista_id" FOREIGN KEY ("artista_id") REFERENCES "AA_artista" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_moneda_Artistas_moneda_id_72667248" ON "AA_moneda_Artistas" ("moneda_id");
CREATE INDEX "AA_moneda_Artistas_artista_id_07de1e24" ON "AA_moneda_Artistas" ("artista_id");
ALTER TABLE "AA_contacto_organizacion" ADD CONSTRAINT "AA_contacto_organizacion_lugar_id_2a68f4ce_fk_AA_tienda_id" FOREIGN KEY ("lugar_id") REFERENCES "AA_tienda" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "AA_contacto_organizacion_lugar_id_2a68f4ce" ON "AA_contacto_organizacion" ("lugar_id");
CREATE INDEX "AA_coleccionista_lugar_id_90b851b3" ON "AA_coleccionista" ("lugar_id");
