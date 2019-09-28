DROP DATABASE cybercloud;

create database cybercloud;
USE cybercloud;

CREATE TABLE adquiere
(
	cantidad             INTEGER NOT NULL,
	fecha                timestamp NOT NULL DEFAULT current_timestamp,
	precio_unidad        INTEGER NOT NULL,
	id_adquiere          INTEGER NOT NULL,
	id_servicio          INTEGER NULL,
	id_caja              INTEGER NULL,
	id_usuario           INTEGER NULL
);

ALTER TABLE adquiere ADD PRIMARY KEY (id_adquiere);
ALTER TABLE adquiere MODIFY id_adquiere INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE articulo
(
	id_articulo          INTEGER NOT NULL,
	nombre               VARCHAR(15) NOT NULL,
	descripcion          VARCHAR(20) NOT NULL,
	imagen               VARCHAR(40) NOT NULL,
	precio               INTEGER NOT NULL
);

ALTER TABLE articulo ADD PRIMARY KEY (id_articulo);
ALTER TABLE articulo MODIFY id_articulo INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE asigna
(
	id_permiso           INTEGER NULL,
	id_grupo             INTEGER NULL,
	id_asigna            INTEGER NOT NULL
);

ALTER TABLE asigna ADD PRIMARY KEY (id_asigna);
ALTER TABLE asigna MODIFY id_asigna INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE caja
(
	id_caja              INTEGER NOT NULL,
	id_operador          INTEGER NULL,
	fecha_apertura       timestamp NOT NULL DEFAULT current_timestamp,
	fecha_cierre         DATE NULL
);

ALTER TABLE caja ADD PRIMARY KEY (id_caja);
ALTER TABLE caja MODIFY id_caja INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE compra
(
	cantidad             INTEGER NOT NULL,
	fecha                timestamp NOT NULL DEFAULT current_timestamp,
	precio_unidad        INTEGER NOT NULL,
	id_compra            INTEGER NOT NULL,
	id_producto          INTEGER NULL,
	id_caja              INTEGER NULL,
	id_usuario           INTEGER NULL
);

ALTER TABLE compra ADD PRIMARY KEY (id_compra);
ALTER TABLE compra MODIFY id_compra INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE fraccion
(
	id_fraccion          INTEGER NOT NULL,
	numero               INTEGER NOT NULL,
	precio               INTEGER NOT NULL,
	id_tarifa            INTEGER NULL
);

ALTER TABLE fraccion ADD PRIMARY KEY (id_fraccion);
ALTER TABLE fraccion MODIFY id_fraccion INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE grupo
(
	id_grupo             INTEGER NOT NULL,
	nombre               VARCHAR(20) NOT NULL
);

ALTER TABLE grupo ADD PRIMARY KEY (id_grupo);
ALTER TABLE grupo MODIFY id_grupo INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE ingresa
(
	cantidad             INTEGER NOT NULL,
	fecha                timestamp NOT NULL DEFAULT current_timestamp,
	id_ingresa           INTEGER NOT NULL,
	id_operador          INTEGER NULL,
	id_producto          INTEGER NULL
);

ALTER TABLE ingresa ADD PRIMARY KEY (id_ingresa);
ALTER TABLE ingresa MODIFY id_ingresa INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE operador
(
	id_grupo             INTEGER NULL,
	id_operador          INTEGER NOT NULL
);

ALTER TABLE operador ADD PRIMARY KEY (id_operador);
ALTER TABLE operador MODIFY id_operador INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE permiso
(
	id_permiso           INTEGER NOT NULL,
	description          VARCHAR(20) NOT NULL
);

ALTER TABLE permiso ADD PRIMARY KEY (id_permiso);
ALTER TABLE permiso MODIFY id_permiso INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE producto
(
	id_producto          INTEGER NOT NULL,
	cantidad             INTEGER NOT NULL
);

ALTER TABLE producto ADD PRIMARY KEY (id_producto);

CREATE TABLE recarga
(
	monto                INTEGER NOT NULL,
	fecha                timestamp NOT NULL DEFAULT current_timestamp,
	id_recarga           INTEGER NOT NULL,
	id_operador          INTEGER NULL,
	id_usuario           INTEGER NULL
);

ALTER TABLE recarga ADD PRIMARY KEY (id_recarga);
ALTER TABLE recarga MODIFY id_recarga INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE registro
(
	id_registro          INTEGER NOT NULL,
	hora_inicio          timestamp NOT NULL DEFAULT current_timestamp,
	hora_fin             timestamp NULL,
	monto_cobrado        INTEGER NOT NULL,
	id_tarifa            INTEGER NULL,
	id_caja              INTEGER NULL,
	id_usuario           INTEGER NULL,
	prepago              BLOB NOT NULL
);

ALTER TABLE registro ADD PRIMARY KEY (id_registro);
ALTER TABLE registro MODIFY id_registro INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;


CREATE TABLE registro_terminales
(
	hora_inicio          DATE NOT NULL,
	hora_fin             DATE NOT NULL,
	id_terminal          INTEGER NULL,
	id_registro          INTEGER NULL,
	id_terminal_ocupada  INTEGER NOT NULL
);

ALTER TABLE registro_terminales ADD PRIMARY KEY (id_terminal_ocupada);
ALTER TABLE registro_terminales MODIFY id_terminal_ocupada INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE servicio
(
	id_servicio          INTEGER NOT NULL
);

ALTER TABLE servicio ADD PRIMARY KEY (id_servicio);

CREATE TABLE tarifa
(
	id_tarifa            INTEGER NOT NULL,
	nombre               VARCHAR(20) NOT NULL
);

ALTER TABLE tarifa ADD PRIMARY KEY (id_tarifa);
ALTER TABLE tarifa MODIFY id_tarifa INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE terminal
(
	id_terminal          INTEGER NOT NULL,
	numero               INTEGER NOT NULL,
	ip                   VARCHAR(20) NOT NULL
);

ALTER TABLE terminal ADD PRIMARY KEY (id_terminal);
ALTER TABLE terminal MODIFY id_terminal INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE terminal_activa
(
	id_terminal          INTEGER NOT NULL,
	id_registro          INTEGER NULL
);

ALTER TABLE terminal_activa ADD PRIMARY KEY (id_terminal);

CREATE TABLE usuario
(
	id_usuario           INTEGER NOT NULL,
	nombre               VARCHAR(20) NOT NULL,
	apellido             VARCHAR(20) NOT NULL,
	password             VARCHAR(50) NOT NULL,
	celular              INTEGER NOT NULL,
	email                VARCHAR(30) NOT NULL,
	avatar               VARCHAR(40) NOT NULL
);

ALTER TABLE usuario ADD PRIMARY KEY (id_usuario);
ALTER TABLE usuario MODIFY id_usuario INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;


ALTER TABLE adquiere
ADD FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio);



ALTER TABLE adquiere
ADD FOREIGN KEY (id_caja) REFERENCES caja (id_caja);



ALTER TABLE adquiere
ADD FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);



ALTER TABLE asigna
ADD FOREIGN KEY (id_permiso) REFERENCES permiso (id_permiso);



ALTER TABLE asigna
ADD FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo);



ALTER TABLE caja
ADD FOREIGN KEY (id_operador) REFERENCES operador (id_operador);



ALTER TABLE compra
ADD FOREIGN KEY (id_producto) REFERENCES producto (id_producto);



ALTER TABLE compra
ADD FOREIGN KEY (id_caja) REFERENCES caja (id_caja);



ALTER TABLE compra
ADD FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);



ALTER TABLE fraccion
ADD FOREIGN KEY (id_tarifa) REFERENCES tarifa (id_tarifa);



ALTER TABLE ingresa
ADD FOREIGN KEY (id_operador) REFERENCES operador (id_operador);



ALTER TABLE ingresa
ADD FOREIGN KEY (id_producto) REFERENCES producto (id_producto);



ALTER TABLE operador
ADD FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo);



ALTER TABLE operador
ADD FOREIGN KEY (id_operador) REFERENCES usuario (id_usuario);



ALTER TABLE producto
ADD FOREIGN KEY (id_producto) REFERENCES articulo (id_articulo);



ALTER TABLE recarga
ADD FOREIGN KEY (id_operador) REFERENCES operador (id_operador);



ALTER TABLE recarga
ADD FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);



ALTER TABLE registro
ADD FOREIGN KEY (id_tarifa) REFERENCES tarifa (id_tarifa);



ALTER TABLE registro
ADD FOREIGN KEY (id_caja) REFERENCES caja (id_caja);



ALTER TABLE registro
ADD FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);



ALTER TABLE registro_terminales
ADD FOREIGN KEY (id_registro) REFERENCES registro (id_registro);



ALTER TABLE registro_terminales
ADD FOREIGN KEY (id_terminal) REFERENCES terminal (id_terminal);



ALTER TABLE servicio
ADD FOREIGN KEY (id_servicio) REFERENCES articulo (id_articulo);



ALTER TABLE terminal_activa
ADD FOREIGN KEY (id_terminal) REFERENCES terminal (id_terminal);



ALTER TABLE terminal_activa
ADD FOREIGN KEY (id_registro) REFERENCES registro (id_registro);


