DROP TABLE IF EXISTS "proveedores";
DROP TABLE IF EXISTS "clientes";
DROP TABLE IF EXISTS "ventas";
DROP TABLE IF EXISTS "productos_vendidos";
DROP TABLE IF EXISTS "compra_productos";
DROP TABLE IF EXISTS "productos";
DROP TABLE IF EXISTS "clientes";

CREATE TABLE "productos"(
    "id" SERIAL PRIMARY KEY,
    "id_poveerdor" INT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "categoria" VARCHAR(255) NULL,
    "precio" DECIMAL(8, 2) NOT NULL,
    "Stock_disponible" BIGINT NOT NULL,
    FOREIGN KEY("id_poveerdor") REFERENCES "proveedores"("id")
);
CREATE TABLE "clientes"(
    "id" SERIAL PRIMARY KEY,
    "nombres" VARCHAR(255) NOT NULL,
    "correro" VARCHAR(255) NOT NULL,
    "telefono" BIGINT NOT NULL
);
CREATE TABLE "ventas"(
    "id" SERIAL PRIMARY KEY,
    "id_cliente" BIGINT NOT NULL,
    "id_Productos_vendidos" BIGINT NOT NULL,
    FOREIGN KEY("id_cliente") REFERENCES "clientes"("id"),
    FOREIGN KEY("id_Productos_vendidos") REFERENCES "productos_vendidos"("id")
);
CREATE TABLE "proveedores"(
    "id" SERIAL PRIMARY KEY,
    "nombre" VARCHAR NOT NULL,
    "coreeo_electronico" VARCHAR(255) NOT NULL,
    "telefono" BIGINT NOT NULL
);
CREATE TABLE "productos_vendidos"(
    "id" SERIAL PRIMARY KEY,
    "id_productos" BIGINT NOT NULL,
    "stock_vendido" BIGINT NOT NULL,
    FOREIGN KEY("id_productos") REFERENCES "productos"("id")
);
CREATE TABLE "compra_productos"(
    "id" SERIAL PRIMARY KEY,
    "id_productos" BIGINT NOT NULL,
    "id_poveerdor" BIGINT NOT NULL,
    "Stock" BIGINT NOT NULL,
    FOREIGN KEY("id_poveerdor") REFERENCES "proveedores"("id"),
    FOREIGN KEY("id_productos") REFERENCES "productos"("id")
);
ALTER TABLE
    "ventas" ADD CONSTRAINT "ventas_id_productos_vendidos_foreign" FOREIGN KEY("id_Productos_vendidos") REFERENCES "productos_vendidos"("id");
ALTER TABLE
    "compra_productos" ADD CONSTRAINT "compra_productos_id_productos_foreign" FOREIGN KEY("id_productos") REFERENCES "productos"("id");
ALTER TABLE
    "productos_vendidos" ADD CONSTRAINT "productos_vendidos_id_productos_foreign" FOREIGN KEY("id_productos") REFERENCES "productos"("id");
ALTER TABLE
    "productos" ADD CONSTRAINT "productos_id_proveedor_foreign" FOREIGN KEY("id_poveerdor") REFERENCES "proveedores"("id");
ALTER TABLE
    "ventas" ADD CONSTRAINT "ventas_id_cliente_foreign" FOREIGN KEY("id_cliente") REFERENCES "clientes"("id");
ALTER TABLE
    "compra_productos" ADD CONSTRAINT "compra_productos_id_proveedor_foreign" FOREIGN KEY("id_poveerdor") REFERENCES "proveedores"("id");