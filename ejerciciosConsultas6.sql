select * from clientes 
select * from productos
select * from factura_detalle
select * from registro_compra_detalle_cliente
update clientes set nombres = 'David Manuel' where autoid = 4

inse

--ID CLIENTES MONTERREY
SELECT autoid FROM clientes where barrio = 'Monterrey'

--ID PRODUCTOS < 15$
SELECT sku FROM productos WHERE precio < 15 

--ID y nombre de los clientes, cantidad vendida, y descripción del producto, en las ventas en las cuales se vendieron más de 10 unidades.
select 
	fdeta.fk_autoid_cliente,
	cli.nombres,
	fdeta.cantidad_compra,
	pro.descripcion
from 
	"Factura_detalle" AS fdeta inner join clientes as cli on fdeta.fk_autoid_cliente = cli.autoid
	inner join productos as pro on fdeta.fk_sku_producto = pro.sku
where
	fdeta.cantidad_compra >= 10
	
--ID y nombre de los clientes que no aparecen en la tabla de ventas (Clientes que no han comprado productos)
select 
	cli.autoid,
	cli.nombres || ' ' || cli.apellidos
from clientes as cli LEFT join factura_detalle as fact on cli.autoid = fact.fk_autoid_cliente
where fact.fk_autoid_cliente IS NULL

--ID y nombre de los clientes que han comprado todos los productos de la empresa.
SELECT 
	cli.autoid,
	cli.nombres || ' ' || cli.apellidos AS NOMBRES
from clientes as cli JOIN factura_detalle as fact on cli.autoid = fact.fk_autoid_cliente
GROUP BY cli.autoid, NOMBRES
HAVING COUNT (DISTINCT fact.fk_sku_producto) = (SELECT COUNT(DISTINCT sku) from productos)

--ID y nombre de cada cliente y la suma total (suma de cantidad) de los productos que ha comprado.
SELECT 
	cli.autoid,
	cli.nombres || ' ' || cli.apellidos AS NOMBRES,
	sum(fact.cantidad_compra) AS cantidad_articulos
from clientes as cli JOIN factura_detalle as fact on cli.autoid = fact.fk_autoid_cliente
group by 	cli.autoid

--ID de los productos que no han sido comprados por clientes de Guadalajara.
SELECT 
	prod.sku
from productos as prod left join factura_detalle as fact on prod.sku = fact.fk_autoid_cliente
left join clientes as cli on fact.fk_autoid_cliente = cli.autoid AND cli.barrio ='Guadalajara'
where cli.autoid is NULL