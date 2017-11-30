;; 2.1 数据抽象导引


;; 2.1.1 实例：有理数的算数运算

(make-rat <n> <d>)
(number <x>)
(denom <x>)

(define x (cons 1 2))

(car x)
1

(cdr x)
2

(define x (cons 1 2))

(define y (cons 3 4))

(define z (cons x y))

(car (car z))
1

(car (cdr z))
3

(define (make-rat n d) (cons n d))

(define (number x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
	(newline)
	(display (number x))
	(display "/")
	(display (denom x)))

(define one-half (make-rat 1 2))

(print-rat one-half)
1/2

(define one-third (make-rat 1 3))

(print-rat (add-rat one-half one-third))
5/6

(print-rat (mul-rat one-half one-third))
1/6

(print-rat (add-rat one-third one-third))
6/9

(define (make-rat n d)
	(let ((g (gcd n d)))
		(cons (/ n g) (/ d g))))

(print-rat (add-rat one-third one-third))
2/3


;; 2.1.2 抽象屏障

add-rat | sub-rat | mul-rat | div-rat | equal-rat?

make-rat | numer | denom

cons car cdr


;; 2.1.3 数据意味着什么

(define (cons x y)
	(define (dispatch m)
		(cond ((= m 0) x)
			    ((= m 1) y)
			    (else (error "Argument not 0 or 1 -- CONS" m))))
	dispatch)

(define (car z) (z 0))

(define (cdr z) (z 1))


;; 2.1.4 扩展练习：区间算术

