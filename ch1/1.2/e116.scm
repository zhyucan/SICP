(define (fast-expt b n)
	(define (iter b n a)
		(cond ((= n 0)
			     0
			     a)
		      ((even? n)
		      	(iter (square b) (/ n 2) a))
		      ((odd? n)
		      	(iter b (- n 1) (* b a)))))
	(iter b n 1))

(iter 10 5 1)
(iter 10 4 10)
(iter 100 2 10)
(iter 10000 1 10)
(iter 10000 0 100000)
100000