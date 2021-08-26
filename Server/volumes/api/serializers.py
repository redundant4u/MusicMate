from rest_framework import serializers
from .models import Song, User


class SongSeriallizer(serializers.ModelSerializer):
    class Meta:
        model = Song
        fields = ['name','artist','name','preview_url','albumart_url','album_name']

class UserSeriallizer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','name']