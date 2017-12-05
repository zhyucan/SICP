;; 3.2 求值的环境模型


;; 3.2.1 求值规则

(define (square x)
  (* x x))

(define square
  (λ (x) (* x x)))


;; 3.2.2 简单过程的应用

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))


;; 3.2.3 将框架看作局部状态的展台

(define (make-withdraw balance)
  (λ (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds")))

(define w1 (make-withdraw 100))

(w1 50)
50


;; 3.2.4 内部定义

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
