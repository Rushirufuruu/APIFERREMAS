from pydantic import BaseModel, Field
from typing import Optional

class Producto(BaseModel):
    id_producto: str
    id_marca: int
    nombre_producto: str
    precio: int
    stock: int
    descripcion: Optional[str] = None
    descuento: Optional[int] = None
    id_categoria: int
    imagen_ruta: Optional[str] = None
