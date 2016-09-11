#lang racket
;; Programming Languages Homework4 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
;;(require "HOMEWORK_FILE")
(require rackunit
         "hw.rkt")

;; Helper functions
(define ones (lambda () (cons 1 ones)))
(define a 2)

(define tests
  (test-suite
   "Sample tests for Assignment 4"
   
   ; sequence test
   (check-equal? (sequence 0 5 1) (list 0 1 2 3 4 5) "Sequence test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
