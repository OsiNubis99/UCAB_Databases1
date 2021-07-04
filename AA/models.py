from django.db import models

# Create your models here.

class Artista(models.Model):
    id=models.AutoField(primary_key=True)
    nombre=models.CharField(max_length=50)
    apellido=models.CharField(max_length=50)
    nombreart=models.CharField(max_length=50)

    
class Pintura(models.Model):
    pass

class Moneda(models.Model):
    pass

class Tienda(models.Model):
    pass

class Contacto_Organizacion(models.Model):
    pass

class Coleccionista(models.Model):
    pass

class Cliente(models.Model):
    pass

class Pais(models.Model):
    pass

class Participante(models.Model):
    pass

class Factura(models.Model):
    pass

class Reglonfactura(models.Model):
    pass

class Subasta_Tienda (models.Model):
    pass

class Subasta_Evento(models.Model):
    pass

class Articulo_Subasta(models.Model):
    pass