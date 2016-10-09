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
   
   ;; apair test
   (check-equal? (eval-exp (apair (int 4) (int 7))) (apair (int 4) (int 7)) "apair test")
   (check-equal? (eval-exp (apair (add (int 4) (int 3)) (int 7))) (apair (int 7) (int 7)) "apair test")
   (check-equal? (eval-exp (apair (apair (int 4) (add (int 7) (int 3))) (int 7))) (apair (apair (int 4) (int 10)) (int 7)) "apair test")
   
   ;;snd and fst test
   (check-equal? (eval-exp (fst (apair (int 1) (int 2)))) (int 1) "snd test")
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")
   (check-exn exn:fail? (lambda () (eval-exp (snd (int 3)))))
   (check-exn exn:fail? (lambda () (eval-exp (fst (int 3)))))
   
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (aunit))) (int 1) "isaunit test")
   
   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   (check-equal? (eval-exp (call (closure (list (cons "a" (int 1))) (fun "name" "z" (add (var "z") (var "a")))) (int 2))) (int 3) "call test")
   (check-equal? (eval-exp (call (closure (list (cons "a" (int 1))) (fun "name" "z" (add (var "z") (var "a")))) (int 2))) (int 3) "call test")
   (check-exn exn:fail? (lambda () (eval-exp (call (fun "name" "z" (add (var "z") (var "a"))) (int 2)))))

   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3))) (int 2) "ifaunit test")

   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x"))) (int 10) "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10)) (cons "y" (add (int 10) (var "x")))) (var "y"))) (int 20) "mlet* test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
