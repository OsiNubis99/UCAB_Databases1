from django.contrib import admin
from . import models

def crear_subasta(modeladmin,request,queryset):
    Subasta =models.Subasta_Evento()
    for tienda in queryset:
        print(tienda)

class Tienda_Admin(admin.StackedInline):
    model=models.Tienda

class Subasta_Admin(admin.StackedInline):
    model=models.Subasta_Evento

class Subasta_EventoAdmin(admin.ModelAdmin):
        list_display = ('id','costo_envio')

class TiendaAmin(admin.ModelAdmin):
    list_display = ('id', 'nombre','fecha_fundacion', 'alcance')
    list_filter=['nombre','fecha_fundacion']
    inlines=[
        Subasta_Admin,
    ]

class ArtiuloSubastaAdmin(admin.ModelAdmin):
    list_filter=['evento']

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
admin.site.register(models.Subasta_Evento,Subasta_EventoAdmin)
admin.site.register(models.Tienda,TiendaAmin)
