# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-06 20:29
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Note',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=1000)),
                ('body', models.TextField()),
                ('timestamp', models.DateTimeField(auto_now=True)),
            ],
        ),
    ]
