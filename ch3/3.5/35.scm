;; 3.5 流


;; 3.5.1 流作为延时的表

(define (sum-primes a b)
  (define (iter count accum)
    (cond ((> count b) accum)
          ((prime? count) (iter (+ count 1) (+ count accum)))
          (else (iter (+ count 1) accum))))
  (iter a 0))

(define (sum-primes a b)
  (accumulate +
              0
              (filter prime? (enumerate-interval a b))))

cons-stream
stream-car
stream-cdr
the-empty-stream
stream-null?

(stream-car (cons-stream x y)) = x
(stream-cdr (cons-stream x y)) = y

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(cons-stream <a> <b>)
<=>
(cons <a> (delay <b>))

(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

;; 计算从 10 000 到 1 000 000 的区间里第二个素数

;; 表
(car (cdr (filter prime?
                  (enumerate-interval 10000 1000000))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (filter pred sequence)
  (cond ((null? sequence) nil)
        ((pred (car sequence))
         (cons (car sequence)
               (filter pred (cdr sequence))))
        (else (filter pred (cdr sequence)))))

;; 流
(stream-car
  (stream-cdr
    (stream-filter prime?
                   (stream-enumerate-interval 10000 1000000))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
        low
        (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(delay <exp>)
<=>
(λ () <exp>)

(define (force delayed-object)
  (delayed-object))


;; 3.5.2 无穷流

;; 正整数流
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;; 所有不能被 7 整除的整数的流
(define (divisible? x y) (= (remainder x y) 0))

(define no-sevens
  (stream-filter (λ (x) (not (divisible? x 7)))
                 integers))

(stream-ref no-sevens 100)
117

;; 斐波拉契数的无穷流
(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))

(define fibs (fibgen 0 1))

;; 素数的无穷流
(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter
             (λ (x)
               (not (divisible? x (stream-car stream))))
             (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

(stream-ref primes 50)
233

;; 隐式定义流

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define integers (cons-stream 1 (add-streams ones integers)))

(define fibs
  (cons-stream 0 (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))


;; 3.5.3 流计算模式的使用


;; 3.5.4 流和延时求值


;; 3.5.5 函数式程序的模块化和对象的模块化
