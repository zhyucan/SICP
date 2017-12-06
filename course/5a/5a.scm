;; Assignment, State, & Side-effects

<before>

(se! <var> <value>)

<after>

;; functional
(define (fact n)
  (define (iter m i)
    (cond ((> i n) m)
          (else (iter (* i m) (+ i 1)))))
  (iter 1 1))

;; imperative
(define (fact n)
  (let ((i 1) (m 1))
    (define (loop)
      (cond ((> i n) m)
            (else
              (set! m (* i m))
              (set! i (+ i 1))
              (loop))))
      (loop)))

;; bound variables

; x, y
(λ (y) ((λ (x) (* x y)) 3))
<=>
(λ (y) ((λ (z) (* z y)) 3))

;; free variables

(λ (x) (* x y)) ; y

(λ (y) ((λ (x) (* x y)) 3)) ; *

(define make-counter
  (λ (n)
    (λ ()
      (set! n (+ 1 n))
      n)))

(define c1 (make-counter 0))

(define c2 (make-counter 10))

(c1)
1
(c2)
11
