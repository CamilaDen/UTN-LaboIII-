--Por cada producto listar la descripción del producto, el precio y el nombre de la categoría a la que pertenece.
SELECT P.Descripcion, P.Precio, C.Nombre FROM Productos AS P LEFT JOIN Categorias as C ON P.IDCategoria = C.ID   

--Listar las categorías de producto de las cuales no se registren productos.
SELECT C.Nombre FROM Categorias AS C
LEFT JOIN Productos AS P ON P.IDCategoria = C.ID
WHERE P.IDCategoria IS NULL

--Listar el nombre de la categoría de producto de aquel o aquellos productos que más tiempo lleven en construir.
SELECT TOP 1 With ties C.Nombre FROM Categorias AS C
INNER JOIN Productos AS P ON P.IDCategoria= C.ID
ORDER BY P.DiasConstruccion DESC

--Listar apellidos y nombres y dirección de mail de aquellos clientes que no hayan registrado pedidos.
SELECT C.Apellidos, C.Nombres, C.Mail FROM Clientes AS C
LEFT JOIN Pedidos AS P ON P.IDCliente = C.ID
WHERE P.IDCliente IS NULL

--Listar apellidos y nombres, mail, teléfono y celular de aquellos clientes que hayan realizado algún pedido cuyo costo supere $1000000
SELECT C.Apellidos, C.Nombres, C.Mail, C.Telefono, C.Celular FROM CLientes AS C
INNER JOIN Pedidos AS P ON P.IDCliente = C.ID
WHERE P.Costo > 1000000

/*Listar IDPedido, Costo, Fecha de solicitud y fecha de finalización, descripción del producto, costo y apellido y nombre del cliente.
Sólo listar aquellos registros de pedidos que hayan sido pagados.*/
SELECT P.ID, P.Costo, P.FechaSolicitud, P.FechaFinalizacion, Pr.Descripcion, Pr.Costo, C.Apellidos, C.Nombres FROM Pedidos AS P
LEFT JOIN Productos AS PR On P.IDProducto = PR.ID
INNER JOIN Clientes AS C ON P.IDCliente= C.ID
WHERE P.Pagado = 1

/*Listar IDPedido, Fecha de solicitud, fecha de finalización, días de construcción del producto, días de construcción del pedido 
(fecha de finalización - fecha de solicitud) y una columna llamada Tiempo de construcción con la siguiente información:
'Con anterioridad' → Cuando la cantidad de días de construcción del pedido sea menor a los días de construcción del producto.
'Exacto'' → Si la cantidad de días de construcción del pedido y el producto son iguales
'Con demora' → Cuando la cantidad de días de construcción del pedido sea mayor a los días de construcción del producto.*/
SELECT P.ID, P.FechaSolicitud, P.FechaFinalizacion, PR.DiasConstruccion, DATEDIFF(DAY,FechaSolicitud,P.FechaFinalizacion) AS 'TiempoConstruccionPedido', 
CASE
	WHEN DATEDIFF(DAY, P.FechaSolicitud, P.FechaFinalizacion) < PR.DiasConstruccion THEN 'CON ANTERIORIDAD'
	WHEN DATEDIFF(DAY, P.FechaSolicitud, P.FechaFinalizacion) = PR.DiasConstruccion THEN 'EXACTO'
	WHEN DATEDIFF(DAY, P.FechaSolicitud, P.FechaFinalizacion) > PR.DiasConstruccion THEN 'CON DEMORA'
END
FROM Pedidos AS P
INNER JOIN Productos AS PR ON PR.ID = P.IDProducto

/*Listar por cada cliente el apellido y nombres y los nombres de las categorías de aquellos productos de los cuales hayan realizado pedidos. 
No deben figurar registros duplicados.*/
SELECT DISTINCT C.Apellidos, C.Nombres, Cat.Nombre FROM Clientes AS C
LEFT JOIN Pedidos AS P ON P.IDCliente = C.ID
INNER JOIN Categorias AS Cat ON P.IDProducto = Cat.ID
WHERE P.IDCliente IS NOT NULL

/*Listar apellidos y nombres de aquellos clientes que hayan realizado algún pedido cuya cantidad sea exactamente igual a la cantidad 
considerada mayorista del producto.*/
SELECT DISTINCT C.Apellidos, C.Nombres FROM Clientes AS C
LEFT JOIN Pedidos AS P ON P.IDCliente = C.ID
INNER JOIN Productos AS Pr ON Pr.ID =  P.IDProducto
WHERE P.Cantidad = Pr.CantidadMayorista

/*Listar por cada producto el nombre del producto, el nombre de la categoría, el precio de venta minorista, el precio de venta mayorista y
el porcentaje de ahorro que se obtiene por la compra mayorista a valor mayorista en relación al valor minorista.*/
SELECT P.Descripcion AS 'Nombre', C.Nombre AS 'Categoria', P.Precio AS 'Precio Minorista', P.PrecioVentaMayorista, ((((P.Precio*100)/P.PrecioVentaMayorista)/100)-1) 
AS 'Porcentaje Ahorro' FROM Productos AS P 
INNER JOIN Categorias AS C ON P.IDCategoria = C.ID 

