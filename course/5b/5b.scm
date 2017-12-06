;; Computational Objects

(define (cons x y)
  (λ (m) (m x y)))

(define (car x)
  (x (λ (a d) a)))

  (define (cdr x)
    (x (λ (a d) d)))

(car (cons 35 47))
(car (λ (m) (m 35 47)))
((λ (m) (m 35 47)) (λ (a d) a))
((λ (a d) a) 35 37)
35

;; Alonzo Church

;; "Lambda Calculus" Mutable Data

(define (cons x y)
  (λ (m)
    (m x
       y
       (λ (n) (set! x n))
       (λ (n) (set! y n)))))

(define (car x)
  (x (λ (a d sa sd) a)))

(define (cdr x)
  (x (λ (a d sa sd) d)))

(define (set-car! x y)
  (x (λ (a d sa sd) (sa y))))

(define (set-cdr! x y)
  (x (λ (a d sa sd) (sd y))))
