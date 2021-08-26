from django.db import models

class Song(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    artist = models.CharField(max_length=30, null=False)
    preview_url = models.URLField(max_length=200)
    albumart_url = models.URLField(max_length=200)
    album_name = models.CharField(max_length=30, null=False)

class loginToken(models.Model):
    token = models.CharField(max_length=20, primary_key=True)
    expired = models.BooleanField(null=False, default= True)
    expireDate = models.DateTimeField()

class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    nickName = models.CharField(max_length=30, null=False)
    password = models.CharField(max_length=50, null=False)
    encryptKey = models.CharField(max_length=50, null=False, default="abn3@f3vsdr-3")

    songs = models.ManyToManyField(
        Song,
        through='UserSong',
        through_fields=('user_id', 'song_id',)
    )
    tokenID = models.ForeignKey(loginToken, null = True, on_delete=models.SET_NULL)

class UserSong(models.Model):
    song_id = models.ForeignKey(Song, on_delete=models.CASCADE)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)

class Friend(models.Model):
    user_id   = models.ForeignKey(User, on_delete=models.CASCADE, related_name='myId')
    friend_id = models.ForeignKey(User, on_delete=models.CASCADE, related_name='friendId')
