from django.urls import path

from . import views

urlpatterns = [
    # ex: /AA/
    path('', views.index, name='index'),
    # ex: /AA/event/0/
    path('event/<int:event_id>/', views.detail, name='get_event'),
]
