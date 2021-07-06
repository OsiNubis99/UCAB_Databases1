from django.db import models

# Create your models here.

class Artista(models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    apellido=models.CharField(max_length=50)
    nombreart=models.CharField(max_length=50)

class Pintura(models.Model):
    artistas=models.ManyToManyField(Artista)

class Moneda(models.Model):
    artistas=models.ManyToManyField(Artista)

class Pais(models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    nacionalidad=models.CharField(max_length=50)

class Tienda(models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    pagina=models.CharField(max_length=50)
    proposito=models.CharField(max_length=100)
    alcance=models.CharField(max_length=50)
    tipos=[
        ('Antiguedades','antiguedades'),
        ('Galeria','galeria'),
        ('Numismatica','numismatica')

    ]
    tipo=models.CharField(max_length=70,choices=tipos)
    lugar=models.ForeignKey(Pais, on_delete=models.CASCADE)

class Contacto_Organizacion(models.Model):
    id=models.AutoField(primary_key=True)
    lugar=models.ForeignKey(Tienda, on_delete=models.CASCADE)
    cargo=models.CharField(max_length=50)
    nombre=models.CharField(max_length=20)
    apellido=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    telefonoid=models.CharField(max_length=50)

class Coleccionista(models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    telefonoid=models.CharField(max_length=50)
    email=models.CharField(max_length=13)
    lugar=models.ForeignKey(Pais, on_delete=models.CASCADE)

class Cliente(models.Model):
    date_client=models.DateField(null=True, blank=True)

class Subasta_Tienda(models.Model):
    pass

class Subasta_Evento(models.Model):
    pass

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
    bid=models.IntegerField()
    por_ganancia=models.IntegerField()
    precio_alcanzado=models.IntegerField()
    duracion_min=models.IntegerField()

class Reglonfactura(models.Model):
    id=models.AutoField(primary_key=True)
    factura=models.ForeignKey(Factura,on_delete=models.CASCADE)
    articulo=models.ForeignKey(Articulo_Subasta,on_delete=models.CASCADE)
    precio=models.IntegerField()
    descripcion=models.CharField(max_length=50)
