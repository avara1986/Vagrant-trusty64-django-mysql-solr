# -*- coding: utf-8 -*-
from django.conf.urls import url

from notes.views import notes

urlpatterns = [
    url(r'^$', notes, name='notes'),
]
