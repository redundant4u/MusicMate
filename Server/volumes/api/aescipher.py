import base64
from Crypto import Random
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes

# pip install pycryptodome
BS = 16
pad = lambda s: s + (BS - len(s.encode('utf-8')) % BS) * chr(BS - len(s.encode('utf-8')) % BS)
unpad = lambda s : s[:-ord(s[len(s)-1:])]

class AESCipher:
    def __init__(self):
        self.key = get_random_bytes(16)

    def encrypt( self, raw ):
        raw = pad(raw)
        iv = Random.new().read( AES.block_size )
        cipher = AES.new( self.key, AES.MODE_CBC, iv )
        return base64.b64encode( iv + cipher.encrypt( raw.encode('utf-8') ) )

    def decrypt( self, enc ):
        enc = base64.b64decode(enc)
        iv = enc[:16]
        cipher = AES.new(self.key, AES.MODE_CBC, iv )
        return unpad(cipher.decrypt( enc[16:] ))

data = "Iran has seized a foreign oil tanker in the Persian Gulf that was smuggling fuel to some Arab states, according to a state television report on Sunday. The report said that the tanker had been detained and the ship's foreign crew held by the country's elite Islamic Revolutionary Guards Corps."

a = AESCipher()
b = a.encrypt(data)
print(a.key)
c = a.decrypt(b)
c = c.decode('utf-8')