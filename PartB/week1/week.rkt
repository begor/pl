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

;; Pairs and lists

(define pair (cons 1 (cons 2 3))) ; this is a pair (or "unproper" list)
(define lst (cons 1 (cons 2 (cons 3 null)))) ; this is a "proper" list (notice null)
(define false (list? pair))
(define true (list? lst))


;; Mutable pairs

(define original (cons 14 null))
(define alias original)
(set! original (cons 42 null)) ; changes original to '(42), but doesn't affect alias.

(define mut-original (mcons 14 null))
(define mut-alias mut-original)
(set-mcar! mut-original 42) ; affects both original and alias


;; Delayed evaluation

(define (bad-if pred tb fb) ; Args to functions evaluated eagerly
  (if pred tb fb)) ; If branches evaluated if needed

(define (bad-fact x)
  (bad-if (= x 0)
          1
          (* x (bad-fact (- x 1))))) ; Never terminates because in order to call bad-if (function) we need to eval all the args

(define (strange-if pred x y)
  (if pred (x) (y))) ; Works because x and y must be 0-args functions, that return needed results

(define (strange-fact x)
  (strange-if (= x 0)
              (lambda () 1) ; Delayed evaluation - put expression in a function (closure). Such a function called "thunk".
              (lambda () (* x (strange-fact (- x 1)))))) ; Works too, because funcs doesn't evaluate its bodies until call


;; Lazy evaluation (aka promises)
;; Represented as an ADT, which is a one-of type:
;; either a thunk, or a result of evaluating it.

(define (delay thunk)
  (mcons #f thunk)) ; #f means that thunk hasn't been evaluated

(define (force thunk)
  (if (mcar thunk)
      (mcdr thunk)
      (begin
        (set-mcar! thunk #t) ; it will be evaluated
        (set-mcdr! thunk ((mcdr thunk)))
        (mcdr thunk))))

;; Streams

(define (number-until stream pred) ; how many elements of a stream should be proceeded until pred is true
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (pred (car pr))
                      ans
                      (f (cdr pr) (+ ans 1)))))])
    (f stream 1)))

(define ones
  (lambda ()
    (cons 1 ones))) ; Stream of ones (1 1 1 1 ... 1)

(define nats
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1)))) ; Streams of natural numbers (1 2 3 4 ...)

(define pow-of-two
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2)))) ; Streams of powers of two (2 4 8 16 ...)

; Abstracts creating of streams

(define (stream-maker fn arg)
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (fn x)))))])
    (lambda () (f arg))))

(define nats2 (stream-maker (lambda (x) (+ x 1)) 1)) 
(define pow-of-two2 (stream-maker (lambda (x) (* x 2)) 2))


;; Memoization

(define (bad-fibo n)
  (if (or (= n 1) (= n 2))
      1
      (+ (bad-fibo (- n 1))
         (bad-fibo (- n 2)))))

(define (fibo n)
  (letrec ([memo null]
           [f (lambda (x)
                (let ([ans (assoc x memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (if (or (= x 1) (= x 2))
                                         1
                                         (+ (f (- x 1)) (f (- x 2))))])
                        (begin
                          (set! memo (cons (cons x new-ans) memo))
                          new-ans)))))])
    (f n)))
                      