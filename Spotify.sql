-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema clientes
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
USE `Spotify` ;
USE `Spotify` ;

-- -----------------------------------------------------
-- Table `Spotify`.`Subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Subscription` (
  `Subscription_id` INT NOT NULL,
  `Start_date` DATE NOT NULL,
  `Renew_date` DATE NOT NULL,
  `Payment` BIT(1) NOT NULL COMMENT 'Payment\n0: credit card\n1: pay pal',
  PRIMARY KEY (`Subscription_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Premium_user` (
  `Premium_id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(80) NOT NULL,
  `Password` VARCHAR(80) NOT NULL,
  `Birth` DATE NOT NULL,
  `Gender` BIT(2) NOT NULL COMMENT 'Gender: 0 Mujer, 1 Hombre, 2 No especifica',
  `Country` VARCHAR(60) NOT NULL,
  `Zip_code` VARCHAR(50) NOT NULL,
  `Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Premium_id`, `Subscription_Subscription_id`),
  UNIQUE INDEX `Country_UNIQUE` (`Country` ASC) ,
  UNIQUE INDEX `Zip_code_UNIQUE` (`Zip_code` ASC) ,
  INDEX `fk_Premium_user_Subscription1_idx` (`Subscription_Subscription_id` ASC) ,
  CONSTRAINT `fk_Premium_user_Subscription1`
    FOREIGN KEY (`Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Subscription` (`Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Free_user` (
  `Free_id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(80) NOT NULL,
  `Password` VARCHAR(80) NOT NULL,
  `Birth` DATE NOT NULL,
  `Gender` BIT(2) NOT NULL COMMENT '0: Mujer, 1: Hombre, 2: no especifica ',
  `Country` VARCHAR(60) NOT NULL,
  `Zip_code` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Free_id`),
  UNIQUE INDEX `Country_UNIQUE` (`Country` ASC) ,
  UNIQUE INDEX `Zip_code_UNIQUE` (`Zip_code` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Credit_card` (
  `Card_id` INT NOT NULL AUTO_INCREMENT,
  `Card_num` INT NOT NULL,
  `Card_month` INT NOT NULL,
  `Card_year` INT NOT NULL,
  `Secure_code` INT NOT NULL,
  `Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Card_id`, `Subscription_Subscription_id`),
  INDEX `fk_Credit_card_Subscription1_idx` (`Subscription_Subscription_id` ASC) ,
  CONSTRAINT `fk_Credit_card_Subscription1`
    FOREIGN KEY (`Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Subscription` (`Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Paypal` (
  `Paypal_id` INT NOT NULL AUTO_INCREMENT,
  `User_name` VARCHAR(80) NOT NULL,
  `Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Paypal_id`, `Subscription_Subscription_id`),
  INDEX `fk_Paypal_Subscription1_idx` (`Subscription_Subscription_id` ASC) ,
  CONSTRAINT `fk_Paypal_Subscription1`
    FOREIGN KEY (`Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Subscription` (`Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Payments` (
  `Order_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Registro de todos los pagos realizados',
  `Date` DATE NOT NULL,
  `Total` INT NOT NULL,
  `Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Order_id`, `Subscription_Subscription_id`),
  INDEX `fk_Payments_Subscription1_idx` (`Subscription_Subscription_id` ASC) ,
  CONSTRAINT `fk_Payments_Subscription1`
    FOREIGN KEY (`Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Subscription` (`Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Delete_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Delete_playlist` (
  `Delete_day` DATE NOT NULL,
  `Delete_id` INT NOT NULL,
  PRIMARY KEY (`Delete_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist` (
  `Shared` BIT(1) NOT NULL COMMENT '0: shared\n1: not shared',
  `Active_id` VARCHAR(45) NOT NULL COMMENT 'En todos mis playlist puede tener la misma canción\nEn una playlist tengo muchas canciones',
  PRIMARY KEY (`Active_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Playlist` (
  `Playlist_id` INT NOT NULL AUTO_INCREMENT,
  `Free_user_Free_id` INT NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `Num_songs` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Delete_playlist_Delete_id` INT NOT NULL,
  `Active_playlist_Active_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Playlist_id`, `Free_user_Free_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`, `Delete_playlist_Delete_id`, `Active_playlist_Active_id`),
  INDEX `fk_Playlist_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Playlist_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC),
  INDEX `fk_Playlist_Delete_playlist1_idx` (`Delete_playlist_Delete_id` ASC) ,
  INDEX `fk_Playlist_Active_playlist1_idx` (`Active_playlist_Active_id` ASC) ,
  CONSTRAINT `fk_Playlist_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Playlist_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Playlist_Delete_playlist1`
    FOREIGN KEY (`Delete_playlist_Delete_id`)
    REFERENCES `Spotify`.`Delete_playlist` (`Delete_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Playlist_Active_playlist1`
    FOREIGN KEY (`Active_playlist_Active_id`)
    REFERENCES `Spotify`.`Active_playlist` (`Active_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artist` (
  `Artist_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(65) NOT NULL,
  `Picture` BLOB NOT NULL,
  `Artist_Artist_id` INT NOT NULL,
  PRIMARY KEY (`Artist_id`, `Artist_Artist_id`),
  INDEX `fk_Artist_Artist1_idx` (`Artist_Artist_id` ASC) ,
  CONSTRAINT `fk_Artist_Artist1`
    FOREIGN KEY (`Artist_Artist_id`)
    REFERENCES `Spotify`.`Artist` (`Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album` (
  `Album_id` INT NOT NULL AUTO_INCREMENT,
  `Artist_Artist_id` INT NOT NULL,
  `Title` VARCHAR(80) NOT NULL,
  `Date` DATE NOT NULL COMMENT 'Anyo de la publicación',
  `Picture` BLOB NOT NULL,
  PRIMARY KEY (`Album_id`, `Artist_Artist_id`),
  INDEX `fk_Album_Artist1_idx` (`Artist_Artist_id` ASC) ,
  CONSTRAINT `fk_Album_Artist1`
    FOREIGN KEY (`Artist_Artist_id`)
    REFERENCES `Spotify`.`Artist` (`Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Songs` (
  `Song_id` INT NOT NULL AUTO_INCREMENT,
  `Album_Album_id` INT NOT NULL,
  `Title` VARCHAR(80) NOT NULL,
  `Duration` INT UNSIGNED NOT NULL,
  `N_reproductions` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Song_id`, `Album_Album_id`),
  INDEX `fk_Songs_Album1_idx` (`Album_Album_id` ASC) ,
  CONSTRAINT `fk_Songs_Album1`
    FOREIGN KEY (`Album_Album_id`)
    REFERENCES `Spotify`.`Album` (`Album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist_has_Songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist_has_Songs` (
  `Active_playlist_Active_id` VARCHAR(45) NOT NULL COMMENT 'Se crea una join table, porque en una playlist compartida puede tener muchas canciones\nY las muchas playlist compartidas pueden tener la misma canción',
  `Songs_Song_id` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Active_playlist_Active_id`, `Songs_Song_id`),
  INDEX `fk_Active_playlist_has_Songs_Songs1_idx` (`Songs_Song_id` ASC) ,
  INDEX `fk_Active_playlist_has_Songs_Active_playlist1_idx` (`Active_playlist_Active_id` ASC) ,
  CONSTRAINT `fk_Active_playlist_has_Songs_Active_playlist1`
    FOREIGN KEY (`Active_playlist_Active_id`)
    REFERENCES `Spotify`.`Active_playlist` (`Active_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Active_playlist_has_Songs_Songs1`
    FOREIGN KEY (`Songs_Song_id`)
    REFERENCES `Spotify`.`Songs` (`Song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist_has_Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist_has_Free_user` (
  `Active_playlist_Active_id` VARCHAR(45) NOT NULL COMMENT 'Playlist que esta activa puede ser compartida con otros usuarios',
  `Free_user_Free_id` INT NOT NULL,
  PRIMARY KEY (`Active_playlist_Active_id`, `Free_user_Free_id`),
  INDEX `fk_Active_playlist_has_Free_user_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Active_playlist_has_Free_user_Active_playlist1_idx` (`Active_playlist_Active_id` ASC) ,
  CONSTRAINT `fk_Active_playlist_has_Free_user_Active_playlist1`
    FOREIGN KEY (`Active_playlist_Active_id`)
    REFERENCES `Spotify`.`Active_playlist` (`Active_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Active_playlist_has_Free_user_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist_has_Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist_has_Premium_user` (
  `Active_playlist_Active_id` VARCHAR(45) NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Active_playlist_Active_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`),
  INDEX `fk_Active_playlist_has_Premium_user_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC),
  INDEX `fk_Active_playlist_has_Premium_user_Active_playlist1_idx` (`Active_playlist_Active_id` ASC),
  CONSTRAINT `fk_Active_playlist_has_Premium_user_Active_playlist1`
    FOREIGN KEY (`Active_playlist_Active_id`)
    REFERENCES `Spotify`.`Active_playlist` (`Active_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Active_playlist_has_Premium_user_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist_has_Songs_has_Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist_has_Songs_has_Free_user` (
  `Active_playlist_has_Songs_Active_playlist_Active_id` VARCHAR(45) NOT NULL COMMENT 'En una lista compartida nos interesa saber qué usuario ha sido el que ha añadido cada canción',
  `Active_playlist_has_Songs_Songs_Song_id` INT NOT NULL,
  `Free_user_Free_id` INT NOT NULL,
  PRIMARY KEY (`Active_playlist_has_Songs_Active_playlist_Active_id`, `Active_playlist_has_Songs_Songs_Song_id`, `Free_user_Free_id`),
  INDEX `fk_Active_playlist_has_Songs_has_Free_user_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Active_playlist_has_Songs_has_Free_user_Active_playlist__idx` (`Active_playlist_has_Songs_Active_playlist_Active_id` ASC, `Active_playlist_has_Songs_Songs_Song_id` ASC) ,
  CONSTRAINT `fk_Active_playlist_has_Songs_has_Free_user_Active_playlist_ha1`
    FOREIGN KEY (`Active_playlist_has_Songs_Active_playlist_Active_id` , `Active_playlist_has_Songs_Songs_Song_id`)
    REFERENCES `Spotify`.`Active_playlist_has_Songs` (`Active_playlist_Active_id` , `Songs_Song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Active_playlist_has_Songs_has_Free_user_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Active_playlist_has_Songs_has_Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Active_playlist_has_Songs_has_Premium_user` (
  `Active_playlist_has_Songs_Active_playlist_Active_id` VARCHAR(45) NOT NULL,
  `Active_playlist_has_Songs_Songs_Song_id` INT NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Active_playlist_has_Songs_Active_playlist_Active_id`, `Active_playlist_has_Songs_Songs_Song_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`),
  INDEX `fk_Active_playlist_has_Songs_has_Premium_user_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC) ,
  INDEX `fk_Active_playlist_has_Songs_has_Premium_user_Active_playli_idx` (`Active_playlist_has_Songs_Active_playlist_Active_id` ASC, `Active_playlist_has_Songs_Songs_Song_id` ASC) ,
  CONSTRAINT `fk_Active_playlist_has_Songs_has_Premium_user_Active_playlist1`
    FOREIGN KEY (`Active_playlist_has_Songs_Active_playlist_Active_id` , `Active_playlist_has_Songs_Songs_Song_id`)
    REFERENCES `Spotify`.`Active_playlist_has_Songs` (`Active_playlist_Active_id` , `Songs_Song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Active_playlist_has_Songs_has_Premium_user_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artist_has_Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artist_has_Free_user` (
  `Artist_Artist_id` INT NOT NULL,
  `Free_user_Free_id` INT NOT NULL,
  PRIMARY KEY (`Artist_Artist_id`, `Free_user_Free_id`),
  INDEX `fk_Artist_has_Free_user_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Artist_has_Free_user_Artist1_idx` (`Artist_Artist_id` ASC) ,
  CONSTRAINT `fk_Artist_has_Free_user_Artist1`
    FOREIGN KEY (`Artist_Artist_id`)
    REFERENCES `Spotify`.`Artist` (`Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Artist_has_Free_user_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artist_has_Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artist_has_Premium_user` (
  `Artist_Artist_id` INT NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Artist_Artist_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`),
  INDEX `fk_Artist_has_Premium_user_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC) ,
  INDEX `fk_Artist_has_Premium_user_Artist1_idx` (`Artist_Artist_id` ASC),
  CONSTRAINT `fk_Artist_has_Premium_user_Artist1`
    FOREIGN KEY (`Artist_Artist_id`)
    REFERENCES `Spotify`.`Artist` (`Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Artist_has_Premium_user_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Songs_has_Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Songs_has_Free_user` (
  `Songs_Song_id` INT NOT NULL,
  `Songs_Album_Album_id` INT NOT NULL,
  `Free_user_Free_id` INT NOT NULL,
  PRIMARY KEY (`Songs_Song_id`, `Songs_Album_Album_id`, `Free_user_Free_id`),
  INDEX `fk_Songs_has_Free_user_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Songs_has_Free_user_Songs1_idx` (`Songs_Song_id` ASC, `Songs_Album_Album_id` ASC) ,
  CONSTRAINT `fk_Songs_has_Free_user_Songs1`
    FOREIGN KEY (`Songs_Song_id` , `Songs_Album_Album_id`)
    REFERENCES `Spotify`.`Songs` (`Song_id` , `Album_Album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Songs_has_Free_user_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Songs_has_Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Songs_has_Premium_user` (
  `Songs_Song_id` INT NOT NULL,
  `Songs_Album_Album_id` INT NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Songs_Song_id`, `Songs_Album_Album_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`),
  INDEX `fk_Songs_has_Premium_user_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC),
  INDEX `fk_Songs_has_Premium_user_Songs1_idx` (`Songs_Song_id` ASC, `Songs_Album_Album_id` ASC) ,
  CONSTRAINT `fk_Songs_has_Premium_user_Songs1`
    FOREIGN KEY (`Songs_Song_id` , `Songs_Album_Album_id`)
    REFERENCES `Spotify`.`Songs` (`Song_id` , `Album_Album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Songs_has_Premium_user_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album_has_Free_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album_has_Free_user` (
  `Album_Album_id` INT NOT NULL,
  `Album_Artist_Artist_id` INT NOT NULL,
  `Free_user_Free_id` INT NOT NULL,
  PRIMARY KEY (`Album_Album_id`, `Album_Artist_Artist_id`, `Free_user_Free_id`),
  INDEX `fk_Album_has_Free_user_Free_user1_idx` (`Free_user_Free_id` ASC) ,
  INDEX `fk_Album_has_Free_user_Album1_idx` (`Album_Album_id` ASC, `Album_Artist_Artist_id` ASC) ,
  CONSTRAINT `fk_Album_has_Free_user_Album1`
    FOREIGN KEY (`Album_Album_id` , `Album_Artist_Artist_id`)
    REFERENCES `Spotify`.`Album` (`Album_id` , `Artist_Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Album_has_Free_user_Free_user1`
    FOREIGN KEY (`Free_user_Free_id`)
    REFERENCES `Spotify`.`Free_user` (`Free_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album_has_Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album_has_Premium_user` (
  `Album_Album_id` INT NOT NULL,
  `Album_Artist_Artist_id` INT NOT NULL,
  `Premium_user_Premium_id` INT NOT NULL,
  `Premium_user_Subscription_Subscription_id` INT NOT NULL,
  PRIMARY KEY (`Album_Album_id`, `Album_Artist_Artist_id`, `Premium_user_Premium_id`, `Premium_user_Subscription_Subscription_id`),
  INDEX `fk_Album_has_Premium_user_Premium_user1_idx` (`Premium_user_Premium_id` ASC, `Premium_user_Subscription_Subscription_id` ASC) ,
  INDEX `fk_Album_has_Premium_user_Album1_idx` (`Album_Album_id` ASC, `Album_Artist_Artist_id` ASC),
  CONSTRAINT `fk_Album_has_Premium_user_Album1`
    FOREIGN KEY (`Album_Album_id` , `Album_Artist_Artist_id`)
    REFERENCES `Spotify`.`Album` (`Album_id` , `Artist_Artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Album_has_Premium_user_Premium_user1`
    FOREIGN KEY (`Premium_user_Premium_id` , `Premium_user_Subscription_Subscription_id`)
    REFERENCES `Spotify`.`Premium_user` (`Premium_id` , `Subscription_Subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
