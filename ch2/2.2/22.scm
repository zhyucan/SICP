;; 2.2 层次性数据和闭包性质

(cons (cons 1 2) (cons 3 4))

(cons (cons 1 (cons 2 3)) 4)


;; 2.2.1 序列的表示

(car 1 (car 2 (car 3 (car 4 nil))))

(list 1 2 3 4)

(define one-through-four (list 1 2 3 4))

one-through-four
(1 2 3 4)

(car one-through-four)
1

(cdr one-through-four)
(2 3 4)

(car (cdr one-through-four))
2

(cons 10 one-through-four)
(10 1 2 3 4)

(cons 5 one-through-four)
(5 1 2 3 4)

(define (list-ref items n)
	(if (= n 0)
		  (car iterms)
		  (list-ref (cdr iterms) (- n 1))))

(define squares (list 1 4 9 16 25))

(list-ref squares 3)
16

(define (length items)
	(if (null? items)
		  0
		  (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))

(length odds)
4

(define (length items)
	(define (length-iter a count)
		(if (null? a)
			  count
			  (length-iter (cdr a) (+ 1 count))))
	(length-iter items 0))

(append squares odds)
(1 4 9 16 25 1 3 5 7)

(append odds squares)
(1 3 5 7 1 4 9 16 25)

(define (append list1 list2)
	(if (null? list1)
		  list2
		  (cons (car list1) (append (cdr list1) list2))))

;; 对表的映射

(define (scale-list items factor)
	(if (null? items)
		  nil
		  (cons (* (car items) factor)
		  	    (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 10)
(10 20 30 40 50)

#|
scheme 提供的 map

(map + (list 1 2 3) (list 40 50 60) (list 700 800 900))
(741 852 963)

(map (lambda (x y) (+ x (* 2 y)))
     (list 1 2 3)
     (list 4 5 6))
(9 12 15)
|#

(define (map proc items)
	(if (null? items)
		  nil
		  (cons (proc (car items))
		  	    (map proc (cdr items)))))

(map abs (list -10 2.5 -11.6 17))
(10 2.5 11.6 17)

(map (lambda (x) (* x x))
	   (list 1 2 3 4))
(1 4 8 16)

(define (scale-list items factor)
	(map (lambda (x) (* x factor)) items))


;; 层次性结构

(define x (cons (list 1 2) (list 3 4)))

(length x)
3

(count-leaves x)
4

(list x x)
(((1 2) 3 4) ((1 2) 3 4))

(length (list x x))
2

(count-leaves (list x x))
8

(define (count-leaves x)
	(cond ((null? x) 0)
		    ((not (pair? x)) 1)
		    (else (+ (count-leaves (car x)
		    	       (count-leaves (cdr x)))))))

(define (scale-tree tree factor)
	(cond ((null? tree) nil)
		    ((not (pair? tree)) (* tree factor))
		    (else (cons (scale-tree (car tree) factor)
		    	          (scale-tree (cdr tree) factor)))))

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
	          10)

(10 (20 (30 40) 50) (60 70))

(define (scale-tree tree factor)
	(map (lambda (sub-tree)
		     (if (pair? sub-tree)
		     	   (scale-tree sub-tree factor)
		     	   (* sub-tree factor)))
	     tree))


;; 序列作为一种约定的接口

(define (sum-odd-squares tree)
	(cond ((null? tree) nil)
		    ((not (pair? tree))
		     (if (odd? tree) (square tree) 0))
		    (else (+ (sum-odd-squares (car tree))
		     	       (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
	(define (next k)
		(if (> k n)
			  nil
			  (let ((f (fib k)))
			  	(if (even? f)
			  		  (cons f (next (+ k 1)))
			  		  (next (+ k 1))))))
	(next 0))

(map square (list 1 2 3 4 5))
(1 4 9 16 25)

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
      ((predicate (car sequence))
       (cons (car sequence) 
              (filter predicate (cdr sequence))))
      (else (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5))
(1 3 5)

(define (accumulate op initial sequence)
	(if (null? sequence)
		  initial
		  (op (car sequence)
		  	  (accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))
15

(accumulate * 1 (list 1 2 3 4 5))
120

(accumulate cons nil (list 1 2 3 4 5))
(1 2 3 4 5)

(define (enumerate-interval low high)
	(if (> low high)
		  nil
		  (cons low (enumerate-interval (+ low 1) high))))

(enumerate-interval 2 7)
(2 3 4 5 6 7)

(define (enumerate-tree tree)
	(cond ((null? tree) nil)
		    ((not (pair? tree)) (list tree))
		    (else (append (enumerate-tree (car tree))
		    	            (enumerate-tree (cdr tree))))))

(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
(1 2 3 4 5)

(define (sum-odd-squares tree)
	(accumulate +
		          0
		          (map square
		          	   (filter odd?
		          	   	       (enumerate-tree tree)))))

(define (even-fibs n)
	(accumulate cons
		          nil
		          (filter even?
		          	      (map fib
		          	      	   (enumerate-interval 0 n)))))

(define (list-fib-squares n)
	(accumulate cons
		          nil
		          (map square
		          	   (map fib
		          	   	    (enumerate-interval 0 n)))))

(list-fib-squares 10)
(0 1 1 4 9 25 64 169 441 1156 3025)

(define (product-of-squares-of-odd-elements sequence)
	(accumulate *
		          1
		          (map square
		          	   (filter odd? sequence))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))
225

(define (salary-of-highest-paid-pragrammer records)
	(accumulate max
		          0
		          (map salary
		          	   (filter programmer? records))))

;; 嵌套映射

(accumulate append
	          nil
	          (map (lambda (i)
	          	     (map (lambda (j) (list i j))
	          	     	    (enumerate-interval 1 (- i 1))))
	               (enumerate-interval 1 n)))

(define (flatmap proc seq)
	(accumulate append nil (map proc seq)))

(define (prime-sum? pair)
	(prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
	(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
	(map make-pair-sum
		   (filter prime-sum?
		   	       (flatmap
		   	       	(lambda (i)
		   	       		(map (lambda (j (list i j))
		   	       			   (enumerate-interval 1 (- i 1))))
		   	       	(enumerate-interval 1 n))))))

(define (permutations s)
	(if (null? s)
		  (list nil)
		  (flatmap (lambda (x)
		  	         (map (lambda (p) (cons x p))
		  	         	    (permutations (remove x s))))
		           s)))

(define (remove item sequence)
	(filter (lambda (x) (not (= x item)))
		      sequence))


;; 实例：一个图形语言

(define wave2 (beside wave (flip-vert wave)))
(define wave4 (below wave2 wave2))

(define (flipped-pairs painter)
	(let ((painter2 (beside painter (flip-vert painter))))
		(below painter2 painter2)))

(define wave4 (flipped-pairs wave))

(define (right-split painter n)
	(if (= n 0)
		  painter
		  (let ((smaller (right-split painter (- n 1))))
		  	(beside painter (below smaller smaller)))))

(right-split painter 1)

(beside painter (below (right-split painter 0)
		                   (right-split painter 0)))

(beside painter (below painter painter))

(define (corner-split painter n)
	(if (= n 0)
		  painter
		  (let ((up (up-split painter (- n 1)))
		  	    (right (right-split painter (- n 1))))
		    (let ((top-left (beside up up))
		    	    (bottom-right (below right right))
		    	    (corner (corner-split painter (- n 1))))
		      (beside (below painter top-left)
		      	      (below bottom-right corner))))))

(corner-split painter 1)

(beside (below painter
	             (beside (up-split painter 0)
	                     (up-split painter 0)))
        (below (below (right-split painter 0)
        	            (right-split painter 0))
               (corner-split painter 0)))

(beside (below painter (beside painter painter))
	      (below (below painter painter) painter))
