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
    def __str__(self):
        return '%s %s' %(self.mrn, self.pat_name)

class Encounter(models.Model):
    visit_number = models.AutoField(primary_key = True)
    date = models.DateField()
    patient = models.ForeignKey(Patient)
    class Meta:
        db_table = 'Encounter'
    def __str__(self):
        return '%s %s' %(self.visit_number, self.patient)

class Lab_Event(models.Model):
    accession_no = models.AutoField(primary_key = True)
    specimen_code = models.CharField(max_length = 10)
    collection_date = models.DateField()
    encounter = models.ForeignKey(Encounter)
    class Meta:
        db_table = 'Lab_Event'
    def __str__(self):
        return '%s %s' %(self.accession_no, self.specimen_code)
    
class Organism(models.Model):
    organism_code = models.CharField(max_length = 10)
    lab_event = models.ForeignKey(Lab_Event)
    class Meta:
        db_table = 'Organism'
    def __str__(self):
        return '%s %s %s' %(self.id, self.organism_code, self.lab_event_id)

class Susceptibility(models.Model):
    drug_code = models.CharField(max_length = 10)
    value = models.CharField(max_length = 1)
    organism = models.ForeignKey(Organism)
    class Meta:
        db_table = 'Susceptibility'
    def __str__(self):
        return '%s %s %s %s' %(self.id, self.drug_code, self.value, self.organism)
    

