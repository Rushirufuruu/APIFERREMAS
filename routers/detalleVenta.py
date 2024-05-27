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


@router.get("/detalleventas")
async def get_detalleventas():
    try:
        cursor = cone.cursor()
        cursor_detalleventas = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_detalle_ventas", [cursor_detalleventas, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_detalleventas.getvalue():
                json = {}
                json['id_det_venta'] = fila[0]
                json['cantidad_prod'] = fila[1]
                json['precio'] = fila[2]
                json['descuento'] = fila[3]
                json['id_venta'] = fila[4]
                json['id_producto'] = fila[5]
                lista.append(json)
            return lista
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.get("/detalleventa/{id_det_venta}")
async def get_detalleventa(id_det_venta: int):
    try:
        cursor = cone.cursor()
        cursor_detalleventa = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_detalle_venta", [id_det_venta, cursor_detalleventa, out])
        if out.getvalue() == 1:
            fila = cursor_detalleventa.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="DetalleVenta not found")
            json = {}
            json['id_det_venta'] = fila[0]
            json['cantidad_prod'] = fila[1]
            json['precio'] = fila[2]
            json['descuento'] = fila[3]
            json['id_venta'] = fila[4]
            json['id_producto'] = fila[5]
            return json
        else:
            raise HTTPException(status_code=400, detail="Failed to get detalleventa")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/detalleventa/{id_det_venta}")
async def put_detalleventa(id_det_venta: int, detalleventa: DetalleVenta):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_detalle_venta", [id_det_venta, 
                                                 detalleventa.cantidad_prod,
                                                 detalleventa.precio,
                                                 detalleventa.descuento,
                                                 detalleventa.id_venta,
                                                 detalleventa.id_producto,
                                                 out])
        if out.getvalue() == 1:
            cone.commit()
            return detalleventa
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/detalleventa/{id_det_venta}")
async def patch_detalleventa(detalleventa: DetalleVenta, id_det_venta: int):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_detalle_venta", [id_det_venta, 
                                                   detalleventa.cantidad_prod,
                                                   detalleventa.precio,
                                                   detalleventa.descuento,
                                                   detalleventa.id_venta,
                                                   detalleventa.id_producto,
                                                   out])
        if out.getvalue() == 1:
            cone.commit()
            return detalleventa
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/detalleventa/{id_det_venta}")
async def delete_detalleventa(id_det_venta: int):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_detalle_venta", [id_det_venta, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "DetalleVenta eliminada correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()