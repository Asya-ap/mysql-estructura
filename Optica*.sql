DROP DATABASE IF EXISTS Optica;
CREATE DATABASE Optica CHARACTER SET utf8mb4;
USE Optica;

CREATE TABLE Clientes(
  Clientes_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(45) NOT NULL,
  Tlf INT UNSIGNED NOT NULL,
  Email VARCHAR(45) NOT NULL,
  Recomendado TINYINT(1) NULL DEFAULT NULL,
  Registro DATE NOT NULL,
  Direccion VARCHAR(90) NOT NULL,
  Codigo_postal INT NOT NULL,
  Clientes_idx INT NOT NULL,
  FOREIGN KEY (Clientes_idx) REFERENCES Clientes(Clientes_id)
  );


CREATE TABLE Proveedor(
  Proveedor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Tlf INT UNSIGNED NOT NULL,
  Fax INT UNSIGNED NOT NULL,
  Nombre VARCHAR(60) NOT NULL,
  Nif VARCHAR(45) NOT NULL,
  Calle VARCHAR(80) NOT NULL,
  Nume INT NULL DEFAULT NULL,
  Codigo_postal INT NOT NULL,
  N_piso INT NULL DEFAULT NULL,
  N_puerta INT NULL DEFAULT NULL,
  Pais VARCHAR(30) NOT NULL,
  Ciudad VARCHAR(45) NOT NULL
);

CREATE TABLE Marca(
  Marca_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(45) NOT NULL,
  Proveedor_id INT NOT NULL,
  FOREIGN KEY (Proveedor_id) REFERENCES Proveedor(Proveedor_id)
  );

CREATE TABLE Montura(
 Montura_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Tipo VARCHAR(45) NOT NULL,
  Color VARCHAR(45) NOT NULL
  );

CREATE TABLE Gafas(
  Gafas_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Graduacion_der DECIMAL(4,0) NOT NULL,
  Graduacion_izq DECIMAL(4,0) NOT NULL,
  Color_cristal_der VARCHAR(30) NULL DEFAULT NULL,
  Color_cristal_izq VARCHAR(30) NULL DEFAULT NULL,
  Precio_gafa INT NOT NULL,
  Proveedor_id INT NOT NULL,
  Montura_id INT NOT NULL,
  Marca_id INT NOT NULL,
  FOREIGN KEY (Proveedor_id) REFERENCES  Proveedor(Proveedor_id),
  FOREIGN KEY (Montura_id) REFERENCES  Montura(Montura_id),
  FOREIGN KEY (Marca_id) REFERENCES  Marca(Marca_id)
  );

CREATE TABLE Empleado (
  Empleado_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(45) NOT NULL
  );

CREATE TABLE Ventas (
  Ventas_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Venta_total INT(10) UNSIGNED NOT NULL,
  Gafas_id INT NOT NULL,
  Clientes_id INT NOT NULL,
  Empleado_id INT NOT NULL,
  FOREIGN KEY (Gafas_id)  REFERENCES  Gafas(Gafas_id),
  FOREIGN KEY (Clientes_id) REFERENCES  Clientes(Clientes_id),
  FOREIGN KEY (Empleado_id) REFERENCES  Empleado(Empleado_id)
);