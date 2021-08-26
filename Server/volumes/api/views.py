from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User
from .serializers import SongSeriallizer
from rest_framework.parsers import JSONParser
from .serializers import UserSeriallizer
from .aescipher import AESCipher

# Create your views here.
@csrf_exempt
def idCheck(request):
    if request.method == 'GET':
        id = request.GET['id']
        try:
            query_set = User.objects.get(name=id)
            result = dict()
            result['statusCode'] = 200
            result['status'] = 'Already Exist'
            return JsonResponse(result, status = 200)
        except User.DoesNotExist as e:
            result = dict()
            result['statusCode'] = 200
            result['status'] = 'Allow'
            return JsonResponse(result, status = 200)
        except Exception as e:
            result['statusCode'] = 404
            result['status'] = 'Error'
            return JsonResponse(result, status = 404)

@csrf_exempt
def signup(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        cipher = AESCipher()

        q = User(name=data['name'], password = cipher.encrypt(data['password']), nickName = data['nickName'], encryptKey=cipher.key)
        q.save()
        result = dict()
        result['statusCode'] = 404
        result['status'] = 'Error'
        return JsonResponse(result, status = 404)

# @csrf_exempt
# def searchUser(request):
#     if request.method == ''