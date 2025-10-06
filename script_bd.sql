/*
============================================================
 Script: script_bd.sql
 Projeto: SkyAid
 Objetivo: Criação das tabelas compatíveis com as entidades JPA
 Autor: Pedro Andrade (RM558186)
============================================================
*/

-- ===========================
-- Tabela: OPERADORES
-- ===========================
CREATE TABLE OPERADORES (
    id_operador INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NOT NULL UNIQUE,
    senha NVARCHAR(255) NOT NULL,
    id_base INT NULL
);
GO

-- ===========================
-- Tabela: DRONES
-- ===========================
CREATE TABLE DRONES (
    id_drone INT IDENTITY(1,1) PRIMARY KEY,
    identificador NVARCHAR(100) NOT NULL UNIQUE,
    modelo NVARCHAR(100) NOT NULL,
    status NVARCHAR(50) NOT NULL,
    id_operador INT NOT NULL,
    CONSTRAINT FK_Drone_Operador FOREIGN KEY (id_operador) REFERENCES OPERADORES(id_operador)
);
GO

-- ===========================
-- Tabela: MISSOES
-- ===========================
CREATE TABLE MISSOES (
    id_missao INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(50) NOT NULL,
    status NVARCHAR(50) NOT NULL,
    descricao NVARCHAR(500) NULL,
    destino_latitude FLOAT NOT NULL,
    destino_longitude FLOAT NOT NULL,
    id_drone INT NOT NULL,
    CONSTRAINT FK_Missao_Drone FOREIGN KEY (id_drone) REFERENCES DRONES(id_drone)
);
GO

-- ===========================
-- Tabela: REGISTROS_DE_SENSOR
-- ===========================
CREATE TABLE REGISTROS_DE_SENSOR (
    id_registro INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(50) NOT NULL,
    valor FLOAT NOT NULL,
    data_hora DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    latitude FLOAT NULL,
    longitude FLOAT NULL,
    id_drone INT NOT NULL,
    CONSTRAINT FK_Registro_Drone FOREIGN KEY (id_drone) REFERENCES DRONES(id_drone)
);
GO
