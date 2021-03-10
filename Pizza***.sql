-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

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
  `Localidad_nombre` VARCHAR(45) NOT NULL,
  `Provincia_Provincia_id1` INT(11) NOT NULL,
  PRIMARY KEY (`Localidad_id`, `Provincia_Provincia_id1`),
  INDEX `fk_Localidad_Provincia1_idx` (`Provincia_Provincia_id1` ASC),
  CONSTRAINT `fk_Localidad_Provincia1`
    FOREIGN KEY (`Provincia_Provincia_id1`)
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
  PRIMARY KEY (`Cliente_id`, `Localidad_Localidad_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC) ,
  UNIQUE INDEX `Codigo_postal_UNIQUE` (`Codigo_postal` ASC) ,
  INDEX `fk_Cliente_Localidad1_idx` (`Localidad_Localidad_id` ASC) ,
  CONSTRAINT `fk_Cliente_Localidad1`
    FOREIGN KEY (`Localidad_Localidad_id`)
    REFERENCES `Pizzeria`.`Localidad` (`Localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Restaurante` (
  `Restaurante_id` INT NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(60) NOT NULL,
  `Codigo_postal` INT(10) UNSIGNED NOT NULL,
  `Localidad_Localidad_id` INT(11) NOT NULL,
  PRIMARY KEY (`Restaurante_id`, `Localidad_Localidad_id`),
  INDEX `fk_Restaurante_Localidad1_idx` (`Localidad_Localidad_id` ASC) ,
  CONSTRAINT `fk_Restaurante_Localidad1`
    FOREIGN KEY (`Localidad_Localidad_id`)
    REFERENCES `Pizzeria`.`Localidad` (`Localidad_id`)
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
  `Restaurante_Restaurante_id` INT NOT NULL,
  PRIMARY KEY (`Empleado_id`, `Restaurante_Restaurante_id`),
  UNIQUE INDEX `Nif_UNIQUE` (`Nif` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC) ,
  INDEX `fk_Empleado_Restaurante1_idx` (`Restaurante_Restaurante_id` ASC) ,
  CONSTRAINT `fk_Empleado_Restaurante1`
    FOREIGN KEY (`Restaurante_Restaurante_id`)
    REFERENCES `Pizzeria`.`Restaurante` (`Restaurante_id`)
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
  PRIMARY KEY (`Repartidor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pedido` (
  `Pedido_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Productos del pedido',
  `Cantidad` INT(11) NOT NULL,
  `Pedido` DATETIME NOT NULL,
  `Tipo_productos` VARCHAR(90) NOT NULL,
  `Entrega` BIT(1) NOT NULL,
  `Precio_total` DECIMAL(8,0) NOT NULL,
  `Pedido_restaurante` VARCHAR(45) NOT NULL,
  `Cliente_Cliente_id` INT(11) NOT NULL,
  `Entrega_domicilio_Repartidor_id` INT(11) NOT NULL,
  `Restaurante_Restaurante_id` INT NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Restaurante_Restaurante_id`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_Cliente_id` ASC) ,
  INDEX `fk_Pedido_Entrega_domicilio1_idx` (`Entrega_domicilio_Repartidor_id` ASC) ,
  INDEX `fk_Pedido_Restaurante1_idx` (`Restaurante_Restaurante_id` ASC) ,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_Cliente_id`)
    REFERENCES `Pizzeria`.`Cliente` (`Cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Entrega_domicilio1`
    FOREIGN KEY (`Entrega_domicilio_Repartidor_id`)
    REFERENCES `Pizzeria`.`Entrega_domicilio` (`Repartidor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Restaurante1`
    FOREIGN KEY (`Restaurante_Restaurante_id`)
    REFERENCES `Pizzeria`.`Restaurante` (`Restaurante_id`)
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
  `Pedido_Pedido_id` INT(11) NOT NULL,
  `Categoria_nombre` VARCHAR(45) NULL DEFAULT NULL,
  UNIQUE INDEX `Hamburguesa_nombre_UNIQUE` (`Productos_id` ASC) ,
  INDEX `fk_Tipo_productos_Pedido1_idx` (`Pedido_Pedido_id` ASC) ,
  PRIMARY KEY (`Productos_id`),
  CONSTRAINT `fk_Tipo_productos_Pedido1`
    FOREIGN KEY (`Pedido_Pedido_id`)
    REFERENCES `Pizzeria`.`Pedido` (`Pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
