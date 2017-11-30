
primitive elements

means of combination

means of abstraction

(define (square x) (* x x))
it's syntactic sugar for lambda

(define square (lambda (x) (* x x)))
lambda make a procedure

(define (average x y)
	(/ (+ x y) 2))

(define (mean-square x y)
	(average (square x) (square y)))

(define (abs x)
	(cond ((< x 0) (- x))
		    ((= x 0) 0)
		    ((> x 0) x)))

(define (abs x)
	(if (< x 0)
		  (- x)
		  x))

to find an approximation to √x
- make a guess g
- improve the guess by averaging a and x/g
- keep improving the guess until it is good enough
- use 1 as an initial guess

(define (try guess x)
	(if (good-enough? guess x)
		  guess
		  (try (improve guess x) x)))

(define (sqrt x)
	(try 1 x))

(define (improve guess x)
	(average guess (/ x guess)))

(define (good-enough? guess x)
	(< (abs (- (square guess) x))
		 0.001))

recursive definition

(define (sqrt x)
	(define (improve guess)
		(average guess (/ x guess)))
	(define (good-enough? guess)
		(< (abs (- (square guess) x))
			 0.001))
	(define (try guess)
		(if (good-enough? guess x)
			  guess
			  (try (improve guess x))))
	(try 1))

block structure

(define a (+ 5 5))
(define d (+ 5 5))
a -> 10
d -> compound procedure d
(d) -> 10
(a) -> error