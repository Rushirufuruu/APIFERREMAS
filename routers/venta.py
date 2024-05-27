from fastapi import APIRouter, HTTPException
from models.models import *
import oracledb

#dsn: tienen que buscar el archivo tnsnames, buscar SERVICE_NAME:

cone = oracledb.connect(user="ferremas",
                        password="ferremas",
                        host="localhost",
                        port=1521,
                        service_name="orcl")


router = APIRouter()


@router.get("/ventas")
async def get_ventas():
    try:
        cursor = cone.cursor()
        cursor_ventas = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_ventas", [cursor_ventas, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_ventas.getvalue():
                json = {}
                json['id_venta'] = fila[0]
                json['fecha_venta'] = fila[1]
                json['doc_tributario'] = fila[2]
                json['descuento'] = fila[3]
                json['tipo_entrega'] = fila[4]
                json['impuesto'] = fila[5]
                json['total'] = fila[6]
                json['rut_cliente'] = fila[7]
                json['id_sucursal'] = fila[8]
                json['id_entrega'] = fila[9]
                lista.append(json)
            return lista
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.get("/venta/{id_venta}")
async def get_venta(id_venta: int):
    try:
        cursor = cone.cursor()
        cursor_venta = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_venta", [id_venta, cursor_venta, out])
        if out.getvalue() == 1:
            fila = cursor_venta.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Venta not found")
            json = {}
            json['id_venta'] = fila[0]
            json['fecha_venta'] = fila[1]
            json['doc_tributario'] = fila[2]
            json['descuento'] = fila[3]
            json['tipo_entrega'] = fila[4]
            json['impuesto'] = fila[5]
            json['total'] = fila[6]
            json['rut_cliente'] = fila[7]
            json['id_sucursal'] = fila[8]
            json['id_entrega'] = fila[9]
            return json
        else:
            raise HTTPException(status_code=400, detail="Failed to get venta")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/ventas")
async def post_venta(venta: Venta):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_venta", [venta.id_venta,
                                          venta.fecha_venta,
                                          venta.doc_tributario,
                                          venta.descuento,
                                          venta.tipo_entrega,
                                          venta.impuesto,
                                          venta.total,
                                          venta.rut_cliente,
                                          venta.id_sucursal,
                                          venta.id_entrega,
                                          out])
        if out.getvalue() == 1:
            cone.commit()
            return venta
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.put("/venta/{id_venta}")
async def put_venta(id_venta: int, venta: Venta):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_venta", [id_venta, 
                                         venta.fecha_venta,
                                         venta.doc_tributario,
                                         venta.descuento,
                                         venta.tipo_entrega,
                                         venta.impuesto,
                                         venta.total,
                                         venta.rut_cliente,
                                         venta.id_sucursal,
                                         venta.id_entrega,
                                         out])
        if out.getvalue() == 1:
            cone.commit()
            return venta
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/venta/{id_venta}")
async def patch_venta(venta: Venta, id_venta: int):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_venta", [id_venta, 
                                           venta.fecha_venta,
                                           venta.doc_tributario,
                                           venta.descuento,
                                           venta.tipo_entrega,
                                           venta.impuesto,
                                           venta.total,
                                           venta.rut_cliente,
                                           venta.id_sucursal,
                                           venta.id_entrega,
                                           out])
        if out.getvalue() == 1:
            cone.commit()
            return venta
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/venta/{id_venta}")
async def delete_venta(id_venta: int):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_venta", [id_venta, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Venta eliminada correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()