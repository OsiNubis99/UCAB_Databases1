from django.db import models

# Create your models here.
class Pais (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    nacionalidad=models.CharField(max_length=50)

class Divisa (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    pais=models.ForeignKey(Pais,on_delete=models.RESTRICT)

class Artista (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    apellido=models.CharField(max_length=50,default=None, blank=True, null=True)
    nombre_art=models.CharField(max_length=50,default=None, blank=True, null=True)

class Moneda (models.Model):
    id=models.AutoField(primary_key=True)
    artistas=models.ManyToManyField(Artista,default=None, blank=True, null=True)
    divisa=models.ForeignKey(Divisa,on_delete=models.RESTRICT)
    creada_en=models.ForeignKey(Pais,on_delete=models.RESTRICT)
    nombre=models.CharField(max_length=50)
    metal=models.CharField(max_length=50)
    forma=models.CharField(max_length=50)
    tamano=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    motivo=models.CharField(max_length=50)
    peso=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    anverso=models.CharField(max_length=50)
    reverso=models.CharField(max_length=50,default=None, blank=True, null=True)
    denominacion=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)

class Tienda (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    fecha_fundacion=models.DateField()
    pagina=models.CharField(max_length=50,default=None, blank=True, null=True)
    proposito=models.CharField(max_length=100)
    alcance=models.CharField(max_length=50)
    tipos=[
        ('Antiguedades','antiguedades'),
        ('Galeria','galeria'),
        ('Numismatica','numismatica')
        ]
    tipo=models.CharField(max_length=70,choices=tipos)
    alcance=models.CharField(max_length=20,null=False)

class Contacto_tienda (models.Model):
    num=models.AutoField(primary_key=True)
    tienda=models.ForeignKey(Tienda, on_delete=models.RESTRICT)
    email=models.CharField(max_length=50,null=False)
    telefono=models.CharField(max_length=50,null=False)
    cargo=models.CharField(max_length=50)
    nombre=models.CharField(max_length=50)
    apellido=models.CharField(max_length=50)

class Coleccionista (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    nombre2=models.CharField(max_length=50,default=None, blank=True, null=True)
    apellido=models.CharField(max_length=50,null=False)
    apellido2=models.CharField(max_length=50,null=True)
    telefono=models.CharField(max_length=50,null=False)
    email=models.CharField(max_length=13,null=False)
    fecha_nacimiento=models.DateField()
    nacio=models.ForeignKey(Pais, on_delete=models.RESTRICT,related_name='nacio')
    vive=models.ForeignKey(Pais, on_delete=models.RESTRICT,related_name='vive')

class Catalogo_Moneda (models.Model):
    num=models.AutoField(primary_key=True)
    moneda=models.ManyToManyField(Moneda,default=None, blank=True, null=False)
    coleccionista=models.ForeignKey(Coleccionista,default=None, blank=True, null=True,on_delete=models.RESTRICT)
    tienda=models.ForeignKey(Tienda,default=None, blank=True, null=True,on_delete=models.RESTRICT)

class Catalogo_Pintura (models.Model):
    num=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50,null=False)
    year=models.CharField(max_length=50,null=False)
    estilo=models.CharField(max_length=50)
    size=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    coleccionista=models.ForeignKey(Coleccionista,default=None, blank=True, null=True,on_delete=models.RESTRICT)
    tienda=models.ForeignKey(Tienda,default=None, blank=True, null=True,on_delete=models.RESTRICT)


class Cliente (models.Model):
    num=models.AutoField(primary_key=True)
    date_client=models.DateField(null=True, blank=True)
    num_coleccionista=models.ForeignKey(Coleccionista,null=False,on_delete=models.RESTRICT)
    num_tienda=models.ForeignKey(Tienda,blank=False,null=False,on_delete=models.RESTRICT)



class Costo_envio (models.Model):
    id=models.AutoField(primary_key=True)
    pais=models.ForeignKey(Pais, on_delete=models.RESTRICT)
    costo=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    extra=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    recargo=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    embalaje=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    seguro=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)

class Subasta_Evento (models.Model):
    id=models.AutoField(primary_key=True)
    tiendas=models.ManyToManyField(Tienda)
    lugar=models.ForeignKey(Pais,on_delete=models.RESTRICT,blank=True,null=False)
    duracion=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    tipos=[
        ('Cerrada','cerrada'),
        ('Dinamica','dinamica'),
        ]
    tipo_puja=models.CharField(max_length=50,choices=tipos)
    costo_cliente=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    costo_general=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    direccion=models.CharField(max_length=50)
    costo_envio=models.ForeignKey(Costo_envio,on_delete=models.CASCADE,null=True)

class Factura (models.Model):
    id=models.AutoField(primary_key=True)
    iva=models.IntegerField()


class Subasta_Evento (models.Model):
    tiendas=models.ManyToManyField(Tienda)
    lugar=models.ForeignKey(Pais,blank=True,null=False,on_delete=models.RESTRICT)
    duracion=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    tipo_puja=models.CharField(max_length=50)
    costo_cliente=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    costo_general=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    direccion=models.CharField(max_length=50)
    costo_envio=models.ForeignKey(Costo_envio,on_delete=models.CASCADE,null=True)

class Participante (models.Model):
    id=models.AutoField(primary_key=True)
    coleccionista=models.ForeignKey(Coleccionista, on_delete=models.CASCADE)
    subasta=models.ForeignKey(Subasta_Evento, on_delete=models.CASCADE)
    factura_inscripcion=models.ForeignKey(Factura, on_delete=models.CASCADE,related_name='inscripcion')
    factura_compra=models.ForeignKey(Factura, on_delete=models.CASCADE,related_name='compras')

class Articulo_Subasta (models.Model):
    id=models.AutoField(primary_key=True)
    ask=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    bid=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    minganancia=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    duracion_min=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    precio_alcanzado=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    ganador=models.ForeignKey(Participante,on_delete=models.RESTRICT)
    evento=models.ForeignKey(Subasta_Evento,on_delete=models.RESTRICT)
    moneda=models.ManyToManyField(Moneda,default=None, blank=True, null=True)
    pintura=models.ManyToManyField(Catalogo_Pintura,default=None, blank=True, null=True)

class Reglonfactura (models.Model):
    id=models.AutoField(primary_key=True)
    factura=models.ForeignKey(Factura,on_delete=models.CASCADE,null=False,blank=False)
    articulo=models.ForeignKey(Articulo_Subasta,on_delete=models.CASCADE,null=True)
    precio=models.DecimalField(max_digits=10,decimal_places=2,default=None, blank=True, null=True)
    descripcion=models.CharField(max_length=50,null=True)

