;; 3.1 赋值和局部状态


;; 3.1.1 局部状态变量

(withdraw 25)
75

(withdraw 25)
50

(withdraw 60)
"Insufficient funds"

(withdraw 15)
35

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

(set! <name> <new-value>)

(define new-withdraw
  (let ((balance 100))
    (λ (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

(define (make-withdraw balance)
  (λ (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds")))

(define w1 (make-withdraw 100))
(define w2 (make-withdraw 100))

(w1 50)
50

(w2 70)
30

(w2 40)
"Insufficient funds"

(w1 40)
10

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

(define acc (make-account 100))
((acc 'withdraw) 50)
50

((acc 'withdraw) 60)
"Insufficient funds"

((acc 'deposit) 40)
90

((acc 'withdraw) 60)
30


;; 3.1.2 引入赋值带来的利益

(define rand
  (let ((x random-init))
    (λ ()
      (set! x (rand-update x))
      x)))


;; 3.1.3 引进赋值的代价

(define (make-simplified-withdraw balance)
  (λ (amount)
    (set! balance (- balance amount))
    balance))

(define w (make-simplified-withdraw 25))

(w 20)
5

(w 10)
-5

(define (make-decrementer balance)
  (λ (amount)
    (- balance amount)))

(define d (make-decrementer 25))

(d 20)
5

(d 10)
15

((make-decrementer 25) 20)
((λ (amount) (- 25 amount)) 20)
(- 25 20)
5

((make-simplified-withdraw 25) 20)
((λ (amount) (set! balance (- 25 amount)) 25) 20)
(set! balance (- 25 20)) 25

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* product counter)
              (+ counter 1))))
  (iter 1 1))

(define (factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n)
          product
          (begin (set! product (* counter product))
                 (set! counter (+ counter 1))
                 (iter))))
    (iter)))
