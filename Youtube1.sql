-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Youtube` DEFAULT CHARACTER SET utf8 ;
USE `Youtube` ;

-- -----------------------------------------------------
-- Table `Youtube`.`Channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Channel` (
  `Channel_id` INT NOT NULL,
  `Name` VARCHAR(80) NOT NULL,
  `Description` VARCHAR(300) NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Channel_id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Playlist` (
  `Playlist_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(80) NOT NULL,
  `Date` DATE NULL,
  `Status` ENUM("private", "public") NOT NULL,
  PRIMARY KEY (`Playlist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Users` (
  `Users_id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(60) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `User_name` VARCHAR(45) NOT NULL,
  `Birth_date` DATE NOT NULL,
  `Gender` VARCHAR(45) NULL DEFAULT 'Default',
  `Country` VARCHAR(45) NOT NULL,
  `Zip_code` VARCHAR(45) NOT NULL,
  `Channel_Channel_id` INT NOT NULL,
  `Playlist_Playlist_id` INT NOT NULL,
  `Playlist_Playlist_id1` INT NOT NULL,
  PRIMARY KEY (`Users_id`, `Channel_Channel_id`, `Playlist_Playlist_id`, `Playlist_Playlist_id1`),
  UNIQUE INDEX `User_name_UNIQUE` (`User_name` ASC),
  UNIQUE INDEX `Zip_code_UNIQUE` (`Zip_code` ASC),
  INDEX `fk_Users_Channel1_idx` (`Channel_Channel_id` ASC),
  INDEX `fk_Users_Playlist1_idx` (`Playlist_Playlist_id1` ASC),
  CONSTRAINT `fk_Users_Channel1`
    FOREIGN KEY (`Channel_Channel_id`)
    REFERENCES `Youtube`.`Channel` (`Channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_Playlist1`
    FOREIGN KEY (`Playlist_Playlist_id1`)
    REFERENCES `Youtube`.`Playlist` (`Playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Video` (
  `Video_id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(300) NULL DEFAULT NULL,
  `Size` VARCHAR(200) NOT NULL COMMENT 'Con BLOB la base de datos crecerá mucho si el sistema es muy utilizado, lo cual impactará negativamente en su rendimiento, hará más costoso los backups, etc… La alternativa simple es guardar su ruta o archivo',
  `File_name` VARCHAR(45) NOT NULL,
  `Duration` TINYINT(255) NOT NULL,
  `Thumbnail` BLOB NOT NULL,
  `N_reproductions` INT UNSIGNED NOT NULL,
  `N_likes` INT UNSIGNED NOT NULL,
  `N_dislikes` INT UNSIGNED NOT NULL,
  `Status` ENUM("private", "public", "hiden") NOT NULL,
  `Users_Users_id` INT NOT NULL,
  `Video_tag_Tag_id` INT NOT NULL,
  `Date` DATETIME NULL DEFAULT NOW() COMMENT 'la función NOW(), para indicar que si la columna no se le asigna un valor tenga un valor por defecto sea la fecha y hora actual con la que se rellene ese registro',
  `Playlist_Playlist_id` INT NOT NULL,
  PRIMARY KEY (`Video_id`, `Users_Users_id`, `Video_tag_Tag_id`, `Playlist_Playlist_id`),
  UNIQUE INDEX `N_dislikes_UNIQUE` (`N_dislikes` ASC),
  INDEX `fk_Video_Users_idx` (`Users_Users_id` ASC),
  UNIQUE INDEX `Video_tag_Tag_id_UNIQUE` (`Video_tag_Tag_id` ASC),
  INDEX `fk_Video_Playlist1_idx` (`Playlist_Playlist_id` ASC),
  CONSTRAINT `fk_Video_Users`
    FOREIGN KEY (`Users_Users_id`)
    REFERENCES `Youtube`.`Users` (`Users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_Playlist1`
    FOREIGN KEY (`Playlist_Playlist_id`)
    REFERENCES `Youtube`.`Playlist` (`Playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Video_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Video_tag` (
  `Tag_id` INT NOT NULL AUTO_INCREMENT,
  `Tag_name` VARCHAR(45) NOT NULL,
  `Video_Video_id` INT NOT NULL,
  `Video_Users_Users_id` INT NOT NULL,
  `Video_Video_tag_Tag_id` INT NOT NULL,
  PRIMARY KEY (`Tag_id`, `Video_Video_id`, `Video_Users_Users_id`, `Video_Video_tag_Tag_id`),
  INDEX `fk_Video_tag_Video1_idx` (`Video_Video_id` ASC, `Video_Users_Users_id` ASC, `Video_Video_tag_Tag_id` ASC),
  CONSTRAINT `fk_Video_tag_Video1`
    FOREIGN KEY (`Video_Video_id` , `Video_Users_Users_id` , `Video_Video_tag_Tag_id`)
    REFERENCES `Youtube`.`Video` (`Video_id` , `Users_Users_id` , `Video_tag_Tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Subscription_channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Subscription_channel` (
  `Subscription_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Un usuario se puede inscribir a otro canal que no sea el suyo',
  `Users_Users_id` INT NOT NULL,
  `Users_Channel_Channel_id` INT NOT NULL,
  PRIMARY KEY (`Subscription_id`, `Users_Users_id`, `Users_Channel_Channel_id`),
  INDEX `fk_Subscription_channel_Users1_idx` (`Users_Users_id` ASC, `Users_Channel_Channel_id` ASC),
  CONSTRAINT `fk_Subscription_channel_Users1`
    FOREIGN KEY (`Users_Users_id` , `Users_Channel_Channel_id`)
    REFERENCES `Youtube`.`Users` (`Users_id` , `Channel_Channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Video_evaluation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Video_evaluation` (
  `Evaluation_id` INT NOT NULL AUTO_INCREMENT,
  `Like_dislike` BIT(1) NULL DEFAULT NULL COMMENT 'dos opciones o le gusta el video o no',
  `Date` DATETIME NULL DEFAULT NOW(),
  `Video_Video_id` INT NOT NULL,
  `Video_Users_Users_id` INT NOT NULL,
  `Video_Video_tag_Tag_id` INT NOT NULL,
  `Users_Users_id` INT NOT NULL,
  `Users_Channel_Channel_id` INT NOT NULL,
  `Users_Playlist_Playlist_id` INT NOT NULL,
  PRIMARY KEY (`Evaluation_id`, `Video_Video_id`, `Video_Users_Users_id`, `Video_Video_tag_Tag_id`, `Users_Users_id`, `Users_Channel_Channel_id`, `Users_Playlist_Playlist_id`),
  INDEX `fk_Video_comments_Video1_idx` (`Video_Video_id` ASC, `Video_Users_Users_id` ASC, `Video_Video_tag_Tag_id` ASC),
  INDEX `fk_Video_comments_Users1_idx` (`Users_Users_id` ASC, `Users_Channel_Channel_id` ASC, `Users_Playlist_Playlist_id` ASC),
  CONSTRAINT `fk_Video_comments_Video1`
    FOREIGN KEY (`Video_Video_id` , `Video_Users_Users_id` , `Video_Video_tag_Tag_id`)
    REFERENCES `Youtube`.`Video` (`Video_id` , `Users_Users_id` , `Video_tag_Tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_comments_Users1`
    FOREIGN KEY (`Users_Users_id` , `Users_Channel_Channel_id` , `Users_Playlist_Playlist_id`)
    REFERENCES `Youtube`.`Users` (`Users_id` , `Channel_Channel_id` , `Playlist_Playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`Video_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Video_comments` (
  `Comment_id` INT NOT NULL AUTO_INCREMENT,
  `Text` VARCHAR(1000) NOT NULL,
  `Date` DATETIME NOT NULL DEFAULT NOW(),
  `Video_Video_id` INT NOT NULL,
  `Video_Users_Users_id` INT NOT NULL,
  `Video_Video_tag_Tag_id` INT NOT NULL,
  `Video_Playlist_Playlist_id` INT NOT NULL,
  `Users_Users_id` INT NOT NULL,
  `Users_Channel_Channel_id` INT NOT NULL,
  `Users_Playlist_Playlist_id` INT NOT NULL,
  `Users_Playlist_Playlist_id1` INT NOT NULL,
  PRIMARY KEY (`Comment_id`, `Video_Video_id`, `Video_Users_Users_id`, `Video_Video_tag_Tag_id`, `Video_Playlist_Playlist_id`, `Users_Users_id`, `Users_Channel_Channel_id`, `Users_Playlist_Playlist_id`, `Users_Playlist_Playlist_id1`),
  INDEX `fk_Video_comments_Video2_idx` (`Video_Video_id` ASC, `Video_Users_Users_id` ASC, `Video_Video_tag_Tag_id` ASC, `Video_Playlist_Playlist_id` ASC),
  INDEX `fk_Video_comments_Users2_idx` (`Users_Users_id` ASC, `Users_Channel_Channel_id` ASC, `Users_Playlist_Playlist_id` ASC, `Users_Playlist_Playlist_id1` ASC),
  CONSTRAINT `fk_Video_comments_Video2`
    FOREIGN KEY (`Video_Video_id` , `Video_Users_Users_id` , `Video_Video_tag_Tag_id` , `Video_Playlist_Playlist_id`)
    REFERENCES `Youtube`.`Video` (`Video_id` , `Users_Users_id` , `Video_tag_Tag_id` , `Playlist_Playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_comments_Users2`
    FOREIGN KEY (`Users_Users_id` , `Users_Channel_Channel_id` , `Users_Playlist_Playlist_id` , `Users_Playlist_Playlist_id1`)
    REFERENCES `Youtube`.`Users` (`Users_id` , `Channel_Channel_id` , `Playlist_Playlist_id` , `Playlist_Playlist_id1`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`User_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`User_comments` (
  `User_comment_id` INT NOT NULL AUTO_INCREMENT,
  `Like_dislike` BIT(1) NULL DEFAULT NULL COMMENT 'Un usuario puede marcar un comentario como me gusta o no me gusta',
  `Date` DATETIME NULL DEFAULT NOW(),
  `Video_comments_Comment_id` INT NOT NULL,
  `Video_comments_Video_Video_id` INT NOT NULL,
  `Video_comments_Video_Users_Users_id` INT NOT NULL,
  `Video_comments_Video_Video_tag_Tag_id` INT NOT NULL,
  `Video_comments_Video_Playlist_Playlist_id` INT NOT NULL,
  `Video_comments_Users_Users_id` INT NOT NULL,
  `Video_comments_Users_Channel_Channel_id` INT NOT NULL,
  `Video_comments_Users_Playlist_Playlist_id` INT NOT NULL,
  `Video_comments_Users_Playlist_Playlist_id1` INT NOT NULL,
  `Users_Users_id` INT NOT NULL,
  `Users_Channel_Channel_id` INT NOT NULL,
  `Users_Playlist_Playlist_id` INT NOT NULL,
  `Users_Playlist_Playlist_id1` INT NOT NULL,
  PRIMARY KEY (`User_comment_id`, `Video_comments_Comment_id`, `Video_comments_Video_Video_id`, `Video_comments_Video_Users_Users_id`, `Video_comments_Video_Video_tag_Tag_id`, `Video_comments_Video_Playlist_Playlist_id`, `Video_comments_Users_Users_id`, `Video_comments_Users_Channel_Channel_id`, `Video_comments_Users_Playlist_Playlist_id`, `Video_comments_Users_Playlist_Playlist_id1`, `Users_Users_id`, `Users_Channel_Channel_id`, `Users_Playlist_Playlist_id`, `Users_Playlist_Playlist_id1`),
  INDEX `fk_User_comments_Video_comments1_idx` (`Video_comments_Comment_id` ASC, `Video_comments_Video_Video_id` ASC, `Video_comments_Video_Users_Users_id` ASC, `Video_comments_Video_Video_tag_Tag_id` ASC, `Video_comments_Video_Playlist_Playlist_id` ASC, `Video_comments_Users_Users_id` ASC, `Video_comments_Users_Channel_Channel_id` ASC, `Video_comments_Users_Playlist_Playlist_id` ASC, `Video_comments_Users_Playlist_Playlist_id1` ASC),
  INDEX `fk_User_comments_Users1_idx` (`Users_Users_id` ASC, `Users_Channel_Channel_id` ASC, `Users_Playlist_Playlist_id` ASC, `Users_Playlist_Playlist_id1` ASC),
  CONSTRAINT `fk_User_comments_Video_comments1`
    FOREIGN KEY (`Video_comments_Comment_id` , `Video_comments_Video_Video_id` , `Video_comments_Video_Users_Users_id` , `Video_comments_Video_Video_tag_Tag_id` , `Video_comments_Video_Playlist_Playlist_id` , `Video_comments_Users_Users_id` , `Video_comments_Users_Channel_Channel_id` , `Video_comments_Users_Playlist_Playlist_id` , `Video_comments_Users_Playlist_Playlist_id1`)
    REFERENCES `Youtube`.`Video_comments` (`Comment_id` , `Video_Video_id` , `Video_Users_Users_id` , `Video_Video_tag_Tag_id` , `Video_Playlist_Playlist_id` , `Users_Users_id` , `Users_Channel_Channel_id` , `Users_Playlist_Playlist_id` , `Users_Playlist_Playlist_id1`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_comments_Users1`
    FOREIGN KEY (`Users_Users_id` , `Users_Channel_Channel_id` , `Users_Playlist_Playlist_id` , `Users_Playlist_Playlist_id1`)
    REFERENCES `Youtube`.`Users` (`Users_id` , `Channel_Channel_id` , `Playlist_Playlist_id` , `Playlist_Playlist_id1`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
