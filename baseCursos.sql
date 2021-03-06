-- MySQL Script generated by MySQL Workbench
-- Tue Nov 13 10:13:43 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cursos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cursos` ;

-- -----------------------------------------------------
-- Schema cursos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cursos` DEFAULT CHARACTER SET utf8 ;
USE `cursos` ;

-- -----------------------------------------------------
-- Table `cursos`.`Clase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Clase` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Clase` (
  `idClase` TINYINT UNSIGNED NOT NULL,
  `Grado` TINYINT UNSIGNED NOT NULL,
  `Grupo` CHAR NOT NULL,
  `Carrera` VARCHAR(4) NULL,
  PRIMARY KEY (`idClase`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursos`.`Alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Alumno` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Alumno` (
  `idAlumno` INT UNSIGNED NOT NULL,
  `matricula` VARCHAR(12) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `idClase` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`idAlumno`),
  CONSTRAINT `idClase`
    FOREIGN KEY (`idClase`)
    REFERENCES `cursos`.`Clase` (`idClase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `matricula_UNIQUE` ON `cursos`.`Alumno` (`matricula` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `cursos`.`Alumno` (`correo` ASC) VISIBLE;

CREATE INDEX `idClase_idx` ON `cursos`.`Alumno` (`idClase` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Profesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Profesor` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Profesor` (
  `idProfesor` INT UNSIGNED NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProfesor`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `usuario_UNIQUE` ON `cursos`.`Profesor` (`usuario` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `cursos`.`Profesor` (`correo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Curso` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Curso` (
  `idCurso` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `inicio` DATE NULL,
  `fin` DATE NULL,
  `idProfesor` INT UNSIGNED NULL,
  `idClase` TINYINT UNSIGNED NOT NULL,
  `montoMaximo` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`idCurso`),
  CONSTRAINT `idProfesor`
    FOREIGN KEY (`idProfesor`)
    REFERENCES `cursos`.`Profesor` (`idProfesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idClase`
    FOREIGN KEY (`idClase`)
    REFERENCES `cursos`.`Clase` (`idClase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idProfesor_idx` ON `cursos`.`Curso` (`idProfesor` ASC) VISIBLE;

CREATE INDEX `idClase_idx` ON `cursos`.`Curso` (`idClase` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`InformacionAlumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`InformacionAlumno` ;

CREATE TABLE IF NOT EXISTS `cursos`.`InformacionAlumno` (
  `idInformacionAlumno` INT UNSIGNED NOT NULL,
  `puntaje` INT UNSIGNED ZEROFILL NULL,
  `pruebasRealizadas` INT UNSIGNED ZEROFILL NULL,
  `monedas` INT UNSIGNED ZEROFILL NULL,
  `posicionRanking` INT NULL,
  `idCurso` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idInformacionAlumno`, `idCurso`),
  CONSTRAINT `idAlumno`
    FOREIGN KEY (`idInformacionAlumno`)
    REFERENCES `cursos`.`Alumno` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCurso`
    FOREIGN KEY (`idCurso`)
    REFERENCES `cursos`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idCurso_idx` ON `cursos`.`InformacionAlumno` (`idCurso` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Tranferencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Tranferencia` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Tranferencia` (
  `idTranferencia` INT UNSIGNED NOT NULL,
  `idEmisor` INT UNSIGNED NOT NULL,
  `idRemitente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTranferencia`),
  CONSTRAINT `fk_Alumno`
    FOREIGN KEY (`idEmisor` , `idRemitente`)
    REFERENCES `cursos`.`InformacionAlumno` (`idInformacionAlumno` , `idInformacionAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alumno_idx` ON `cursos`.`Tranferencia` (`idEmisor` ASC, `idRemitente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Beneficio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Beneficio` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Beneficio` (
  `idBeneficio` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  `costo` INT ZEROFILL NULL,
  PRIMARY KEY (`idBeneficio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursos`.`Transaccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Transaccion` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Transaccion` (
  `idTransaccion` INT UNSIGNED NOT NULL,
  `idAlumno` INT UNSIGNED NOT NULL,
  `idBeneficio` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTransaccion`),
  CONSTRAINT `idAlumno`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `cursos`.`Alumno` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBeneficio`
    FOREIGN KEY (`idBeneficio`)
    REFERENCES `cursos`.`Beneficio` (`idBeneficio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idAlumno_idx` ON `cursos`.`Transaccion` (`idAlumno` ASC) VISIBLE;

CREATE INDEX `idBeneficio_idx` ON `cursos`.`Transaccion` (`idBeneficio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Administrador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Administrador` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Administrador` (
  `idAdministrador` INT UNSIGNED NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdministrador`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `cursos`.`Administrador` (`correo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Prueba`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Prueba` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Prueba` (
  `idPrueba` INT UNSIGNED NOT NULL,
  `idCurso` INT UNSIGNED NOT NULL,
  `montoRecompensa` INT NULL,
  `cantidadRecompensas` INT NULL,
  `inicio` DATETIME NOT NULL,
  `fin` DATETIME NOT NULL,
  PRIMARY KEY (`idPrueba`),
  CONSTRAINT `idCurso`
    FOREIGN KEY (`idCurso`)
    REFERENCES `cursos`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idCurso_idx` ON `cursos`.`Prueba` (`idCurso` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`ContraReloj`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`ContraReloj` ;

CREATE TABLE IF NOT EXISTS `cursos`.`ContraReloj` (
  `idPrueba` INT UNSIGNED NOT NULL,
  `tiempoPorPregunta` TIME NOT NULL,
  PRIMARY KEY (`idPrueba`),
  CONSTRAINT `idPrueba`
    FOREIGN KEY (`idPrueba`)
    REFERENCES `cursos`.`Prueba` (`idPrueba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursos`.`Pregunta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Pregunta` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Pregunta` (
  `idPregunta` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `idPrueba` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPregunta`),
  CONSTRAINT `idPrueba`
    FOREIGN KEY (`idPrueba`)
    REFERENCES `cursos`.`Prueba` (`idPrueba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idPruebas_idx` ON `cursos`.`Pregunta` (`idPrueba` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Respuesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Respuesta` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Respuesta` (
  `idRespuesta` INT NOT NULL,
  `idPregunta` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `correcta` TINYINT NULL,
  PRIMARY KEY (`idRespuesta`),
  CONSTRAINT `idPregunta`
    FOREIGN KEY (`idPregunta`)
    REFERENCES `cursos`.`Pregunta` (`idPregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idPregunta_idx` ON `cursos`.`Respuesta` (`idPregunta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`PruebaAlumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`PruebaAlumno` ;

CREATE TABLE IF NOT EXISTS `cursos`.`PruebaAlumno` (
  `idPrueba` INT UNSIGNED NOT NULL,
  `idAlumno` INT UNSIGNED NOT NULL,
  `aciertos` TINYINT NULL,
  `tiempoAcumulado` TIME NULL,
  `realizado` TINYINT NULL,
  PRIMARY KEY (`idPrueba`, `idAlumno`),
  CONSTRAINT `idPrueba`
    FOREIGN KEY (`idPrueba`)
    REFERENCES `cursos`.`Prueba` (`idPrueba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idAlumno`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `cursos`.`InformacionAlumno` (`idInformacionAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idAlumno_idx` ON `cursos`.`PruebaAlumno` (`idAlumno` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Ultimo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Ultimo` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Ultimo` (
  `idPrueba` INT UNSIGNED NOT NULL,
  `vidasPrueba` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPrueba`),
  CONSTRAINT `idPrueba`
    FOREIGN KEY (`idPrueba`)
    REFERENCES `cursos`.`Prueba` (`idPrueba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idPrueba_idx` ON `cursos`.`Ultimo` (`idPrueba` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cursos`.`Campal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cursos`.`Campal` ;

CREATE TABLE IF NOT EXISTS `cursos`.`Campal` (
  `idPrueba` INT UNSIGNED NOT NULL,
  `idContrincante1` INT UNSIGNED NOT NULL,
  `idContrincante2` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPrueba`),
  CONSTRAINT `idPrueba`
    FOREIGN KEY (`idPrueba`)
    REFERENCES `cursos`.`Prueba` (`idPrueba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idContrincantes`
    FOREIGN KEY (`idContrincante1` , `idContrincante2`)
    REFERENCES `cursos`.`InformacionAlumno` (`idInformacionAlumno` , `idInformacionAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idContrincante1_idx` ON `cursos`.`Campal` (`idContrincante1` ASC, `idContrincante2` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
