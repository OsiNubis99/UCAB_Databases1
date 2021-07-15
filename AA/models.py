# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class ArticuloSubasta(models.Model):
    por_min_ganancia = models.DecimalField(max_digits=65535, decimal_places=65535)
    precio_alcanzado = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    duracion = models.DecimalField(max_digits=65535, decimal_places=65535)
    subasta = models.ForeignKey('SubastaEvento', models.CASCADE, db_column='subasta')
    comprador = models.ForeignKey('Participante', models.CASCADE, db_column='comprador', blank=True, null=True)
    reglon_factura = models.ForeignKey('ReglonFactura', models.CASCADE, db_column='reglon_factura', blank=True, null=True)
    moneda = models.ForeignKey('CatalogoMoneda', models.CASCADE, db_column='moneda', blank=True, null=True)
    pintura = models.ForeignKey('CatalogoPintura', models.CASCADE, db_column='pintura', blank=True, null=True)

    class Meta:
        db_table = 'AA_Articulo_Subasta'


class Artista(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)

    class Meta:
        db_table = 'AA_Artista'


class CatalogoMoneda(models.Model):
    moneda = models.ForeignKey('Moneda', models.CASCADE, db_column='moneda', blank=True, null=True)
    tienda = models.ForeignKey('Tienda', models.CASCADE, db_column='tienda', blank=True, null=True)
    coleccionista = models.ForeignKey('Coleccionista', models.CASCADE, db_column='coleccionista', blank=True, null=True)

    class Meta:
        db_table = 'AA_Catalogo_Moneda'


class CatalogoPintura(models.Model):
    nombre = models.CharField(max_length=50)
    fecha = models.CharField(max_length=10)
    estilo = models.CharField(max_length=50)
    size = models.CharField(max_length=50)
    artista = models.ForeignKey(Artista, models.CASCADE, db_column='artista')
    tienda = models.ForeignKey('Tienda', models.CASCADE, db_column='tienda', blank=True, null=True)
    coleccionista = models.ForeignKey('Coleccionista', models.CASCADE, db_column='coleccionista', blank=True, null=True)

    class Meta:
        db_table = 'AA_Catalogo_Pintura'


class Cliente(models.Model):
    coleccionista = models.ForeignKey('Coleccionista', models.CASCADE, db_column='coleccionista')
    tienda = models.ForeignKey('Tienda', models.CASCADE, db_column='tienda')
    fecha = models.DateField()

    class Meta:
        db_table = 'AA_Cliente'


class Coleccionista(models.Model):
    nombre = models.CharField(max_length=100)
    telefono = models.CharField(max_length=20)
    email = models.CharField(max_length=100)
    nacio = models.ForeignKey('Pais', models.CASCADE, db_column='nacio')
    vive = models.ForeignKey('Pais', models.CASCADE, db_column='vive')
    fecha_nacimiento = models.DateField()

    class Meta:
        db_table = 'AA_Coleccionista'


class ContactoTienda(models.Model):
    tienda = models.ForeignKey('Tienda', models.CASCADE, db_column='tienda')
    email = models.CharField(max_length=50)
    telefono = models.CharField(max_length=50)
    cargo = models.CharField(max_length=50)
    nombre = models.CharField(max_length=50)
    apellido = models.CharField(max_length=50)

    class Meta:
        db_table = 'AA_Contacto_Tienda'


class CostoEnvio(models.Model):
    costo = models.DecimalField(max_digits=65535, decimal_places=65535)
    embalaje = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    seguro = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    extra = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    pais = models.ForeignKey('Pais', models.CASCADE, db_column='pais')
    evento = models.ForeignKey('SubastaEvento', models.CASCADE, db_column='evento')

    class Meta:
        db_table = 'AA_Costo_Envio'


class Divisa(models.Model):
    nombre = models.CharField(max_length=50)
    pais = models.ForeignKey('Pais', models.CASCADE, db_column='pais')

    class Meta:
        db_table = 'AA_Divisa'


class Factura(models.Model):
    total = models.DecimalField(max_digits=65535, decimal_places=65535)
    fecha = models.DateField()
    participante = models.ForeignKey('Participante', models.CASCADE, db_column='participante')

    class Meta:
        db_table = 'AA_Factura'


class Moneda(models.Model):
    artista = models.ForeignKey(Artista, models.CASCADE, db_column='artista')
    divisa = models.ForeignKey(Divisa, models.CASCADE, db_column='divisa')
    creada_en = models.ForeignKey('Pais', models.CASCADE, db_column='creada_en')
    nombre = models.CharField(max_length=100)
    tamano = models.DecimalField(max_digits=65535, decimal_places=65535)
    metal = models.CharField(max_length=100)
    forma = models.CharField(max_length=100)
    motivo = models.CharField(max_length=100)
    peso = models.DecimalField(max_digits=65535, decimal_places=65535)
    anverso = models.CharField(max_length=100)
    reverso = models.CharField(max_length=100)
    denominacion = models.CharField(max_length=100)

    class Meta:
        db_table = 'AA_Moneda'


class Pais(models.Model):
    nombre = models.CharField(max_length=50)
    nacionalidad = models.CharField(max_length=50)

    class Meta:
        db_table = 'AA_Pais'


class Participante(models.Model):
    subasta = models.ForeignKey('SubastaEvento', models.CASCADE, db_column='subasta')
    coleccionista = models.ForeignKey(Coleccionista, models.CASCADE, db_column='coleccionista')
    factura = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'AA_Participante'


class ReglonFactura(models.Model):
    precio = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    factura = models.ForeignKey(Factura, models.CASCADE, db_column='factura')

    class Meta:
        db_table = 'AA_Reglon_Factura'


class SubastaEvento(models.Model):
    fecha = models.DateField()
    duracion = models.DecimalField(max_digits=65535, decimal_places=65535)
    costo_inscrip = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    costo_inscrip_cliente = models.DecimalField(max_digits=65535, decimal_places=65535)
    pais_lugar = models.ForeignKey(Pais, models.CASCADE, db_column='pais_lugar', blank=True, null=True)
    tipo = models.CharField(max_length=15)

    class Meta:
        db_table = 'AA_Subasta_Evento'


class Tienda(models.Model):
    nombre = models.CharField(max_length=50)
    fecha_fundacion = models.DateField()
    pagina = models.CharField(max_length=50, blank=True, null=True)
    proposito = models.CharField(max_length=100)
    alcance = models.CharField(max_length=50)
    tipo = models.CharField(max_length=15)

    class Meta:
        db_table = 'AA_Tienda'
