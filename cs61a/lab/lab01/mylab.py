# !/usr/bin/env python
# -*- coding:utf-8 -*-

log = print


# def sum_digits(n):
#     l = len(str(n)) - 1
#     index = int('1' + l * '0')
#     s = 0
#     while index >= 1:
#         s += n // index
#         log(index, n, n // index)
#         n = n - n // index * index
#         index = index / 10
#     return int(s)
#
#
# log(sum_digits(1234567890))


# def falling(n, k):
#     if k == 0:
#         return 1
#     result = 1
#     for i in range(k):
#         result *= n - i
#     return result
#
#
# log(falling(4, 1))


# def double_eights(n):
#     s = str(n)
#     result = False
#     for i in range(len(s)):
#         if s[i:i+2] == '88':
#             return True
#     return result
#
#
# log(double_eights(80808080))

