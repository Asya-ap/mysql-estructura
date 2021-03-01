-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish2_ci ;
-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Clientes` (
  `Clientes_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tlf` INT(10) UNSIGNED NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Clientes_Clientes_id` INT(11) NOT NULL,
  `Recomendado` TINYINT(1) NULL DEFAULT NULL,
  `Registro` DATE NOT NULL,
  `Direccion` VARCHAR(90) NOT NULL,
  `Codigo_postal` INT NOT NULL,
  PRIMARY KEY (`Clientes_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) ,
  INDEX `fk_Clientes_Clientes1_idx` (`Clientes_Clientes_id` ASC) ,
  UNIQUE INDEX `Codigo_postal_UNIQUE` (`Codigo_postal` ASC) ,
  CONSTRAINT `fk_Clientes_Clientes1`
    FOREIGN KEY (`Clientes_Clientes_id`)
    REFERENCES `Optica`.`Clientes` (`Clientes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `Optica`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Proveedor` (
  `Proveedor_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Tlf` INT(10) UNSIGNED NOT NULL,
  `Fax` INT(10) UNSIGNED NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` INT NULL DEFAULT NULL,
  `Codigo_postal` INT NOT NULL,
  `N_piso` INT NULL DEFAULT NULL,
  `N_puerta` INT NULL DEFAULT NULL,
  `Pais` VARCHAR(30) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Proveedor_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) ,
  UNIQUE INDEX `Codigo_postal_UNIQUE` (`Codigo_postal` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `Optica`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Gafas` (
  `Gafas_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  `Graduacion_der` DECIMAL(4,0) NOT NULL,
  `Graduacion-izq` DECIMAL(4,0) NOT NULL,
  `Tipo_montura` VARCHAR(35) NOT NULL,
  `Montura_color` VARCHAR(35) NULL DEFAULT NULL,
  `Color_cristal_der` VARCHAR(30) NULL DEFAULT 'Default',
  `Color_cristal_izq` VARCHAR(30) NULL DEFAULT NULL,
  `Precio_gafa` INT(11) NOT NULL,
  `Proveedor_Proveedor_id` INT(11) NOT NULL,
  PRIMARY KEY (`Gafas_id`, `Proveedor_Proveedor_id`),
  INDEX `fk_Gafas_Proveedor1_idx` (`Proveedor_Proveedor_id` ASC),
  CONSTRAINT `fk_Gafas_Proveedor1`
    FOREIGN KEY (`Proveedor_Proveedor_id`)
    REFERENCES `Optica`.`Proveedor` (`Proveedor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `Optica`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Ventas` (
  `Ventas_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Empleado_id` INT(11) NOT NULL COMMENT 'A cada empleado se identifica con un numero ',
  `Venta_total` INT(10) UNSIGNED NOT NULL,
  `Gafas_Gafas_id` INT(11) NOT NULL,
  `Clientes_Clientes_id` INT(11) NOT NULL,
  PRIMARY KEY (`Ventas_id`, `Gafas_Gafas_id`, `Clientes_Clientes_id`),
  UNIQUE INDEX `Empleado_id_UNIQUE` (`Empleado_id` ASC) ,
  INDEX `fk_Ventas_Gafas1_idx` (`Gafas_Gafas_id` ASC) ,
  INDEX `fk_Ventas_Clientes1_idx` (`Clientes_Clientes_id` ASC) ,
  CONSTRAINT `fk_Ventas_Gafas1`
    FOREIGN KEY (`Gafas_Gafas_id`)
    REFERENCES `Optica`.`Gafas` (`Gafas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventas_Clientes1`
    FOREIGN KEY (`Clientes_Clientes_id`)
    REFERENCES `Optica`.`Clientes` (`Clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;

USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categoria_pizza` (
  `Categoria_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Categoria_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Categoria_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Provincia` (
  `Provincia_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Provincia_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Provincia_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Localidad` (
  `Localidad_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Provincia_Provincia_id` INT(11) NOT NULL,
  `Localidad_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Localidad_id`, `Provincia_Provincia_id`),
  INDEX `fk_Localidad_Provincia1_idx` (`Provincia_Provincia_id` ASC) ,
  CONSTRAINT `fk_Localidad_Provincia1`
    FOREIGN KEY (`Provincia_Provincia_id`)
    REFERENCES `Pizzeria`.`Provincia` (`Provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Cliente` (
  `Cliente_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(50) NOT NULL,
  `Codigo_postal` INT(11) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `Localidad_Localidad_id` INT(11) NOT NULL,
  `Localidad_Provincia_Provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`Cliente_id`, `Localidad_Localidad_id`, `Localidad_Provincia_Provincia_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC) ,
  UNIQUE INDEX `Codigo_postal_UNIQUE` (`Codigo_postal` ASC) ,
  INDEX `fk_Cliente_Localidad1_idx` (`Localidad_Localidad_id` ASC, `Localidad_Provincia_Provincia_id` ASC) ,
  CONSTRAINT `fk_Cliente_Localidad1`
    FOREIGN KEY (`Localidad_Localidad_id` , `Localidad_Provincia_Provincia_id`)
    REFERENCES `Pizzeria`.`Localidad` (`Localidad_id` , `Provincia_Provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Empleado` (
  `Empleado_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Nif` VARCHAR(20) NOT NULL,
  `Tlf` INT(11) NOT NULL,
  `Tipo` VARCHAR(60) NOT NULL COMMENT 'Cocinero/Repartidor',
  PRIMARY KEY (`Empleado_id`),
  UNIQUE INDEX `Nif_UNIQUE` (`Nif` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Restaurante` (
  `Restaurante_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(60) NOT NULL,
  `Codigo_postal` INT(10) UNSIGNED NOT NULL,
  `Localidad_Localidad_id` INT(11) NOT NULL,
  `Localidad_Provincia_Provincia_id` INT(11) NOT NULL,
  `Empleado_Empleado_id` INT(11) NOT NULL,
  PRIMARY KEY (`Restaurante_id`, `Localidad_Localidad_id`, `Localidad_Provincia_Provincia_id`, `Empleado_Empleado_id`),
  INDEX `fk_Restaurante_Localidad1_idx` (`Localidad_Localidad_id` ASC, `Localidad_Provincia_Provincia_id` ASC) ,
  INDEX `fk_Restaurante_Empleado1_idx` (`Empleado_Empleado_id` ASC),
  CONSTRAINT `fk_Restaurante_Localidad1`
    FOREIGN KEY (`Localidad_Localidad_id` , `Localidad_Provincia_Provincia_id`)
    REFERENCES `Pizzeria`.`Localidad` (`Localidad_id` , `Provincia_Provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Restaurante_Empleado1`
    FOREIGN KEY (`Empleado_Empleado_id`)
    REFERENCES `Pizzeria`.`Empleado` (`Empleado_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Tipo_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Tipo_productos` (
  `Productos_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(90) NOT NULL,
  `Imagen` VARBINARY(8000) NOT NULL,
  `Precio` INT(11) NOT NULL,
  PRIMARY KEY (`Productos_id`),
  UNIQUE INDEX `Hamburguesa_nombre_UNIQUE` (`nombre` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pedido` (
  `Pedido_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Productos del pedido',
  `Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Cantidad` INT(11) NOT NULL,
  `Tipo_productos_Productos_id` INT(11) NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Restaurante_Restaurante_id`),
  INDEX `fk_Pedido_Restaurante1_idx` (`Restaurante_Restaurante_id` ASC),
  INDEX `fk_Pedido_Tipo_productos1_idx` (`Tipo_productos_Productos_id` ASC) ,
  CONSTRAINT `fk_Pedido_Restaurante1`
    FOREIGN KEY (`Restaurante_Restaurante_id`)
    REFERENCES `Pizzeria`.`Restaurante` (`Restaurante_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Tipo_productos1`
    FOREIGN KEY (`Tipo_productos_Productos_id`)
    REFERENCES `Pizzeria`.`Tipo_productos` (`Productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Entrega_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Entrega_domicilio` (
  `Repartidor_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Empleado_Empleado_id` INT(11) NOT NULL,
  `Pedido_Pedido_id` INT(11) NOT NULL,
  PRIMARY KEY (`Repartidor_id`),
  INDEX `fk_Entrega_domicilio_Empleado1_idx` (`Empleado_Empleado_id` ASC),
  INDEX `fk_Entrega_domicilio_Pedido1_idx` (`Pedido_Pedido_id` ASC),
  CONSTRAINT `fk_Entrega_domicilio_Empleado1`
    FOREIGN KEY (`Empleado_Empleado_id`)
    REFERENCES `Pizzeria`.`Empleado` (`Empleado_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Entrega_domicilio_Pedido1`
    FOREIGN KEY (`Pedido_Pedido_id`)
    REFERENCES `Pizzeria`.`Pedido` (`Pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizza` (
  `Pizza` INT(11) NOT NULL,
  `Tipo_productos_Productos_id` INT(11) NOT NULL,
  `Categoria_pizza_Categoria_id` INT(11) NOT NULL,
  PRIMARY KEY (`Pizza`),
  INDEX `fk_Pizza_Tipo_productos1_idx` (`Tipo_productos_Productos_id` ASC) ,
  INDEX `fk_Pizza_Categoria_pizza1_idx` (`Categoria_pizza_Categoria_id` ASC) ,
  CONSTRAINT `fk_Pizza_Tipo_productos1`
    FOREIGN KEY (`Tipo_productos_Productos_id`)
    REFERENCES `Pizzeria`.`Tipo_productos` (`Productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizza_Categoria_pizza1`
    FOREIGN KEY (`Categoria_pizza_Categoria_id`)
    REFERENCES `Pizzeria`.`Categoria_pizza` (`Categoria_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizzeria_web`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizzeria_web` (
  `Pedido_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Pedido` DATETIME NOT NULL,
  `Tipo_productos` VARCHAR(90) NOT NULL COMMENT 'numero de productos seleccionados',
  `Entrega` BIT(1) NOT NULL COMMENT 'Entrega a domicilio o recogida en el restaurante',
  `Precio_total` DECIMAL(8,0) NOT NULL,
  `Pedido_Pedido_id1` INT(11) NOT NULL,
  `Pedido_Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Cliente_Cliente_id1` INT(11) NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Pedido_Pedido_id1`, `Pedido_Restaurante_Restaurante_id`, `Cliente_Cliente_id1`),
  INDEX `fk_Pizzeria_web_Pedido1_idx` (`Pedido_Pedido_id1` ASC, `Pedido_Restaurante_Restaurante_id` ASC) ,
  INDEX `fk_Pizzeria_web_Cliente1_idx` (`Cliente_Cliente_id1` ASC) ,
  CONSTRAINT `fk_Pizzeria_web_Pedido1`
    FOREIGN KEY (`Pedido_Pedido_id1` , `Pedido_Restaurante_Restaurante_id`)
    REFERENCES `Pizzeria`.`Pedido` (`Pedido_id` , `Restaurante_Restaurante_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizzeria_web_Cliente1`
    FOREIGN KEY (`Cliente_Cliente_id1`)
    REFERENCES `Pizzeria`.`Cliente` (`Cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
