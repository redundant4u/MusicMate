from django.contrib import admin

# Register your models here.

from .models import Music, User, UserSong, Friend

admin.site.register(Music)
admin.site.register(User)
admin.site.register(UserSong)
admin.site.register(Friend)
