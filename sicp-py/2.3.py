log = print

# 序列
# 序列的行为: 长度 元素选择


# 实现序列抽象

# 序列表示是递归的 -> (第一个元素, 其余部分)
# (1, (2, (3, (4, None))))


# 递归列表 rlist 的实现
empty_rlist = None


def make_rlist(first, rest):
    return (first, rest)


def first(s):
    return s[0]


def rest(s):
    return s[1]


# 使用构造器和选择器操作递归列表 rlist
counts = make_rlist(1, make_rlist(2, make_rlist(3, make_rlist(4, empty_rlist))))

# log(first(counts))
#
# log(rest(counts))


# 实现序列的抽象

"""
def len_rlist(s):
    l = 0
    while 1:
        log(s, l)
        s = rest(s)
        l += 1
        if s == None:
            break
    return l
"""

def len_rlist(s):
    l = 0
    while s != None:
        s, l = rest(s), l + 1
    return l


def getitem_rlist(s, i):
    while i > 0:
        s, i = rest(s), i - 1
    return first(s)


# for _ in range(3):
#     print('abc')


"""
对前n个斐波那契数中的偶数求和

def fib(n):
    fis, sec = 0, 1
    while n > 1:
        fis, sec = sec, fis + sec
        n -= 1
    return fis


def iseven(n):
    return n % 2 == 0


sum(filter(iseven, map(fib, range(1, n+1))))

sum(fib(i) for i in range(1, n+1) if fib(i) % 2 == 0)
"""


"""
列出一个名称中的所有缩写字母，它包含每个大写单词的首字母
'University of California Berkeley'
('U', 'C', 'B')

def iscap(s):
    return s[0].isupper()


def first(s):
    return s[0]


def acronym(s):
    return tuple(map(first, filter(iscap, s.split())))


s = 'University of California Berkeley'
log(acronym(s))
"""
