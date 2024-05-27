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


@router.get("/contadores")
async def get_contadores():
    try:
        cursor = cone.cursor()
        cursor_contadores = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_contadores", [cursor_contadores, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_contadores.getvalue():
                json = {}
                json['rut_contador'] = fila[0]
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

@router.get("/contador/{rut_contador}")
async def get_contador(rut_contador: str):
    try:
        cursor = cone.cursor()
        cursor_contador = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_contador", [rut_contador, cursor_contador, out])
        if out.getvalue() == 1:
            fila = cursor_contador.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Contador not found")
            json = {}
            json['rut_contador'] = fila[0]
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
            raise HTTPException(status_code=400, detail="Failed to get contador")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/contadores")
async def post_contador(contador: Contador):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_contador", [contador.rut_contador,
                                              contador.primer_nombre,
                                              contador.segundo_nombre,
                                              contador.ape_paterno,
                                              contador.ape_materno,
                                              contador.direccion,
                                              contador.telefono,
                                              contador.correo,
                                              contador.id_credencial,
                                              contador.id_sucursal,
                                              out])
        if out.getvalue() == 1:
            cone.commit()
            return contador
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/contador/{rut_contador}")
async def put_contador(rut_contador: str, contador: Contador):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_contador", [rut_contador, 
                                             contador.primer_nombre, 
                                             contador.segundo_nombre, 
                                             contador.ape_paterno, 
                                             contador.ape_materno, 
                                             contador.direccion, 
                                             contador.telefono, 
                                             contador.correo, 
                                             contador.id_credencial, 
                                             contador.id_sucursal, 
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return (contador)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/contadores/{rut_contador}")
async def patch_contador(contador: Contador, rut_contador: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_contador", [rut_contador,
                                               contador.primer_nombre,
                                               contador.segundo_nombre,
                                               contador.ape_paterno,
                                               contador.ape_materno,
                                               contador.direccion,
                                               contador.telefono,
                                               contador.correo,
                                               contador.id_credencial,
                                               contador.id_sucursal,
                                               out])
        if out.getvalue() == 1:
            cone.commit()
            return contador
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/contadores/{rut_contador}")
async def delete_contador(rut_contador: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_contador", [rut_contador, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Contador eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()