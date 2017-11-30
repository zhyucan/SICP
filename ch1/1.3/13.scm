;; 用高阶函数做抽象


;; 1.3.1 过程作为参数

(define (sum-integers a b)
	(if (> a b)
		  0
		  (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
	(if (> a b)
		  0
		  (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
	(if (> a b)
		  0
		  (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

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

(define (cube n) (* n n n))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
	(sum cube a inc b))

(sum-cubes 1 10)
3025

(define (identity x) x)
(define (sum-integers a b)
	(sum identity a inc b))

(sum-integers 1 10)
55

(defien (pi-sum a b)
	(define (pi-term x)
		(/ 1.0 (* x (+ x 2))))
	(define (pi-next x)
		(+ x 4))
	(sum pi-term a pi-next b))

(* 8 (pi-sum 1 1000))
3.139592655589783

(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(integral cube 0 1 0.01)
.24998750000000042

(integral cube 0 1 0.001)
.249999875000001

x^3 在 [0, 1] 积分的精确值是 1/4


;; 1.3.2 用 lambda 构造过程

(lambda (x) (+ x 4))

(lambda (x) (/ 1.0 (* x (+ x 2))))

(define (pi-sum a b)
	(sum (lambda (x) (/ 1.0 (* x (+ x 2))))
		   a
		   (lambda (x) (+ x 4))
		   b))

(define (integral f a b dx)
	(* (sum f
		      (+ a (/ dx 2.0))
		      (lambda (x) (+ x dx))
		      b)
	   dx))

(lambda (<formal-parameters>) <body>)

(define (plus4 x) (+ x 4))

<=>

(define plus4 (lambda (x) (+ x 4)))

((lambda (x y z) (+ x y (square z))) 1 2 3)
12

f(x, y) = x(1 + xy)^2 + y(1 - y) + (1 + xy)(1 - y)

a = 1 + xy
b = 1 - y
f(x, y) = xa^2 + yb + ab

(define (f x y)
	(define (f-helper a b)
		(+ (* x (square a))
			 (* y b)
			 (* a b)))
	(f-helper (+ 1 (* x y)) (- 1 y)))

(define (f x y)
	(define a (+ 1 (* x y)))
	(define b (- 1 y))
	(+ (* x (square a))
	  	 (* y b)
	  	 (* a b)))

(define (f x y)
	((lambda (a b)
		(+ (* x (square a))
			 (* y b)
			 (* a b)))
	 (+ 1 (* x y)) (- 1 y)))

(define (f x y)
	(let ((a (+ 1 (* x y)))
		    (b (- 1 y)))
	  (+ (* x (square a))
	  	 (* y b)
	  	 (* a b))))


(let ((<var1> <exp1>)
	    (<var2> <exp2>)
	    .
	    .
	    (<varn> <expn>))
  <body>)

<=>

((lambda (<var1> ... <varn>) <body>)
 <exp1>
 .
 .
 <expn>)

(+ (let ((x 3))
	   (+ x (* x 10)))
   x)

x = 5
(+ 33 5)
38

(let ((x 3)
	    (y (+ x 2)))
	(* x y))

x = 2
(* 3 4)
12


;; 1.3.3 过程作为一般性的方法

;; 零点

(define (search f neg-point pos-point)
	((let ((midpoint (average neg-point pos-point)))
		(if (close-enough? neg-point pos-point)
			  midpoint
			  (let ((test-value (f midpoint)))
			  	(cond ((positive? test-value)
			  		     (search f neg-point midpoint))
			  	      ((negative? test-value)
			  	       (search f midpoint pos-point))
			  	      (else midpoint)))))))

(define (close-enough? x y)
	(< (abs (- x y)) 0.001))

(define (half-interval-method f a b)
	(let ((a-value (f a))
		    (b-value (f b)))
	  (cond ((and (negative? a-value) (positive? b-value))
	  	     (search f a b))
	        ((and (negative? b-value) (positive? a-value))
	  	     (search f b a))
	        (else
	        	(error "Values are not of opposite sign" a b)))))

sin x = 0 in [2, 4]
(half-interval-method sin 2.0 4.0)

x^3 - 2x - 3 = 0 in [1, 2]
(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
	                     1.0
	                     2.0)

;; 不动点

f(x) = x

(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				  next
				  (try next))))
	(try first-guess))

cos x = x
(fixed-point cos 1.0)

sin x + cos x = x
(fixed-point (lambda (x) (+ (sin x) (cos x)))
	           1.0)

y = x / y
(define (sqrt x)
	(fixed-point (lambda (y) (average x (/ x y))) 1.0))


;; 1.3.4 过程作为返回值

(define (average-damp f)
	(lambda (x) (average x (f x))))

((average-damp square) 10)
55

(define (sqrt x)
	(fixed-point (average-damp (lambda (y) (average x (/ x y))))
		           1.0))

(define (deriv g)
	(lambda (x)
		(/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (cube x) (* x x x))

((deriv cube) 5)
75

(define (newton-transform g)
	(lambda (x)
		(- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
	(fixed-point (newton-transform g) guess))

(define (sqrt x)
	(newtons-method (lambda (y) (- (square y) x)) 1.0))