;; Metacircular Evaluator - 2

;; a feature in Lisp

;; (λ (x · y))
;; x is required,
;; and many arguments, y will be the list of them

(λ (x . y)
  (map (λ (u) (* x u) y)))

(define pair-up
  (λ (vars vals)
    (cond
      ((eq? vars '())
       (cons ((eq? vals '()) '())
             (else (error TMA))))
      ((symbol? vars)
       (cons (cons vars vals) '()))
      ((eq? vals '()) (error TFA))
      (else
        (cons (cons (car vars) (car vals))
              (pair-up (cdr vars) (cdr vals)))))))

;; dynamic binding of variables
