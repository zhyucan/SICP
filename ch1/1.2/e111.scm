(define (f n)
	(if (< n 3)
		  n
		  (+ (f (- n 1))
		  	 (* 2 (f (- n 2)))
		  	 (* 3 (f (- n 3))))))

(define (g n)
	(define (iter a b c i)
		(if (= i n)
			  c
			  (iter (+ a (* 2 b) (* 3 c)) a b (+ i 1))))
	(iter 2 1 0 0)))