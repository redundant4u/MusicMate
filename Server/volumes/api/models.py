from django.db import models

class Music(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    artist = models.CharField(max_length=30, null=False)
    preview_url = models.URLField(max_length=200)
    albumart_url = models.URLField(max_length=200)
    album_name = models.CharField(max_length=30, null=False)


class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    nickName = models.CharField(max_length=30, null=False)
    password = models.CharField(max_length=50, null=False)
    encryptKey = models.CharField(max_length=50, null=False, default="abn3@f3vsdr-3")
    token = models.CharField(max_length=65, null=True)
    expired = models.BooleanField(null=False, default= True)
    expireTime = models.DateTimeField(null=True)

    songs = models.ManyToManyField(
        Music,
        through='UserSong',
        through_fields=('user_id', 'song_id',)
    )
    
class UserSong(models.Model):
    song_id = models.ForeignKey(Music, on_delete=models.CASCADE)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)

class Friend(models.Model):
    user_id   = models.ForeignKey(User, on_delete=models.CASCADE, related_name='myId')
    friend_id = models.ForeignKey(User, on_delete=models.CASCADE, related_name='friendId')
