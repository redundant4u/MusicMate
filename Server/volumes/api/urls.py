from django.contrib import admin
from django.urls import path
from api import views
urlpatterns = [
    path('idDuplicateCheck', views.idCheck),
    path('signUp', views.signUp),
    path('login',views.login),
    path('searchMusic', views.searchMusic),
    path('searchUser', views.searchUser)
]
