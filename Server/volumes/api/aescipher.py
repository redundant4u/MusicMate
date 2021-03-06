import base64
import random, string

from Crypto import Random
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
# pip install pycryptodome

BS = 16
pad = lambda s: s + (BS - len(s.encode('utf-8')) % BS) * chr(BS - len(s.encode('utf-8')) % BS)
unpad = lambda s : s[:-ord(s[len(s)-1:])]

class AESCipher:
    def __init__(self, key = ""):
        if key == "":
            for p in range(0, 32):
                key += random.choice(string.ascii_letters)
        self.key = key
    def encrypt( self, raw ):
        key = self.key.encode('utf-8')
        raw = pad(raw)
        iv = Random.new().read( AES.block_size )
        cipher = AES.new( key, AES.MODE_CBC, iv )
        return base64.b64encode( iv + cipher.encrypt( raw.encode('utf-8') ) )

    def decrypt( self, enc ):
        key = self.key.encode('utf-8')
        enc = base64.b64decode(enc)
        iv = enc[:16]
        cipher = AES.new(key, AES.MODE_CBC, iv )
        return unpad(cipher.decrypt( enc[16:] ))