-- Crear base de datos
CREATE DATABASE EmpresaTransportes;
USE EmpresaTransportes;

-- Tabla para los camioneros
CREATE TABLE Camionero (
    dpi BIGINT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    salario DECIMAL(10,2),
    zona_aldea VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50)
);

-- Tabla para los camiones
CREATE TABLE Camion (
    matricula VARCHAR(10) PRIMARY KEY,
    modelo VARCHAR(50),
    tipo VARCHAR(50),
    tonelaje DECIMAL(5,2),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50)
);

-- Tabla para los departamentos
CREATE TABLE Departamento (
    codigo_departamento INT PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50)
);

-- Tabla para los paquetes
CREATE TABLE Paquete (
    codigo_paquete INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255),
    destinatario VARCHAR(100),
    direccion_destinatario VARCHAR(255),
    codigo_departamento INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (codigo_departamento) REFERENCES Departamento(codigo_departamento)
);

-- Tabla para los motivos de no entrega de paquetes 
CREATE TABLE Motivo_No_Entrega (
    id_motivo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50)
);

-- Tabla para los viajes
CREATE TABLE Viaje (
    id_viaje INT PRIMARY KEY AUTO_INCREMENT,
    dpi_camionero BIGINT,
    matricula_camion VARCHAR(10),
    fecha_salida DATETIME,
    fecha_regreso DATETIME,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (dpi_camionero) REFERENCES Camionero(dpi),
    FOREIGN KEY (matricula_camion) REFERENCES Camion(matricula)
);

-- Tabla para relacionar los paquetes con los viajes
CREATE TABLE Paquete_Viaje (
    id_viaje INT,
    codigo_paquete INT,
    estado_entrega VARCHAR(50),
    motivo_no_entrega INT,
    PRIMARY KEY (id_viaje, codigo_paquete),
    FOREIGN KEY (id_viaje) REFERENCES Viaje(id_viaje),
    FOREIGN KEY (codigo_paquete) REFERENCES Paquete(codigo_paquete),
    FOREIGN KEY (motivo_no_entrega) REFERENCES Motivo_No_Entrega(id_motivo)
);
