(define (sqrt-iter guess x)
	(if (good-enough? guess (improve guess x))
		  (improve guess x)
		  (sqrt-iter (improve guess x) x)))

(define (sqrt-iter1 old-guess x)
  (let ((new-guess (improve old-guess x)))
    (if (good-enough? old-guess new-guess)
        new-guess
        (sqrt-iter1 new-guess x))))

(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? oldguess new-guess)
	(> 0.01
       (/ (abs (- new-guess old-guess))
          old-guess)))

(define (sqrt x)
	(sqrt-iter 1 x))