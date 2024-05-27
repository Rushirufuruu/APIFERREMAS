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


@router.get("/admins")
async def get_admins():
    try:
        cursor = cone.cursor()
        # VARIABLE CURSOR PARA RECIBIR LOS DATOS DESDE ORACLE: sys_refcursr
        cursor_admins = cursor.var(oracledb.CURSOR)
        # VARIABLE NÚMERO PARA RECIBIR EL 1 o 0
        out = cursor.var(int)
        # EJECUTAMOS EL PROCEDIMIENTO:
        cursor.callproc("sp_get_admins", [cursor_admins, out])
        if out.getvalue() == 1:
            lista = []
            for fila in cursor_admins.getvalue():
                json = {}
                json['rut_admin'] = fila[0]
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

@router.get("/admin/{rut_admin}")
async def get_admin(rut_admin: str):
    try:
        cursor = cone.cursor()
        # VARIABLE CURSOR PARA RECIBIR LOS DATOS DESDE ORACLE: sys_refcursr
        cursor_admin = cursor.var(oracledb.CURSOR)
        # VARIABLE NÚMERO PARA RECIBIR EL 1 o 0
        out = cursor.var(int)
        # EJECUTAMOS EL PROCEDIMIENTO:
        cursor.callproc("sp_get_admin", [rut_admin, cursor_admin, out])
        if out.getvalue() == 1:
            fila = cursor_admin.getvalue().fetchone()
            if fila is None:
                raise HTTPException(status_code=404, detail="Admin not found")
            json = {}
            json['rut_admin'] = fila[0]
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
            raise HTTPException(status_code=400, detail="Failed to get admin")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.post("/admins")
async def post_admin(admin: Admin):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_post_admin", [admin.rut_admin,
                                          admin.primer_nombre,
                                          admin.segundo_nombre,
                                          admin.ape_paterno,
                                          admin.ape_materno,
                                          admin.direccion,
                                          admin.telefono,
                                          admin.correo,
                                          admin.id_credencial,
                                          admin.id_sucursal,
                                          out])
        if out.getvalue() == 1:
            cone.commit()
            return admin
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.put("/admin/{rut_admin}")
async def put_admin(rut_admin: str, admin: Admin):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_put_admin", [rut_admin, admin.primer_nombre, admin.segundo_nombre, admin.ape_paterno, admin.ape_materno, admin.direccion, admin.telefono, admin.correo, admin.id_credencial, admin.id_sucursal, out])
        if out.getvalue() == 1:
            cone.commit()
            return (admin)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.patch("/admins/{rut_admin}")
async def patch_admin(admin: Admin, rut_admin: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_patch_admin", [rut_admin,
                                           admin.primer_nombre,
                                           admin.segundo_nombre,
                                           admin.ape_paterno,
                                           admin.ape_materno,
                                           admin.direccion,
                                           admin.telefono,
                                           admin.correo,
                                           admin.id_credencial,
                                           admin.id_sucursal,
                                           out])
        if out.getvalue() == 1:
            cone.commit()
            return admin
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()

@router.delete("/admins/{rut_admin}")
async def delete_admin(rut_admin: str):
    try:
        cursor = cone.cursor()
        out = cursor.var(int)
        cursor.callproc("sp_delete_admin", [rut_admin, out])
        if out.getvalue() == 1:
            cone.commit()
            return {"message": "Admin eliminado correctamente"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()