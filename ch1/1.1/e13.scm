(define (square x) (* x x))

(define (sum-of-squares x y)
	(+ (square x) (square y)))

(define (bigger a b)
	(if (>= a b) a b))

(define (smaller a b)
	(if (<= a b) a b))

(define (bigger-mum-of-squares a b c)
	(local ((define bigger (bigger a b))
		      (define another-bigger 
		      	(bigger (smaller a b) c)))
	  (sum-of-squares bigger another-bigger)))