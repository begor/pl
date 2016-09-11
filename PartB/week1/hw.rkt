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
      
                   
                   