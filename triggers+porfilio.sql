
USE Gimnasios;

CREATE TABLE socios_log (
  ID_Log int AUTO_INCREMENT PRIMARY KEY,
  ID_Socio int,
  Nombre varchar(50),
  Apellido varchar(50),
  DNI int,
  Email varchar(100),
  Telefono int,
  SocioActivo tinyint,
  Accion varchar(10),
  FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Usuario VARCHAR (50)
);

DELIMITER $$

CREATE TRIGGER tr_socios_after_insert
AFTER INSERT ON socios FOR EACH ROW
BEGIN
  INSERT INTO socios_log (ID_Socio, Nombre, Apellido, DNI, Email, Telefono, SocioActivo, Accion, Usuario)
  VALUES (NEW.ID_Socio, NEW.Nombre, NEW.Apellido, NEW.DNI, NEW.Email, NEW.Telefono, NEW.SocioActivo, 'INSERT', USER());
END$$

DELIMITER ;

-- Crear tabla que lleve el log de los cambios en la tabla salario profesores
CREATE TABLE SALARIO_PROFESORES_LOG (
  ID_Log int AUTO_INCREMENT PRIMARY KEY,
  ID_SalarioProfesores int,
  ID_AreaProfesores int,
  Descripcion varchar(200),
  AntiguedadMinima tinyint,
  ValorHora float,
  Accion varchar(10),
  FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Usuario varchar(50)
);

DELIMITER $$

-- crear trigger del tipo BEFORE para la tabla salario profesores
CREATE TRIGGER tr_salario_profesores_before_insert
BEFORE INSERT ON SALARIO_PROFESORES FOR EACH ROW
BEGIN
  INSERT INTO SALARIO_PROFESORES_LOG (ID_SalarioProfesores, ID_AreaProfesores, Descripcion, AntiguedadMinima, ValorHora, Accion, Usuario)
  VALUES (NEW.ID_SalarioProfesores, NEW.ID_AreaProfesores, NEW.Descripcion, NEW.AntiguedadMinima, NEW.ValorHora, 'INSERT', CURRENT_USER());
END$$


DELIMITER ;


