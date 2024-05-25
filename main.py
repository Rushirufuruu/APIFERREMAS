#importamos la librería para crear una API REST:
from fastapi import FastAPI
from routers.producto import router as ruta_productos

#vamos a crear la aplicación:
app = FastAPI()


@app.get("/")
def get_inicial():
    return { "mensaje": "hola mundo"}

app.include_router(ruta_productos)