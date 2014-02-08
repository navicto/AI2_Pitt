'''
Created on 21/09/2013

@author: Victor
'''
from django.db import models

class Patient(models.Model):
    mrn = models.IntegerField()
    pat_name = models.CharField(max_length = 50)
    gender = models.CharField(max_length = 1)
    dob = models.DateField()
    home_zip = models.IntegerField()
    class Meta:
        db_table = 'Patient'

class Encounter(models.Model):
    visit_number = models.IntegerField(primary_key = True)
    date = models.DateField()
    patient = models.ForeignKey(Patient)
    class Meta:
        db_table = 'Encounter'

class Lab_Event(models.Model):
    accession_no = models.IntegerField(primary_key = True)
    specimen_code = models.CharField(max_length = 10)
    collection_date = models.DateField()
    class Meta:
        db_table = 'Lab_Event'
    
class Orgnism(models.Model):
    organism_code = models.CharField(max_length = 10)
    lab_event_id = models.ForeignKey(Lab_Event)
    class Meta:
        db_table = 'Organism'

class Susceptibility(models.Model):
    drug_code = models.CharField(max_length = 10)
    value = models.CharField(max_length = 1)
    organism = models.ForeignKey(Orgnism)
    class Meta:
        db_table = 'Susceptibility'
    

