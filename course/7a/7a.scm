;; Metacircular Evaluator 1

;; Eval is a "Universal Machine"

(define eval
  (λ (exp env)
    (cond ((number? exp) exp)                   ; 3 -> 3
          ((symbol? exp) (loolup exp env))      ; x -> 3 | car -> #[procedure]
          ((eq? (car exp) 'quote) (cadr exp))   ; 'foo -> (quote foo) -> foo
          ((eq? (car exp) 'lambda)
           (list 'closure (cdr exp) env))       ; (lambda (x) (+ x y)) -> (closure ((x) (+ x y)) <env>) 过程对象的内部表示
          ((eq? (car exp) 'cond)
           (evcond (cdr exp) env))              ; (cond (p1 e1) (p2 e2) ...)
          (else
            (apply (eval (car exp) env)
                   (evlist (cdr exp) env)))     ; (+ x 3)

;; the environment is a dictionary,
;; which maps the symbol names to their values.

;; the procedure is not the expression λ x,
;; that's the description of it, the textual description

;; not defined -- apply lookup evcond evlist

;; apply's job is to take a procedure
;; and apply it to its arguments
;; after both have been evaluated to
;; come up with a procedure and the arguments
;; rather the operator symbols and the operand symbols
;; whatever they are -- symbolic expressions

(define apply
  (λ (proc args)
    (cond ((primitive? proc)
           (apply-primop proc args))
          ((eq? (car proc) 'closure)
           (eval (cadadr proc)
                 (bind (caadr proc) args (caddr proc))))
          (else error))))

;; not defined -- primitive? apply-primop bind

(define evlist
  (λ (l env)
    (cond ((eq? l '()) '())
          (else
            (cons (eval (car l) env)
                  (evlist (cdr l) env))))))

(define evcond
  (λ (clauses env)
    (cond ((eq? clauses '()) '())
          ((eq? (caar clauses) 'else)
           (eval (cadar clauses) env))
          ((false? (eval (caar clauses) env))
           (evcond (cdr clauses) env))
          (else (eval (cadar clauses) env)))))

(define bind
  (λ (vars vals env)
    (cons (pair-up vars vals) env)))

(define pair-up
  (λ (vars vals)
    (cond
      ((eq? vars '())
       (cons ((eq? vals '()) '())
             (else (error TMA))))
      ((eq? vals '()) (error TFA))
      (else
        (cons (cons (car vars) (car vals))
              (pair-up (cdr vars) (cdr vals)))))))

(define lookup
  (λ (sym env)
    (cond ((eq? env '()) (error UBV))
          (else
            ((λ (vcell)
               (cond ((eq? vcell '())
                      (lookup sym (cdr env)))
                     (else (cdr vcell))))
             (assq sym (car env)))))))

(define assq
  (λ (sym alist)
    (cond ((eq? alist '()) '())
          ((eq? sym (car alist)) (car alist))
          (else
            (assq sym (cdr alist))))))


;; practice

(eval '(((λ (x) (λ (y) (+ x y))) 3) 4) <e0>)

; e0 --> +:.. *:.. -:.. /:.. car:.. cdr:.. cons:.. eq?:.. ......

(apply (eval '((λ (x) (λ (y) (+ x y))) 3) <e0>)
       (evlist '(4) <e0>))

(apply (eval '((λ (x) (λ (y) (+ x y))) 3) <e0>)
       (cons (eval 4 <e0>)
             (evlist '() <e0>)))

(apply (eval '((λ (x) (λ (y) (+ x y))) 3) <e0>)
       (cons 4 '()))

(apply (eval '((λ (x) (λ (y) (+ x y))) 3) <e0>)
       '(4))

(apply (apply (eval '(λ (x) (λ (y) (+ x y))) <e0>)
              (evlist '(3) <e0>))
       '(4))

(apply (apply (eval '(λ (x) (λ (y) (+ x y))) <e0>)
              '(3))
       '(4))

(apply (apply '(closure ((x) (λ (y) (+ x y))) <e0>)
              '(3))
       '(4))

(apply (eval '(λ (y) (+ x y))
             (bind '(x) '(3) <e0>))
       '(4))

(apply (eval '(λ (y) (+ x y)) <e1>)
       '(4))

; e1 --> x:3 -> e0

(apply '(closure ((y) (+ x y)) <e1>)
       '(4))

(eval '(+ x y)
      (bind '(y) '(4) <e1>))

(eval '(+ x y) <e2>)

; e2 --> y:4 -> e1

(apply (eval '+ <e2>)
       (evlist '(x y) <e2>))

(apply +.. '(3 4))

7


;; eval produces a procedure and arguments for apply
;; apply produces an expression and environment for eval


F = (λ (g)
      (λ (x n)
        (cond ((= n 0) 1)
              (else
                (* x (g x (- n 1)))))))

((λ (x) (x x)) (λ (x) (x x)))

;; Y -- Curry's Paradoxial Combinator of Y

Y = (λ (f)
      ((λ (x) (f (x x)))
       (λ (x) (f (x x)))))

(Y F) = ((λ (x) (F (x x)))
         (λ (x) (F (x x))))
      = (F ((λ (x) (F (x x)))
            (λ (x) (F (x x)))))

(Y F) = (F (Y F))

;; Y is a magical thing which, when applied to some function
;; produces the object which is the fixed point of that function

;; It's almost about time for you merit being made a member
;; of the grand recursive order of λ calculus hackers
