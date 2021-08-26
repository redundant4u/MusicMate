from api.token import getToken, isValid, updateToken
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User, Friend
from .serializers import SongSeriallizer
from rest_framework.parsers import JSONParser
from .serializers import UserSeriallizer
from .aescipher import AESCipher
from api.key import Config
from datetime import timezone

import base64
import json
import requests
import datetime
import api.token

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
            result = dict()
            result['statusCode'] = 404
            result['status'] = 'Error'
            return JsonResponse(result, status = 404)
    else:
        result = dict()
        result['statusCode'] = 404
        result['status'] = 'Error'
        return JsonResponse(result, status = 404)

@csrf_exempt
def signUp(request):
    if request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            cipher = AESCipher()
            
            userQuery = User(name=data['name'], password = cipher.encrypt(data['password']).decode('utf-8'), nickName = data['nickName'], encryptKey=cipher.key)
            userQuery.token = getToken(userQuery.id)
            userQuery.expired = False
            userQuery.expireTime = datetime.datetime.now(timezone.utc) + datetime.timedelta(hours=1)
            userQuery.save()

            result = dict()
            result['statusCode'] = 200
            result['status'] = 'allow'
            result['key'] = userQuery.encryptKey
            result['token'] = userQuery.token
            return JsonResponse(result, status = 200)
        except Exception as e:
            result = dict()
            result['statusCode'] = 404
            result['status'] = 'error'
            return JsonResponse(result, status = 404)
    else:
        result = dict()
        result['statusCode'] = 404
        result['status'] = 'error'
        return JsonResponse(result, status = 404)

@csrf_exempt
def login(request):
    if request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            searchResult = User.objects.get(name=data['name'])
            cipher = AESCipher(searchResult.encryptKey)
            password = cipher.decrypt(searchResult.password.encode('utf-8'))
            password = password.decode('utf-8')
            if data['password'] == password:
                searchResult.token = getToken(searchResult.id)
                searchResult.expired = False
                searchResult.expireTime = datetime.datetime.now(timezone.utc) + datetime.timedelta(hours=1)
                searchResult.save()
                result = dict()
                result['statusCode'] = 200
                result['userToken'] = searchResult.token
                result['status'] = 'Success'
                return JsonResponse(result, status = 200)
            else:
                raise(User.DoesNotExist)
        except User.DoesNotExist as e:
            result = dict()
            result['statusCode'] = 404
            result['status'] = 'error'
            return JsonResponse(result, status = 404)
    else:
        result = dict()
        result['statusCode'] = 404
        result['status'] = 'error'
        return JsonResponse(result, status = 404)

@csrf_exempt
def searchUser(request):
    if request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            if isValid(data['userToken']):
                query_set = User.objects.filter(name__contains = data['userName'])
                friendList = []
                for friend in query_set:
                    info = dict()
                    info['name'] = friend.name
                    info['nickName'] = friend.nickName
                    friendList.append(info)
                result = dict()
                result['statusCode'] = 200
                result['status'] = "Success"
                result['items'] = friendList
                updateToken(data['userToken'])
                return JsonResponse(result, status = 200)
            else :
                result = dict()
                result['statusCode'] = 401
                result['status'] = 'Token-expired'
                return JsonResponse(result, status = 401)
        except Exception as e:
            result = dict()
            result['statusCode'] = 404
            result['status'] = 'error'
            return JsonResponse(result, status = 404)
    else:
        result = dict()
        result['statusCode'] = 404
        result['status'] = 'error'
        return JsonResponse(result, status = 404)

@csrf_exempt
def updateFriendList(request):
    if request.method == 'POST':
        if request.GET['method'] == 'add':
            try:
                data = JSONParser().parse(request)
                if isValid(data['userToken']):
                    userid = User.objects.get(token=data['userToken'])
                    friendid = User.objects.get(name=data['friendName'])
                    queryset = Friend(user_id=userid, friend_id = friendid)
                    queryset.save()
                    updateToken(data['userToken'])
                    result = dict()
                    result['statusCode'] = 200
                    result['status'] = 'Success'
                    return JsonResponse(result, status = 200)
                else:
                    result = dict()
                    result['statusCode'] = 401
                    result['status'] = 'Token-expired'
                    return JsonResponse(result, status = 401)
            except Exception as e:
                pass
    result = dict()
    result['statusCode'] = 404
    result['status'] = 'error'
    return JsonResponse(result, status = 404)

@csrf_exempt
def getFriendList(request):
    if request.method == 'POST':
        try:
            data = JSONParser().parse(request)
            if isValid(data['userToken']):
                query_set = Friend.objects.filter(user_id_id = User.objects.get(token=data['userToken']))
                items = []
                for friendIter in query_set:
                    friendInfo = dict()
                    friendInfo['name'] = friendIter.friend_id.name
                    friendInfo['nickName'] = friendIter.friend_id.nickName
                    items.append(friendInfo)
                updateToken(data['userToken'])
                result = dict()
                result['itemSize'] = items.__len__()
                result['statusCode'] = 200
                result['status'] = 'Success'
                result['items'] = items
                return JsonResponse(result, status = 200)
            else:
                result = dict()
                result['statusCode'] = 401
                result['status'] = 'Token-expired'
                return JsonResponse(result, status = 401)
        except Exception as e:
            pass
    result = dict()
    result['statusCode'] = 404
    result['status'] = 'error'
    return JsonResponse(result, status = 404)
# SPOTIFY API TOKEN 받기
def get_headers(client_id, client_secret):
    endpoint = 'https://accounts.spotify.com/api/token'

    encoded = base64.b64encode('{}:{}'.format(client_id,client_secret).encode('utf-8')).decode('ascii')
    headers = {'Authorization' : 'Basic {}'.format(encoded)}
    grant_type = {'grant_type' : 'client_credentials'}

    res = requests.post(endpoint, headers=headers, data=grant_type)
    raw = json.loads(res.text)
    access_token = raw['access_token']

    headers = {'Authorization' : 'Bearer {}'.format(access_token)}
    return headers


# @csrf_exempt
def searchMusic(request):
    # Spotify API 에서 검색 결과 받아오기
    endpoint = 'https://api.spotify.com/v1/search'
    spotify_token = get_headers(Config.CLIENT_KEY, Config.CLIENT_SECRET)
    params = {
        'q': request.GET['search'],
        'type': 'track',
        'limit': '1'
    }

    r = requests.get(endpoint,params=params,headers=spotify_token)
    raw = json.loads(r.text)

    # Json Filtering
    items = []
    for i in range(0,len(raw['tracks']['items'])):
        item = {
            'musicName': raw['tracks']['items'][i]['name'],
            'artist': raw['tracks']['items'][i]['artists'][0]['name'],
            'musicPreview': raw['tracks']['items'][i]['preview_url'],
            'albumArt': raw['tracks']['items'][i]['album']['images'][0]['url'],
            'albumName': raw['tracks']['items'][i]['album']['name']
        }
        items.append(item)

    # Result
    result = {
        'statusCode' : 200,
        'status': 'success',
        'items': items
    }

    return JsonResponse(result,status=200)