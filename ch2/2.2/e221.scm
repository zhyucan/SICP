(define (square-list items)
	(if (null? items)
		  nil
		  (cons (square (car items))
		  	    (square-list (cdr items)))))

(define (square x)
	(* x x))

(define (square-list items)
	(map (lambda (x) (* x x)) items))


(square-list (list 1 2 3 4))
(1 4 9 16)