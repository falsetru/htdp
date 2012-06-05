#lang racket

(require "../41/41.3.3.scm")

(define (eq-child? p1 p2)
  (local (
	  (define old-x1 (child-social p1))
	  (define old-x2 (child-social p2))
	  ;; modify both x fields of p1 and p2
	  (define effect1 (set-child-social! p1 5))
	  (define effect2 (set-child-social! p2 6))
	  ;; now compare the two fields
	  (define same (= (child-social p1) (child-social p2)))
	  ;; restore old values
	  (define effect3 (set-child-social! p1 old-x1))
	  (define effect4 (set-child-social! p2 old-x2)))
    same))


(require rackunit)
(require rackunit/text-ui)

(define intentional-equality-tests
  (test-suite
   "Test for intentional-equality"

   (test-case
    ""
    (define Gustav-clone (make-child 'Gustav 1988 Fred Eva))
    (check-false (eq-child? Gustav Gustav-clone))
    (check-true (eq-child? Gustav Gustav))
    )
   ))

(exit (run-tests intentional-equality-tests))
