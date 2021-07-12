from django.db import models

# Create your models here.
class Pais (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    nacionalidad=models.CharField(max_length=50)

class Divisa (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    pais=models.ForeignKey(Pais,on_delete=models.CASCADE)

class Artista (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    apellido=models.CharField(max_length=50,default=None, blank=True, null=True)
    nombre_art=models.CharField(max_length=50,default=None, blank=True, null=True)

class Moneda (models.Model):
    id=models.AutoField(primary_key=True)
    artistas=models.ManyToManyField(Artista,default=None, blank=True, null=True)
    divisa=models.ForeignKey(Divisa,on_delete=models.CASCADE)
    creada_en=models.ForeignKey(Pais,on_delete=models.CASCADE)
    nombre=models.CharField(max_length=50)
    metal=models.CharField(max_length=50)
    forma=models.CharField(max_length=50)
    tamano=models.DecimalField()
    motivo=models.CharField(max_length=50)
    peso=models.DecimalField()
    anverso=models.CharField(max_length=50)
    reverso=models.CharField(max_length=50)
    denominacion=models.DecimalField()

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
    tienda=models.ForeignKey(Tienda, on_delete=models.CASCADE)
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
    nacio=models.ForeignKey(Pais, on_delete=models.CASCADE)
    vive=models.ForeignKey(Pais, on_delete=models.CASCADE)

class Catalogo_Moneda (models.Model):
    num=models.AutoField(primary_key=True)
    moneda=models.ManyToManyField(Moneda,default=None, blank=True, null=False)
    coleccionista=models.ManyToManyField(Coleccionista,default=None, blank=True, null=True)
    tienda=models.ManyToManyField(Tienda,default=None, blank=True, null=True)

class Catalogo_Pintura (models.Model):
    num=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50,null=False)
    year=models.CharField(max_length=50,null=False)
    estilo=models.CharField(max_length=50)
    size=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    artistas=models.ManyToManyField(Artista,default=None, blank=True, null=True)
    coleccionista=models.ManyToManyField(Coleccionista,default=None, blank=True, null=True)
    tienda=models.ManyToManyField(Tienda,default=None, blank=True, null=True)

class Cliente (models.Model):
    num=models.AutoField(primary_key=True)
    date_client=models.DateField(null=True, blank=True)
    num_coleccionista=models.ForeignKey(Coleccionista,on_delete=models.CASCADE,null=False)
    num_tienda=models.ForeignKey(Tienda,on_delete=models.CASCADE,blank=False,null=False)

class Costo_envio (models.Model):
    id=models.AutoField(primary_key=True)
    pais=models.ForeignKey(Pais, on_delete=models.CASCADE)
    costo=models.DecimalField(max_digits=None,decimal_places=None)
    extra=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    recargo=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    embalaje=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    seguro=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)

class Subasta_Evento (models.Model):
    id=models.AutoField(primary_key=True)
    tiendas=models.ManyToManyField(Tienda)
    lugar=models.ForeignKey(Pais,on_delete=models.CASCADE,blank=True,null=False)
    duracion=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    tipo_puja=models.CharField(max_length=50)
    costo_cliente=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    costo_general=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    direccion=models.CharField(max_length=50)
    costo_envio=models.ForeignKey(Costo_envio,on_delete=models.CASCADE,null=True)

class Factura (models.Model):
    id=models.AutoField(primary_key=True)
    iva=models.IntegerField()

class Participante (models.Model):
    id=models.AutoField(primary_key=True)
    coleccionista=models.ForeignKey(Coleccionista, on_delete=models.CASCADE)
    subasta=models.ForeignKey(Subasta_Evento, on_delete=models.CASCADE)
    factura_inscripcion=models.ForeignKey(Factura, on_delete=models.CASCADE)
    factura_compra=models.ForeignKey(Factura, on_delete=models.CASCADE)

class Articulo_Subasta (models.Model):
    id=models.AutoField(primary_key=True)
    ask=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    bid=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    minganancia=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    duracion_min=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    precio_alcanzado=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    ganador=models.ForeignKey(Participante,on_delete=models.CASCADE)
    evento=models.ForeignKey(Subasta_Evento,on_delete=models.CASCADE)

class Reglonfactura (models.Model):
    id=models.AutoField(primary_key=True)
    factura=models.ForeignKey(Factura,on_delete=models.CASCADE,null=False,blank=False)
    articulo=models.ForeignKey(Articulo_Subasta,on_delete=models.CASCADE,null=True)
    precio=models.DecimalField(max_digits=None,decimal_places=None,default=None, blank=True, null=True)
    descripcion=models.CharField(max_length=50,null=True)

