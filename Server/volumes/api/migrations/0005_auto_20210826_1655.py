# Generated by Django 3.2.6 on 2021-08-26 07:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_alter_logintoken_token'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='tokenID',
        ),
        migrations.AddField(
            model_name='user',
            name='expireTime',
            field=models.DateTimeField(null=True),
        ),
        migrations.AddField(
            model_name='user',
            name='expired',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='user',
            name='token',
            field=models.CharField(max_length=65, null=True),
        ),
        migrations.DeleteModel(
            name='loginToken',
        ),
    ]
