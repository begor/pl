#lang racket

(provide (all-defined-out))

;; Definitions

(define x 3)

(define cube1
  (lambda (x)
    (* x x x)))

(define (cube2 x)
  (* x x x)) ; syntactic sugar for lambda

(define (pow1 x y)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y)))) ; with currying

(define three-to-the (pow2 3)) ; partial application

(define ((pow3 x) y) ; sugar for cyrring
  (if (= y 0)
      1
      (* x ((pow3 x) (- y 1)))))

;; Lists

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

(define (my-map fn xs)
  (if (null? xs)
      null
      (cons (fn (car xs)) (my-map fn (cdr xs)))))

;; Dynamic typing

(define xs
  (list 1 2 3 4 5 6))
(define ys
  (list 1 2 (list (list 3 4) 5) (list 6)))

; We can define a function that can take arbiraty nested list of [lists] ints.
(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs)
             (sum1 (cdr xs)))
          (+ (sum1 (car xs))
             (sum1 (cdr xs))))))

;; Cond
(define (sum2 xs)
  (cond [(null? xs) 0]
        [(number? (car xs))
         (+ (car xs) (sum2 (cdr xs)))]
        [#t
         (+ (sum2 (car xs)) (sum2 (cdr xs)))]))


;; Local bindings
(define (max-of-list xs)
  (cond [(null? xs) (error "max-of-list called with empty list")]
        [(null? (cdr xs)) (car xs)]
        [#t (let ([max-tl (max-of-list (cdr xs))])
              (if (> (car xs) max-tl)
                  (car xs)
                  max-tl))]))

(define (silly-double1 x)
  (let ([x (+ x 2)]
        [y (+ x 3)])
    (- (+ x y) 5)))

(define (silly-double2 x)
  (let* ([x (+ x 2)]
         [y (+ x 3)]) ; Previous bindings available in scope
    (- (+ x y) 8)))

(define (silly-triple x)
  (letrec ([y (+ x 2)] ; All (previous and proceeding) bindings are available, great for mutual recursion
           [doubler (lambda (z) (- (+ z y w) 5))]
           [w (+ x 3)])
    (doubler x)))

;; Module bindings

(define a 17)

(define (f x) (+ x a b)) ; Can use later bindings (b)

(define b 34)

(f 9)
