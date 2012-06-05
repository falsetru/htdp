#lang racket

(require "../41/41.3.3.scm")
(define-struct posn (x y) #:mutable #:transparent)

(define (eq-abstract getf setf value1 value2)
  (local 
    ((define (eq-posn p1 p2)
       (local (;; save old x values of p1 and p2
               (define old-x1 (getf p1))
               (define old-x2 (getf p2))
               ;; modify both x fields of p1 and p2
               (define effect1 (setf p1 value1))
               (define effect2 (setf p2 value2))
               ;; now compare the two fields
               (define same (= (getf p1) (getf p2)))
               ;; restore old values
               (define effect3 (setf p1 old-x1))
               (define effect4 (setf p2 old-x2)))
              same)))
    eq-posn))

(define eq-posn (eq-abstract posn-x set-posn-x! 5 6))
(define eq-child? (eq-abstract child-social set-child-social! 1234 5678))

(require rackunit)
(require rackunit/text-ui)

(define intentional-equality-tests
  (test-suite
   "Test for intentional-equality"

   (test-case
    "eq-posn"
    (check-false (eq-posn (make-posn 1 2) (make-posn 1 2)))
    (check-true (local ((define p (make-posn 1 2))) (eq-posn p p)))
    (check-true (local ((define p (make-posn 1 2))
                        (define a (list p)))
                       (eq-posn (first a) p)))
    )

   (test-case
    "eq-child?"
    (define Gustav-clone (make-child 'Gustav 1988 Fred Eva))
    (check-false (eq-child? Gustav Gustav-clone))
    (check-true (eq-child? Gustav Gustav))
    )
   ))

(exit (run-tests intentional-equality-tests))
