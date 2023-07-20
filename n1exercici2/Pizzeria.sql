-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Províncies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Províncies` (
  `idProvíncia` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProvíncia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Localitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Localitats` (
  `idLocalitat` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `idProvíncia` INT NOT NULL,
  PRIMARY KEY (`idLocalitat`, `idProvíncia`),
  INDEX `idProvíncia_idx` (`idProvíncia` ASC) VISIBLE,
  CONSTRAINT `idProvíncia`
    FOREIGN KEY (`idProvíncia`)
    REFERENCES `Pizzeria`.`Províncies` (`idProvíncia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Cients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Cients` (
  `idCient` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognom` VARCHAR(45) NOT NULL,
  `Adreça` VARCHAR(45) NOT NULL,
  `Codi Postal` VARCHAR(10) NOT NULL,
  `Telèfon` VARCHAR(15) NOT NULL,
  `Localitats_idLocalitat` INT NOT NULL,
  `Localitats_idProvíncia` INT NOT NULL,
  PRIMARY KEY (`idCient`),
  INDEX `fk_Cients_Localitats1_idx` (`Localitats_idLocalitat` ASC, `Localitats_idProvíncia` ASC) VISIBLE,
  CONSTRAINT `fk_Cients_Localitats1`
    FOREIGN KEY (`Localitats_idLocalitat` , `Localitats_idProvíncia`)
    REFERENCES `Pizzeria`.`Localitats` (`idLocalitat` , `idProvíncia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categories Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categories Pizza` (
  `idCategoria Pizza` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria Pizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizzes` (
  `idProducte` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripció` VARCHAR(45) NOT NULL,
  `Imatge` BLOB NOT NULL,
  `Preu` DECIMAL(10) NOT NULL,
  `Categoria Pizza` INT NOT NULL,
  PRIMARY KEY (`idProducte`),
  INDEX `Categoria Pizza_idx` (`Categoria Pizza` ASC) VISIBLE,
  CONSTRAINT `Categoria Pizza`
    FOREIGN KEY (`Categoria Pizza`)
    REFERENCES `Pizzeria`.`Categories Pizza` (`idCategoria Pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Begudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Begudes` (
  `idBeguda` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripció` VARCHAR(45) NOT NULL,
  `Imatge` BLOB NOT NULL,
  `Preu` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`idBeguda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Hamburgueses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Hamburgueses` (
  `idHamburguesa` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripció` VARCHAR(45) NOT NULL,
  `Imatge` BLOB NOT NULL,
  `Preu` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`idHamburguesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Botiga` (
  `idBotiga` INT NOT NULL,
  `Adreça` VARCHAR(45) NOT NULL,
  `Codi Postal` VARCHAR(10) NOT NULL,
  `Localitat` VARCHAR(45) NOT NULL,
  `Província` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBotiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Empleats` (
  `idEmpleat` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognoms` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  `Telèfon` VARCHAR(15) NOT NULL,
  `Feina` ENUM('Cuiner', 'Repartidor') NOT NULL,
  `Botiga_idBotiga` INT NOT NULL,
  PRIMARY KEY (`idEmpleat`),
  INDEX `fk_Empleats_Botiga1_idx` (`Botiga_idBotiga` ASC) VISIBLE,
  CONSTRAINT `fk_Empleats_Botiga1`
    FOREIGN KEY (`Botiga_idBotiga`)
    REFERENCES `Pizzeria`.`Botiga` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Comandes` (
  `idComanda` INT NOT NULL,
  `idClient` INT NOT NULL,
  ` Data/Hora comanda` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Repartiment` ENUM('Domicili', 'Botiga') NOT NULL,
  `Quantitat Pizzes` INT NULL,
  `Quantitat Begudes` INT NULL,
  `Quantitat Hamburgueses` INT NULL,
  `Preu total` DECIMAL(10) NOT NULL,
  `idBotiga` INT NOT NULL,
  `Repartidor` INT NULL,
  `Data/Hora entrega` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComanda`),
  INDEX `idClient_idx` (`idClient` ASC) VISIBLE,
  INDEX `Quantitat Pizzes_idx` (`Quantitat Pizzes` ASC) VISIBLE,
  INDEX `Quantitat Begudes_idx` (`Quantitat Begudes` ASC) VISIBLE,
  INDEX `Quantitat Hamburgueses_idx` (`Quantitat Hamburgueses` ASC) VISIBLE,
  INDEX `idBotiga_idx` (`idBotiga` ASC) VISIBLE,
  INDEX `Repartidor_idx` (`Repartidor` ASC) VISIBLE,
  CONSTRAINT `idClient`
    FOREIGN KEY (`idClient`)
    REFERENCES `Pizzeria`.`Cients` (`idCient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Quantitat Pizzes`
    FOREIGN KEY (`Quantitat Pizzes`)
    REFERENCES `Pizzeria`.`Pizzes` (`idProducte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Quantitat Begudes`
    FOREIGN KEY (`Quantitat Begudes`)
    REFERENCES `Pizzeria`.`Begudes` (`idBeguda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Quantitat Hamburgueses`
    FOREIGN KEY (`Quantitat Hamburgueses`)
    REFERENCES `Pizzeria`.`Hamburgueses` (`idHamburguesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBotiga`
    FOREIGN KEY (`idBotiga`)
    REFERENCES `Pizzeria`.`Botiga` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Repartidor`
    FOREIGN KEY (`Repartidor`)
    REFERENCES `Pizzeria`.`Empleats` (`idEmpleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
