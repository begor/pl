#lang racket

(provide (all-defined-out))

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