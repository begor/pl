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