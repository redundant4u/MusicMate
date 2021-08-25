from rest_framework import serializers
from .models import Song


class SongSeriallizer(serializers.ModelSerializer):
    class Meta:
        model = Song
        fields = ['name','artist','name','preview_url','albumart_url','album_name']