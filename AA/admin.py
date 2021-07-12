from django.contrib import admin
from .models import Articulo_Subasta
from .models import Artista
from .models import Catalogo_Moneda
from .models import Catalogo_Pintura
from .models import Cliente
from .models import Coleccionista
from .models import Contacto_tienda
from .models import Costo_envio
from .models import Divisa
from .models import Factura
from .models import Moneda
from .models import Pais
from .models import Participante
from .models import Reglonfactura
from .models import Subasta_Evento
from .models import Tienda

# Register your models here.

admin.site.register(Articulo_Subasta)
admin.site.register(Artista)
admin.site.register(Catalogo_Moneda)
admin.site.register(Catalogo_Pintura)
admin.site.register(Cliente)
admin.site.register(Coleccionista)
admin.site.register(Contacto_tienda)
admin.site.register(Costo_envio)
admin.site.register(Divisa)
admin.site.register(Factura)
admin.site.register(Moneda)
admin.site.register(Pais)
admin.site.register(Participante)
admin.site.register(Reglonfactura)
admin.site.register(Subasta_Evento)
admin.site.register(Tienda)
