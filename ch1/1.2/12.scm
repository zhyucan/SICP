;; 1.2 过程与它们所产生的计算


;; 1.2.1 线性的递归和迭代

n! = n·(n-1)·(n-2)···3·2·1

n! = n·[(n-1)·(n-2)···3·2·1] = n·(n-1)!

(define (factorial n)
	(if (= n 1)
		  1
		  (* n (factorial (- n 1)))))	

(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720

(define (factorial n)
	(define (iter product counter)
		(if (> counter n)
			  product
			  (iter (* counter product) 
			  	    (+ counter 1))))
	(iter 1 1))

(factorial 6)
(fact-iter   1 1 6)
(fact-iter   1 2 6)
(fact-iter   2 3 6)
(fact-iter   6 4 6)
(fact-iter  24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720

;; 在 Scheme 中，迭代计算过程都是尾递归的
;; 其他语言里，用递归过程实现的迭代计算过程不是尾递归，
;; 必须借助 for, while..


;; 1.2.2 树形递归

(define (fib n)
	(cond ((= n 0) 0)
		    ((= n 1) 1)
		    (else (+ (fib (- n 1))
		    	       (fib (- n 2))))))

(define (fib n)
	(define (iter a b n)
		(if (= n 0)
			  b
			  (iter (+ a b) a (- n 1))))
	(iter 1 0 n))

(define (fib n)
	(define (iter a b counter)
		(if (= counter n)
			  b
			  (iter (+ a b) a) (+ counter 1)))
	(iter 1 0 0))


;; 1.2.3 增长的阶		

O(1) < O(log n) < O(n) < O(n log n) < O(n^2) < O(n^3) < ... < O(2^n) <


;; 1.2.4 求幂

;; Θ(n) | Θ(n)
(define (expt b n)
	(if (= n 0)
		  1
		  (* b (expt b (- n 1)))))

;; Θ(n) | Θ(1)
(define (expt b n)
	(define (iter product n)
		(if (= n 0)
			  product
			  (iter (* b product) (- n 1))))
	(iter 1 n))

;; Θ(log n) | Θ(log n)
(define (fast-expt b n)
	(cond ((= n 0) 1)
		    ((even? n) (square (fast-expt b (/ n 2))))
		    (else (* b (fast-expt b (- n 1))))))

(define (even? n)
	(= (remainder n 2) 0))


;; 1.2.5 最大公约数

(define (gcd a b)
	(if (= b 0)
		  a
		  (gcd b (remainder a b))))


;; 1.2.6 实例：素数检测

(define (smallest-divisor n)
	(find-divisor n 2))

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		    ((divides? test-divisor n) test-divisor)
		    (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
	(= (remainder b a) 0))

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		    ((even? exp)
		    	(remainder (square (expmod base (/ exp 2) m)) 
		    		         m))
		    (else
		    	(remainder (* base (expmod base (- exp 1) m)) 
		    		         m))))









