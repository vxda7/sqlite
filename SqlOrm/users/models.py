from django.db import models

# Create your models here.
class User(models.Model):
    first_name = models.CharField(max_length=10)
    last_name = models.CharField(max_length=10)
    age = models.IntegerField()
    country = models.CharField(max_length=50)
    phone = models.CharField(max_length=30)
    balance = models.IntegerField()
