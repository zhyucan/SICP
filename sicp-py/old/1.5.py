def percent_difference(x, y):
    difference = abs(x-y)
    return 100 * difference / x


def fib(n):
    pre, curr = 0, 1
    k = 2

    while k < n:
        pre, curr = curr, pre + curr
        k += 1

    return curr


def fib_test():
    assert fib(2) == 1, 'test 1'
    assert fib(3) == 1, 'test 2'
    assert fib(50) == 7778742049, 'test 3'


fib_test()
