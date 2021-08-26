from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User
from .serializers import SongSeriallizer
from rest_framework.parsers import JSONParser


# Create your views here.
@csrf_exempt
def idCheck(request):
    if request.method == 'GET':
        query_set = User.objects.all()
        serializer = User(query_set, many=True)
        return JsonResponse(serializer.data, safe=False)
