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

@router.get("/clientes")
async def get_clientes():
    try:
        cursor = cone.cursor()
        cursor_clientes = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_clientes", [cursor_clientes, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_clientes.getvalue():
                json = {}
                json['rut_cliente'] = fila[0]
                json['nombre'] = fila[1]
                json['apellido_paterno'] = fila[2]
                json['apellido_materno'] = fila[3]
                json['direccion'] = fila[4]
                json['telefono'] = fila[5]
                json['correo'] = fila[6]
                json['id_credencial'] = fila[7]
                lista.append(json)
            return lista
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.get("/cliente/{rut_cliente}")
async def get_cliente(rut_cliente: str):
    try:
        cursor = cone.cursor()
        cursor_cliente = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("sp_get_cliente", [rut_cliente, cursor_cliente, out])
        if out.getvalue() == 1:
            fila = cursor_cliente.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Cliente not found")
            json = {}
            json['rut_cliente'] = fila[0]
            json['nombre'] = fila[1]
            json['apellido_paterno'] = fila[2]
            json['apellido_materno'] = fila[3]
            json['direccion'] = fila[4]
            json['telefono'] = fila[5]
            json['correo'] = fila[6]
            json['id_credencial'] = fila[7]
            return json
        else:
            raise HTTPException(status_code=400, detail="Failed to get cliente")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/clientes")
async def post_cliente(cliente: Cliente):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_cliente", [cliente.rut_cliente,
                                            cliente.nombre,
                                            cliente.apellido_paterno,
                                            cliente.apellido_materno,
                                            cliente.direccion,
                                            cliente.telefono,
                                            cliente.correo,
                                            cliente.id_credencial,
                                            out])
        if out.getvalue() == 1:
            cone.commit()
            return cliente
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/cliente/{rut_cliente}")
async def put_cliente(rut_cliente: str, cliente: Cliente):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_cliente", [rut_cliente, 
                                           cliente.nombre, 
                                           cliente.apellido_paterno, 
                                           cliente.apellido_materno, 
                                           cliente.direccion, 
                                           cliente.telefono, 
                                           cliente.correo, 
                                           cliente.id_credencial, 
                                           out])
        if out.getvalue() == 1:
            cone.commit()
            return cliente
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.patch("/clientes/{rut_cliente}")
async def patch_cliente(cliente: Cliente, rut_cliente: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_cliente", [rut_cliente,
                                             cliente.nombre,
                                             cliente.apellido_paterno,
                                             cliente.apellido_materno,
                                             cliente.direccion,
                                             cliente.telefono,
                                             cliente.correo,
                                             cliente.id_credencial,
                                             out])
        if out.getvalue() == 1:
            cone.commit()
            return cliente
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()


@router.delete("/clientes/{rut_cliente}")
async def delete_cliente(rut_cliente: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_cliente", [rut_cliente, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Cliente eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()