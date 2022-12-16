from hashlib import md5
import itertools

input = "ckczppom"
foundRightHash = False

for i in itertools.count(start=0):
    hash = md5((input + str(i)).encode('utf-8')).hexdigest()
    hashString = str(hash)

    if hashString.startswith("000000"):
        print("Found hash: " + hashString + " with number: " + str(i))
        break


# hex()
# md5