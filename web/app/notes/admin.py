from django.contrib import admin

from notes.models import Note


class NoteAdmin(admin.ModelAdmin):
    pass
admin.site.register(Note, NoteAdmin)
