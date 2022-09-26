/* Aclaraciones
- Un cliente de tipo particular registra 'P' en el campo Tipo. Mientras que uno de tipo empresa registra 'E'.
- Las formas de pago pueden ser 'E' para efectivo, 'B' - Bitcoin, 'T' para tarjeta y 'C' para cheque.
- Los servicios con garantía tienen al menos un día de garantía */

--Listado con Apellido y nombres de los técnicos que, en promedio, hayan demorado más de 225 minutos en la prestación de servicios.
SELECT T.Apellido, T.Nombre FROM Tecnicos T
INNER JOIN Servicios S On T.ID = S.IDTecnico
GROUP BY T.Apellido, T.Nombre
HAVING AVG(S.Duracion) > 225

--Listado con Descripción del tipo de servicio, el texto 'Particular' y la cantidad de clientes de tipo Particular. 
--Luego añadirle un listado con descripción del tipo de servicio, el texto 'Empresa' y la cantidad de clientes de tipo Empresa.
SELECT TS.Descripcion, C.Tipo AS 'Particular ', COUNT(DISTINCT C.ID) AS 'Cantidad' FROM Servicios S
INNER JOIN TiposServicio TS ON TS.ID = S.IDTipo
INNER JOIN Clientes C ON S.IDCliente = C.ID 
WHERE C.Tipo = 'P'
GROUP BY TS.Descripcion, C.Tipo
UNION
SELECT TS.Descripcion, C.Tipo AS 'Empresa', COUNT(DISTINCT C.ID) AS 'Cantidad' FROM Servicios S
INNER JOIN TiposServicio TS ON TS.ID = S.IDTipo
INNER JOIN Clientes C ON S.IDCliente = C.ID
WHERE C.Tipo = 'E'
GROUP BY TS.Descripcion, C.Tipo

--Listado con Apellidos y nombres de los clientes que hayan abonado con las cuatro formas de pago.
SELECT C.Apellido, C.Nombre FROM CLIENTES C
INNER JOIN Servicios S ON C.ID = S.IDCliente
GROUP BY C.Apellido, C.Nombre
HAVING COUNT(DISTINCT S.FormaPago) = 4

--La descripción del tipo de servicio que en promedio haya brindado mayor cantidad de días de garantía.
SELECT TOP 1 WITH TIES TS.Descripcion FROM TiposServicio TS
INNER JOIN Servicios S ON S.IDTipo = TS.ID
GROUP BY TS.Descripcion
ORDER BY AVG(S.DiasGarantia*1.0) DESC

/* Agregar las tablas y/o restricciones que considere necesario para permitir a un cliente que contrate a un técnico por un período determinado. 
Dicha contratación debe poder registrar la fecha de inicio y fin del trabajo, el costo total, el domicilio al que debe el técnico asistir y 
la periodicidad del trabajo (1 - Diario, 2 - Semanal, 3 - Quincenal). */

CREATE TABLE Contratos(
	ID int NOT NULL PRIMARY KEY Identity(1,1),
	IDCLiente INT NOT NULL FOREIGN KEY REFERENCES Clientes(ID),
	IDTecnico INT NOT NULL FOREIGN KEY REFERENCES Tecnicos(ID),
	FechaInicio DATE NOT NULL,
	FechaFinalizacion DATE NOT NULL Check(FechaInicio <= FechaFinalizacion),
	Costo Money NOT NULL CHECK(Costo>0),
	DomicilioTrabajo varchar(150) NOT NULL,
	Periodicidad int NOT NULL CHECK(Periodicidad = 1 OR Periodicidad =2 OR Periodicidad = 3) 
)
