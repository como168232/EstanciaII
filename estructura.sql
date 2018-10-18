SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Usuario`;
DROP TABLE IF EXISTS `TipoUsuario`;
DROP TABLE IF EXISTS `Curso`;
DROP TABLE IF EXISTS `Prueba`;
DROP TABLE IF EXISTS `Pregunta`;
DROP TABLE IF EXISTS `Respuesta`;
DROP TABLE IF EXISTS `OpcionRespuesta`;
DROP TABLE IF EXISTS `TipoPrueba`;
DROP TABLE IF EXISTS `informacion`;
DROP TABLE IF EXISTS `Recompensa`;
DROP TABLE IF EXISTS `TipoRecompensa`;
DROP TABLE IF EXISTS `Transaccion`;
DROP TABLE IF EXISTS `Alumno`;
DROP TABLE IF EXISTS `Profesor`;
DROP TABLE IF EXISTS `AlumnoCurso`;
DROP TABLE IF EXISTS `Administrador`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Usuario` (
    `idUsuario` INTEGER NOT NULL,
    `usuario` INTEGER NOT NULL,
    `password` INTEGER NOT NULL,
    `nombre` INTEGER NOT NULL,
    `apellido` INTEGER NOT NULL,
    `idTipoUsuario` INTEGER NOT NULL,
    `correo` INTEGER NOT NULL
);

CREATE TABLE `TipoUsuario` (
    `idTipoUsuario` INTEGER NOT NULL,
    `nombreTipo` INTEGER NOT NULL
);

CREATE TABLE `Curso` (
    `idCurso` INTEGER NOT NULL,
    `nombreCurso` INTEGER NOT NULL,
    `fechaInicio` INTEGER NOT NULL,
    `fechaTermino` INTEGER NOT NULL,
    PRIMARY KEY (`idCurso`)
);

CREATE TABLE `Prueba` (
    `idPrueba` INTEGER NOT NULL,
    `idCurso` INTEGER NOT NULL,
    `idRecompensa` INTEGER NOT NULL,
    `idTipoPrueba` INTEGER NOT NULL,
    PRIMARY KEY (`idPrueba`)
);

CREATE TABLE `Pregunta` (
    `idPregunta` INTEGER NOT NULL,
    `descripcion` INTEGER NOT NULL,
    `idPrueba` INTEGER NOT NULL,
    PRIMARY KEY (`idPregunta`)
);

CREATE TABLE `Respuesta` (
    `idRespuesta` INTEGER NOT NULL,
    `idPregunta` INTEGER NOT NULL,
    PRIMARY KEY (`idRespuesta`)
);

CREATE TABLE `OpcionRespuesta` (
    `idOpcionRespuesta` INTEGER NOT NULL,
    `descripcion` INTEGER NOT NULL,
    `idPregunta` INTEGER NOT NULL,
    PRIMARY KEY (`idOpcionRespuesta`)
);

CREATE TABLE `TipoPrueba` (
    `idTipoPrueba` INTEGER NOT NULL,
    `tipoPrueba` INTEGER NOT NULL,
    PRIMARY KEY (`idTipoPrueba`)
);

CREATE TABLE `informacion` (
    `idInformacion` INTEGER NOT NULL,
    `puntaje` INTEGER NOT NULL,
    `compras` INTEGER NOT NULL,
    `quizzesContestados` INTEGER NOT NULL,
    `monedas` INTEGER NOT NULL,
    `posicionRanking` INTEGER NOT NULL,
    PRIMARY KEY (`idInformacion`)
);

CREATE TABLE `Recompensa` (
    `idRecompensa` INTEGER NOT NULL,
    `descripcion` INTEGER NOT NULL,
    `montoRecompensa` INTEGER NOT NULL,
    `cantidadDisponible` INTEGER NOT NULL,
    `idTipoRecompensa` INTEGER NOT NULL,
    PRIMARY KEY (`idRecompensa`)
);

CREATE TABLE `TipoRecompensa` (
    `idTipoRecompensa` INTEGER NOT NULL,
    `nombreRecompensa` INTEGER NOT NULL,
    PRIMARY KEY (`idTipoRecompensa`)
);

CREATE TABLE `Transaccion` (
    `idTransaccion` INTEGER NOT NULL,
    `idAlumno` INTEGER NOT NULL,
    PRIMARY KEY (`idTransaccion`)
);

CREATE TABLE `Alumno` (
    `idAlumno` INTEGER NOT NULL,
    `usuario` INTEGER NOT NULL,
    `password` INTEGER NOT NULL,
    `nombre` INTEGER NOT NULL,
    `apellido` INTEGER NOT NULL,
    `correo` INTEGER NOT NULL,
    PRIMARY KEY (`idAlumno`)
);

CREATE TABLE `Profesor` (
    `idProfesor` INTEGER NOT NULL,
    `usuario` INTEGER NOT NULL,
    `contraseña` INTEGER NOT NULL,
    `nombre` INTEGER NOT NULL,
    `apellido` INTEGER NOT NULL,
    `correo` INTEGER NOT NULL,
    PRIMARY KEY (`idProfesor`)
);

CREATE TABLE `AlumnoCurso` (
    `idAlumno` INTEGER NOT NULL,
    `idCurso` INTEGER NOT NULL
);

CREATE TABLE `Administrador` (
    `idAdministrador` SMALLINT NOT NULL,
    `usuario` VARCHAR(30) NOT NULL,
    `password` VARCHAR(30) NOT NULL,
    `nombre` VARCHAR(30) NOT NULL,
    `apellido` VARCHAR(40) NOT NULL,
    `correo` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`idAdministrador`)
);

ALTER TABLE `OpcionRespuesta` ADD FOREIGN KEY (`idPregunta`) REFERENCES `Pregunta`(`idPregunta`);