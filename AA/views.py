from django.shortcuts import render

# Create your views here.


def subastas(request):
    return render(request,'./templates/subastas.html',{})
