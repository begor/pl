#lang racket
;; Constructors, which return tagged list.
(define (Const e) (list 'Const e))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

;; What kind of expression is x?
(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

;; Get the pieces of expression
(define Const-int cadr)
(define Negate-e cadr)
(define Add-e1 cadr)
(define Add-e2 caddr)
(define Multiply-e1 cadr)
(define Multiply-e2 caddr)

;; Interpeter
(define (eval exp)
  (cond [(Const? exp) exp]
        [(Negate? exp) (Const (- (Const-int
                                  (eval (Negate-e exp)))))]
        [(Add? exp) (let ([v1 (Const-int (eval (Add-e1 exp)))]
                          [v2 (Const-int (eval (Add-e2 exp)))])
                      (Const (+ v1 v2)))]
        [(Multiply? exp) (let ([v1 (Const-int (eval (Multiply-e1 exp)))]
                               [v2 (Const-int (eval (Multiply-e2 exp)))])
                           (Const (* v1 v2)))]
        [#t (error "bad expression")]))

(define minus-hundred-eight (eval (Multiply (Const 12) (Negate (Add (Const 3) (Multiply (Const 2) (Const 3)))))))


;; Using structs

(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

(define (eval-exp exp)
  (cond [(const? exp) exp]
        [(negate? exp) (const (- (eval-exp (negate-e exp))))]
        [(add? exp) (let ([v1 (const-int (eval-exp (add-e1 exp)))]
                          [v2 (const-int (eval-exp (add-e2 exp)))])
                      (const (+ v1 v2)))]
        [(multiply? exp) (let ([v1 (const-int (eval-exp (multiply-e1 exp)))]
                          [v2 (const-int (eval-exp (multiply-e2 exp)))])
                      (const (* v1 v2)))]
        [#t (error "bad expression")]))