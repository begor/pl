#lang racket
;; Programming Languages Homework 5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and, if necessary, change the filename
;;(require "hw5")

(require rackunit)
(require "hw.rkt")

(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list (int 3) (int 4))) (apair (int 3) (apair (int 4) (aunit))) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist null) (aunit) "racketlist->mupllist test")
   
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit)))) (list (int 3) (int 4)) "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (aunit)) null "racketlist->mupllist test")

   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 4) (int 3) (int 3) (int 2))) (int 3) "ifgreater test")
   (check-exn exn:fail? (lambda () (eval-exp (ifgreater (int 3) (var "s") (int 3) (int 2)))))

   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
   (check-equal? (eval-exp (mlet "x" (int 1) (ifgreater (int 5) (var "x") (int 3) (int 4)))) (int 3) "mlet test")
   (check-equal? (eval-exp (mlet "x" (int 6) (ifgreater (int 5) (var "x") (int 3) (int 4)))) (int 4) "mlet test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
