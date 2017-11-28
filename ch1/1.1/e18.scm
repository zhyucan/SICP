(define (cube-root-iter old-guess x)
  (let ((new-guess (improve old-guess x)))
    (if (good-enough? old-guess new-guess)
        new-guess
        (cube-root-iter new-guess x))))

(define (improve guess x)
	(/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (good-enough? oldguess new-guess)
	(> 0.01
       (/ (abs (- new-guess old-guess))
          old-guess)))

(define (cube-root x)
    (cube-root-iter 1.0 x))