from operator import add, mul


def square(x):
    return mul(x, x)


def sum_square(x, y):
    return add(square(x), square(y))


sum_square(5, 12)
