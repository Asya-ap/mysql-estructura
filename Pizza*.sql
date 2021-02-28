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
-- Table `Pizzeria`.`Categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categoria_pizza` (
  `Categoria_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Categoria_nombre` VARCHAR(50) NOT NULL,
  `Categoria_pizza_Categoria_id` INT(11) NOT NULL,
  PRIMARY KEY (`Categoria_id`, `Categoria_pizza_Categoria_id`))
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
  `Provincia_Provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`Cliente_id`, `Localidad_Localidad_id`, `Provincia_Provincia_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC) ,
  UNIQUE INDEX `Codigo_postal_UNIQUE` (`Codigo_postal` ASC) ,
  INDEX `fk_Cliente_Localidad_idx` (`Localidad_Localidad_id` ASC),
  CONSTRAINT `fk_Cliente_Localidad`
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
  `Restaurante_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(60) NOT NULL,
  `Codigo_postal` INT(10) UNSIGNED NOT NULL,
  `Localidad_Localidad_id` INT(11) NOT NULL,
  `Localidad_Provincia_Provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`Restaurante_id`, `Localidad_Localidad_id`, `Localidad_Provincia_Provincia_id`),
  INDEX `fk_Restaurante_Localidad1_idx` (`Localidad_Localidad_id` ASC, `Localidad_Provincia_Provincia_id` ASC) ,
  CONSTRAINT `fk_Restaurante_Localidad1`
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
  `Tlf` INT NOT NULL,
  `Tipo` VARCHAR(60) NOT NULL COMMENT 'Cocinero/Repartidor',
  `Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Restaurante_Localidad_Localidad_id` INT(11) NOT NULL,
  `Restaurante_Localidad_Provincia_Provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`Empleado_id`, `Restaurante_Restaurante_id`, `Restaurante_Localidad_Localidad_id`, `Restaurante_Localidad_Provincia_Provincia_id`),
  UNIQUE INDEX `Nif_UNIQUE` (`Nif` ASC) ,
  UNIQUE INDEX `Apellidos_UNIQUE` (`Apellidos` ASC) ,
  INDEX `fk_Empleado_Restaurante1_idx` (`Restaurante_Restaurante_id` ASC, `Restaurante_Localidad_Localidad_id` ASC, `Restaurante_Localidad_Provincia_Provincia_id` ASC) ,
  CONSTRAINT `fk_Empleado_Restaurante1`
    FOREIGN KEY (`Restaurante_Restaurante_id` , `Restaurante_Localidad_Localidad_id` , `Restaurante_Localidad_Provincia_Provincia_id`)
    REFERENCES `Pizzeria`.`Restaurante` (`Restaurante_id` , `Localidad_Localidad_id` , `Localidad_Provincia_Provincia_id`)
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
  `Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Repartidor_Repartidor_id` INT(11) NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Restaurante_Restaurante_id`, `Repartidor_Repartidor_id`),
  INDEX `fk_Pedido_Restaurante1_idx` (`Restaurante_Restaurante_id` ASC) ,
  INDEX `fk_Pedido_Repartidor1_idx` (`Repartidor_Repartidor_id` ASC) ,
  CONSTRAINT `fk_Pedido_Repartidor1`
    FOREIGN KEY (`Repartidor_Repartidor_id`)
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
  `Pedido_Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Pedido_Repartidor_Repartidor_id` INT(11) NOT NULL,
  PRIMARY KEY (`Productos_id`),
  UNIQUE INDEX `Hamburguesa_nombre_UNIQUE` (`nombre` ASC) ,
  INDEX `fk_Tipo_productos_Pedido1_idx` (`Pedido_Pedido_id` ASC, `Pedido_Restaurante_Restaurante_id` ASC, `Pedido_Repartidor_Repartidor_id` ASC) ,
  CONSTRAINT `fk_Tipo_productos_Pedido1`
    FOREIGN KEY (`Pedido_Pedido_id` , `Pedido_Restaurante_Restaurante_id` , `Pedido_Repartidor_Repartidor_id`)
    REFERENCES `Pizzeria`.`Pedido` (`Pedido_id` , `Restaurante_Restaurante_id` , `Repartidor_Repartidor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizza` (
  `Categorai_pizza_Categoria_id` INT(11) NOT NULL,
  `Tipo_productos_Productos_id` INT(11) NOT NULL,
  `Categoria_pizza_Categoria_id` INT(11) NOT NULL,
  `Categoria_pizza_Categoria_pizza_Categoria_id` INT(11) NOT NULL,
  PRIMARY KEY (`Categorai_pizza_Categoria_id`, `Tipo_productos_Productos_id`, `Categoria_pizza_Categoria_id`, `Categoria_pizza_Categoria_pizza_Categoria_id`),
  INDEX `fk_Pizza_Tipo_productos1_idx` (`Tipo_productos_Productos_id` ASC),
  INDEX `fk_Pizza_Categoria_pizza1_idx` (`Categoria_pizza_Categoria_id` ASC, `Categoria_pizza_Categoria_pizza_Categoria_id` ASC),
  CONSTRAINT `fk_Pizza_Tipo_productos1`
    FOREIGN KEY (`Tipo_productos_Productos_id`)
    REFERENCES `Pizzeria`.`Tipo_productos` (`Productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizza_Categoria_pizza1`
    FOREIGN KEY (`Categoria_pizza_Categoria_id` , `Categoria_pizza_Categoria_pizza_Categoria_id`)
    REFERENCES `Pizzeria`.`Categoria_pizza` (`Categoria_id` , `Categoria_pizza_Categoria_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizzeria_web`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizzeria_web` (
  `Pedido_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Cliente_Cliente_id` INT(11) NOT NULL,
  `Cliente_Localidad_Localidad_id` INT(11) NOT NULL,
  `Cliente_Provincia_Provincia_id` INT(11) NOT NULL,
  `Pedido` DATETIME NOT NULL,
  `Tipo_productos` VARCHAR(90) NOT NULL COMMENT 'numero de productos seleccionados',
  `Entrega` BIT(1) NOT NULL COMMENT 'Entrega a domicilio o recogida en el restaurante',
  `Precio_total` DECIMAL(8,0) NOT NULL,
  `Pedido_Pedido_id` INT(11) NOT NULL,
  `Cliente_Cliente_id1` INT(11) NOT NULL,
  `Cliente_Localidad_Localidad_id1` INT(11) NOT NULL,
  `Cliente_Provincia_Provincia_id1` INT(11) NOT NULL,
  `Pedido_Pedido_id1` INT(11) NOT NULL,
  `Pedido_Restaurante_Restaurante_id` INT(11) NOT NULL,
  `Pedido_Repartidor_Repartidor_id` INT(11) NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Cliente_Cliente_id`, `Cliente_Localidad_Localidad_id`, `Cliente_Provincia_Provincia_id`, `Pedido_Pedido_id`, `Cliente_Cliente_id1`, `Cliente_Localidad_Localidad_id1`, `Cliente_Provincia_Provincia_id1`, `Pedido_Pedido_id1`, `Pedido_Restaurante_Restaurante_id`, `Pedido_Repartidor_Repartidor_id`),
  INDEX `fk_Pizzeria_web_Cliente1_idx` (`Cliente_Cliente_id1` ASC, `Cliente_Localidad_Localidad_id1` ASC, `Cliente_Provincia_Provincia_id1` ASC),
  INDEX `fk_Pizzeria_web_Pedido1_idx` (`Pedido_Pedido_id1` ASC, `Pedido_Restaurante_Restaurante_id` ASC, `Pedido_Repartidor_Repartidor_id` ASC),
  CONSTRAINT `fk_Pizzeria_web_Cliente1`
    FOREIGN KEY (`Cliente_Cliente_id1` , `Cliente_Localidad_Localidad_id1` , `Cliente_Provincia_Provincia_id1`)
    REFERENCES `Pizzeria`.`Cliente` (`Cliente_id` , `Localidad_Localidad_id` , `Provincia_Provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pizzeria_web_Pedido1`
    FOREIGN KEY (`Pedido_Pedido_id1` , `Pedido_Restaurante_Restaurante_id` , `Pedido_Repartidor_Repartidor_id`)
    REFERENCES `Pizzeria`.`Pedido` (`Pedido_id` , `Restaurante_Restaurante_id` , `Repartidor_Repartidor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
