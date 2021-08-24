from django.db import models

class Song(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    artist = models.CharField(max_length=30, null=False)
    url = models.URLField(max_length=200)

class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    nick_name = models.CharField(max_length=30, null=False)
    password = models.CharField(max_length=50, null=False)
    songs = models.ManyToManyField(
        Song,
        through='UserSong',
        through_fields=('user_id', 'song_id',)
    )

class UserSong(models.Model):
    song_id = models.ForeignKey(Song, on_delete=models.CASCADE)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)