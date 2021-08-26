import hashlib
from datetime import datetime, timezone, timedelta
import time
from .models import User

def getToken(id : int):
    hashInput = str(time.time()) +str(id)
    token = hashlib.sha256(hashInput.encode('utf-8'))
    return token.hexdigest()

def updateToken(token : str):
    try:
        query_set = User.objects.get(token=token)
        query_set.expireTime = datetime.now(timezone.utc) + timedelta(hours=1)
        query_set.save()
        return True
    except User.DoesNotExist as e:
        return False
    except Exception as e:
        print(e)
        return False
        
def isValid(token : str):
    try:
        query_set = User.objects.get(token=token)
        if (query_set.expireTime - datetime.now(timezone.utc)).total_seconds() > 0 :
            return True
        else :
            return False
    except User.DoesNotExist as e:
        return False
    except Exception as e:
        print(e)
        return False

# print(getToken(3))
updateToken('0b550bd9b7c04e57a7acdb0611c1d91e154493b66d3f04ebbd89143d2477d8e8')