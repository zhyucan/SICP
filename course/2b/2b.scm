;; Compound Data

for any x and y
(car (cons x y)) is x
(cdr (cons x y)) is y

(define (make-rat n d)
	(cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (cons a b)
	(λ (pick)
		(cond ((= pick 1) a)
			    ((= pick 2) b))))

(define (car x) (x 1))

(define (cdr x) (x 2))


