from django.shortcuts import render
from .models import *
from .forms import *
# Create your views here.


def subastas(request):
    subastas=Subasta_Evento.objects.all()



    evento_subastas=Subasta_Evento.objects.all()

    return render(request,'subastas.html',{})


def welcome(request):
    return render(request,'menu.html',{})


def crear_subasta(request):

    formSubasta= SubastaForm()

    return render(request,'registroEvento.html',{'form': formSubasta})

def Tiendas(request):


    return render(request,'menu.html',{})