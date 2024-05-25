DROP TABLE administrador CASCADE CONSTRAINTS;
DROP TABLE bodeguero CASCADE CONSTRAINTS;
DROP TABLE categoria CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE contador CASCADE CONSTRAINTS;
DROP TABLE credencial CASCADE CONSTRAINTS;
DROP TABLE detalle_venta CASCADE CONSTRAINTS;
DROP TABLE entrega CASCADE CONSTRAINTS;
DROP TABLE metodo_pago CASCADE CONSTRAINTS;
DROP TABLE pago CASCADE CONSTRAINTS;
DROP TABLE perfil CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;
DROP TABLE sucursal CASCADE CONSTRAINTS;
DROP TABLE vendedor CASCADE CONSTRAINTS;
DROP TABLE venta CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE marca CASCADE CONSTRAINTS;
/
CREATE TABLE administrador (
    rut_admin      VARCHAR2(12) NOT NULL,
    primer_nombre  VARCHAR2(45) NOT NULL,
    segundo_nombre VARCHAR2(45),
    ape_paterno    VARCHAR2(45) NOT NULL,
    ape_materno    VARCHAR2(45) NOT NULL,
    direccion      VARCHAR2(60) NOT NULL,
    telefono       INTEGER NOT NULL,
    correo         VARCHAR2(60) NOT NULL,
    id_credencial  INTEGER NOT NULL,
    id_sucursal    INTEGER NOT NULL
);

ALTER TABLE administrador ADD CONSTRAINT administrador_pk PRIMARY KEY ( rut_admin );

CREATE TABLE bodeguero (
    rut_bodeguero  VARCHAR2(12) NOT NULL,
    primer_nombre  VARCHAR2(45) NOT NULL,
    segundo_nombre VARCHAR2(45),
    ape_paterno    VARCHAR2(45) NOT NULL,
    ape_materno    VARCHAR2(45) NOT NULL,
    direccion      VARCHAR2(60) NOT NULL,
    telefono       INTEGER NOT NULL,
    correo         VARCHAR2(45) NOT NULL,
    id_sucursal    INTEGER NOT NULL,
    id_credencial  INTEGER NOT NULL
);

ALTER TABLE bodeguero ADD CONSTRAINT bodeguero_pk PRIMARY KEY ( rut_bodeguero );

CREATE TABLE categoria (
    id_categoria  INTEGER NOT NULL,
    nom_categoria VARCHAR2(45) NOT NULL,
    descripcion   VARCHAR2(45) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    rut_cliente      VARCHAR2(12) NOT NULL,
    nombre           VARCHAR2(30) NOT NULL,
    apellido_paterno VARCHAR2(45) NOT NULL,
    apellido_materno VARCHAR2(45) NOT NULL,
    direccion        VARCHAR2(60) NOT NULL,
    telefono         INTEGER NOT NULL,
    correo           VARCHAR2(45) NOT NULL,
    id_credencial    INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

CREATE TABLE comuna (
    id_comuna  INTEGER NOT NULL,
    nom_comuna VARCHAR2(45) NOT NULL,
    id_region  INTEGER NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE contador (
    rut_contador   VARCHAR2(12) NOT NULL,
    primer_nombre  VARCHAR2(45) NOT NULL,
    segundo_nombre VARCHAR2(45),
    ape_paterno    VARCHAR2(45) NOT NULL,
    ape_materno    VARCHAR2(45) NOT NULL,
    direccion      VARCHAR2(60) NOT NULL,
    telefono       INTEGER NOT NULL,
    correo         VARCHAR2(45) NOT NULL,
    id_sucursal    INTEGER NOT NULL,
    id_credencial  INTEGER NOT NULL
);

ALTER TABLE contador ADD CONSTRAINT contador_pk PRIMARY KEY ( rut_contador );

CREATE TABLE credencial (
    id_credencial INTEGER NOT NULL,
    correo        VARCHAR2(60) NOT NULL,
    contrasena    VARCHAR2(45) NOT NULL,
    id_perfil     INTEGER NOT NULL
);

ALTER TABLE credencial ADD CONSTRAINT credencial_pk PRIMARY KEY ( id_credencial );

CREATE TABLE detalle_venta (
    id_det_venta  INTEGER NOT NULL,
    cantidad_prod INTEGER NOT NULL,
    precio        INTEGER NOT NULL,
    descuento     NUMBER(11, 2),
    id_venta      INTEGER NOT NULL,
    id_producto  VARCHAR2(45) NOT NULL
);

ALTER TABLE detalle_venta ADD CONSTRAINT detalle_venta_pk PRIMARY KEY ( id_det_venta );

CREATE TABLE entrega (
    id_entrega   VARCHAR2(45) NOT NULL,
    direccion    VARCHAR2(60) NOT NULL,
    estado       VARCHAR2(45) NOT NULL,
    rut_contador VARCHAR2(12) NOT NULL
);

ALTER TABLE entrega ADD CONSTRAINT entrega_pk PRIMARY KEY ( id_entrega );

CREATE TABLE marca (
    id_marca     INTEGER NOT NULL,
    nombre_marca VARCHAR2(45) NOT NULL
);

ALTER TABLE marca ADD CONSTRAINT marca_pk PRIMARY KEY ( id_marca );

CREATE TABLE metodo_pago (
    id_met_pago  INTEGER NOT NULL,
    nom_met_pago VARCHAR2(45) NOT NULL
);

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( id_met_pago );

CREATE TABLE pago (
    id_pago      INTEGER NOT NULL,
    fecha_pago   DATE NOT NULL,
    estado       VARCHAR2(45) NOT NULL,
    id_met_pago  INTEGER NOT NULL,
    rut_contador VARCHAR2(12) NOT NULL,
    id_venta     INTEGER NOT NULL
);

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE perfil (
    id_perfil     INTEGER NOT NULL,
    nombre_perfil VARCHAR2(45) NOT NULL,
    descripcion   VARCHAR2(60) NOT NULL
);

ALTER TABLE perfil ADD CONSTRAINT perfil_pk PRIMARY KEY ( id_perfil );

CREATE TABLE producto (
    id_producto VARCHAR2(45) NOT NULL,
    nombre       VARCHAR2(45) NOT NULL,
    descripcion  VARCHAR2(80) NOT NULL,
    precio       INTEGER NOT NULL,
    stock        INTEGER NOT NULL,
    descuento    INTEGER,
    imagen       BLOB NOT NULL,
    id_marca     INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE region (
    id_region  INTEGER NOT NULL,
    nom_region VARCHAR2(45) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE sucursal (
    id_sucursal  INTEGER NOT NULL,
    nom_sucursal VARCHAR2(45) NOT NULL,
    direccion    VARCHAR2(60) NOT NULL,
    telefono     INTEGER NOT NULL,
    id_comuna    INTEGER NOT NULL
);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( id_sucursal );

CREATE TABLE vendedor (
    rut_vendedor   VARCHAR2(12) NOT NULL,
    primer_nombre  VARCHAR2(45) NOT NULL,
    segundo_nombre VARCHAR2(45),
    ape_paterno    VARCHAR2(45) NOT NULL,
    ape_materno    VARCHAR2(45) NOT NULL,
    direccion      VARCHAR2(60) NOT NULL,
    telefono       INTEGER NOT NULL,
    correo         VARCHAR2(45) NOT NULL,
    id_sucursal    INTEGER NOT NULL,
    id_credencial  INTEGER NOT NULL
);

ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( rut_vendedor );

CREATE TABLE venta (
    id_venta       INTEGER NOT NULL,
    fecha_venta    DATE NOT NULL,
    doc_tributario VARCHAR2(45) NOT NULL,
    descuento      INTEGER,
    tipo_entrega   VARCHAR2(45) NOT NULL,
    impuesto       INTEGER NOT NULL,
    total          INTEGER NOT NULL,
    rut_cliente    VARCHAR2(12) NOT NULL,
    id_sucursal    INTEGER NOT NULL,
    id_entrega     VARCHAR2(45) NOT NULL
);

ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( id_venta );

ALTER TABLE administrador
    ADD CONSTRAINT administrador_credencial_fk FOREIGN KEY ( id_credencial )
        REFERENCES credencial ( id_credencial );

ALTER TABLE administrador
    ADD CONSTRAINT administrador_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE bodeguero
    ADD CONSTRAINT bodeguero_credencial_fk FOREIGN KEY ( id_credencial )
        REFERENCES credencial ( id_credencial );

ALTER TABLE bodeguero
    ADD CONSTRAINT bodeguero_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_credencial_fk FOREIGN KEY ( id_credencial )
        REFERENCES credencial ( id_credencial );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( id_region )
        REFERENCES region ( id_region );

ALTER TABLE contador
    ADD CONSTRAINT contador_credencial_fk FOREIGN KEY ( id_credencial )
        REFERENCES credencial ( id_credencial );

ALTER TABLE contador
    ADD CONSTRAINT contador_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE credencial
    ADD CONSTRAINT credencial_perfil_fk FOREIGN KEY ( id_perfil )
        REFERENCES perfil ( id_perfil );

ALTER TABLE detalle_venta
    ADD CONSTRAINT detalle_venta_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE detalle_venta
    ADD CONSTRAINT detalle_venta_venta_fk FOREIGN KEY ( id_venta )
        REFERENCES venta ( id_venta );

ALTER TABLE entrega
    ADD CONSTRAINT entrega_contador_fk FOREIGN KEY ( rut_contador )
        REFERENCES contador ( rut_contador );

ALTER TABLE pago
    ADD CONSTRAINT pago_contador_fk FOREIGN KEY ( rut_contador )
        REFERENCES contador ( rut_contador );

ALTER TABLE pago
    ADD CONSTRAINT pago_metodo_pago_fk FOREIGN KEY ( id_met_pago )
        REFERENCES metodo_pago ( id_met_pago );

ALTER TABLE pago
    ADD CONSTRAINT pago_venta_fk FOREIGN KEY ( id_venta )
        REFERENCES venta ( id_venta );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE producto
    ADD CONSTRAINT producto_marca_fk FOREIGN KEY ( id_marca )
        REFERENCES marca ( id_marca );

ALTER TABLE sucursal
    ADD CONSTRAINT sucursal_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_credencial_fk FOREIGN KEY ( id_credencial )
        REFERENCES credencial ( id_credencial );

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE venta
    ADD CONSTRAINT venta_cliente_fk FOREIGN KEY ( rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE venta
    ADD CONSTRAINT venta_entrega_fk FOREIGN KEY ( id_entrega )
        REFERENCES entrega ( id_entrega );

ALTER TABLE venta
    ADD CONSTRAINT venta_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );
        
/
create or replace NONEDITIONABLE PROCEDURE sp_delete_producto(p_id_producto VARCHAR2, p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM producto
    WHERE id_producto = p_id_producto;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_producto;
/
create or replace NONEDITIONABLE PROCEDURE sp_get_producto(p_id_producto VARCHAR2,p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT p.id_producto,
                           p.nombre,
                           p.id_marca,
                           (SELECT nombre_marca FROM marca m WHERE p.id_marca = m.id_marca) AS marca,
                           p.id_categoria,
                           (SELECT nom_categoria FROM categoria c WHERE p.id_categoria = c.id_categoria) AS categoria,
                           p.precio,
                           p.stock,
                           p.descripcion,
                           p.imagen,
                           p.descuento
                      FROM producto p
                      WHERE p.id_producto = p_id_producto;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_producto;
/
create or replace NONEDITIONABLE PROCEDURE sp_get_productos(p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT p.id_producto,
                           p.nombre,
                           p.id_marca,
                           (SELECT nombre_marca FROM marca m WHERE p.id_marca = m.id_marca) AS marca,
                           p.id_categoria,
                           (SELECT nom_categoria FROM categoria c WHERE p.id_categoria = c.id_categoria) AS categoria,
                           p.precio,
                           p.stock,
                           p.descripcion,
                           p.imagen,
                           p.descuento
                      FROM producto p;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_productos;
/
create or replace NONEDITIONABLE PROCEDURE sp_patch_producto(p_id_producto VARCHAR2, p_id_marca NUMBER, p_nombre VARCHAR2, 
                                          p_precio NUMBER, p_stock NUMBER, p_descuento NUMBER, p_id_categoria NUMBER, p_descripcion VARCHAR2, p_imagen BLOB,
                                          p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria) 
    VALUES(p_id_producto, p_nombre, p_descripcion, p_precio, p_stock, p_descuento, p_imagen, p_id_marca, p_id_categoria);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE producto
        SET nombre = p_nombre,
            id_marca = p_id_marca,
            precio = p_precio,
            stock = p_stock,
            descuento = p_descuento,
            id_categoria = p_id_categoria,
            descripcion = p_descripcion,
            imagen = p_imagen
        WHERE id_producto = p_id_producto;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_producto;
/
create or replace NONEDITIONABLE PROCEDURE sp_post_producto(p_id_producto VARCHAR2, p_nombre VARCHAR2, p_descripcion VARCHAR2, 
                                          p_precio NUMBER, p_stock NUMBER, p_descuento NUMBER, p_imagen BLOB, p_id_marca NUMBER, p_id_categoria NUMBER,
                                          p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria) 
    VALUES(p_id_producto, p_nombre, p_descripcion, p_precio, p_stock, p_descuento, p_imagen, p_id_marca, p_id_categoria);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_producto;
/
create or replace NONEDITIONABLE PROCEDURE sp_put_producto(p_id_producto VARCHAR2, p_nombre VARCHAR2, p_id_marca NUMBER,
                                         p_precio NUMBER, p_stock NUMBER,
                                         p_out OUT NUMBER)
IS
BEGIN
    UPDATE producto
    SET nombre = p_nombre,
        id_marca = p_id_marca,
        precio = p_precio,
        stock = p_stock
    WHERE id_producto = p_id_producto;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_producto;