'''
Created on 25/09/2013

@author: Victor
'''
from django.contrib import admin
from AI2_Databases.models import *

admin.site.register(Patient)
admin.site.register(Encounter)
admin.site.register(Lab_Event)
admin.site.register(Organism)
admin.site.register(Susceptibility)
