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
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC),
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
  INDEX `fk_Ventas_Gafas1_idx` (`Gafas_Gafas_id` ASC),
  INDEX `fk_Ventas_Clientes1_idx` (`Clientes_Clientes_id` ASC),
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
