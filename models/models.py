from pydantic import BaseModel
from typing import Optional
from datetime import date

class Producto(BaseModel):
    id_producto: str
    id_marca: int
    nombre_producto: str
    precio: int
    stock: int
    descripcion: Optional[str] = None
    descuento: Optional[int] = None
    id_categoria: int
    imagen_ruta: Optional[str] = 'images/default.png'


class Admin(BaseModel):
    rut_admin: str
    primer_nombre: str
    segundo_nombre: Optional[str] = None
    ape_paterno: str
    ape_materno: str
    direccion: str
    telefono: int
    correo: str
    id_credencial: int
    id_sucursal: int

class Bodeguero(BaseModel):
    rut_bodeguero: str
    primer_nombre: str
    segundo_nombre: Optional[str] = None
    ape_paterno: str
    ape_materno: str
    direccion: str
    telefono: int
    correo: str
    id_sucursal: int
    id_credencial: int


class Cliente(BaseModel):
    rut_cliente: str
    nombre: str
    apellido_paterno: str
    apellido_materno: str
    direccion: str
    telefono: int
    correo: str
    id_credencial: int

class Contador(BaseModel):
    rut_contador: str
    primer_nombre: str
    segundo_nombre: Optional[str] = None
    ape_paterno: str
    ape_materno: str
    direccion: str
    telefono: int
    correo: str
    id_sucursal: int
    id_credencial: int

class Vendedor(BaseModel):
    rut_vendedor: str
    primer_nombre: str
    segundo_nombre: Optional[str] = None
    ape_paterno: str
    ape_materno: str
    direccion: str
    telefono: int
    correo: str
    id_sucursal: int
    id_credencial: int


class Venta(BaseModel):
    id_venta: int
    fecha_venta: date
    doc_tributario: str
    descuento: Optional[int] = None
    tipo_entrega: str
    impuesto: int
    total: int
    rut_cliente: str
    id_sucursal: int
    id_entrega: str


class DetalleVenta(BaseModel):
    id_det_venta: int
    cantidad_prod: int
    precio: int
    descuento: Optional[float] = None
    id_venta: int
    id_producto: str