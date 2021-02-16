-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish2_ci ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Direccion_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Direccion_proveedor` (
  `Direccion_id` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` INT NULL,
  `Codigo_postal` INT NOT NULL,
  `Numero_piso` INT NULL,
  `Numero_puerta` INT NULL,
  `Pais` VARCHAR(15) NOT NULL,
  `Ciudad` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Direccion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Proveedor` (
  `Proveedor_id` INT NOT NULL AUTO_INCREMENT,
  `Proveedor_tlf` INT UNSIGNED NOT NULL,
  `Proveedor_fax` INT UNSIGNED NOT NULL,
  `Proveedor_direccion` VARCHAR(50) NOT NULL,
  `Proveedor_nif` VARCHAR(15) NOT NULL,
  `Direccion_proveedor_Address_id` INT NOT NULL,
  PRIMARY KEY (`Proveedor_id`, `Direccion_proveedor_Address_id`),
  UNIQUE INDEX `Proveedor_nif_UNIQUE` (`Proveedor_nif` ASC),
  INDEX `fk_Proveedor_Direccion_proveedor1_idx` (`Direccion_proveedor_Address_id` ASC),
  CONSTRAINT `fk_Proveedor_Direccion_proveedor1`
    FOREIGN KEY (`Direccion_proveedor_Address_id`)
    REFERENCES `Optica`.`Direccion_proveedor` (`Direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Ventas` (
  `Ventas_id` INT NOT NULL AUTO_INCREMENT,
  `Empleado_id` INT NOT NULL COMMENT 'A cada empleado se identifica con un numero ',
  `Venta_total` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Ventas_id`),
  UNIQUE INDEX `Empleado_id_UNIQUE` (`Empleado_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Gafas` (
  `Gafas_id` INT NOT NULL AUTO_INCREMENT,
  `Proveedor_Proveedor_id` INT NOT NULL,
  `Proveedor_Address_Address_id` INT NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Graduacion_der` DECIMAL(4) NOT NULL,
  `Graduacion-izq` DECIMAL(4) NOT NULL,
  `Montura_flotant` VARCHAR(35) NULL DEFAULT 'Default',
  `Montura_pasta` VARCHAR(35) NULL,
  `Montura_metalica` VARCHAR(35) NULL,
  `Montura_color` VARCHAR(35) NULL,
  `Color_cristal_der` VARCHAR(30) NULL DEFAULT 'Default',
  `Color_cristal_izq` VARCHAR(30) NULL,
  `Precio_gafa` INT NOT NULL,
  `Ventas_Ventas_id` INT NOT NULL,
  PRIMARY KEY (`Gafas_id`, `Proveedor_Proveedor_id`, `Proveedor_Address_Address_id`, `Ventas_Ventas_id`),
  INDEX `fk_Gafas_Proveedor1_idx` (`Proveedor_Proveedor_id` ASC, `Proveedor_Address_Address_id` ASC),
  INDEX `fk_Gafas_Ventas1_idx` (`Ventas_Ventas_id` ASC),
  CONSTRAINT `fk_Gafas_Proveedor1`
    FOREIGN KEY (`Proveedor_Proveedor_id`)
    REFERENCES `Optica`.`Proveedor` (`Proveedor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Ventas1`
    FOREIGN KEY (`Ventas_Ventas_id`)
    REFERENCES `Optica`.`Ventas` (`Ventas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Direccion_clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Direccion_clientes` (
  `Direccion_clientes_id` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` INT UNSIGNED NULL DEFAULT NULL,
  `Codigo_postal` INT UNSIGNED NOT NULL,
  `Numero_piso` INT UNSIGNED NULL,
  `Numero_puerta` INT UNSIGNED NULL,
  `Pais` VARCHAR(15) NOT NULL,
  `Ciudad` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Direccion_clientes_id`),
  UNIQUE INDEX `Pais_UNIQUE` (`Pais` ASC),
  UNIQUE INDEX `Ciudad_UNIQUE` (`Ciudad` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Clientes` (
  `Clientes_id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cliente_direccion` VARCHAR(50) NOT NULL,
  `Cliente_tlf` INT UNSIGNED NOT NULL,
  `Cliente_email` VARCHAR(45) NOT NULL,
  `Clientes_Clientes_id` INT NOT NULL,
  `Recomendado` TINYINT(1) NULL DEFAULT NULL,
  `Registro` DATE NOT NULL,
  `Ventas_Ventas_id` INT NOT NULL,
  `Direccion_clientes_Direccion_clientes_id` INT NOT NULL,
  PRIMARY KEY (`Clientes_id`, `Ventas_Ventas_id`, `Direccion_clientes_Direccion_clientes_id`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC),
  INDEX `fk_Clientes_Clientes1_idx` (`Clientes_Clientes_id` ASC),
  INDEX `fk_Clientes_Ventas1_idx` (`Ventas_Ventas_id` ASC),
  INDEX `fk_Clientes_Direccion_clientes1_idx` (`Direccion_clientes_Direccion_clientes_id` ASC),
  CONSTRAINT `fk_Clientes_Clientes1`
    FOREIGN KEY (`Clientes_Clientes_id`)
    REFERENCES `Optica`.`Clientes` (`Clientes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_Ventas1`
    FOREIGN KEY (`Ventas_Ventas_id`)
    REFERENCES `Optica`.`Ventas` (`Ventas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_Direccion_clientes1`
    FOREIGN KEY (`Direccion_clientes_Direccion_clientes_id`)
    REFERENCES `Optica`.`Direccion_clientes` (`Direccion_clientes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
