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
    descrip_subcategoria VARCHAR(30) NOT NULL,
    descrip_categoria VARCHAR(30) NOT NULL
);

CREATE TABLE Accidente(
    nro_referencia SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    lugar_acc VARCHAR(30) NOT NULL,
    hora_acc DATE NOT NULL,
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
    id_persona  integer NOT NULL,
    CONSTRAINT FK_Persona FOREIGN KEY (id_persona) REFERENCES Persona(id_persona),
    fecha_contrato DATE NOT NULL,
    monto_com_ag FLOAT NOT NULL CHECK (monto_com_ag > 0),
    tipo VARCHAR (30) NOT NULL,
    estado_contrato VARCHAR(30) NOT NULL CONSTRAINT EstadoContrato CHECK (
        estado_contrato = 'Activo'
        OR estado_contrato = 'Vencido'
        OR estado_contrato = 'Suspendido'
    ),
    PRIMARY KEY(id_vida, id_cliente, id_agente, id_persona, fecha_contrato, estado_contrato)
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

INSERT INTO Categoria (id_categoria, descrip_categoria) VALUES (1, 'lujo');
INSERT INTO Categoria (id_categoria, descrip_categoria) VALUES (2, 'gran Turismo');
INSERT INTO Categoria (id_categoria, descrip_categoria) VALUES (3, 'Gama media');
INSERT INTO Categoria (id_categoria, descrip_categoria) VALUES (4, 'Gama alta');
INSERT INTO Categoria (id_categoria, descrip_categoria) VALUES (5, 'utilitario');

INSERT INTO Tipo_Cobertura (id_tipo, descrip_cobertura) VALUES (1, 'todo riesgo');
INSERT INTO Tipo_Cobertura (id_tipo, descrip_cobertura) VALUES (2, 'franquicia');
INSERT INTO Tipo_Cobertura (id_tipo, descrip_cobertura) VALUES (3, 'terceros');
INSERT INTO Tipo_Cobertura (id_tipo, descrip_cobertura) VALUES (4, 'media');
INSERT INTO Tipo_Cobertura (id_tipo, descrip_cobertura) VALUES (5, 'porcentual');

INSERT INTO Pais  (id_pais, nb_pais) VALUES (1, 'Venezuela');
INSERT INTO Estado (id_estado, id_pais, nb_estado) Values (1, 1, 'Miranda');
INSERT INTO Municipio (id_municipio, id_estado, nb_municipio) VALUES (1, 1, 'Libertador');
INSERT INTO Ciudad (id_ciudad, id_municipio, nb_ciudad) VALUES (1, 1, 'Caricuao');
INSERT INTO Vida VALUES ( 1, 13333, 14000);
INSERT INTO Vida VALUES ( 2, 12222, 13000);
INSERT INTO Persona VALUES ( 1, 'Alexis', '02120222258', 'Empleado');
INSERT INTO Persona VALUES ( 2, 'Andres', '02120222258', 'Agente');
INSERT INTO Persona VALUES ( 3, 'Pepito', '02120222258', 'Cliente');
INSERT INTO Persona VALUES ( 4, 'Pablito', '02120222258', 'Cliente');
INSERT INTO Empleado VALUES (1, CURRENT_DATE);
INSERT INTO Sucursal VALUES  (1, 'Sub_caricuao', 1, 1, 'muchos');
INSERT INTO Agente VALUES (2, 'Tipo 1', 'Direccion');
INSERT INTO Cliente VALUES (3, 'Gonzales', 'Direccion', 'Calle', 'Ciudad', 'H', CURRENT_DATE, 'Profecion', 1);
INSERT INTO Inmueble VALUES (1, 'Direccion de Inmueble 1', 12732.40, 'Contenido', 'Riesgos');
INSERT INTO Vehiculo VALUES ('a3f44da', 'Mustang', 'Z', '2015', 1, 1);

INSERT INTO Usuario VALUES (1, 'ASTRO', 'Astro21234', '12345', 'alexis', 'Quiros', 'M', 1);
INSERT INTO Prestamo VALUES (1, 2.0);
INSERT INTO Pago VALUES (1, 1, CURRENT_DATE, 1);
INSERT INTO Multa VALUES (1, 'a3f44da', CURRENT_DATE,'En mi casa', '12:20', 12, 9);
