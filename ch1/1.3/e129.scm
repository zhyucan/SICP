(define (sum term a next b)
	(if (> a b)
		  0
		  (+ (term a)
		  	 (sum term (next a) next b))))

(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(integral cube 0 1 0.01)
.24998750000000042

(integral cube 0 1 0.001)
.249999875000001


(define (integral f a b n)
	(* (/ h 3) (sum int-term a int-next b)))

(define h (/ (- b a) n))

(define (y k)
	(f (+ a (* k h))))

(define (factor k)
	(cond ((or (= k 0) (= k n)) 1)
		    ((even? k) 2)
		    ((odd? k) 4)))

(define (integral f a b n)
	(define h (/ (- b a) n))
	(define (y k)
		(f (+ a (* k h))))
	(define (factor k)
		(cond ((or (= k 0) (= k n)) 1)
			    ((even? k) 2)
			    ((odd? k) 4)))
	(define (term k)
		(* (factor k) (y k)))
	(define (next k)
		(+ k 1))
	(if (even? n)
		  (* (/ h 3) (sum term (exact->inexact 0)  next n)
		  (error "n can't be odd")))