from __future__ import unicode_literals

from django.db import models

# Create your models here.


class Note(models.Model):
    title = models.CharField(max_length=1000)
    body = models.TextField()
    timestamp = models.DateTimeField(auto_now=True)

    def __unicode__(self):
        return self.title
