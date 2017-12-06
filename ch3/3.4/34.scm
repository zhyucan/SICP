;; 3.4 并发：时间是一个本质问题


;; 3.4.1 并发系统中时间的性质


;; 3.4.2 控制并发的机制

(parallel-execute <p1> <p2> ... <pk>)

(define x 10)

(parallel-execute (λ () (set! x (* x x)))
                  (λ () (set! x (+ x 1))))

(define x 10)

(define s (make-serializer))

(parallel-execute (s (λ () (set! x (* x x))))
                  (s (λ () (set! x (+ x 1)))))

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance) balance)
            (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch))
