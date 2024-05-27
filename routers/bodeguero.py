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


@router.get("/bodegueros")
async def get_bodegueros():
    try:
        cursor = cone.cursor()
        cursor_bodegueros = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_bodegueros", [cursor_bodegueros, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_bodegueros.getvalue():
                json = {}
                json['rut_bodeguero'] = fila[0]
                json['primer_nombre'] = fila[1]
                json['segundo_nombre'] = fila[2]
                json['ape_paterno'] = fila[3]
                json['ape_materno'] = fila[4]
                json['direccion'] = fila[5]
                json['telefono'] = fila[6]
                json['correo'] = fila[7]
                json['id_credencial'] = fila[8]
                json['id_sucursal'] = fila[9]
                lista.append(json)
            return lista
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.get("/bodeguero/{rut_bodeguero}")
async def get_bodeguero(rut_bodeguero: str):
    try:
        cursor = cone.cursor()
        cursor_bodeguero = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_bodeguero", [rut_bodeguero, cursor_bodeguero, out])
        if out.getvalue() == 1:
            fila = cursor_bodeguero.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Bodeguero not found")
            json = {}
            json['rut_bodeguero'] = fila[0]
            json['primer_nombre'] = fila[1]
            json['segundo_nombre'] = fila[2]
            json['ape_paterno'] = fila[3]
            json['ape_materno'] = fila[4]
            json['direccion'] = fila[5]
            json['telefono'] = fila[6]
            json['correo'] = fila[7]
            json['id_credencial'] = fila[8]
            json['id_sucursal'] = fila[9]
            return json
        else:
            raise HTTPException(status_code=400, detail="Failed to get bodeguero")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/bodegueros")
async def post_bodeguero(bodeguero: Bodeguero):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_bodeguero", [bodeguero.rut_bodeguero,
                                              bodeguero.primer_nombre,
                                              bodeguero.segundo_nombre,
                                              bodeguero.ape_paterno,
                                              bodeguero.ape_materno,
                                              bodeguero.direccion,
                                              bodeguero.telefono,
                                              bodeguero.correo,
                                              bodeguero.id_credencial,
                                              bodeguero.id_sucursal,
                                              out])
        if out.getvalue() == 1:
            cone.commit()
            return bodeguero
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/bodeguero/{rut_bodeguero}")
async def put_bodeguero(rut_bodeguero: str, bodeguero: Bodeguero):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_bodeguero", [rut_bodeguero, 
                                             bodeguero.primer_nombre, 
                                             bodeguero.segundo_nombre, 
                                             bodeguero.ape_paterno, 
                                             bodeguero.ape_materno, 
                                             bodeguero.direccion, 
                                             bodeguero.telefono, 
                                             bodeguero.correo, 
                                             bodeguero.id_credencial, 
                                             bodeguero.id_sucursal, 
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return (bodeguero)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/bodegueros/{rut_bodeguero}")
async def patch_bodeguero(bodeguero: Bodeguero, rut_bodeguero: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_bodeguero", [rut_bodeguero,
                                               bodeguero.primer_nombre,
                                               bodeguero.segundo_nombre,
                                               bodeguero.ape_paterno,
                                               bodeguero.ape_materno,
                                               bodeguero.direccion,
                                               bodeguero.telefono,
                                               bodeguero.correo,
                                               bodeguero.id_credencial,
                                               bodeguero.id_sucursal,
                                               out])
        if out.getvalue() == 1:
            cone.commit()
            return bodeguero
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.delete("/bodegueros/{rut_bodeguero}")
async def delete_bodeguero(rut_bodeguero: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_bodeguero", [rut_bodeguero, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Bodeguero eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()