# 高阶函数
log = print


def sum_naturals(n):
    total, k = 0, 1
    while k <= n:
        total, k = total + k, k + 1
    return total


def sum_cubes(n):
    total, k = 0, 1
    while k <= n:
        total, k = total + pow(k, 3), k + 1
    return total


def pi_sum(n):
    total, k = 0, 1
    while k <= n:
        total, k = total + 8 / (k * (k + 2)), k + 4
    return total


def summation(n, term, next):
    total, k = 0, 1
    while k <= n:
        total, k = total + term(k), next(k)
    return total


def pi_term(k):
    return 8 / k * (k + 2)


def successor(k):
    return k + 4


def pi_sum1(n):
    return summation(n, pi_term, successor)


def iter_improve(update, test, guess=1):
    while not test(guess):
        guess = update(guess)
    return guess


def compose1(f, g):
    return lambda x: f(g(x))


compose2 = lambda f, g: lambda x: f(g(x))


def trace1(fn):
    def wrapped(x):
        log('abc', fn)
        return fn(x)
    return wrapped


@trace1
def triple(x):
    return 3 * x


# triple(x)

# trace1(triple)(x)

# wrapped(x)

# log()
# triple(x)
