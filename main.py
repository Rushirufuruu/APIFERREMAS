#importamos la librería para crear una API REST:
from fastapi import FastAPI
from routers.producto import router as ruta_productos
from routers.admin import router as ruta_admins
from routers.bodeguero import router as ruta_bodegueros
from routers.cliente import router as ruta_clientes
from routers.contador import router as ruta_contadores
from routers.vendedor import router as ruta_vendedores
from routers.venta import router as ruta_ventas
from routers.detalleVenta import router as ruta_detalleVentas

#vamos a crear la aplicación:
app = FastAPI()


@app.get("/")
def get_inicial():
    return { "mensaje": "hola mundo"}

app.include_router(ruta_productos)
app.include_router(ruta_admins)
app.include_router(ruta_bodegueros)
app.include_router(ruta_clientes)
app.include_router(ruta_contadores)
app.include_router(ruta_vendedores)
app.include_router(ruta_ventas)
app.include_router(ruta_detalleVentas)