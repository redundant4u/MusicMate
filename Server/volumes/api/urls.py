from django.contrib import admin
from django.urls import path
from api import views
urlpatterns = [
    path('idDuplicateCheck', views.idCheck),
    path('signUp', views.signUp),
    path('searchMusic', views.searchMusic)
]
