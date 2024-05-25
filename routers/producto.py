from fastapi import APIRouter, HTTPException
from models.models import Producto
import oracledb
import base64

#dsn: tienen que buscar el archivo tnsnames, buscar SERVICE_NAME:
try:
    cone = oracledb.connect(user="ferremas",
                            password="ferremas",
                            host="localhost",
                            port=1521,
                            service_name="xe")
except oracledb.DatabaseError as e:
    print("There was a problem connecting to the database: ", e)
    cone = None

router = APIRouter()

@router.get("/productos")
async def get_productos():
    try:
        cursor = cone.cursor()
        # VARIABLE CURSOR PARA RECIBIR LOS DATOS DESDE ORACLE: sys_refcursr
        cursor_productos = cursor.var(oracledb.CURSOR)
        # VARIABLE NÚMERO PARA RECIBIR EL 1 o 0
        out = cursor.var(int)
        # EJECUTAMOS EL PROCEDIMIENTO:
        cursor.callproc("sp_get_productos", [cursor_productos, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_productos.getvalue():
                json = {}
                json['id_producto'] = fila[0]
                json['nombre_producto'] = fila[1]
                json['id_marca'] = fila[2]
                json['nombre_marca'] = fila[3]
                json['id_categoria'] = fila[4]
                json['nombre_categoria'] = fila[5]
                json['precio'] = fila[6]
                json['stock'] = fila[7]
                json['descripcion'] = fila[8]
                if fila[9] is not None:  # if the imagen field is not NULL
                    json['imagen'] = base64.b64encode(fila[9].read()).decode('utf-8')
                json['descuento'] = fila[10]
                lista.append(json)
            return lista
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.get("/producto/{id_producto}")
async def get_producto(id_producto: str):
    try:
        cursor = cone.cursor()
        cursor_producto = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_producto", [id_producto, cursor_producto, out])
        if out.getvalue() == 1:
            json = {}
            for fila in cursor_producto.getvalue():
                json['id_producto'] = fila[0]
                json['nombre_producto'] = fila[1]
                json['id_marca'] = fila[2]
                json['nombre_marca'] = fila[3]
                json['id_categoria'] = fila[4]
                json['nombre_categoria'] = fila[5]
                json['precio'] = fila[6]
                json['stock'] = fila[7]
                json['descripcion'] = fila[8]
                if fila[9] is not None:  # if the imagen field is not NULL
                    json['imagen'] = base64.b64encode(fila[9].read()).decode('utf-8')
                json['descuento'] = fila[10]
            return json
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/productos")
async def post_producto(producto: Producto):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        imagen = None
        if producto.imagen_ruta:
            with open(producto.imagen_ruta, "rb") as file:
                imagen = file.read()
        cursor.callproc("sp_post_producto", [producto.id_producto,
                                             producto.nombre_producto,
                                             producto.descripcion,
                                             producto.precio,
                                             producto.stock,
                                             producto.descuento,
                                             imagen,
                                             producto.id_marca,
                                             producto.id_categoria,
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return producto
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.put("/productos/{id_producto}")
async def put_producto(id_producto: str, producto: Producto):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_producto", [id_producto,
                                             producto.nombre_producto,
                                             producto.id_marca,
                                             producto.precio,
                                             producto.stock,
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return producto
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.patch("/productos/{id_producto}")
async def patch_producto(producto: Producto, id_producto: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        imagen = None
        if producto.imagen_ruta:
            with open(producto.imagen_ruta, "rb") as file:
                imagen = file.read()
        cursor.callproc("sp_patch_producto", [id_producto,
                                              producto.id_marca,
                                              producto.nombre_producto,
                                              producto.precio,
                                              producto.stock,
                                              producto.descuento,
                                              producto.id_categoria,
                                              producto.descripcion,
                                              imagen,
                                              out])
        if out.getvalue() == 1:
            cone.commit()
            return producto
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/productos/{id_producto}")
async def delete_producto(id_producto: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_producto", [id_producto, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "ProductO eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

