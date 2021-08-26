import hashlib
import time

def getToken(id : int):
    hashInput = str(time.time()) +str(id)
    token = hashlib.sha256(hashInput.encode('utf-8'))
    return token.hexdigest()