CREATE TABLE Perfil(
    id_perfil SERIAL PRIMARY KEY,
    nombre_perfil VARCHAR(30) NOT NULL
);

CREATE TABLE Pais(
    id_pais SERIAL PRIMARY KEY,
    nb_pais VARCHAR(30) NOT NULL
);

CREATE TABLE Estado(
    id_estado SERIAL PRIMARY KEY,
    id_pais integer NOT NULL,
    CONSTRAINT FK_IdPais FOREIGN KEY (id_pais) REFERENCES Pais(id_pais),
    nb_estado VARCHAR(30) NOT NULL
);

CREATE TABLE Municipio(
    id_municipio SERIAL PRIMARY KEY,
    id_estado integer NOT NULL,
    CONSTRAINT FK_IdEstado FOREIGN KEY (id_estado) REFERENCES Estado(id_estado),
    nb_municipio VARCHAR(30) NOT NULL
);

CREATE TABLE Ciudad(
    id_ciudad SERIAL PRIMARY KEY,
    id_municipio INTEGER NOT NULL,
    CONSTRAINT FK_IdMunicipio FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio),
    nb_ciudad VARCHAR(30) NOT NULL
);

CREATE TABLE Parroquia(
    id_parroquia SERIAL PRIMARY KEY,
    id_municipio INTEGER NOT NULL,
    CONSTRAINT FK_IdMunicipio FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio),
    nb_parroquia VARCHAR(30) NOT NULL
);

CREATE TABLE Usuario(
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL,
    pass VARCHAR(50) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    sexo CHAR NOT NULL CHECK (
      sexo = 'M'
      OR sexo = 'H'
      OR sexo = 'N/A'),
    id_ciudad INTEGER NOT NULL,
    CONSTRAINT FK_IdCiudad FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Persona(
    id_persona SERIAL PRIMARY KEY,
    nombre_persona VARCHAR(30) NOT NULL,
    num_telPersona VARCHAR(50) NOT NULL,
    tipo_persona VARCHAR(50) NOT NULL,
    CONSTRAINT Tipo_Persona CHECK (
      tipo_persona='Beneficiario'
      or tipo_persona='Empleado'
      or tipo_persona='Agente'
      or tipo_persona='Cliente'
    )
);

CREATE TABLE Rol_Usuario (
    id_usuario  INTEGER NOT NULL,
    CONSTRAINT FK_IdUsuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    id_perfil  INTEGER NOT NULL,
    CONSTRAINT FK_Perfil FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
    PRIMARY KEY(id_usuario, id_perfil)
);

CREATE TABLE Empleado (
    id_empleado INTEGER PRIMARY KEY,
    CONSTRAINT FK_IdPersona FOREIGN KEY (id_empleado) REFERENCES Persona(id_persona),
    fecha_inicio_empresa DATE
);

CREATE TABLE Sucursal(
    id_sucursal  SERIAL PRIMARY KEY,
    nb_sucursal  VARCHAR(30) NOT NULL,
    id_director INTEGER NOT NULL,
    CONSTRAINT FK_Director FOREIGN KEY (id_director) REFERENCES Empleado(id_empleado),
    id_ciudad INTEGER NOT NULL,
    CONSTRAINT FK_IdCiudad FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad),
    activos VARCHAR(250) NOT NULL
);

CREATE TABLE Agente (
    id_agente INTEGER PRIMARY KEY,
    CONSTRAINT FK_IdPersona FOREIGN KEY (id_agente) REFERENCES Persona(id_persona),
    tipo_agente VARCHAR(30) NOT NULL,
    direc_agente varchar(250) NOT NULL
);

CREATE TABLE Banda_Salarial(
    id_banda SERIAL PRIMARY KEY,
    banda_min INTEGER NOT NULL CHECK (banda_min > 0),
    banda_max INTEGER NOT NULL CHECK (banda_max > banda_min)
);

CREATE TABLE Cliente(
    id_cliente serial primary key,
    apellido_cliente VARCHAR(30) NOT NULL,
    direc_cliente VARCHAR(250) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    ciudad Varchar(50) NOT NULL,
    genero VARCHAR(3) NOT NULL CHECK (
        genero = 'M'
        OR genero = 'H'
        OR genero = 'N/A'),
    fecha_nac DATE NOT NULL,
    profesion VARCHAR(30) NOT NULL,
    id_sucursal INTEGER NOT NULL,
    CONSTRAINT FK_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Persona(id_persona)
);

CREATE TABLE Poliza(
    id_poliza SERIAL PRIMARY KEY,
    descripcion_poliza VARCHAR(50) NOT NULL,

    tipo VARCHAR(30) NOT NULL CHECK (
        tipo = 'Vehiculo'
        OR tipo = 'Vida'
        OR tipo = 'Hogar'),
    prima INTEGER NOT NULL
);

CREATE TABLE Inmueble(
    id_inmueble SERIAL PRIMARY KEY,
    direc_inmueble VARCHAR(250) NOT NULL,
    valor FLOAT NOT NULL CHECK (valor > 0),
    contenido  VARCHAR(250) NOT NULL,
    riesgos_auxiliares VARCHAR(250) NOT NULL
);

CREATE TABLE Categoria(
    id_categoria SERIAL PRIMARY KEY,
    descrip_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Cobertura(
    id_tipo SERIAL PRIMARY KEY,
    descrip_cobertura VARCHAR(30) NOT NULL
);

CREATE TABLE Vehiculo(
    matricula VARCHAR(30) PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    annio VARCHAR(4) NOT NULL,
    id_categoria INTEGER NOT NULL,
    CONSTRAINT FK_Categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    id_tipo_cobertura INTEGER NOT NULL,
    CONSTRAINT FK_Tipo_Cobertura FOREIGN KEY (id_tipo_cobertura) REFERENCES Tipo_Cobertura(id_tipo)
);

CREATE TABLE Vida(
    id_vida SERIAL PRIMARY KEY,
    prima FLOAT NOT NULL,
    cobertura FLOAT NOT NULL
);

CREATE TABLE Multa(
    nro_referencia SERIAL PRIMARY KEY,
    matricula VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Matricula FOREIGN KEY (matricula) REFERENCES Vehiculo(matricula),
    fecha DATE NOT NULL,
    lugar_multa VARCHAR(30) NOT NULL,
    hora_multa VARCHAR(5) NOT NULL,
    importe FLOAT NOT NULL CHECK (importe > 0),
    puntaje INTEGER NOT NULL CHECK (puntaje > 0 AND puntaje < 11)
);

CREATE TABLE Categoria_Accidente(
    id_categoria_accidente SERIAL PRIMARY KEY,
    descrip_subcategoria VARCHAR(200) NOT NULL,
    descrip_categoria VARCHAR(200) NOT NULL
);

CREATE TABLE Accidente(
    nro_referencia SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    lugar_acc VARCHAR(30) NOT NULL,
    hora_acc VARCHAR(30) NOT NULL,
    id_categoria_acc INTEGER NOT NULL,
    CONSTRAINT FK_Categoria_Acc FOREIGN KEY (id_categoria_acc) REFERENCES Categoria_Accidente(id_categoria_accidente)
);

CREATE TABLE Prestamo(
    id_prestamo SERIAL PRIMARY KEY,
    importe FLOAT NOT NULL CHECK (importe > 0)
);

CREATE TABLE Pago(
    nro_pago INTEGER NOT NULL,
    id_prestamo INTEGER NOT NULL,
    CONSTRAINT FK_Prestamo FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo),
    fecha DATE NOT NULL,
    importe FLOAT NOT NULL CHECK (importe > 0),
    PRIMARY KEY(nro_pago, id_prestamo)
);

CREATE TABLE Financiadora(
    id_financiadora SERIAL PRIMARY KEY,
    Direcc_financiadora VARCHAR(250) NOT NULL,
    telefono  VARCHAR(30) NOT NULL
);

CREATE TABLE Trabaja(
    id_empleado integer NOT NULL,
    CONSTRAINT FK_Empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    id_sucursal INTEGER NOT NULL,
    CONSTRAINT FK_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    id_banda integer NOT NULL,
    CONSTRAINT FK_Banda FOREIGN KEY (id_banda) REFERENCES Banda_Salarial(id_banda),
    fecha_inicio DATE NOT NULL,
    PRIMARY KEY(id_empleado, id_sucursal, id_banda)
);

CREATE TABLE Titular(
    id_cliente integer NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    id_poliza INTEGER NOT NULL,
    CONSTRAINT FK_Poliza FOREIGN KEY (id_poliza) REFERENCES Poliza(id_poliza),
    saldo_prima VARCHAR(30) NOT NULL,
    fecha_ultima DATE NOT NULL,
    PRIMARY KEY(id_cliente, id_poliza)
);

CREATE TABLE Involucra(
    nro_referencia integer NOT NULL,
    CONSTRAINT FK_Referencia FOREIGN KEY (nro_referencia) REFERENCES Accidente(nro_referencia),
    matricula VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Matricula FOREIGN KEY (matricula) REFERENCES Vehiculo(matricula),
    id_persona integer NOT NULL,
    CONSTRAINT FK_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona),
    PRIMARY KEY(nro_referencia, matricula, id_persona)
);

CREATE TABLE Posee(
    id_persona integer PRIMARY KEY,
    CONSTRAINT FK_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona),
    matricula VARCHAR(30) NOT NULL ,
    CONSTRAINT FK_Matricula FOREIGN KEY (matricula) REFERENCES Vehiculo(matricula)
);

CREATE TABLE Contrata_Inmueble(
    id_inmueble integer NOT NULL,
    CONSTRAINT FK_Inmueble FOREIGN KEY (id_inmueble) REFERENCES Inmueble(id_inmueble),
    id_cliente INTEGER NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    id_agente integer NOT NULL,
    CONSTRAINT FK_Agente FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
    fecha_contrato DATE NOT NULL,
    monto_com_ag FLOAT NOT NULL CHECK (monto_com_ag > 0),
    tipo VARCHAR(30) NOT NULL,
    estado_contrato VARCHAR(30) NOT NULL CONSTRAINT EstadoContrato CHECK (
        estado_contrato = 'Activo'
        OR estado_contrato = 'Vencido'
        OR estado_contrato = 'Suspendido'
    ),
    PRIMARY KEY(id_inmueble, id_cliente, id_agente, fecha_contrato, estado_contrato)
);

CREATE TABLE Contrata_Vehiculo(
    matricula VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Matricula FOREIGN KEY (matricula) REFERENCES Vehiculo(matricula),
    id_cliente INTEGER NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    id_agente integer NOT NULL,
    CONSTRAINT FK_Agente FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
    fecha_contrato DATE NOT NULL,
    monto_com_ag FLOAT NOT NULL CHECK (monto_com_ag > 0),
    recargo FLOAT NOT NULL CHECK (recargo > 0),
    descuento  FLOAT NOT NULL CHECK (descuento > 0),
    tipo VARCHAR (30) NOT NULL,
    estado_contrato VARCHAR(30) NOT NULL CONSTRAINT EstadoContrato CHECK (
        estado_contrato = 'Activo'
        OR estado_contrato = 'Vencido'
        OR estado_contrato = 'Suspendido'
    ),
    PRIMARY KEY(matricula, id_cliente, id_agente, fecha_contrato, estado_contrato)
);

CREATE TABLE Contrata_Vida(
    id_vida integer NOT NULL,
    CONSTRAINT FK_Vida FOREIGN KEY (id_vida) REFERENCES Vida(id_vida),
    id_cliente INTEGER NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    id_agente  integer NOT NULL,
    CONSTRAINT FK_Agente FOREIGN KEY (id_agente) REFERENCES Agente(id_agente),
    id_persona_vida  integer NOT NULL,
    CONSTRAINT FK_Persona FOREIGN KEY (id_persona_vida) REFERENCES Persona(id_persona),
    fecha_contrato DATE NOT NULL,
    monto_com_ag FLOAT NOT NULL CHECK (monto_com_ag > 0),
    tipo VARCHAR (30) NOT NULL,
    estado_contrato VARCHAR(30) NOT NULL CONSTRAINT EstadoContrato CHECK (
        estado_contrato = 'Activo'
        OR estado_contrato = 'Vencido'
        OR estado_contrato = 'Suspendido'
    ),
    PRIMARY KEY(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato, estado_contrato)
);

CREATE TABLE Prestario(
    id_prestamo integer PRIMARY KEY,
    CONSTRAINT FK_Prestamo FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo),
    id_cliente INTEGER NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    id_financiadora integer NOT NULL,
    CONSTRAINT FK_Financiadora FOREIGN KEY (id_financiadora) REFERENCES Financiadora(id_financiadora),
    fecha_fecha DATE NOT NULL,
    tipo_interes VARCHAR(30) NOT NULL
);

CREATE TABLE Siniestro(
    nro_siniestro integer PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE Registro_Siniestro(
    nro_siniestro integer PRIMARY KEY,
    CONSTRAINT FK_Siniestro FOREIGN KEY (nro_siniestro) REFERENCES Siniestro(nro_siniestro),
    id_poliza INTEGER NOT NULL,
    CONSTRAINT FK_Poliza FOREIGN KEY (id_poliza) REFERENCES Poliza(id_poliza),
    fecha_sinietro DATE not null,
    fecha_respesta DATE NOT NULL,
    id_rechazo VARCHAR(2) NOT NULL CONSTRAINT Rechazo_Registro CHECK (
        id_rechazo = 'SI' OR id_rechazo = 'NO'
    ),
    monto_reconocido FLOAT NOT NULL,
    monto_solicitado FLOAT NOT NULL
);



/*A. municipios ciudades*/

INSERT INTO Pais  ( nb_pais) VALUES ( 'Venezuela');--1
/*estados*/
INSERT INTO Estado ( id_pais, nb_estado) Values ( 1, 'Miranda');--1
INSERT INTO Estado ( id_pais, nb_estado) Values ( 1, 'Aragua');--2
INSERT INTO Estado ( id_pais, nb_estado) Values ( 1, 'Carabobo');--3
INSERT INTO Estado ( id_pais, nb_estado) Values ( 1, 'Lara');--4


/*municipios*/
/*miranda*/
INSERT INTO Municipio ( id_estado, nb_municipio) VALUES ( 1, 'Libertador');--1
/*Aragua*/
INSERT INTO Municipio (id_estado, nb_municipio) VALUES ( 2, 'Bolivar');--2
INSERT INTO Municipio (id_estado, nb_municipio) VALUES ( 2, 'Jose Felix Rivas');--3
INSERT INTO Municipio (id_estado, nb_municipio) VALUES ( 2, 'tovar');--4
/*Carabobo*/
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (3, 'valencia');--5
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (3, 'Puerto Cabello ');--6
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (3, 'San diego ');--7
/*Lara*/
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (4, 'Iribarren ');--8
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (4, 'Autonomo Torres ');--9
INSERT INTO Municipio (id_estado, nb_municipio) VALUES (4, 'Jimenez ');--10


/*ciudades*/
/*miranda*/
INSERT INTO Ciudad (id_municipio, nb_ciudad) VALUES ( 1, 'Caricuao');--1
/*Aragua*/
INSERT INTO Ciudad (id_municipio, nb_ciudad) VALUES ( 2, 'Maracay');--2
INSERT INTO Ciudad (id_municipio, nb_ciudad) VALUES ( 3, 'La victoria');--3
INSERT INTO Ciudad (id_municipio, nb_ciudad) VALUES ( 4, 'Colonia Tovar');--4
/*Carabobo*/
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES ( 5, 'Valencia');--5
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES ( 6, 'Puerto Cabello ');--6
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES ( 7, 'San diego ');--7
/*Lara*/
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES (8, 'Barquisimeto ');--8
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES (9 ,'Carora ');--9
INSERT INTO Ciudad ( id_municipio, nb_ciudad) VALUES ( 10, 'Quibor ');--10

/*Parroquias*/
/*miranda*/
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 1, 'San Agustin');--1
/*Aragua*/
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 2, 'Parroquia Camatagua');--2
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 3, 'Castor Nieves Ríos');--3
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 4, ' la colonia tovar');--4
/*Carabobo*/
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 5, ' El Socorro ');--5
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 6, ' Fraternidad ');--6
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES ( 7, ' San Diego de Alcalá ');--7
/*Lara*/
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES (8, ' Catedral');--8
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES (9, 'Heriberto Arroyo');--9
INSERT INTO Parroquia ( id_municipio, nb_parroquia) VALUES (10, 'Juan Bautista Rodríguez');--10



INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Alexis', '02120222258', 'Empleado');--1
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Andres', '02120222258', 'Agente');--2
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Pepito', '02120222258', 'Cliente');--3
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Pablito', '02120222258', 'Cliente');--4
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Diego', '02122835173', 'Agente');--5
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Juan', '02122835175', 'Agente');--6
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Maria', '02122834532', 'Beneficiario');--7
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Daniel', '02122835178', 'Beneficiario');--8
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES ( 'Jose', '04165228947', 'Empleado');--9
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Jesus', '0212857632', 'Empleado');--10
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Douglas', '04165228946', 'Empleado');--11
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Gabriel', '0416522776', 'Empleado');--12
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Manuel ', '04165228927', 'Empleado');--13
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Angelo', '04145228947', 'Empleado');--14
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Juan ', '0212245643', 'Cliente');--15
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Angelo ', '04145896214', 'Cliente');--16
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Maria ', '021234543', 'Cliente');--17
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Diego ', '021266643', 'Cliente');--18
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Pedro nouel', '021222643', 'Cliente');--19
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Pablo de lucia', '04145643', 'Cliente');--20
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Gabriel perez', '041611243', 'Cliente');--21
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Daniel', '021228358', 'Beneficiario');--22
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Juan', '0212244348', 'Beneficiario');--23
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Alexis', '022221478', 'Beneficiario');--24
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Manuel', '02125435178', 'Beneficiario');--25
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Adrian', '0422835178', 'Beneficiario');--26
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Alejandro', '0322835178', 'Beneficiario');--27
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'gabriel', '021542835178', 'Beneficiario');--28
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Juan', '02123835176', 'Beneficiario');--29
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Maria', '02152835179', 'Beneficiario');--30
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Rosimily', '02122835160', 'Beneficiario');--31
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Emily', '02125435178', 'Beneficiario');--32
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Shadai', '0422855178', 'Beneficiario');--33
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Alejandro', '032255178', 'Beneficiario');--34
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'gabriel', '021542832378', 'Beneficiario');--35
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Juan', '0212383526', 'Beneficiario');--36
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Maria', '02152835179', 'Beneficiario');--37
INSERT INTO Persona (nombre_persona,num_telPersona,tipo_persona) VALUES (  'Rosimily', '0212255160', 'Beneficiario');--38



INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (1, CURRENT_DATE);
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (9, '1/12/2021');
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (10, '3/05/2021');
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (11, '05/05/2021');
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (12, '07/02/2020');
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (13, '07/09/2020');
INSERT INTO Empleado(id_empleado,fecha_inicio_empresa) VALUES (14, '11/09/2018');

/*FIN PASO 2*/

/*Sucursales insertadas*/

INSERT INTO Sucursal(  nb_sucursal,id_director,id_ciudad,activos) VALUES  ( 'Sub_caricuao', 1, 1, 'muchos');--1
INSERT INTO Sucursal(  nb_sucursal,id_director,id_ciudad,activos) VALUES  ( 'Sub_Aragua_Maracay', 9, 2, 'muchos');--2
INSERT INTO Sucursal(  nb_sucursal,id_director,id_ciudad,activos) VALUES  ( 'Sub_Valencia', 10, 5, 'muchos');--3
INSERT INTO Sucursal(  nb_sucursal,id_director,id_ciudad,activos) VALUES  ( 'Sub_Barquisimeto', 11, 8, 'muchos');--4
INSERT INTO Sucursal(  nb_sucursal,id_director,id_ciudad,activos) VALUES  ( 'Sub_Barquisimeto2', 12, 8, 'muchos');--5


INSERT INTO Categoria ( descrip_categoria) VALUES ( 'lujo');--1
INSERT INTO Categoria ( descrip_categoria) VALUES ( 'gran Turismo');--2
INSERT INTO Categoria ( descrip_categoria) VALUES ( 'Gama media');--3
INSERT INTO Categoria ( descrip_categoria) VALUES ( 'Gama alta');--4
INSERT INTO Categoria ( descrip_categoria) VALUES ( 'utilitario');--5




/*PASO 5*/
INSERT INTO Tipo_Cobertura ( descrip_cobertura) VALUES ( 'todo riesgo');--1
INSERT INTO Tipo_Cobertura ( descrip_cobertura) VALUES ( 'franquicia');--2
INSERT INTO Tipo_Cobertura ( descrip_cobertura) VALUES ( 'terceros');--3
INSERT INTO Tipo_Cobertura ( descrip_cobertura) VALUES ( 'media');--4
INSERT INTO Tipo_Cobertura ( descrip_cobertura) VALUES ( 'porcentual');--5
/*FIN PASO 5*/


/*E. Se tiene informacion de al menos 3 agentes*/



INSERT INTO Agente VALUES (2, 'corredurías tradicionales', 'bello campo');
INSERT INTO Agente VALUES (5, ', agentes de seguros', 'El hatillo');
INSERT INTO Agente VALUES (6, 'operadores de banca', 'Valencia san diego');





/*B. poliza:vida,hogar,vehiculo*/

INSERT INTO Vida ( prima,cobertura ) VALUES (  13333, 14000);--1
INSERT INTO Vida ( prima,cobertura ) VALUES (  12222, 13000);--2
INSERT INTO Vida ( prima,cobertura ) VALUES (  23453,50000);--3
INSERT INTO Inmueble( direc_inmueble, valor,contenido,riesgos_auxiliares) VALUES ( 'Altamira 1', 12732.40, 'Muebles,Cuadros,Electrodomesticos', 'Dano estructural,incendio');--1
INSERT INTO Inmueble( direc_inmueble, valor,contenido,riesgos_auxiliares) VALUES ( 'Santa eduvigis', 23547.60, 'Muebles,Cuadros,Electrodomesticos', 'Robo,terremoto,Dano estructural,incendio');--2
INSERT INTO Vehiculo VALUES ('a3f44da', 'Mustang', 'Z', '2015', 1, 1);
INSERT INTO Vehiculo VALUES ('a5gs4g5', 'BMW', 'x3', '2018', 1, 1);



/*PASO 8*/
INSERT INTO Cliente VALUES (3, 'Gonzales', 'Direccion', 'Calle', 'Ciudad', 'H', CURRENT_DATE, 'Profecion', 1);
INSERT INTO Usuario (nombre_usuario,email,pass,nombre,apellido,sexo,id_ciudad ) VALUES ( 'ASTRO', 'Astro21234', '12345', 'alexis', 'Quiros', 'M', 1);--1
INSERT INTO Prestamo(importe) VALUES ( 2.0);--1
INSERT INTO Pago VALUES (1, 1, CURRENT_DATE, 1);
INSERT INTO Multa (matricula,fecha,lugar_multa,hora_multa, importe,puntaje) VALUES ( 'a3f44da', CURRENT_DATE,'En mi casa', '12:20', 12, 9);--1
/*FIN PASO 8*/




/*C.Categorias de accidente y sub categorias*/

INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('hogar', 'Intoxicaciones, quemaduras, torceduras, herida, etc.');--1
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('trabajo','Quemaduras, congelamiento, inmersión, electrocución, etc.');--2
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('calle','Choques, atropellamientos, volcaduras, bala perdida etc.');--3
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('campo','Caídas, ataque por animales, incendios, etc.');--4
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('infancia','Los más frecuentes son las caídas, los producidos durante el
transporte, las intoxicaciones y las quemaduras.2');--5
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('escuela','Caídas, heridas');--6
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('hospitales','Caídas, intoxicación');--7
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('animales','Picaduras, heridas, lesiones, intoxicaciones');--8
INSERT INTO Categoria_Accidente(descrip_subcategoria,descrip_categoria) VALUES ('desastres naturales','Derrumbes, deslizamientos, muertes, pérdida de
hogares, entre otros.');--9

/*D. Almacenar 3 contratos o poliza*/
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (1,3,2,1,'2/02/2022',100,'Todo riesgo','Activo');
INSERT INTO Contrata_Inmueble(id_inmueble, id_cliente, id_agente,  fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (1,3,2,'10/01/2022',100,'Todo riesgo ','Activo');
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('a5gs4g5',3,2,'4/01/2022',100,30,5,'todo riesgo ','Activo');


/*insert reporte 10*/

INSERT INTO Cliente VALUES (4, 'De lucia', 'Los palos grandes', 'Calle santa ana', 'Caracas', 'M', '03/04/2018', 'ingeniero', 1);
INSERT INTO Cliente VALUES (15, 'hernandez', 'Bolivar', 'Calle francia', 'maracay', 'M', '03/04/1956', 'Comunicador', 2);
INSERT INTO Cliente VALUES (16, 'Perez', 'guadalupe', 'Calle urbina', 'maracay', 'M', '4/04/1999', 'ingeniero', 2);
INSERT INTO Cliente VALUES (17, 'Jose', 'San diego', 'Calle san diego ', 'valencia', 'M', '02/05/1987', 'Abogado', 3);
INSERT INTO Cliente VALUES (18, 'hurtado', 'jose felix riva', 'Calle jose felix', 'valencia', 'M', '01/01/1966', 'ingeniero', 3);
INSERT INTO Cliente VALUES (19, 'nouel', 'Barquisemtito', 'Calle panteon', 'Barquisimeto', 'M', '03/12/1965', 'Abogado', 4);
INSERT INTO Cliente VALUES (20, 'armas', 'san juan', 'Calle santa ana', 'Barquisimeto', 'M', '03/04/1998', 'ingeniero', 4);
INSERT INTO Cliente VALUES (21, 'Arraiz','bolivar', 'Calle bolivar', 'Barquisimeto', 'M', '09/09/1993', 'Administrador de empresas', 5);

/*reporte 1*/
INSERT INTO Vehiculo VALUES ('a5g45hy', 'Audi', 'q1', '2010', 4, 1);
INSERT INTO Vehiculo VALUES ('2jg45A', 'toyota', 'corola', '2013', 2, 1);
INSERT INTO Vehiculo VALUES ('1jg65A', 'toyota', 'corola', '2010', 2, 1);
INSERT INTO Vehiculo VALUES ('6jg3eA', 'subaru', 'impreza', '2010', 4, 1);

INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('a5gs4g5',3,2,'12/01/2019',60,6,5,'todo riesgo ','Activo');
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('a5g45hy',3,2,'04/09/2016',80,11,10,'todo riesgo ','Activo');

INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('2jg45A',15,5,'01/10/2017',10,2,6,'todo riesgo ','Activo');
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('1jg65A',15,5,'06/09/2018',30,4,8,'todo riesgo ','Activo');
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('6jg3eA',15,5,'02/11/2016',10,1,9,'todo riesgo ','Activo');

/*reporte 4*/
INSERT INTO Vida ( prima,cobertura ) VALUES (  100003,70000);

INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (1,3,2,1,'4/01/2022',100,'Todo riesgo','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (2,3,2,1,'12/06/2018',60,'Todo riesgo','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (3,3,2,1,'11/01/2020',80,'Incapacidad','Activo');

INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (1,15,5,1,'04/08/2015',1000,'Todo riesgo','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (2,15,5,1,'12/06/2021',600,'Incapacida','Activo');

INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (3,16,6,1,'11/08/2020',80,'Incapacidad','Activo');

INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (1,17,2,1,'10/09/2019',70,'Todo riesgo','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (2,17,2,1,'05/10/2018',65,'Incapacidad','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (3,17,2,1,'09/11/2021',700,'Todo riesgo','Activo');
INSERT INTO Contrata_Vida(id_vida, id_cliente, id_agente, id_persona_vida, fecha_contrato,monto_com_ag,  tipo, estado_contrato) VALUES (4,17,2,1,'6/12/2017',80,'Incapacidad','Activo');


/*reporte 9*/

INSERT INTO Vehiculo VALUES ('4dsf4A', 'toyota', 'canrry', '2011', 2, 1);
INSERT INTO Vehiculo VALUES ('736nde', 'mercedes benz', 'cc', '2012', 4, 1);
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('4dsf4A',16,5,'06/10/2018',30,4,8,'todo riesgo ','Activo');
INSERT INTO Contrata_Vehiculo(matricula, id_cliente, id_agente,  fecha_contrato,monto_com_ag,recargo,descuento,  tipo, estado_contrato) VALUES ('736nde',17,2,'02/12/2016',10,1,9,'todo riesgo ','Activo');

INSERT INTO Accidente(fecha,lugar_acc,hora_acc,id_categoria_acc) VALUES ('02/01/2021','Francisco Fajardo','3:30',3);--1
INSERT INTO Involucra(nro_referencia,matricula,id_persona) VALUES (1,'a5g45hy',3);

INSERT INTO Accidente(fecha,lugar_acc,hora_acc,id_categoria_acc) VALUES ('07/10/2021','Calle bolivar','6:30',3);--2
INSERT INTO Involucra(nro_referencia,matricula,id_persona) VALUES (2,'2jg45A',15);

INSERT INTO Accidente(fecha,lugar_acc,hora_acc,id_categoria_acc) VALUES ('09/03/2022','maracay','2:30',3);--3
INSERT INTO Involucra(nro_referencia,matricula,id_persona) VALUES (3,'4dsf4A',16);

INSERT INTO Accidente(fecha,lugar_acc,hora_acc,id_categoria_acc) VALUES ('02/06/2023','valencia','2:00',3);--4
INSERT INTO Involucra(nro_referencia,matricula,id_persona) VALUES (4,'736nde',17);



