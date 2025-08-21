CREATE TABLE "Productos"(
    "id" BIGINT NOT NULL,
    "id_proveedor" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "categoria" VARCHAR(255) NULL,
    "precio" DECIMAL(8, 2) NOT NULL,
    "Stock_disponible" BIGINT NOT NULL
);
ALTER TABLE
    "Productos" ADD PRIMARY KEY("id");
CREATE TABLE "clientes"(
    "id" BIGINT NOT NULL,
    "nombres" VARCHAR(255) NOT NULL,
    "correro" VARCHAR(255) NOT NULL,
    "telefono" BIGINT NOT NULL
);
ALTER TABLE
    "clientes" ADD PRIMARY KEY("id");
CREATE TABLE "ventas"(
    "id" BIGINT NOT NULL,
    "id_cliente" BIGINT NOT NULL,
    "id_Productos_vendidos" BIGINT NOT NULL
);
ALTER TABLE
    "ventas" ADD PRIMARY KEY("id");
CREATE TABLE "Proveedores"(
    "id" BIGINT NOT NULL,
    "nombre" BIGINT NOT NULL,
    "coreeo_electronico" VARCHAR(255) NOT NULL,
    "telefono" BIGINT NOT NULL
);
ALTER TABLE
    "Proveedores" ADD PRIMARY KEY("id");
CREATE TABLE "productos_vendidos"(
    "id" BIGINT NOT NULL,
    "id_productos" BIGINT NOT NULL,
    "stock_vendido" BIGINT NOT NULL
);
ALTER TABLE
    "productos_vendidos" ADD PRIMARY KEY("id");
CREATE TABLE "compra_productos"(
    "id" BIGINT NOT NULL,
    "id_productos" BIGINT NOT NULL,
    "id_proveedor" BIGINT NOT NULL,
    "Stock" BIGINT NOT NULL
);
ALTER TABLE
    "compra_productos" ADD PRIMARY KEY("id");
ALTER TABLE
    "ventas" ADD CONSTRAINT "ventas_id_productos_vendidos_foreign" FOREIGN KEY("id_Productos_vendidos") REFERENCES "productos_vendidos"("id");
ALTER TABLE
    "compra_productos" ADD CONSTRAINT "compra_productos_id_productos_foreign" FOREIGN KEY("id_productos") REFERENCES "Productos"("id");
ALTER TABLE
    "productos_vendidos" ADD CONSTRAINT "productos_vendidos_id_productos_foreign" FOREIGN KEY("id_productos") REFERENCES "Productos"("id");
ALTER TABLE
    "Productos" ADD CONSTRAINT "productos_id_proveedor_foreign" FOREIGN KEY("id_proveedor") REFERENCES "Proveedores"("id");
ALTER TABLE
    "ventas" ADD CONSTRAINT "ventas_id_cliente_foreign" FOREIGN KEY("id_cliente") REFERENCES "clientes"("id");
ALTER TABLE
    "compra_productos" ADD CONSTRAINT "compra_productos_id_proveedor_foreign" FOREIGN KEY("id_proveedor") REFERENCES "Proveedores"("id");