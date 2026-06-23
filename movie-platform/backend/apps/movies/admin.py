from django.contrib import admin

from .models import Category, Movie, Cinema, Hall, Session


admin.site.register(Category)
admin.site.register(Movie)
admin.site.register(Cinema)
admin.site.register(Hall)
admin.site.register(Session)
