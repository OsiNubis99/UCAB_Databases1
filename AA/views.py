from django.shortcuts import render
from django.http import HttpResponse
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

def get_event(request):
    event = Subasta_Evento.objects.get(id=request)
    event.items = Articulo_Subasta.objects.get(evento=event.id)
    event.participantes = Participante.objects.get(subasta=event.id)
    return HttpResponse(event)

# Leave the rest of the views (detail, results, vote) unchanged
# Create your views here.

# def detail(request, question_id):
#     return HttpResponse("You're looking at question %s." % question_id)

# def results(request, question_id):
#     response = "You're looking at the results of question %s."
#     return HttpResponse(response % question_id)

# def vote(request, question_id):
#     return HttpResponse("You're voting on question %s." % question_id)
