(define (A x y)
	(cond ((= y 0) 0)
		    ((= x 0) (* 2 y))
		    ((= y 1) 2)
		    (else (A (- x 1)
		    	       (A x (- y 1))))))

(A 1 10)
1024

(A 2 4)
65536

(A 3 3)
65536

(define (f n) (A 0 n))
   n  1 2 3 4  5  6  7
(f n) 2 4 6 8 10 12 14
; 2 * n

(define (g n) (A 1 n))
   n  1 2 3 4  5  6  7
(g n) 2 4 8 16 32 64 128
; 2 ^ n

(define (h n) (A 2 n))
   n  1 2  3  4  
(h n) 2 4 16 65536
