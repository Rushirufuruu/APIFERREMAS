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
--PROCEDIMIENTOS PRODUCTOS
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
/

--PROCEDIMIENTOS ADMINISTRADOR
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_admin(p_rut_admin VARCHAR2, p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM administrador
    WHERE rut_admin = p_rut_admin;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_admin;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_admin(p_rut_admin VARCHAR2, p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_admin,
                           primer_nombre,
                           segundo_nombre,
                           ape_paterno,
                           ape_materno,
                           direccion,
                           telefono,
                           correo,
                           id_credencial,
                           id_sucursal
                      FROM administrador
                      WHERE rut_admin = p_rut_admin;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_admin;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_admins(p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_admin, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal 
                      FROM administrador;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_admins;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_admin(
    p_rut_admin VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO administrador (rut_admin, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal) 
    VALUES(p_rut_admin, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_credencial, p_id_sucursal);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE administrador
        SET primer_nombre = p_primer_nombre,
            segundo_nombre = p_segundo_nombre,
            ape_paterno = p_ape_paterno,
            ape_materno = p_ape_materno,
            direccion = p_direccion,
            telefono = p_telefono,
            correo = p_correo,
            id_credencial = p_id_credencial,
            id_sucursal = p_id_sucursal
        WHERE rut_admin = p_rut_admin;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_admin;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_admin(
    p_rut_admin VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO administrador (rut_admin, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal) 
    VALUES(p_rut_admin, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_credencial, p_id_sucursal);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_admin;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_admin(
    p_rut_admin VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE administrador
    SET primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        ape_paterno = p_ape_paterno,
        ape_materno = p_ape_materno,
        direccion = p_direccion,
        telefono = p_telefono,
        correo = p_correo,
        id_credencial = p_id_credencial,
        id_sucursal = p_id_sucursal
    WHERE rut_admin = p_rut_admin;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_admin;
/

--PROCEDIMIETNOS BODEGUERO
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_bodeguero(p_rut_bodeguero VARCHAR2, p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM bodeguero
    WHERE rut_bodeguero = p_rut_bodeguero;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_bodeguero;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_bodeguero(p_rut_bodeguero VARCHAR2, p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_bodeguero,
                           primer_nombre,
                           segundo_nombre,
                           ape_paterno,
                           ape_materno,
                           direccion,
                           telefono,
                           correo,
                           id_credencial,
                           id_sucursal
                      FROM bodeguero
                      WHERE rut_bodeguero = p_rut_bodeguero;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_bodeguero;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_bodegueros(p_cursor OUT SYS_REFCURSOR, p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_bodeguero, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal 
                      FROM bodeguero;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_bodegueros;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_bodeguero(
    p_rut_bodeguero VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO bodeguero (rut_bodeguero, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal) 
    VALUES(p_rut_bodeguero, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_credencial, p_id_sucursal);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE bodeguero
        SET primer_nombre = p_primer_nombre,
            segundo_nombre = p_segundo_nombre,
            ape_paterno = p_ape_paterno,
            ape_materno = p_ape_materno,
            direccion = p_direccion,
            telefono = p_telefono,
            correo = p_correo,
            id_credencial = p_id_credencial,
            id_sucursal = p_id_sucursal
        WHERE rut_bodeguero = p_rut_bodeguero;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_bodeguero;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_bodeguero(
    p_rut_bodeguero VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO bodeguero (rut_bodeguero, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal) 
    VALUES(p_rut_bodeguero, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_credencial, p_id_sucursal);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_bodeguero;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_bodeguero(
    p_rut_bodeguero VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_id_sucursal NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE bodeguero
    SET primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        ape_paterno = p_ape_paterno,
        ape_materno = p_ape_materno,
        direccion = p_direccion,
        telefono = p_telefono,
        correo = p_correo,
        id_credencial = p_id_credencial,
        id_sucursal = p_id_sucursal
    WHERE rut_bodeguero = p_rut_bodeguero;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_bodeguero;
/

--PROCEDIMIENTOS CLIENTE
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_cliente(
    p_rut_cliente VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM cliente
    WHERE rut_cliente = p_rut_cliente;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_cliente;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_cliente(
    p_rut_cliente VARCHAR2, 
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_cliente,
                           nombre,
                           apellido_paterno,
                           apellido_materno,
                           direccion,
                           telefono,
                           correo,
                           id_credencial
                      FROM cliente
                      WHERE rut_cliente = p_rut_cliente;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_cliente;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_clientes(
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_cliente, nombre, apellido_paterno, apellido_materno, direccion, telefono, correo, id_credencial
                      FROM cliente;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_clientes;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_cliente(
    p_rut_cliente VARCHAR2, 
    p_nombre VARCHAR2, 
    p_apellido_paterno VARCHAR2, 
    p_apellido_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO cliente (rut_cliente, nombre, apellido_paterno, apellido_materno, direccion, telefono, correo, id_credencial) 
    VALUES(p_rut_cliente, p_nombre, p_apellido_paterno, p_apellido_materno, p_direccion, p_telefono, p_correo, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE cliente
        SET nombre = p_nombre,
            apellido_paterno = p_apellido_paterno,
            apellido_materno = p_apellido_materno,
            direccion = p_direccion,
            telefono = p_telefono,
            correo = p_correo,
            id_credencial = p_id_credencial
        WHERE rut_cliente = p_rut_cliente;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_cliente;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_cliente(
    p_rut_cliente VARCHAR2, 
    p_nombre VARCHAR2, 
    p_apellido_paterno VARCHAR2, 
    p_apellido_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO cliente (rut_cliente, nombre, apellido_paterno, apellido_materno, direccion, telefono, correo, id_credencial) 
    VALUES(p_rut_cliente, p_nombre, p_apellido_paterno, p_apellido_materno, p_direccion, p_telefono, p_correo, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_cliente;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_cliente(
    p_rut_cliente VARCHAR2, 
    p_nombre VARCHAR2, 
    p_apellido_paterno VARCHAR2, 
    p_apellido_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE cliente
    SET nombre = p_nombre,
        apellido_paterno = p_apellido_paterno,
        apellido_materno = p_apellido_materno,
        direccion = p_direccion,
        telefono = p_telefono,
        correo = p_correo,
        id_credencial = p_id_credencial
    WHERE rut_cliente = p_rut_cliente;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_cliente;
/

--PROCEDIMIENTOS CONTADOR
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_contador(
    p_rut_contador VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM contador
    WHERE rut_contador = p_rut_contador;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_contador;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_contador(
    p_rut_contador VARCHAR2, 
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_contador,
                           primer_nombre,
                           segundo_nombre,
                           ape_paterno,
                           ape_materno,
                           direccion,
                           telefono,
                           correo,
                           id_credencial,
                           id_sucursal
                      FROM contador
                      WHERE rut_contador = p_rut_contador;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_contador;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_contadores(
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_contador, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal
                      FROM contador;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_contadores;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_contador(
    p_rut_contador VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO contador (rut_contador, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial) 
    VALUES(p_rut_contador, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_sucursal, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE contador
        SET primer_nombre = p_primer_nombre,
            segundo_nombre = p_segundo_nombre,
            ape_paterno = p_ape_paterno,
            ape_materno = p_ape_materno,
            direccion = p_direccion,
            telefono = p_telefono,
            correo = p_correo,
            id_sucursal = p_id_sucursal,
            id_credencial = p_id_credencial
        WHERE rut_contador = p_rut_contador;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_contador;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_contador(
    p_rut_contador VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO contador (rut_contador, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial) 
    VALUES(p_rut_contador, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_sucursal, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_contador;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_contador(
    p_rut_contador VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE contador
    SET primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        ape_paterno = p_ape_paterno,
        ape_materno = p_ape_materno,
        direccion = p_direccion,
        telefono = p_telefono,
        correo = p_correo,
        id_sucursal = p_id_sucursal,
        id_credencial = p_id_credencial
    WHERE rut_contador = p_rut_contador;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_contador;
/

--VENDEDOR
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_vendedor(
    p_rut_vendedor VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM vendedor
    WHERE rut_vendedor = p_rut_vendedor;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_vendedor;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_vendedor(
    p_rut_vendedor VARCHAR2, 
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_vendedor,
                           primer_nombre,
                           segundo_nombre,
                           ape_paterno,
                           ape_materno,
                           direccion,
                           telefono,
                           correo,
                           id_credencial,
                           id_sucursal
                      FROM vendedor
                      WHERE rut_vendedor = p_rut_vendedor;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_vendedor;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_vendedores(
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT rut_vendedor, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal
                      FROM vendedor;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_vendedores;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_vendedor(
    p_rut_vendedor VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO vendedor (rut_vendedor, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial) 
    VALUES(p_rut_vendedor, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_sucursal, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE vendedor
        SET primer_nombre = p_primer_nombre,
            segundo_nombre = p_segundo_nombre,
            ape_paterno = p_ape_paterno,
            ape_materno = p_ape_materno,
            direccion = p_direccion,
            telefono = p_telefono,
            correo = p_correo,
            id_sucursal = p_id_sucursal,
            id_credencial = p_id_credencial
        WHERE rut_vendedor = p_rut_vendedor;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_vendedor;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_vendedor(
    p_rut_vendedor VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO vendedor (rut_vendedor, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial) 
    VALUES(p_rut_vendedor, p_primer_nombre, p_segundo_nombre, p_ape_paterno, p_ape_materno, p_direccion, p_telefono, p_correo, p_id_sucursal, p_id_credencial);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_vendedor;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_vendedor(
    p_rut_vendedor VARCHAR2, 
    p_primer_nombre VARCHAR2, 
    p_segundo_nombre VARCHAR2, 
    p_ape_paterno VARCHAR2, 
    p_ape_materno VARCHAR2, 
    p_direccion VARCHAR2, 
    p_telefono NUMBER, 
    p_correo VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_credencial NUMBER, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE vendedor
    SET primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        ape_paterno = p_ape_paterno,
        ape_materno = p_ape_materno,
        direccion = p_direccion,
        telefono = p_telefono,
        correo = p_correo,
        id_sucursal = p_id_sucursal,
        id_credencial = p_id_credencial
    WHERE rut_vendedor = p_rut_vendedor;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_vendedor;
/

--PROCEDIMIENTOS VENTAS

CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_venta(
    p_id_venta INTEGER, 
    p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM venta
    WHERE id_venta = p_id_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_venta(
    p_id_venta INTEGER, 
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT id_venta,
                           fecha_venta,
                           doc_tributario,
                           descuento,
                           tipo_entrega,
                           impuesto,
                           total,
                           rut_cliente,
                           id_sucursal,
                           id_entrega
                      FROM venta
                      WHERE id_venta = p_id_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_ventas(
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT id_venta, fecha_venta, doc_tributario, descuento, tipo_entrega, impuesto, total, rut_cliente, id_sucursal, id_entrega
                      FROM venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_ventas;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_venta(
    p_id_venta INTEGER, 
    p_fecha_venta DATE, 
    p_doc_tributario VARCHAR2, 
    p_descuento NUMBER, 
    p_tipo_entrega VARCHAR2, 
    p_impuesto NUMBER, 
    p_total NUMBER, 
    p_rut_cliente VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_entrega VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO venta (id_venta, fecha_venta, doc_tributario, descuento, tipo_entrega, impuesto, total, rut_cliente, id_sucursal, id_entrega) 
    VALUES(p_id_venta, p_fecha_venta, p_doc_tributario, p_descuento, p_tipo_entrega, p_impuesto, p_total, p_rut_cliente, p_id_sucursal, p_id_entrega);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE venta
        SET fecha_venta = p_fecha_venta,
            doc_tributario = p_doc_tributario,
            descuento = p_descuento,
            tipo_entrega = p_tipo_entrega,
            impuesto = p_impuesto,
            total = p_total,
            rut_cliente = p_rut_cliente,
            id_sucursal = p_id_sucursal,
            id_entrega = p_id_entrega
        WHERE id_venta = p_id_venta;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_post_venta(
    p_id_venta INTEGER, 
    p_fecha_venta DATE, 
    p_doc_tributario VARCHAR2, 
    p_descuento NUMBER, 
    p_tipo_entrega VARCHAR2, 
    p_impuesto NUMBER, 
    p_total NUMBER, 
    p_rut_cliente VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_entrega VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO venta (id_venta, fecha_venta, doc_tributario, descuento, tipo_entrega, impuesto, total, rut_cliente, id_sucursal, id_entrega) 
    VALUES(p_id_venta, p_fecha_venta, p_doc_tributario, p_descuento, p_tipo_entrega, p_impuesto, p_total, p_rut_cliente, p_id_sucursal, p_id_entrega);
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_post_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_venta(
    p_id_venta INTEGER, 
    p_fecha_venta DATE, 
    p_doc_tributario VARCHAR2, 
    p_descuento NUMBER, 
    p_tipo_entrega VARCHAR2, 
    p_impuesto NUMBER, 
    p_total NUMBER, 
    p_rut_cliente VARCHAR2, 
    p_id_sucursal NUMBER,
    p_id_entrega VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE venta
    SET fecha_venta = p_fecha_venta,
        doc_tributario = p_doc_tributario,
        descuento = p_descuento,
        tipo_entrega = p_tipo_entrega,
        impuesto = p_impuesto,
        total = p_total,
        rut_cliente = p_rut_cliente,
        id_sucursal = p_id_sucursal,
        id_entrega = p_id_entrega
    WHERE id_venta = p_id_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_venta;
/


--PROCEDIMIENTOS DETALLE VENTAS
--GETS Y ACTUALIZAR 
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_delete_detalle_venta(
    p_id_det_venta INTEGER, 
    p_out OUT NUMBER)
IS
BEGIN
    DELETE FROM detalle_venta
    WHERE id_det_venta = p_id_det_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_delete_detalle_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_detalle_venta(
    p_id_det_venta INTEGER, 
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT id_det_venta,
                           cantidad_prod,
                           precio,
                           descuento,
                           id_venta,
                           id_producto
                      FROM detalle_venta
                      WHERE id_det_venta = p_id_det_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_detalle_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_get_detalle_ventas(
    p_cursor OUT SYS_REFCURSOR, 
    p_out OUT NUMBER)
IS
BEGIN
    OPEN p_cursor FOR SELECT id_det_venta, cantidad_prod, precio, descuento, id_venta, id_producto
                      FROM detalle_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_get_detalle_ventas;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_patch_detalle_venta(
    p_id_det_venta INTEGER, 
    p_cantidad_prod INTEGER, 
    p_precio INTEGER, 
    p_descuento NUMBER, 
    p_id_venta INTEGER, 
    p_id_producto VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    INSERT INTO detalle_venta (id_det_venta, cantidad_prod, precio, descuento, id_venta, id_producto) 
    VALUES(p_id_det_venta, p_cantidad_prod, p_precio, p_descuento, p_id_venta, p_id_producto);
    p_out := 1;

    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        UPDATE detalle_venta
        SET cantidad_prod = p_cantidad_prod,
            precio = p_precio,
            descuento = p_descuento,
            id_venta = p_id_venta,
            id_producto = p_id_producto
        WHERE id_det_venta = p_id_det_venta;
        p_out := 1;
    WHEN OTHERS THEN
        p_out := 0;
END sp_patch_detalle_venta;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE sp_put_detalle_venta(
    p_id_det_venta INTEGER, 
    p_cantidad_prod INTEGER, 
    p_precio INTEGER, 
    p_descuento NUMBER, 
    p_id_venta INTEGER, 
    p_id_producto VARCHAR2, 
    p_out OUT NUMBER)
IS
BEGIN
    UPDATE detalle_venta
    SET cantidad_prod = p_cantidad_prod,
        precio = p_precio,
        descuento = p_descuento,
        id_venta = p_id_venta,
        id_producto = p_id_producto
    WHERE id_det_venta = p_id_det_venta;
    p_out := 1;

    EXCEPTION
    WHEN OTHERS THEN
        p_out := 0;
END sp_put_detalle_venta;
/




-- Insertar datos en la tabla perfil
INSERT INTO perfil (id_perfil, nombre_perfil, descripcion) VALUES (1, 'Admin', 'Administrador del sistema');
INSERT INTO perfil (id_perfil, nombre_perfil, descripcion) VALUES (2, 'Vendedor', 'Empleado de ventas');
INSERT INTO perfil (id_perfil, nombre_perfil, descripcion) VALUES (3, 'Contador', 'Responsable de contabilidad');

-- Insertar datos en la tabla credencial
INSERT INTO credencial (id_credencial, correo, contrasena, id_perfil) VALUES (1, 'admin@ferreteria.com', 'admin123', 1);
INSERT INTO credencial (id_credencial, correo, contrasena, id_perfil) VALUES (2, 'vendedor1@ferreteria.com', 'vendedor123', 2);
INSERT INTO credencial (id_credencial, correo, contrasena, id_perfil) VALUES (3, 'contador1@ferreteria.com', 'contador123', 3);

-- Insertar datos en la tabla region
INSERT INTO region (id_region, nom_region) VALUES (1, 'Región Metropolitana');
INSERT INTO region (id_region, nom_region) VALUES (2, 'Valparaíso');

-- Insertar datos en la tabla comuna
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (1, 'Santiago', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (2, 'Viña del Mar', 2);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (3, 'La Florida', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (4, 'Maipú', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (5, 'Providencia', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (6, 'Las Condes', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (7, 'Ñuñoa', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (8, 'Santiago Centro', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (9, 'San Miguel', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (10, 'La Reina', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (11, 'Puente Alto', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (12, 'Quilicura', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (13, 'Peñalolén', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (14, 'Renca', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (15, 'Independencia', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (16, 'Recoleta', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (17, 'La Cisterna', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (18, 'Macul', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (19, 'Vitacura', 1);
INSERT INTO comuna (id_comuna, nom_comuna, id_region) VALUES (20, 'La Pintana', 1);

-- Insertar datos en la tabla sucursal
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (1, 'Sucursal Central', 'Av. Principal 123', 12345678, 1);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (2, 'Sucursal Viña', 'Calle 456', 87654321, 2);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (3, 'Sucursal La Florida', 'Av. Vicuña Mackenna 789', 98765432, 3);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (4, 'Sucursal Maipú', 'Calle Pajaritos 321', 87654321, 4);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (5, 'Sucursal Providencia', 'Av. Providencia 1234', 98765123, 5);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (6, 'Sucursal Las Condes', 'Av. Las Condes 5678', 87651234, 6);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (7, 'Sucursal Ñuñoa', 'Av. Irarrázaval 910', 98761234, 7);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (8, 'Sucursal Santiago Centro', 'Av. Libertador Bernardo OHiggins 123', 87652345, 8);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (9, 'Sucursal San Miguel', 'Av. Departamental 456', 98762345, 9);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (10, 'Sucursal La Reina', 'Av. Príncipe de Gales 789', 87653456, 10);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (11, 'Sucursal Puente Alto', 'Av. Concha y Toro 1111', 98763567, 11);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (12, 'Sucursal Quilicura', 'Av. Matta 2222', 87654678, 12);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (13, 'Sucursal Peñalolén', 'Av. Grecia 3333', 98764789, 13);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (14, 'Sucursal Renca', 'Av. Dorsal 4444', 87655890, 14);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (15, 'Sucursal Independencia', 'Av. Independencia 5555', 98765901, 15);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (16, 'Sucursal Recoleta', 'Av. Recoleta 6666', 87656012, 16);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (17, 'Sucursal La Cisterna', 'Av. Américo Vespucio 7777', 98767123, 17);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (18, 'Sucursal Macul', 'Av. Macul 8888', 87668234, 18);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (19, 'Sucursal Vitacura', 'Av. Vitacura 9999', 98769345, 19);
INSERT INTO sucursal (id_sucursal, nom_sucursal, direccion, telefono, id_comuna) VALUES (20, 'Sucursal La Pintana', 'Av. Santa Rosa 1010', 87670456, 20);


-- Insertar datos en la tabla administrador
INSERT INTO administrador (rut_admin, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_credencial, id_sucursal)
VALUES ('12345678-9', 'Juan', 'Pablo', 'Perez', 'Gonzalez', 'Calle Falsa 123', 12345678, 'juan.perez@ferreteria.com', 1, 1);

-- Insertar datos en la tabla bodeguero
INSERT INTO bodeguero (rut_bodeguero, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial)
VALUES ('23456789-0', 'Pedro', 'Alonso', 'Gomez', 'Lopez', 'Av. Siempre Viva 456', 23456789, 'pedro.gomez@ferreteria.com', 1, 2);

-- Insertar datos en la tabla contador
INSERT INTO contador (rut_contador, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial)
VALUES ('34567890-1', 'Maria', 'Jose', 'Rodriguez', 'Fernandez', 'Calle Los Olivos 789', 34567890, 'maria.rodriguez@ferreteria.com', 2, 3);

-- Insertar datos en la tabla vendedor
INSERT INTO vendedor (rut_vendedor, primer_nombre, segundo_nombre, ape_paterno, ape_materno, direccion, telefono, correo, id_sucursal, id_credencial)
VALUES ('45678901-2', 'Luis', 'Miguel', 'Hernandez', 'Martinez', 'Pje. Las Rosas 101', 45678901, 'luis.hernandez@ferreteria.com', 1, 2);

-- Insertar datos en la tabla categoria
INSERT INTO categoria (id_categoria, nom_categoria, descripcion) VALUES (1, 'Herramientas', 'Herramientas manuales y eléctricas');
INSERT INTO categoria (id_categoria, nom_categoria, descripcion) VALUES (2, 'Materiales', 'Materiales de construcción');

-- Insertar datos en la tabla marca
INSERT INTO marca (id_marca, nombre_marca) VALUES (1, 'Bosch');
INSERT INTO marca (id_marca, nombre_marca) VALUES (2, 'DeWalt');
INSERT INTO marca (id_marca, nombre_marca) VALUES (3, 'Makita');
INSERT INTO marca (id_marca, nombre_marca) VALUES (4, 'Stanley');
INSERT INTO marca (id_marca, nombre_marca) VALUES (5, 'Black y Decker');
INSERT INTO marca (id_marca, nombre_marca) VALUES (6, 'Hitachi');
INSERT INTO marca (id_marca, nombre_marca) VALUES (7, 'Milwaukee');
INSERT INTO marca (id_marca, nombre_marca) VALUES (8, 'Craftsman');
INSERT INTO marca (id_marca, nombre_marca) VALUES (9, 'Metabo');
INSERT INTO marca (id_marca, nombre_marca) VALUES (10, 'Hilti');
INSERT INTO marca (id_marca, nombre_marca) VALUES (11, 'Ridgid');
INSERT INTO marca (id_marca, nombre_marca) VALUES (12, 'Ryobi');
INSERT INTO marca (id_marca, nombre_marca) VALUES (13, 'Kobalt');
INSERT INTO marca (id_marca, nombre_marca) VALUES (14, 'Festool');
INSERT INTO marca (id_marca, nombre_marca) VALUES (15, 'Porter-Cable');
INSERT INTO marca (id_marca, nombre_marca) VALUES (16, 'Bostitch');
INSERT INTO marca (id_marca, nombre_marca) VALUES (17, 'Paslode');
INSERT INTO marca (id_marca, nombre_marca) VALUES (18, 'Skil');
INSERT INTO marca (id_marca, nombre_marca) VALUES (19, 'Dremel');
INSERT INTO marca (id_marca, nombre_marca) VALUES (20, 'Worx');
INSERT INTO marca (id_marca, nombre_marca) VALUES (21, 'Husqvarna');
INSERT INTO marca (id_marca, nombre_marca) VALUES (22, 'Echo');
INSERT INTO marca (id_marca, nombre_marca) VALUES (23, 'Shindaiwa');
INSERT INTO marca (id_marca, nombre_marca) VALUES (24, 'Poulan');
INSERT INTO marca (id_marca, nombre_marca) VALUES (25, 'Generac');
INSERT INTO marca (id_marca, nombre_marca) VALUES (26, 'Toro');
INSERT INTO marca (id_marca, nombre_marca) VALUES (27, 'Greenworks');
INSERT INTO marca (id_marca, nombre_marca) VALUES (28, 'Oregon');
INSERT INTO marca (id_marca, nombre_marca) VALUES (29, 'Snap-on');
INSERT INTO marca (id_marca, nombre_marca) VALUES (30, 'Ridgid');
INSERT INTO marca (id_marca, nombre_marca) VALUES (31, 'AEG');
INSERT INTO marca (id_marca, nombre_marca) VALUES (32, 'Einhell');
INSERT INTO marca (id_marca, nombre_marca) VALUES (33, 'Silverline');
INSERT INTO marca (id_marca, nombre_marca) VALUES (34, 'Irwin');
INSERT INTO marca (id_marca, nombre_marca) VALUES (35, 'Lenox');
INSERT INTO marca (id_marca, nombre_marca) VALUES (36, 'Narex');
INSERT INTO marca (id_marca, nombre_marca) VALUES (37, 'Facom');
INSERT INTO marca (id_marca, nombre_marca) VALUES (38, 'Parkside');
INSERT INTO marca (id_marca, nombre_marca) VALUES (39, 'Powerplus');
INSERT INTO marca (id_marca, nombre_marca) VALUES (40, 'Proxxon');

-- Insertar datos en la tabla producto
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P001', 'Taladro Bosch', 'Taladro inalámbrico 18V', 120000, 15, 10, EMPTY_BLOB(), 1, 1);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P002', 'Sierra Circular DeWalt', 'Sierra circular 7-1/4 pulgadas', 200000, 10, 5, EMPTY_BLOB(), 2, 1);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P003', 'Lijadora Makita', 'Lijadora orbital 300W', 85000, 20, 0, EMPTY_BLOB(), 3, 2);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P004', 'Amoladora Stanley', 'Amoladora angular 4-1/2 pulgadas', 60000, 25, 15, EMPTY_BLOB(), 4, 2);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P005', 'Martillo Black & Decker', 'Martillo perforador 500W', 110000, 30, 10, EMPTY_BLOB(), 5, 1);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P006', 'Taladro Hitachi', 'Taladro percutor 600W', 95000, 12, 5, EMPTY_BLOB(), 6, 1);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P007', 'Caladora Milwaukee', 'Sierra caladora 400W', 130000, 8, 20, EMPTY_BLOB(), 7, 1);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P008', 'Destornillador Craftsman', 'Destornillador eléctrico 200W', 75000, 18, 0, EMPTY_BLOB(), 8, 2);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P009', 'Multiherramienta Metabo', 'Multiherramienta oscilante 250W', 160000, 10, 25, EMPTY_BLOB(), 9, 2);
INSERT INTO producto (id_producto, nombre, descripcion, precio, stock, descuento, imagen, id_marca, id_categoria)
VALUES ('P010', 'Llave de impacto Hilti', 'Llave de impacto inalámbrica 18V', 220000, 5, 10, EMPTY_BLOB(), 10, 2);


-- Insertar datos en la tabla cliente
INSERT INTO cliente (rut_cliente, nombre, apellido_paterno, apellido_materno, direccion, telefono, correo, id_credencial)
VALUES ('56789012-3', 'Ana', 'Garcia', 'Perez', 'Calle Nueva 102', 56789012, 'ana.garcia@cliente.com', 2);

-- Insertar datos en la tabla entrega
INSERT INTO entrega (id_entrega, direccion, estado, rut_contador) 
VALUES ('E001', 'Calle de Entrega 1', 'En camino', '34567890-1');

-- Insertar datos en la tabla metodo_pago
INSERT INTO metodo_pago (id_met_pago, nom_met_pago) VALUES (1, 'Tarjeta de Crédito');
INSERT INTO metodo_pago (id_met_pago, nom_met_pago) VALUES (2, 'Transferencia Bancaria');

-- Insertar datos en la tabla venta
INSERT INTO venta (id_venta, fecha_venta, doc_tributario, descuento, tipo_entrega, impuesto, total, rut_cliente, id_sucursal, id_entrega)
VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Factura', 0, 'Domicilio', 19, 238000, '56789012-3', 1, 'E001');

-- Insertar datos en la tabla detalle_venta
INSERT INTO detalle_venta (id_det_venta, cantidad_prod, precio, descuento, id_venta, id_producto)
VALUES (1, 1, 120000, 10, 1, 'P001');
INSERT INTO detalle_venta (id_det_venta, cantidad_prod, precio, descuento, id_venta, id_producto)
VALUES (2, 1, 200000, 5, 1, 'P002');

-- Insertar datos en la tabla pago
INSERT INTO pago (id_pago, fecha_pago, estado, id_met_pago, rut_contador, id_venta) 
VALUES (1, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 'Completado', 1, '34567890-1', 1);
/
select * from producto;