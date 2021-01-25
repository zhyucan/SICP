import urllib.request


log = print

shakespeare = urllib.request.urlopen('http://inst.eecs.berkeley.edu/~cs61a/fa11/shakespeare.txt')

words = set(shakespeare.read().decode().split())

x = {w for w in words if len(w) >= 5 and w[::-1] in words}


