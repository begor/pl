#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; 1
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

; 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let* ([l (length xs)]
                   [rem (remainder l n)])
              (car (list-tail xs (+ rem 1))))]))

; 4
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([cur (s)])
        (cons (car cur)
              (stream-for-n-steps (cdr cur) (- n 1))))))

; 5
(define (funny-number-stream)
  (letrec ([f (lambda (x)
                (if (= (remainder x 5) 0)
                    (cons (- 0 x) (lambda () (f (+ x 1))))
                    (cons x (lambda () (f (+ x 1))))))])
    (f 1)))

; 6
(define (dan-then-dog)
  (letrec ([f (lambda (x)
                (let ([next (if (equal? x "dan.jpg")
                                "dog.jpg"
                                "dan.jpg")])
                  (cons x (lambda () (f next)))))])
    (f "dan.jpg")))

; 7
(define (stream-add-zero s)
  (lambda ()
    (let ([next (s)])
      (cons (cons 0 (car next))
            (stream-add-zero (cdr next))))))