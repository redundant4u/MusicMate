from django.contrib import admin
from django.urls import path
from api import views
urlpatterns = [
    path('admin/', admin.site.urls),
    path('idDuplicateCheck',views.idCheck),
    path('signup',views.signUp),
    path('searchMusic',views.searchMusic),
    path('addMusic',views.addMusic),
    path('deleteMusic',views.deleteMusic),
    path('getMusicList',views.getMusicList),
]
