from django.forms import ModelForm
from AA.models import Subasta_Evento

# Create the form class.
class SubastaForm(ModelForm):
    class Meta: 
        model = Subasta_Evento
        fields = '__all__'