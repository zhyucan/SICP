log = print

# 有理数的算术

# 有理数可精确表示为两整数之比

# 假定我们已知
# 如何使用分子和分母构造有理数  -- 构造器
# 如何从有理数中提取分子和分母  -- 选择器


# make_rat(n, d)    -- 构造器
# numer(x) denom(x) -- 选择器

# 先不管构造器和选择器如何实现
# 可以用它们执行有理数操作

def add_rat(x, y):
    nx, dx = numer(x), denom(x)
    ny, dy = numer(y), denom(y)

    return make_rat(nx * ny + ny * dx, dx * dy)


def mul_rat(x, y):
    nx, dx = numer(x), denom(x)
    ny, dy = numer(y), denom(y)

    return make_rat(nx * ny, dx * dy)


def eq_rat(x, y):
    nx, dx = numer(x), denom(x)
    ny, dy = numer(y), denom(y)

    return nx * dy == ny * dx


# 用元组作胶水实现构造器和选择器
# 进一步实现抽象数据类型
from operator import getitem


def make_rat(n, d):
    return (n, d)


def numer(x):
    return getitem(x, 0)


def denom(x):
    return getitem(x, 1)


def str_rat(x):
    return '{}/{}'.format(numer(x), denom(x))


half = make_rat(1, 2)
third = make_rat(1, 3)

str_rat(mul_rat(half, third))  # 1/6
str_rat(add_rat(third, third))  # 6/9


# 什么是数据抽象
# 实现构造器和选择器，并用它们操作数据

# 数据是什么不重要
# 重要的是如何创建和操作数据

# 抽象数据类型是构造器和选择器的集合

# 所谓数据，不过是函数的集合


