INSERT INTO "proveedores"("nombre", "coreeo_electronico", "telefono") VALUES
('Apple', 'AppleSupport@email.apple.com', 123456789),
('Samsung', 'SamsungSupport@email.samsung.com', 987654321),
('Redmi', 'RedmiSupport@email.redmi.com', 876543210),
('Xbox', 'XboxSupport@email.xbox.com', 765432109),
('Nintendo', 'NintendoSupport@email.nintendo.com', 654321098),
('Azus', 'AzusSupport@email.azus.com', 543210987),
('Playstation', 'PlaystationSupport@email.playstation.com', 432109876);


INSERT INTO "productos"("id_poveerdor","nombre", "categoria", "precio", "Stock_disponible") VALUES 
(1, 'iPhone', 'celular', 100, 10),
(1, 'iPad', 'celular', 200, 20),
(1, 'iPod', 'celular', 300, 30),
(3, 'Redmi', 'celular', 400, 40),
(2, 'Samsung', 'celular', 500, 50),
(4, 'xbox', 'videojuego', 600, 60),
(7, 'ps4', 'videojuego', 700, 70),
(5, 'nintendo', 'videojuego', 800, 80),
(6, 'azus', 'computador', 900, 90);

INSERT INTO "compra_productos"("id_productos", "id_poveerdor", "Stock") VALUES 
(1, 1, 10),
(2, 1, 20),
(3, 1, 30),
(4, 3, 40),
(5, 2, 50),
(6, 4, 60),
(7, 7, 70),
(8, 5, 80),
(9, 6, 90);

INSERT INTO "productos_vendidos"("id_productos", "stock_vendido") VALUES 
(1, 10),
(2, 20),
(3, 30),
(4, 40),
(5, 50),
(6, 60),
(7, 70),
(8, 80),
(9, 90);

INSERT INTO "ventas"("id_cliente", "id_Productos_vendidos") VALUES 
(1, 1),
(3, 2),
(1, 3),
(5, 4),
(2, 5),
(7, 6),
(9, 7),
(1, 8),
(6, 9);

INSERT INTO "clientes"("nombres", "correro", "telefono") VALUES
('jose david', 'josedavid@email.com', 123456789),
('juan carlos', 'juancarlos@email.com', 987654321),
('alejandro', 'alejandro@email.com', 876543210),
('juan', 'juan@email.com', 765432109),
('jose', 'jose@email.com', 654321098),
