/*Aclaración: Para resolver esta actividad, ignorar la columna Estado de todas las tablas.*/
----------------------------------------------------------------------------------------------
--La cantidad de colaboradores que nacieron luego del año 1995.
SELECT COUNT(Legajo) FROM Colaboradores WHERE YEAR(FechaNacimiento) > 1995

--El costo total de todos los pedidos que figuren como Pagado.
SELECT SUM(Costo) FROM Pedidos WHERE Pagado = 1

--La cantidad total de unidades pedidas del producto con ID igual a 30.
SELECT SUM(Cantidad) FROM Pedidos WHERE IDProducto = 30

--La cantidad de clientes distintos que hicieron pedidos en el año 2020
SELECT COUNT(DISTINCT IDCliente) FROM Pedidos WHERE YEAR(FechaSolicitud) = 2020

--Por cada material, la cantidad de productos que lo utilizan.
SELECT M.ID, COUNT(*) AS 'productos que lo utilizan' FROM Materiales M
INNER JOIN Materiales_x_Producto MXP ON M.ID = MXP.IDMaterial
GROUP BY M.ID
ORDER BY COUNT(DISTINCT MXP.IDProducto) DESC

--Para cada producto, listar el nombre y la cantidad de pedidos pagados.
SELECT P.Descripcion, COUNT(Ped.IDProducto) AS 'Cantidad Pagados' FROM Productos P
INNER JOIN Pedidos Ped ON P.ID = Ped.IDProducto
WHERE Ped.Pagado = 1
GROUP BY P.Descripcion, Ped.Pagado

--Por cada cliente, listar apellidos y nombres de los clientes y la cantidad de productos distintos que haya pedido
SELECT DISTINCT C.Apellidos + ', ' + C. Nombres AS 'Apellido y nombre', COUNT(DISTINCT P.IDProducto) AS 'Productos Distintos' FROM Clientes C 
INNER JOIN Pedidos P ON P.IDCliente = C.ID
GROUP BY C.Apellidos + ', ' + C. Nombres

--Por cada colaborador y tarea que haya realizado, listar apellidos y nombres, nombre de la tarea y la cantidad de veces que haya realizado esa tarea.
SELECT C.Apellidos, C.Nombres, T.Nombre, COUNT(T.ID) FROM Tareas_x_Pedido TxP
INNER JOIN Tareas T ON TxP.IDTarea = T.ID
INNER JOIN Colaboradores C ON TxP.Legajo = C.Legajo
GROUP BY C.Apellidos, C.Nombres, T.Nombre

--Por cada cliente, listar los apellidos y nombres y el importe individual más caro que hayan abonado en concepto de pago
SELECT C.Apellidos, C.Nombres, MAX(Pa.Importe) AS 'Maximo Importe' FROM Clientes C
INNER JOIN Pedidos P ON P.IDCliente = C.ID
INNER JOIN Pagos Pa ON Pa.IDPedido = P.ID
GROUP BY C.Apellidos, C.Nombres

--Por cada colaborador, apellidos y nombres y la menor cantidad de unidades solicitadas en un pedido individual en el que haya trabajado.
SELECT C.Apellidos, C.Nombres, MIN(P.Cantidad) AS ' ' FROM Tareas_x_Pedido TxP
INNER JOIN Pedidos P On TxP.IDPedido = P.ID
INNER JOIN Colaboradores C ON C.Legajo = TxP.Legajo
GROUP BY C.Apellidos, C.Nombres

--Listar apellidos y nombres de aquellos clientes que no hayan realizado ningún pedido. Es decir, que contabilicen 0 pedidos
SELECT C.Apellidos, C.Nombres FROM Clientes C
LEFT JOIN Pedidos P On P.IDCliente = C.ID
GROUP BY C.Apellidos, C.Nombres
HAVING COUNT(P.ID) = 0

--Obtener un listado de productos indicando descripción y precio de aquellos productos que hayan registrado más de 15 pedidos.
SELECT P.Descripcion, P.Precio FROM Productos P
INNER JOIN Pedidos Pe ON Pe.IDProducto = P.ID
GROUP BY P.Descripcion, P.Precio
HAVING COUNT(Pe.ID) > 15

--Apellidos y nombres de los clientes que hayan registrado más de 15 pedidos que superen los $15000.
SELECT C.Apellidos, C.Nombres FROM CLIENTES C
INNER JOIN Pedidos P ON C.ID = P.IDCliente
INNER JOIN Pagos Pa ON Pa.IDPedido = P.ID
WHERE Pa.Importe > 15000
GROUP BY C.Apellidos, C.Nombres
HAVING COUNT(P.ID) > 15

-- Para cada producto, listar el nombre, el texto 'Pagados'  y la cantidad de pedidos pagados. 
--Anexar otro listado con nombre, el texto 'No pagados' y cantidad de pedidos no pagados.
SELECT P.Descripcion, CONCAT( 'Pagados: ', COUNT(Pe.ID)) AS 'Estado' FROM Pedidos Pe
INNER JOIN Productos P ON P.ID = Pe.IDProducto
WHERE Pe.Pagado = 1
GROUP BY P.Descripcion
UNION 
SELECT P.Descripcion, CONCAT( 'No Pagados: ', COUNT(Pe.ID)) AS 'Estado' FROM Pedidos Pe
INNER JOIN Productos P ON P.ID = Pe.IDProducto
WHERE Pe.Pagado = 0
GROUP BY P.Descripcion