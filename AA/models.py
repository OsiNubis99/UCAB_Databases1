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

class Moneda(models.Model):
    id=models.AutoField(primary_key=True)
    artistas=models.ManyToManyField(Artista,default=None, blank=True, null=True)
    divisa=models.ForeignKey(Divisa,on_delete=models.CASCADE)
    creada_en=models.ForeignKey(Pais,on_delete=models.CASCADE)

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
    alcance=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    telefono=models.CharField(max_length=50)

class Coleccionista (models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    nombre2=models.CharField(max_length=50,default=None, blank=True, null=True)
    apellido=models.CharField(max_length=50)
    apellido2=models.CharField(max_length=50)
    telefono=models.CharField(max_length=50)
    email=models.CharField(max_length=13)
    fecha_nacimiento=models.DateField()
    nacio=models.ForeignKey(Pais, on_delete=models.CASCADE)
    vive=models.ForeignKey(Pais, on_delete=models.CASCADE)

class Catalogo_Moneda(models.Model):
    num=models.AutoField(primary_key=True)

class Catalogo_Pintura(models.Model):
    num=models.AutoField(primary_key=True)
    titulo=models.CharField(max_length=50)
    year=models.CharField(max_length=50)
    estilo=models.CharField(max_length=50)
    size=models.CharField(max_length=50)
    artistas=models.ManyToManyField(Artista,default=None, blank=True, null=True)

class Cliente(models.Model):
    date_client=models.DateField(null=True, blank=True)

class Subasta_Evento(models.Model):
    tiendas=models.ManyToManyField(Tienda)
    pass

class Costo_envio (models.Model):
    id=models.AutoField(primary_key=True)
    pais=models.ForeignKey(Pais, on_delete=models.CASCADE)
    evento=models.ForeignKey(Subasta_Evento, on_delete=models.CASCADE)
    costo=models.IntegerField()
    extra=models.IntegerField(default=None, blank=True, null=True)
    recargo=models.IntegerField(default=None, blank=True, null=True)
    embalaje=models.IntegerField(default=None, blank=True, null=True)
    seguro=models.IntegerField(default=None, blank=True, null=True)

class Factura(models.Model):
    id=models.AutoField(primary_key=True)
    iva=models.IntegerField()

class Participante(models.Model):
    id=models.AutoField(primary_key=True)
    coleccionista=models.ForeignKey(Coleccionista, on_delete=models.CASCADE)
    subasta=models.ForeignKey(Subasta_Evento, on_delete=models.CASCADE)
    factura=models.ForeignKey(Factura, on_delete=models.CASCADE)

class Articulo_Subasta(models.Model):
    id=models.AutoField(primary_key=True)
    ask=models.IntegerField()
    bid=models.IntegerField(default=None, blank=True, null=True)
    minganancia=models.IntegerField(default=None, blank=True, null=True)
    duracion_min=models.IntegerField()
    precio_alcanzado=models.IntegerField()
    ganador=models.ForeignKey(Participante,on_delete=models.CASCADE)

class Reglonfactura(models.Model):
    id=models.AutoField(primary_key=True)
    factura=models.ForeignKey(Factura,on_delete=models.CASCADE)
    articulo=models.ForeignKey(Articulo_Subasta,on_delete=models.CASCADE)
    precio=models.IntegerField()
    descripcion=models.CharField(max_length=50)
