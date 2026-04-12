from django.db import models

# Create your models here.

class ExpenseModel(models.Model):

    cost = models.IntegerField(default=0)
    name = models.CharField(max_length=255)
    desc = models.TextField(blank=True)
    datetime = models.DateTimeField(auto_now_add=True)
