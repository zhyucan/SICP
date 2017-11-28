;; 1.1 程序设计的基本元素


;; 1.1.1 表达式

486
486

(+ 137 349)
486

(- 1000 334)
666

(* 5 99)
495

(/ 10 5)
2

(+ 2.7 10)
12.7

(+ 21 35 12 7)
75

(* 25 4 12)
1200

(+ (* 3 5) (- 10 6))
19

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
(+ (* 3
	    (+ (* 2 4)
	    	 (+ 3 5)))
   (+ (- 10 7)
   	  6))
57


;; 1.1.2 命名和环境

(define size 2)

size
2

(* 5 size)
10

(define pi 3.14159)

(define radius 10)

(* pi (* radius radius))
314.159

(define circumference (* 2 pi radius))

circumference
62.8318


;; 1.1.3 组合式的求值

(* (+ 2 (* 4 6))
	 (+ 3 5 7))


;; 1.1.4 复合过程

(define (square x) (* x x))

(define (<name> <formal parameters>) <body>)

(square 21)
441

(square (+ 2 5))
49

(square (square 3))
81

(define (sum-of-squares x y)
	(+ (square x) (square y)))

(sum-of-squares 3 4)
25

(define (f a)
	(sum-of-squares (+ a 1) (* a 2)))

(f 5)
136


;; 1.1.5 过程应用的代换模型

;; 应用序
(f 5)

(sum-of-squares (+ 5 1) (* 5 2))

(+ (square 6) (square 10))

(+ (* 6 6) (* 10 10))

(+ 36 100)

136

;; 正则序
(f 5)

(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) (square (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

(+ (* 6 6) (* 10 10))

(+ 36 100)

136


;; 1.1.6 条件表达式和谓词

(define (abs x)
	(cond ((> x 0) x)
		    ((= x 0) 0)
		    ((< x 0) (- x))))

(cond (<p1> <e1>)
	    (<p2> <e2>)
	    .
	    .
	    (<pn> <en>))

(define (abs x)
	(cond
		((< x 0) (- x))
		(else x)))

(define (abs x)
	((if (< x 0)
		(- x)
		x)))

(if <predicate> <consequent> <alternative>)

(and <e1> ... <en>)

(or <e1> ... <en>)

(not <e>)

(and (> x 5) (< x 10))

(define (>= x y)
	(or (> x y) (= x y)))

(define (>= x y)
	(not (< x y)))


;; 1.1.7 实例：采用牛顿法求平方根

√2 = ？

guess    quotient    average
1        2/1         (1 + 2/1) / 2 = 1.5
1.5      2/1.5       (1.5 + 2/1.5) / 2 = 1.4167
1.4167   2/1.4167    (1.4167 + 2/1.4167) / 2 = 1.4142
1.4142   ...         ...

(define (sqrt-iter guess x)
	(if (good-enough? guess x)
		  guess
		  (sqrt-iter (improve guess x) x)))

(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
	(sqrt-iter 1 x))


;; 过程作为黑箱抽象

(define (square x) (* x x))

(define (square x)
	(exp (double (log x))))

(define (double x) (+ x x))

(define (sqrt x)
	(define (good-enough? guess)
	  (< (abs (- (square guess) x)) 0.001))
	(define (improve guess)
	  (average guess (/ x guess)))
	(define (sqrt-iter guess)
		(if (good-enough? guess)
			  guess
			  (sqrt-iter (improve guess) x)))
	(sqrt-iter 1 x))