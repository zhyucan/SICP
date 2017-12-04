;; Pattern-matching: Rule-based Substitution

(define (deriv exp var)
  (cond ((constant? exp var) 0)
        ((same-var? exp var) 1)
        ((sum? exp)
         (make-sum (deriv (a1 exp) var)
                   (deriv (a2 exp) var)))
        ((product? exp)
         (make-sum
           (make-product (m1 exp) (deriv (m2 exp) var))
           (make-product (m2 exp) (deriv (m1 exp) var))))))

(define deriv-rules
  '())

(define dsimp (simplifier deriv-rules))
