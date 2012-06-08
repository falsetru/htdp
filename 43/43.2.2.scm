#lang racket

(require "43.2.1.scm")

(define (how-many-ancestors ftn)
  (cond [(false? ftn) 0]
        [else (+ 1
                 (how-many-ancestors (person-father ftn))
                 (how-many-ancestors (person-mother ftn)))]))


(require rackunit)
(require rackunit/text-ui)

(define how-many-ancestors-tests
  (test-suite
   "Test for how-many-ancestors"

   (check-equal? (how-many-ancestors Carl) 1)
   (check-equal? (how-many-ancestors Adam) 3)
   (check-equal? (how-many-ancestors Gustav) 5)
   ))

(exit (run-tests how-many-ancestors-tests))
