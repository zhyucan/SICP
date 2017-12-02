;; Higher-order Procedures


(define (sum-int a b)
	(if (> a b)
		  0
		  (+ a (sum-int (+ 1 a) b))))

(define (sum-sq a b)
	(if (> a b)
		  0
		  (+ (square a) (sum-sq (+ 1 a) b))))

(define (pi-sum a b)
	(if (> a b)
		  0
		  (+ (/ 1 (* a (+ a 2)))
		  	 (pi-sum (+ a 4) b))))

(define (<name> a b)
	(if (> a b)
		  0
		  (+ (<term> a)
		  	 (<name> (<next> a) b))))

(define (sum term a next b)
	(if (> a b)
		  0
		  (+ (term a)
		  	 (sum term (next a) next b))))

(define (sum-int a b)
	(define (identity a) a)
	(sum identity a 1+ b)

(define (sum-sq a b)
	(sum square a 1+ b))

(define (pi-sum a b)
	(sum (λ (x) (/ 1 (* x (+ x 2))))
		   a
		   (λ (x) (+ x 4))
		   b))

(define (sum term a next)
	(define (iter j ans)
		(if (> j b)
			  ans
			  (iter (next j)
			  	    (+ (term j) ans))))
	(iter a 0))

(define (sqrt x)
	(define tolerance 0.00001)
	(define (good-enough? y)
		(< (abs (- (* y y) x)) tolerance))
	(define (improve y)
		(average (/ x y) y))
	(define (try y)
		(if (good-enough? y)
			  y
			  (try (improve y))))
	(try 1))

(define (sqrt x)
	(fixed-point (λ (y) (average (/ x y) y)) 1))

(define (fixed-point f start)
	(define (iter old new)
		(if (close-enough? (old new))
			  new
			  (iter new (f new))))
	(iter start (f start)))

(define (fixed-point f start)
	(define tolerance 0.00001)
	(define (close-enough? u v)
		(< (abs (- u v)) tolerance))
	(define (iter old new)
		(if (close-enough? old new)
			  new
			  (iter new (f new))))
	(iter start (f start))))

(define (sqrt x)
	(fixed-point
		(average-damp (λ (y) (/ x y)))
		1))

(define (average-damp f)
	(define (foo x)
		(average x (f x)))
	foo)

<=>

(define average-damp
	(λ (f)
		 (λ (x) (average x (f x)))))


;; Part 3

;; Procedures compute functions

to find a y such that f(y) = 0
start with a guess

y^2=x => y?

(define (sqrt x)
	(newton (λ (y) (- x (square y)))
		      1))

(define (newton f guess)
	(define df (deriv f))
	(fixed-point
		(λ (x) (- x (/ (f x) (df x))))
		guess))

(define deriv
	(λ (f)
		(λ (x)
			(/ (- (f (+ x dx)) (f x)) dx))))

(define dx 0.000001)