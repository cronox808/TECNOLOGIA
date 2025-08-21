---
## **2.1 Tipos de datos principales en PostgreSQL**

* **Numéricos:**

  * `SMALLINT` (–32768 a 32767)
  * `INTEGER` (–2,147,483,648 a 2,147,483,647)
  * `BIGINT` (–9 cuatrillones a +9 cuatrillones)
  * `DECIMAL` / `NUMERIC` (precisión exacta)
  * `REAL` / `DOUBLE PRECISION` (flotantes)

* **Texto:**

  * `CHAR(n)` (longitud fija)
  * `VARCHAR(n)` (longitud variable)
  * `TEXT` (sin límite)

* **Booleanos:**

  * `BOOLEAN` (`TRUE` / `FALSE`)

* **Fecha y hora:**

  * `DATE` (fecha)
  * `TIME` (hora)
  * `TIMESTAMP` (fecha y hora)
  * `TIMESTAMPTZ` (fecha y hora con zona horaria)

* **Otros útiles:**

  * `SERIAL` / `BIGSERIAL` (autoincremento)
  * `UUID` (identificador único)
  * `JSON` / `JSONB` (datos en formato JSON)

---

## **2.2 Crear tablas en PostgreSQL**

**Sintaxis:**

```sql
CREATE TABLE nombre_tabla (
    columna1 tipo_dato restricción,
    columna2 tipo_dato restricción,
    ...
);
```

Ejemplo:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);
```

---

## **2.3 Modificar tablas**

```sql
-- Agregar columna
ALTER TABLE clientes ADD telefono VARCHAR(15);

-- Modificar tipo de columna
ALTER TABLE clientes ALTER COLUMN telefono TYPE TEXT;

-- Renombrar columna
ALTER TABLE clientes RENAME COLUMN telefono TO celular;

-- Eliminar columna
ALTER TABLE clientes DROP COLUMN celular;
```

---

## **2.4 Eliminar tablas**

```sql
DROP TABLE clientes;
```

---

## **Ejercicio 2 – Tu primera tabla en PostgreSQL**

**Objetivo:** Crear y modificar tablas en tu base `practica_pg`.

**Reglas:**

1. Crear una tabla llamada `productos` con:
   
   * `id` entero autoincremental (PRIMARY KEY)
   * `nombre` texto obligatorio
   * `precio` decimal obligatorio
   * `fecha_ingreso` fecha con valor por defecto la fecha actual

2. Agregar una columna `stock` entero.

3. Renombrar la columna `stock` a `cantidad_disponible`.

4. Cambiar el tipo de `cantidad_disponible` a `BIGINT`.

5. Eliminar la columna `cantidad_disponible`.

---

### 2. **FOREIGN KEY**

Crea una relación entre dos tablas, asegurando que el valor exista en la tabla referenciada.

```sql
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

---

### 3. **UNIQUE**

Evita que se repitan valores en una columna (puede tener `NULL`).

```sql
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    correo VARCHAR(100) UNIQUE
);
```

---

### 4. **NOT NULL**

Obliga a que el valor no sea `NULL`.

```sql
CREATE TABLE productos2 (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
```

---

### 5. **CHECK**

Verifica que el valor cumpla una condición.

```sql
CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    saldo NUMERIC CHECK (saldo >= 0)
);
```

---

## **2.6 Claves compuestas**

Una **clave primaria compuesta** está formada por **dos o más columnas**.

```sql
CREATE TABLE detalle_pedido (
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    PRIMARY KEY (pedido_id, producto_id)
);
```

Esto asegura que no haya dos filas con el mismo par `(pedido_id, producto_id)`.

---

## **2.7 Autoincremento**

En PostgreSQL existen dos formas principales:

1. **`SERIAL`**
   
   * Crea automáticamente una secuencia interna.
   
   * Ejemplo:
     
     ```sql
     CREATE TABLE categorias (
         id SERIAL PRIMARY KEY,
         nombre VARCHAR(50)
     );
     ```

2. **`GENERATED AS IDENTITY`** (recomendado en versiones nuevas)
   
   * Más estándar y con mejor control.
     
     ```sql
     CREATE TABLE marcas (
         id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
         nombre VARCHAR(50)
     );
     ```

---

# 📌 Módulo 4: DML – Manipulación de Datos

En este módulo aprenderás a **insertar, actualizar y eliminar** datos en PostgreSQL.

---

## 🔹 4.1 `INSERT INTO`

Sirve para **agregar filas** a una tabla.

Ejemplo con tu tabla `clientes`:

```sql
INSERT INTO clientes (nombre, correo, telefono)
VALUES ('Juan Pérez', 'juanperez@email.com', '3001112233');
```

👉 Puedes omitir columnas si tienen **DEFAULT** o aceptan `NULL`:

```sql
INSERT INTO pedidos (cliente_id, comercial_id, fecha_pedido, total)
VALUES (1, 2, DEFAULT, 150.00);
```

📌 Insertar múltiples filas de una sola vez:

```sql
INSERT INTO productos (nombre, precio, stock)
VALUES 
  ('Teclado mecánico', 120000, 10),
  ('Mouse gamer', 80000, 15),
  ('Monitor 24"', 650000, 5);
```

---

## 🔹 4.2 `UPDATE`

Sirve para **modificar datos existentes**.

Ejemplo: cambiar el stock de un producto.

```sql
UPDATE productos
SET stock = stock - 2
WHERE id = 1;
```

👉 También puedes actualizar varias columnas:

```sql
UPDATE clientes
SET telefono = '3002223344',
    correo = 'nuevoemail@email.com'
WHERE id = 1;
```

---

## 🔹 4.3 `DELETE`

Sirve para **eliminar filas**.

```sql
DELETE FROM productos
WHERE id = 3;
```

👉 Si quieres eliminar **toda la tabla**, usa:

```sql
DELETE FROM productos;
```

⚠️ Esto borra TODO, pero la tabla sigue existiendo.
Si quisieras borrar también la estructura → `DROP TABLE`.

---

## 🔹 4.4 `RETURNING`

PostgreSQL permite devolver filas modificadas después de un `INSERT`, `UPDATE` o `DELETE`.

Ejemplo:

```sql
INSERT INTO clientes (nombre, correo, telefono)
VALUES ('Ana López', 'ana@email.com', '3015556677')
RETURNING id, nombre;
```

---

## Tipo de consultas

```sql
-- Crear tabla de ejemplo
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    ciudad VARCHAR(50)
);

-- Insertar datos
INSERT INTO cliente (nombre, edad, ciudad) VALUES
('Ana', 25, 'Bogotá'),
('Luis', 30, 'Medellín'),
('Carlos', 19, 'Bogotá'),
('María', 40, 'Cali'),
('Lucía', 30, 'Medellín');

-- Consultas PostgreSQL
-- 1. Selección simple
SELECT nombre, ciudad FROM cliente;

-- 2. Filtrado con WHERE
SELECT * FROM cliente WHERE ciudad = 'Bogotá';

-- 3. Búsqueda sin importar mayúsculas (ILIKE, exclusivo de PostgreSQL)
SELECT * FROM cliente WHERE ciudad ILIKE 'bogotá';

-- 4. Eliminar duplicados
SELECT DISTINCT ciudad FROM cliente;

-- 5. Orden descendente
SELECT * FROM cliente ORDER BY edad DESC;
```

# 📚 Módulo 5 – Funciones y Expresiones en PostgreSQL

---

## 1. Funciones de texto

Sirven para manipular cadenas de caracteres.

Ejemplos principales:

```sql
-- Convertir a mayúsculas y minúsculas
SELECT UPPER('postgresql'), LOWER('POSTGRESQL');

-- Concatenar cadenas
SELECT CONCAT('Hola', ' ', 'Mundo');

-- Extraer parte de un texto (posición inicial, longitud)
SELECT SUBSTRING('PostgreSQL' FROM 1 FOR 4); -- "Post"

-- Longitud del texto
SELECT LENGTH('Base de Datos');

-- Quitar espacios
SELECT TRIM('   hola   ');
```

---

## 2. Funciones numéricas

Muy útiles para cálculos:

```sql
-- Redondear
SELECT ROUND(123.456, 2);   -- 123.46

-- Techo (hacia arriba)
SELECT CEIL(7.2);           -- 8

-- Piso (hacia abajo)
SELECT FLOOR(7.8);          -- 7

-- Potencias y raíces
SELECT POWER(2, 3), SQRT(16);
```

---

## 3. Funciones de fecha y hora

PostgreSQL es muy fuerte en manejo de fechas.

```sql
-- Fecha y hora actual
SELECT NOW();

-- Solo fecha
SELECT CURRENT_DATE;

-- Diferencia entre fechas
SELECT AGE('2025-12-31', '2024-12-31');

-- Extraer partes de la fecha
SELECT EXTRACT(YEAR FROM NOW()), EXTRACT(MONTH FROM NOW()), EXTRACT(DAY FROM NOW());
```

---

## 4. Funciones de agregación

Se usan con **conjuntos de registros**.

```sql
-- Contar registros
SELECT COUNT(*) FROM cliente;

-- Valor mínimo, máximo y promedio
SELECT MIN(edad), MAX(edad), AVG(edad) FROM cliente;

-- Suma total
SELECT SUM(edad) FROM cliente;
```

---

## 5. Agrupamiento de resultados (`GROUP BY` y `HAVING`)

Permite **agrupar registros** por una columna y aplicar funciones de agregación.

```sql
-- Número de clientes por ciudad
SELECT ciudad, COUNT(*) 
FROM cliente
GROUP BY ciudad;

-- Promedio de edad por ciudad
SELECT ciudad, AVG(edad)
FROM cliente
GROUP BY ciudad;

-- Filtrar agrupaciones (HAVING)
SELECT ciudad, COUNT(*) 
FROM cliente
GROUP BY ciudad
HAVING COUNT(*) > 1;
```

---

# 📚 Módulo 6 – Consultas Avanzadas en PostgreSQL

En este módulo vamos a ver cómo **hacer consultas más potentes y reutilizables**.

---

## 1. Subconsultas en `WHERE`

Permiten usar el resultado de una consulta dentro de otra.

```sql
-- Clientes con la edad mayor que el promedio de todos
SELECT nombre, edad
FROM cliente
WHERE edad > (SELECT AVG(edad) FROM cliente);
```

---

## 2. Subconsultas en `FROM` (tablas derivadas)

Se usa una consulta como si fuera una tabla temporal.

```sql
-- Promedio de edad por ciudad y filtramos resultados
SELECT sub.ciudad, sub.promedio
FROM (
    SELECT ciudad, AVG(edad) AS promedio
    FROM cliente
    GROUP BY ciudad
) sub
WHERE sub.promedio > 25;
```

---

## 3. Expresiones de tabla comunes (CTE – `WITH`)

Son **consultas temporales con nombre**, más legibles que las subconsultas anidadas.

```sql
-- Clientes mayores al promedio usando CTE
WITH promedio_edades AS (
    SELECT AVG(edad) AS promedio FROM cliente
)
SELECT nombre, edad
FROM cliente, promedio_edades
WHERE cliente.edad > promedio_edades.promedio;
```

---

## 4. Operaciones de conjuntos (`UNION`, `INTERSECT`, `EXCEPT`)

Se usan para combinar resultados de varias consultas.

```sql
-- UNION (une resultados sin duplicados)
SELECT ciudad FROM cliente WHERE edad < 25
UNION
SELECT ciudad FROM cliente WHERE edad > 35;

-- INTERSECT (intersección)
SELECT ciudad FROM cliente WHERE edad < 25
INTERSECT
SELECT ciudad FROM cliente WHERE edad > 35;

-- EXCEPT (diferencia)
SELECT ciudad FROM cliente
EXCEPT
SELECT ciudad FROM cliente WHERE edad = 30;
```

---

## 5. Filtros avanzados con `FILTER` en agregaciones

Permite aplicar una condición dentro de una agregación.

```sql
-- Contar clientes por ciudad, diferenciando mayores de 30
SELECT ciudad,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE edad > 30) AS mayores_30
FROM cliente
GROUP BY ciudad;
```

---



# 📚 Módulo 7 – Joins y Relaciones en PostgreSQL

Este módulo es clave porque **relaciona varias tablas** y nos permite trabajar con bases de datos normalizadas.

---

## 1. Tipos de `JOIN`

### 🔹 `INNER JOIN`

Devuelve solo los registros que tienen coincidencia en ambas tablas.

```sql
SELECT c.nombre, p.monto
FROM cliente c
INNER JOIN pedido p ON c.id = p.cliente_id;
```

---

### 🔹 `LEFT JOIN`

Devuelve todos los registros de la tabla izquierda, aunque no haya coincidencia en la derecha.

```sql
SELECT c.nombre, p.monto
FROM cliente c
LEFT JOIN pedido p ON c.id = p.cliente_id;
```

---

### 🔹 `RIGHT JOIN`

Lo contrario del anterior: devuelve todos los registros de la tabla derecha.

```sql
SELECT c.nombre, p.monto
FROM cliente c
RIGHT JOIN pedido p ON c.id = p.cliente_id;
```

---

### 🔹 `FULL JOIN`

Devuelve todos los registros de ambas tablas (coincidan o no).

```sql
SELECT c.nombre, p.monto
FROM cliente c
FULL JOIN pedido p ON c.id = p.cliente_id;
```

---

### 🔹 `CROSS JOIN`

Hace un **producto cartesiano** (todas las combinaciones posibles).

```sql
SELECT c.nombre, p.monto
FROM cliente c
CROSS JOIN pedido p;
```

---

### 🔹 `NATURAL JOIN`

Une automáticamente por las columnas con el mismo nombre en ambas tablas. *(poco usado en la práctica porque puede dar resultados inesperados)*.

```sql
SELECT *
FROM cliente
NATURAL JOIN pedido;
```

---

## 2. Auto-join (self join)

Cuando una tabla se une consigo misma.

```sql
-- Clientes que viven en la misma ciudad
SELECT a.nombre AS cliente1, b.nombre AS cliente2, a.ciudad
FROM cliente a
JOIN cliente b ON a.ciudad = b.ciudad
WHERE a.id <> b.id;
```

---

## 3. Relaciones entre tablas

- **Uno a uno** → Un cliente con un solo perfil.

- **Uno a muchos** → Un cliente con muchos pedidos.

- **Muchos a muchos** → Estudiantes y cursos (requiere tabla intermedia).

Ejemplo relación **uno a muchos** con `FOREIGN KEY`:

```sql
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES cliente(id) ON DELETE CASCADE,
    monto DECIMAL
);
```

---

## 4. `ON DELETE CASCADE` y `ON UPDATE CASCADE`

- `ON DELETE CASCADE`: si borras un cliente, se borran también sus pedidos.

- `ON UPDATE CASCADE`: si cambias el `id` de un cliente, también cambia en sus pedidos.

Ejemplo:

```sql
CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    monto DECIMAL,
    FOREIGN KEY (cliente_id) 
      REFERENCES cliente(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
```

---

Perfecto Jose David 🙌 entendido, en este chat vamos solo con **la teoría clara y resumida de cada módulo** sin ejercicios prácticos.

Sigamos entonces con el siguiente:

---

# 📚 Módulo 8 – Vistas y Materialized Views en PostgreSQL

## 1. Vistas (`VIEW`)

Una **vista** es una consulta guardada que se comporta como una tabla virtual.

- Facilita la reutilización de consultas.

- Puede simplificar reportes o consultas complejas.

👉 Ejemplo:

```sql
CREATE VIEW clientes_bogota AS
SELECT nombre, edad
FROM cliente
WHERE ciudad = 'Bogotá';
```

Luego puedes usarla como si fuera una tabla:

```sql
SELECT * FROM clientes_bogota;
```

---

## 2. Vistas actualizables

En algunos casos, puedes hacer `INSERT`, `UPDATE` o `DELETE` sobre una vista, y los cambios afectan a la tabla original (cuando la vista es simple y directa).

---

## 3. Vistas materializadas (`MATERIALIZED VIEW`)

Son como vistas, pero **almacenan físicamente los datos** en disco.

- Mejor rendimiento en consultas pesadas.

- Necesitan ser actualizadas manualmente.

👉 Ejemplo:

```sql
CREATE MATERIALIZED VIEW resumen_ciudades AS
SELECT ciudad, COUNT(*) AS total_clientes
FROM cliente
GROUP BY ciudad;
```

---

## 4. Actualización de vistas materializadas

Se actualizan con:

```sql
REFRESH MATERIALIZED VIEW resumen_ciudades;
```

---

📌 Diferencia clave:

- **VIEW** → siempre muestra los datos actualizados, pero puede ser más lenta.

- **MATERIALIZED VIEW** → es más rápida, pero requiere actualización manual.

---

Perfecto Jose David 🚀 seguimos avanzando entonces:

---

# 📚 Módulo 9 – Índices y Rendimiento en PostgreSQL

Los **índices** son estructuras que aceleran la búsqueda de datos en una tabla. Funcionan como un índice de libro: permiten encontrar un dato sin recorrer todo el contenido.

---

## 1. Creación y uso de índices (`CREATE INDEX`)

Por defecto, PostgreSQL ya crea índices para claves primarias (`PRIMARY KEY`) y únicas (`UNIQUE`).  
También puedes crear índices manualmente:

```sql
CREATE INDEX idx_cliente_ciudad ON cliente(ciudad);
```

Ahora, las consultas que filtren por `ciudad` serán más rápidas:

```sql
SELECT * FROM cliente WHERE ciudad = 'Bogotá';
```

---

## 2. Índices únicos y compuestos

- **Índice único**: garantiza que no se repitan valores.

```sql
CREATE UNIQUE INDEX idx_cliente_email ON cliente(email);
```

- **Índice compuesto**: se crea sobre varias columnas.

```sql
CREATE INDEX idx_cliente_ciudad_edad ON cliente(ciudad, edad);
```

---

## 3. Índices para búsquedas de texto (GIN y GiST)

PostgreSQL soporta índices especializados:

- **GIN (Generalized Inverted Index)** → ideal para `JSONB` y búsquedas de texto completo.

```sql
CREATE INDEX idx_cliente_ciudad_gin ON cliente USING GIN (to_tsvector('spanish', ciudad));
```

- **GiST (Generalized Search Tree)** → útil en búsquedas espaciales o rangos.

---

## 4. Optimización de consultas con `EXPLAIN` y `ANALYZE`

Permiten analizar cómo PostgreSQL ejecuta una consulta.

```sql
EXPLAIN SELECT * FROM cliente WHERE ciudad = 'Bogotá';
```

Muestra el plan de ejecución (si usa índice o hace un **secuential scan**).  
Con `ANALYZE` se ejecuta realmente y se miden tiempos:

```sql
EXPLAIN ANALYZE SELECT * FROM cliente WHERE ciudad = 'Bogotá';
```

---

📌 **Resumen rápido:**

- Los índices aceleran búsquedas, pero ocupan espacio y ralentizan inserciones/actualizaciones.

- Usa índices en columnas que se consulten mucho en `WHERE`, `JOIN` o `ORDER BY`.

- Usa `EXPLAIN` para verificar si tu índice está siendo utilizado.

---

Perfecto Jose David 🚀 seguimos avanzando con:

---

# 📚 Módulo 10 – Funciones, Procedimientos y Triggers en PostgreSQL

Este módulo trata de la **automatización y reutilización de lógica** dentro de la base de datos.

---

## 1. Funciones en SQL (`CREATE FUNCTION`)

Son bloques de código que reciben parámetros, ejecutan lógica y devuelven un valor.

Ejemplo simple en SQL:

```sql
CREATE FUNCTION suma(a INT, b INT) RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;
```

Uso:

```sql
SELECT suma(5, 7);
```

---

## 2. Funciones en PL/pgSQL

PL/pgSQL es el **lenguaje procedural** de PostgreSQL, más potente que SQL puro.  
Permite usar variables, condicionales y bucles.

Ejemplo:

```sql
CREATE FUNCTION edad_cliente(id_cliente INT) RETURNS INT AS $$
DECLARE
    resultado INT;
BEGIN
    SELECT edad INTO resultado
    FROM cliente
    WHERE id = id_cliente;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;
```

---

## 3. Procedimientos almacenados (`CREATE PROCEDURE`)

A diferencia de las funciones:

- **No devuelven un valor directamente.**

- Se ejecutan con `CALL`.

- Útiles para procesos grandes (inserciones masivas, reportes, mantenimiento).

Ejemplo:

```sql
CREATE PROCEDURE borrar_cliente(id_cliente INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM cliente WHERE id = id_cliente;
END;
$$;

CALL borrar_cliente(3);
```

---

## 4. Triggers (`CREATE TRIGGER`)

Un **trigger** (disparador) ejecuta una función automáticamente cuando ocurre un evento (`INSERT`, `UPDATE`, `DELETE`).

Ejemplo:

```sql
-- 1. Función de disparo
CREATE FUNCTION log_borrado() RETURNS trigger AS $$
BEGIN
    INSERT INTO auditoria(tabla, accion, fecha)
    VALUES ('cliente', 'DELETE', NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- 2. Trigger asociado a la tabla
CREATE TRIGGER trg_borrar_cliente
AFTER DELETE ON cliente
FOR EACH ROW
EXECUTE FUNCTION log_borrado();
```

---

## 5. Ejemplos prácticos de automatización

- Auditoría de cambios (`INSERT` en tabla de logs).

- Cálculo automático de totales al insertar un pedido.

- Bloqueo de inserciones si no cumplen una condición (`BEFORE INSERT`).

---

📌 **Resumen rápido:**

- **Funciones** → devuelven un valor, se llaman con `SELECT`.

- **Procedimientos** → no devuelven valor, se ejecutan con `CALL`.

- **Triggers** → se ejecutan automáticamente al ocurrir un evento en la tabla.

---

✅ Con esto cerramos el **Módulo 10 – Funciones, Procedimientos y Triggers**.

👉 ¿Quieres que sigamos directo con el **Módulo 11 – Administración y Seguridad**