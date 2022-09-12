--Apellido, nombres y fecha de ingreso de todos los colaboradores
SELECT Apellidos, Nombres, AñoIngreso FROM Colaboradores 
GO
--Apellido, nombres y antigüedad de todos los colaboradores
SELECT Apellidos, Nombres,  DATEDIFF(YEAR,0,GETDATE()-AñoIngreso) AS Antiguedad FROM Colaboradores --REVISAR SIEMPRE RESULTA 117 Antiguedad
GO
--Apellido y nombres de aquellos colaboradores que trabajen part-time.
SELECT Apellidos, Nombres FROM Colaboradores WHERE ModalidadTrabajo = 'P'
GO
--Apellido y nombres, antigüedad y modalidad de trabajo de aquellos colaboradores cuyo sueldo sea entre 50000 y 100000.
SELECT Apellidos, Nombres, DATEDIFF(YEAR,0,GETDATE()-AñoIngreso) AS Antiguedad FROM Colaboradores WHERE Sueldo BETWEEN 50000 AND 100000
GO
--Apellidos y nombres y edad de los colaboradores con legajos 4, 6, 12 y 25.
SELECT APellidos, Nombres, DATEDIFF(YEAR,0,GETDATE()-YEAR(FechaNacimiento)) AS Edad FROM Colaboradores WHERE Legajo IN (4,6,12,25) --REVISAR NO DEVUELVE NADA
GO
--Todos los datos de todos los productos ordenados por precio de venta. Del más caro al más barato
SELECT * FROM Productos ORDER BY Precio DESC
GO
--El nombre del producto más costoso.
SELECT TOP(1) A.Nombre, B.Precio FROM Categorias AS A, Productos AS B ORDER BY Precio DESC
GO
--Todos los datos de todos los pedidos que hayan superado el monto de $20000.
SELECT * FROM Pedidos WHERE Costo > 20000
GO
--Apellido y nombres de los clientes que no hayan registrado teléfono.
SELECT Apellidos, Nombres FROM Clientes WHERE Telefono IS NULL
GO
--Apellido y nombres de los clientes que hayan registrado mail pero no teléfono.
SELECT Apellidos, Nombres FROM Clientes WHERE Mail IS NOT NULL AND Telefono IS NULL
GO
/*
Apellidos, nombres y datos de contacto de todos los clientes.
Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el número de teléfono fijo y si no tiene este último el mail.
En caso de no tener ninguno de los tres debe figurar 'Incontactable'.
*/
SELECT Apellidos, Nombres, Coalesce(Celular, Telefono, Mail, 'Incontactable') as Contacto FROM CLIENTES
GO
/*
Apellidos, nombres y medio de contacto de todos los clientes. Si tiene celular debe figurar 'Celular'.
Si no tiene celular pero tiene teléfono fijo debe figurar 'Teléfono fijo' de lo contrario y si tiene Mail debe figurar 'Email'.
Si no posee ninguno de los tres debe figurar NULL.
*/
SELECT Apellidos, Nombres, CASE WHEN Celular IS NOT NULL THEN 'Celular' WHEN Telefono IS NOT NULL THEN 'Telefono FIjo' WHEN Mail IS NOT NULL THEN 'Email' END AS Contacto FROM Clientes
GO
--Todos los datos de los colaboradores que hayan nacido luego del año 2000
SELECT * FROM Colaboradores WHERE YEAR(FechaNacimiento) > 2000 --REVISAR NO DEVUELVE NADA
GO
--Todos los datos de los colaboradores que hayan nacido entre los meses de Enero y Julio (inclusive)
SELECT * FROM Colaboradores WHERE Month(FechaNacimiento) > 1 AND Month(FechaNacimiento) <= 7
GO
--Todos los datos de los clientes cuyo apellido finalice con vocal
SELECT * FROM Clientes WHERE Apellidos LIKE '%[aeiou]'
GO
--Todos los datos de los clientes cuyo nombre comience con 'A' y contenga al menos otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc
SELECT * FROM Clientes WHERE Nombres LIKE 'A%a%'
GO
--Todos los colaboradores que tengan más de 10 años de antigüedad
SELECT * FROM Colaboradores WHERE DATEDIFF(YEAR,0,GETDATE()-AñoIngreso) > 10
GO
--Los códigos de producto, sin repetir, que hayan registrado al menos un pedido
SELECT DISTINCT IDProducto FROM Pedidos WHERE Cantidad > 1
GO
--Todos los datos de todos los productos con su precio aumentado en un 20%
SELECT ID, IDCategoria, Descripcion, DiasConstruccion, Costo, Precio, Precio*1.2 as 'Precio + 20%', PrecioVentaMayorista, CantidadMayorista, Estado FROM Productos
GO
/*
Todos los datos de todos los colaboradores ordenados por apellido ascendentemente en primera instancia y por nombre descendentemente
en segunda instancia.
*/
SELECT * FROM Colaboradores ORDER BY Apellidos ASC,Nombres DESC