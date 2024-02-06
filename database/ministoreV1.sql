-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ministore-v1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ministore-v1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ministore-v1` DEFAULT CHARACTER SET utf8mb4 ;
USE `ministore-v1` ;

-- -----------------------------------------------------
-- Table `ministore-v1`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `celular` VARCHAR(12) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `celular_UNIQUE` (`celular` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Unidad-medida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Unidad-medida` (
  `id_unidad-medida` INT NOT NULL AUTO_INCREMENT,
  `unidad-medida_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_unidad-medida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `categoria_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `marca_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Login` (
  `id_login` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_login`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Producto` (
  `id_Producto` INT NOT NULL AUTO_INCREMENT,
  `codigo_barra` VARCHAR(45) NULL,
  `costo` DOUBLE UNSIGNED NOT NULL DEFAULT 0.0,
  `precio` DOUBLE UNSIGNED NOT NULL DEFAULT 0.0,
  `cantidad` INT NOT NULL,
  `tamano` INT NULL COMMENT 'Ejemplo: \nGaseosa Cocacola 500 ml. Donde tamaño es 500\nEn el caso de productos a granel, este dato no se considera y el precio se calcula en base a la unidad de medida y el costo',
  `unidad-medidaid` INT NOT NULL,
  `sabor` VARCHAR(45) NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_vencimiento` DATE NULL,
  `categoriaid` INT NOT NULL,
  `marcaid` INT NOT NULL,
  `loginid` INT NOT NULL,
  PRIMARY KEY (`id_Producto`, `unidad-medidaid`, `categoriaid`, `marcaid`, `loginid`),
  INDEX `fk_Producto_Unidadmedida_idx` (`unidad-medidaid` ASC) VISIBLE,
  INDEX `fk_Producto_Categoria1_idx` (`categoriaid` ASC) VISIBLE,
  INDEX `fk_Producto_Marca1_idx` (`marcaid` ASC) VISIBLE,
  INDEX `fk_Producto_Login1_idx` (`loginid` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Unidadmedida`
    FOREIGN KEY (`unidad-medidaid`)
    REFERENCES `ministore-v1`.`Unidad-medida` (`id_unidad-medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`categoriaid`)
    REFERENCES `ministore-v1`.`Categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Marca1`
    FOREIGN KEY (`marcaid`)
    REFERENCES `ministore-v1`.`Marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Login1`
    FOREIGN KEY (`loginid`)
    REFERENCES `ministore-v1`.`Login` (`id_login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Compras` (
  `Cliente_id_cliente` INT NOT NULL,
  `Producto_id_Producto` INT NOT NULL,
  `fecha_compra` DATETIME NOT NULL,
  `cantidadComprada` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cliente_id_cliente`, `Producto_id_Producto`),
  INDEX `fk_Cliente_has_Producto_Producto1_idx` (`Producto_id_Producto` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Producto_Cliente1_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Producto_Cliente1`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `ministore-v1`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Producto_Producto1`
    FOREIGN KEY (`Producto_id_Producto`)
    REFERENCES `ministore-v1`.`Producto` (`id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Vendedor` (
  `id_Vendedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `loginid` INT NOT NULL,
  PRIMARY KEY (`id_Vendedor`, `loginid`),
  INDEX `fk_Vendedor_Login1_idx` (`loginid` ASC) VISIBLE,
  CONSTRAINT `fk_Vendedor_Login1`
    FOREIGN KEY (`loginid`)
    REFERENCES `ministore-v1`.`Login` (`id_login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Proveedor` (
  `id_Proveedor` INT NOT NULL AUTO_INCREMENT,
  `RUC` VARCHAR(11) NULL,
  `nombrejuridico` VARCHAR(70) NULL,
  `telefono` VARCHAR(12) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ministore-v1`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ministore-v1`.`Pedido` (
  `Proveedorid` INT NOT NULL,
  `Productoid` INT NOT NULL,
  `fecha_pedido` DATETIME NULL,
  `preciotota` DOUBLE NULL,
  `Estado` ENUM('Completado', 'Cancelado', 'Pendiente') NULL,
  PRIMARY KEY (`Proveedorid`, `Productoid`),
  INDEX `fk_Proveedor_has_Producto_Producto1_idx` (`Productoid` ASC) VISIBLE,
  INDEX `fk_Proveedor_has_Producto_Proveedor1_idx` (`Proveedorid` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_has_Producto_Proveedor1`
    FOREIGN KEY (`Proveedorid`)
    REFERENCES `ministore-v1`.`Proveedor` (`id_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedor_has_Producto_Producto1`
    FOREIGN KEY (`Productoid`)
    REFERENCES `ministore-v1`.`Producto` (`id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
