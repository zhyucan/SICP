# !/usr/bin/env python
# -*- coding:utf-8 -*-

log = print


# λa,x,b.ax+b
# the Greek letter lambda

# def λ(a, x, b):
#     return a * x + b
#
#
# log(λ(1, 2, 3))

# lambda a, x, b: a * x + b


# pure functions
# output depends only on input

# inpure functions
# side effects besides return
# hidden-variable

# f = min
# f = max
# g, h = min, max
# max = g
# log(max(f(2, g(h(1, 5), 3)), 4))
"""
假设 
min 指向的内存地址是 100
max 指向的内存地址是 001

f = min
f 指向 100

f = max
f 重新指向 001

g, h = min, max
g 指向 100, h 指向 001

max = g
max 重新指向 100
f h 指向 001 不变

btw 内存地址 --> memory address
"""

# log(min(max(2, min(max(1, 5), 3)), 4))


# x = 1
# y = x
# x = 2
# x, y = x + y, x
#
# log(x, y)

# x = 1
# y = x
# x = 2
# x = x + y
# y = x
#
# log(x, y)


def hmmmm(x):
    def f(x):
        return x

    return f


log(hmmmm(5)(6))
