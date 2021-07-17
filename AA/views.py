from django.shortcuts import render
from django.http import HttpResponse
from .models import *
from .forms import *
import requests

from django.views.decorators.csrf import csrf_protect
# Create your views here.

@csrf_protect
def subastas(request):
    subastas=SubastaEvento.objects.all()
    participantes=Participante.objects.all()
    tiendas=Tienda.objects.all()
    if request.method =='GET':
        pass

    return render(request,'subastas.html',{'tiendas':tiendas,'subastas':subastas})

def welcome(request):

    return render(request,'menu.html',{})



def getTiendas():
    response = requests.get('http://localhost:4000/Tiendas',{})

    if response.status_code == 200:
        return response.json()

def getColeccionistas():
    response = requests.get('http://localhost:4000/coleccionistas',{})

    if response.status_code == 200:
        return response.json()



def getPais():
    response = requests.get('http://localhost:4000/Pais',{})

    if response.status_code == 200:
        return response.json()



def getCatalogoMoneda(params={}):
    pass

def getCatalogoPintura(params={}):
    print(params)
    response = requests.get('http://localhost:4000/catalogoPintura',{})

    if response.status_code == 200:
        return response.json()

def crearSubasta(params={}):
    response = requests.post('http://localhost:4000/crearSubasta',params)

    if response.status_code == 200:
        return response.json()

def getSubastasTiendas():
    response = requests.get('http://localhost:4000/subastas',{})

    if response.status_code == 200:
        return response.json()
@csrf_protect
def articuloSubasta(request,pinturas,monedas,subasta):
    pass


@csrf_protect
def crear_subasta(request):

    tiendas=getTiendas()
    coleccionistas=getColeccionistas()
    pais=getPais()
    if request.method== 'POST':
        params={
            "duracion" : float(request.POST.get('duracion')),
            "costo_inscripcion": float(request.POST.get('costo_inscripcion')),
            "costo_cliente": float(request.POST.get('costo_cliente')),
            "fecha": request.POST.get('fecha'),
            "tipo" :request.POST.get('tipo'),
            "tiendas": request.POST.getlist('nombre_tienda'),
            "coleccionistas": request.POST.getlist('nombre_coleccionita'),
            "pais": int(request.POST.getlist('nombre_pais')[0])
        }
        #crearSubasta(params)
        tiendas =request.POST.getlist('nombre_tienda')
        catalogosPinturas= getCatalogoPintura()
        catalogoMoneda=getCatalogoMoneda()
        monedas=[]
        pinturas=[]
        for pintura in catalogosPinturas:
            if str(pintura.get('tienda')) in params.get('tiendas'):
                pinturas.append(pintura)
        print(pinturas)

    return render(request,'crearSubasta.html',{'tiendas':tiendas,'coleccionistas':coleccionistas,'paises': pais})

def Tiendas(request):
    return render(request,'menu.html',{})

def subastas(request):
    subastas=getSubastasTiendas()
    if request.method == 'GET':
        pass
    return render(request,'subastas.html',{'subastas':subastas})

# Leave the rest of the views (detail, results, vote) unchanged
# Create your views here.

# def detail(request, question_id):
#     return HttpResponse("You're looking at question %s." % question_id)

# def results(request, question_id):
#     response = "You're looking at the results of question %s."
#     return HttpResponse(response % question_id)

# def vote(request, question_id):
#     return HttpResponse("You're voting on question %s." % question_id)
