from django.contrib import admin
from . import models
# Register your models here.


class TiendaAmin(admin.ModelAdmin):
    list_filter=['nombre','fecha_fundacion']


class ArtiuloSubastaAdmin(admin.ModelAdmin):
    list_filter=['evento']


def crear_subasta(modeladmin,request,queryset):
    pass

admin.site.register(models.Articulo_Subasta,ArtiuloSubastaAdmin)
admin.site.register(models.Artista)
admin.site.register(models.Catalogo_Moneda)
admin.site.register(models.Catalogo_Pintura)
admin.site.register(models.Cliente)
admin.site.register(models.Coleccionista)
admin.site.register(models.Contacto_tienda)
admin.site.register(models.Costo_envio)
admin.site.register(models.Divisa)
admin.site.register(models.Factura)
admin.site.register(models.Moneda)
admin.site.register(models.Pais)
admin.site.register(models.Participante)
admin.site.register(models.Reglonfactura)
admin.site.register(models.Subasta_Evento)
admin.site.register(models.Tienda,TiendaAmin)
