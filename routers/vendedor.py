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

@router.get("/vendedores")
async def get_vendedores():
    try:
        cursor = cone.cursor()
        cursor_vendedores = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_vendedores", [cursor_vendedores, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_vendedores.getvalue():
                json = {}
                json['rut_vendedor'] = fila[0]
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

@router.get("/vendedor/{rut_vendedor}")
async def get_vendedor(rut_vendedor: str):
    try:
        cursor = cone.cursor()
        cursor_vendedor = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_vendedor", [rut_vendedor, cursor_vendedor, out])
        if out.getvalue() == 1:
            fila = cursor_vendedor.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Vendedor not found")
            json = {}
            json['rut_vendedor'] = fila[0]
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
            raise HTTPException(status_code=400, detail="Failed to get vendedor")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.post("/vendedores")
async def post_vendedor(vendedor: Vendedor):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_vendedor", [vendedor.rut_vendedor,
                                              vendedor.primer_nombre,
                                              vendedor.segundo_nombre,
                                              vendedor.ape_paterno,
                                              vendedor.ape_materno,
                                              vendedor.direccion,
                                              vendedor.telefono,
                                              vendedor.correo,
                                              vendedor.id_credencial,
                                              vendedor.id_sucursal,
                                              out])
        if out.getvalue() == 1:
            cone.commit()
            return vendedor
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/vendedor/{rut_vendedor}")
async def put_vendedor(rut_vendedor: str, vendedor: Vendedor):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_vendedor", [rut_vendedor, 
                                             vendedor.primer_nombre, 
                                             vendedor.segundo_nombre, 
                                             vendedor.ape_paterno, 
                                             vendedor.ape_materno, 
                                             vendedor.direccion, 
                                             vendedor.telefono, 
                                             vendedor.correo, 
                                             vendedor.id_credencial, 
                                             vendedor.id_sucursal, 
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return (vendedor)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/vendedores/{rut_vendedor}")
async def patch_vendedor(vendedor: Vendedor, rut_vendedor: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_vendedor", [rut_vendedor,
                                               vendedor.primer_nombre,
                                               vendedor.segundo_nombre,
                                               vendedor.ape_paterno,
                                               vendedor.ape_materno,
                                               vendedor.direccion,
                                               vendedor.telefono,
                                               vendedor.correo,
                                               vendedor.id_credencial,
                                               vendedor.id_sucursal,
                                               out])
        if out.getvalue() == 1:
            cone.commit()
            return vendedor
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/vendedores/{rut_vendedor}")
async def delete_vendedor(rut_vendedor: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_vendedor", [rut_vendedor, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Vendedor eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()