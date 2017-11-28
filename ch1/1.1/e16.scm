(define (new-if predicate then-clause else-clause)
	(cond (predicate then-clause)
		    (else else-clause)))

(define (sqrt-iter guess x)
	(new-if (good-enough? guess x)
		  guess
		  (sqrt-iter (improve guess x) x)))

(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
	(sqrt-iter 1 x))

;; 无限循环

(if #t (display "good") (display "bad"))
; good

(new-if #t (display "good") (display "bad"))
; goodbad


