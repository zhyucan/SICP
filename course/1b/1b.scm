;; Procedures & Processes: Substitution Model

;; Part 1

(define (sos x y)
	(+ (sq x) (sq y)))

(define (sq x)
	(* x x))

(sos 3 4) => 25

kinds of expressions
numbers
symbols
λ expressions
definitions
conditionals
combinations

Substitution Rule
To evaluate an application
	Evaluate the operator to get procedure
	Evaluate the operands to get arguments
	Apply the procedure to the arguments
		Copy the body of the procedure
			substituting the arguments supplied
			for the formal parameters of the procedure
		Evaluate the resulting new body

(sos 3 4)
(+ (sq 3) (sq 4))
(+ (sq 3) (* 4 4))
(+ (sq 3) 16)
(+ (* 3 3) 16)
(+ 9 16)
25

;; Part 2

peano arithmetic

two ways to add whole numbers:

(define (+ x y)
	(if (= x 0)
		  y
		  (+ (-1 + x) (1 + y)))

(define (+ x y)
	(if (= x 0)
		  y
		  (1+ (+ (-1 + x) y))))

(+ 3 4)
(+ 2 5)
(+ 1 6)
(+ 0 7)
7

time = O(x)
space = O(1)

such a process is called a linear iteration

(+ 3 4)
(1+ (+ 2 4))
(1+ (1+ (+ 1 4)))
(1+ (1+ (1+ (0 4))))
(1+ (1+ (1+ 4)))
(1+ (1+ 5))
(1+ 6)
7

time = O(x)
space = O(x)

such a process is called a linear recursion

(define (fib n)
	(if (< n 2)
		  n
		  (+ (fib (- n 1)) (fib (- n 2)))))

(define (fib n)
	(define (iter a b n)
		(if (= n 0)
			  b
			  (iter b (+ a b) (- n 1))))
	(iter 0 1 n))